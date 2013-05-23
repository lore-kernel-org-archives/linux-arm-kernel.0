From: horms@verge.net.au (Simon Horman)
Date: Thu, 23 May 2013 10:39:18 +0900
Subject: [PATCH v4 3/7] clocksource: sh_tmu: Add OF support
In-Reply-To: <1365679443-25456-3-git-send-email-hechtb+renesas@gmail.com>
References: <1365679443-25456-1-git-send-email-hechtb+renesas@gmail.com>
 <1365679443-25456-3-git-send-email-hechtb+renesas@gmail.com>
Message-ID: <20130523013918.GE22608@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 11, 2013 at 01:23:59PM +0200, Bastian Hecht wrote:
> We add the capabilty to probe SH CMT timer devices using Device Tree
> setup.
> 
> Signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>

As per my recent email regarding "ARM: shmobile: sh73a0: Add timer DT names
to clock list", I have dropped this patch which was previously queued-up
for v3.11.

> ---
> v4:
> Moved the assignments of p->channel_offset and p->timer_bit so that
> they are ready as soon as setup_irq() is called.
> 
>  drivers/clocksource/sh_tmu.c |   96 +++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 85 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/clocksource/sh_tmu.c b/drivers/clocksource/sh_tmu.c
> index 78b8dae..17bb607 100644
> --- a/drivers/clocksource/sh_tmu.c
> +++ b/drivers/clocksource/sh_tmu.c
> @@ -34,10 +34,13 @@
>  #include <linux/module.h>
>  #include <linux/pm_domain.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/of.h>
>  
>  struct sh_tmu_priv {
>  	void __iomem *mapbase;
>  	struct clk *clk;
> +	long channel_offset;
> +	int timer_bit;
>  	struct irqaction irqaction;
>  	struct platform_device *pdev;
>  	unsigned long rate;
> @@ -57,12 +60,11 @@ static DEFINE_RAW_SPINLOCK(sh_tmu_lock);
>  
>  static inline unsigned long sh_tmu_read(struct sh_tmu_priv *p, int reg_nr)
>  {
> -	struct sh_timer_config *cfg = p->pdev->dev.platform_data;
>  	void __iomem *base = p->mapbase;
>  	unsigned long offs;
>  
>  	if (reg_nr == TSTR)
> -		return ioread8(base - cfg->channel_offset);
> +		return ioread8(base - p->channel_offset);
>  
>  	offs = reg_nr << 2;
>  
> @@ -75,12 +77,11 @@ static inline unsigned long sh_tmu_read(struct sh_tmu_priv *p, int reg_nr)
>  static inline void sh_tmu_write(struct sh_tmu_priv *p, int reg_nr,
>  				unsigned long value)
>  {
> -	struct sh_timer_config *cfg = p->pdev->dev.platform_data;
>  	void __iomem *base = p->mapbase;
>  	unsigned long offs;
>  
>  	if (reg_nr == TSTR) {
> -		iowrite8(value, base - cfg->channel_offset);
> +		iowrite8(value, base - p->channel_offset);
>  		return;
>  	}
>  
> @@ -94,7 +95,6 @@ static inline void sh_tmu_write(struct sh_tmu_priv *p, int reg_nr,
>  
>  static void sh_tmu_start_stop_ch(struct sh_tmu_priv *p, int start)
>  {
> -	struct sh_timer_config *cfg = p->pdev->dev.platform_data;
>  	unsigned long flags, value;
>  
>  	/* start stop register shared by multiple timer channels */
> @@ -102,9 +102,9 @@ static void sh_tmu_start_stop_ch(struct sh_tmu_priv *p, int start)
>  	value = sh_tmu_read(p, TSTR);
>  
>  	if (start)
> -		value |= 1 << cfg->timer_bit;
> +		value |= 1 << p->timer_bit;
>  	else
> -		value &= ~(1 << cfg->timer_bit);
> +		value &= ~(1 << p->timer_bit);
>  
>  	sh_tmu_write(p, TSTR, value);
>  	raw_spin_unlock_irqrestore(&sh_tmu_lock, flags);
> @@ -421,15 +421,83 @@ static int sh_tmu_register(struct sh_tmu_priv *p, char *name,
>  	return 0;
>  }
>  
> -static int sh_tmu_setup(struct sh_tmu_priv *p, struct platform_device *pdev)
> +static const struct of_device_id of_sh_tmu_match[] = {
> +	{ .compatible = "renesas,tmu-timer" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, of_sh_tmu_match);
> +
> +#define TMU_OFFSET_MULTIPLIER	0xc
> +#define TMU_MAX_CHANNELS	3
> +
> +static struct sh_timer_config *sh_tmu_parse_dt(struct device *dev)
> +{
> +	struct sh_timer_config *cfg;
> +	struct device_node *np = dev->of_node;
> +	u32 channel_id, rating;
> +
> +	if (!IS_ENABLED(CONFIG_OF) || !np)
> +		return NULL;
> +
> +	cfg = devm_kzalloc(dev, sizeof(struct sh_timer_config), GFP_KERNEL);
> +	if (!cfg) {
> +		dev_err(dev, "failed to allocate DT config data\n");
> +		return NULL;
> +	}
> +
> +	if (of_property_read_u32(np, "renesas,channel-id", &channel_id)) {
> +		dev_err(dev, "channel id missing\n");
> +		return NULL;
> +	}
> +	if (channel_id >= TMU_MAX_CHANNELS) {
> +		dev_err(dev, "invalid channel id\n");
> +		return NULL;
> +	}
> +
> +	cfg->channel_offset = channel_id * TMU_OFFSET_MULTIPLIER + 4;
> +	cfg->timer_bit = channel_id;
> +
> +	/*
> +	 * We convert the {source,event}-quality DT properties to linux specific
> +	 * clock{source,event}_ratings.
> +	 */
> +	if (!of_property_read_u32(np, "renesas,source-quality", &rating)) {
> +		if (rating > 10) {
> +			dev_err(dev, "invalid source-quality\n");
> +			return NULL;
> +		}
> +		if (rating)
> +			cfg->clocksource_rating = rating * 50 - 1;
> +	}
> +
> +	if (!of_property_read_u32(np, "renesas,event-quality", &rating)) {
> +		if (rating > 10) {
> +			dev_err(dev, "invalid event-quality\n");
> +			return NULL;
> +		}
> +		if (rating)
> +			cfg->clockevent_rating = rating * 50 - 1;
> +	}
> +
> +	if (!cfg->clocksource_rating && !cfg->clockevent_rating) {
> +		dev_err(dev, "source- and event-quality 0, timer is unused\n");
> +		return NULL;
> +	}
> +
> +	return cfg;
> +}
> +
> +static int sh_tmu_setup(struct sh_tmu_priv *p, struct platform_device *pdev,
> +						struct sh_timer_config *cfg)
>  {
> -	struct sh_timer_config *cfg = pdev->dev.platform_data;
>  	struct resource *res;
>  	int irq, ret;
>  	ret = -ENXIO;
>  
>  	memset(p, 0, sizeof(*p));
>  	p->pdev = pdev;
> +	p->channel_offset = cfg->channel_offset;
> +	p->timer_bit = cfg->timer_bit;
>  
>  	if (!cfg) {
>  		dev_err(&p->pdev->dev, "missing platform data\n");
> @@ -487,7 +555,7 @@ static int sh_tmu_setup(struct sh_tmu_priv *p, struct platform_device *pdev)
>  static int sh_tmu_probe(struct platform_device *pdev)
>  {
>  	struct sh_tmu_priv *p = platform_get_drvdata(pdev);
> -	struct sh_timer_config *cfg = pdev->dev.platform_data;
> +	struct sh_timer_config *cfg;
>  	int ret;
>  
>  	if (!is_early_platform_device(pdev)) {
> @@ -495,6 +563,11 @@ static int sh_tmu_probe(struct platform_device *pdev)
>  		pm_runtime_enable(&pdev->dev);
>  	}
>  
> +	if (pdev->dev.of_node)
> +		cfg = sh_tmu_parse_dt(&pdev->dev);
> +	else
> +		cfg = pdev->dev.platform_data;
> +
>  	if (p) {
>  		dev_info(&pdev->dev, "kept as earlytimer\n");
>  		goto out;
> @@ -506,7 +579,7 @@ static int sh_tmu_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  	}
>  
> -	ret = sh_tmu_setup(p, pdev);
> +	ret = sh_tmu_setup(p, pdev, cfg);
>  	if (ret) {
>  		kfree(p);
>  		platform_set_drvdata(pdev, NULL);
> @@ -535,6 +608,7 @@ static struct platform_driver sh_tmu_device_driver = {
>  	.remove		= sh_tmu_remove,
>  	.driver		= {
>  		.name	= "sh_tmu",
> +		.of_match_table = of_sh_tmu_match,
>  	}
>  };
>  
> -- 
> 1.7.9.5
> 
