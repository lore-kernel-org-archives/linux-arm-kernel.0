From: horms@verge.net.au (Simon Horman)
Date: Thu, 23 May 2013 10:39:14 +0900
Subject: [PATCH v4 2/7] clocksource: sh_cmt: Add OF support
In-Reply-To: <1365679443-25456-2-git-send-email-hechtb+renesas@gmail.com>
References: <1365679443-25456-1-git-send-email-hechtb+renesas@gmail.com>
 <1365679443-25456-2-git-send-email-hechtb+renesas@gmail.com>
Message-ID: <20130523013914.GD22608@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 11, 2013 at 01:23:58PM +0200, Bastian Hecht wrote:
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
> they are ready as soon as setup_irq() is called
> 
>  drivers/clocksource/sh_cmt.c |  108 +++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 95 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/clocksource/sh_cmt.c b/drivers/clocksource/sh_cmt.c
> index 08d0c41..66a12e9 100644
> --- a/drivers/clocksource/sh_cmt.c
> +++ b/drivers/clocksource/sh_cmt.c
> @@ -34,10 +34,13 @@
>  #include <linux/module.h>
>  #include <linux/pm_domain.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/of.h>
>  
>  struct sh_cmt_priv {
>  	void __iomem *mapbase;
>  	struct clk *clk;
> +	long channel_offset;
> +	int timer_bit;
>  	unsigned long width; /* 16 or 32 bit version of hardware block */
>  	unsigned long overflow_bit;
>  	unsigned long clear_bits;
> @@ -109,9 +112,7 @@ static void sh_cmt_write32(void __iomem *base, unsigned long offs,
>  
>  static inline unsigned long sh_cmt_read_cmstr(struct sh_cmt_priv *p)
>  {
> -	struct sh_timer_config *cfg = p->pdev->dev.platform_data;
> -
> -	return p->read_control(p->mapbase - cfg->channel_offset, 0);
> +	return p->read_control(p->mapbase - p->channel_offset, 0);
>  }
>  
>  static inline unsigned long sh_cmt_read_cmcsr(struct sh_cmt_priv *p)
> @@ -127,9 +128,7 @@ static inline unsigned long sh_cmt_read_cmcnt(struct sh_cmt_priv *p)
>  static inline void sh_cmt_write_cmstr(struct sh_cmt_priv *p,
>  				      unsigned long value)
>  {
> -	struct sh_timer_config *cfg = p->pdev->dev.platform_data;
> -
> -	p->write_control(p->mapbase - cfg->channel_offset, 0, value);
> +	p->write_control(p->mapbase - p->channel_offset, 0, value);
>  }
>  
>  static inline void sh_cmt_write_cmcsr(struct sh_cmt_priv *p,
> @@ -176,7 +175,6 @@ static DEFINE_RAW_SPINLOCK(sh_cmt_lock);
>  
>  static void sh_cmt_start_stop_ch(struct sh_cmt_priv *p, int start)
>  {
> -	struct sh_timer_config *cfg = p->pdev->dev.platform_data;
>  	unsigned long flags, value;
>  
>  	/* start stop register shared by multiple timer channels */
> @@ -184,9 +182,9 @@ static void sh_cmt_start_stop_ch(struct sh_cmt_priv *p, int start)
>  	value = sh_cmt_read_cmstr(p);
>  
>  	if (start)
> -		value |= 1 << cfg->timer_bit;
> +		value |= 1 << p->timer_bit;
>  	else
> -		value &= ~(1 << cfg->timer_bit);
> +		value &= ~(1 << p->timer_bit);
>  
>  	sh_cmt_write_cmstr(p, value);
>  	raw_spin_unlock_irqrestore(&sh_cmt_lock, flags);
> @@ -673,15 +671,93 @@ static int sh_cmt_register(struct sh_cmt_priv *p, char *name,
>  	return 0;
>  }
>  
> -static int sh_cmt_setup(struct sh_cmt_priv *p, struct platform_device *pdev)
> +static const struct of_device_id of_sh_cmt_match[] = {
> +	{ .compatible = "renesas,cmt-timer" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, of_sh_cmt_match);
> +
> +static const int sh_cmt_offset_multiplier[] = { 0x60, 0x10, 0x40, 0x40, 0x40 };
> +#define CMT_MAX_CHANNELS	6
> +
> +static struct sh_timer_config *sh_cmt_parse_dt(struct device *dev)
> +{
> +	struct sh_timer_config *cfg;
> +	struct device_node *np = dev->of_node;
> +	u32 timer_id, channel_id, rating;
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
> +	if (of_property_read_u32(np, "renesas,device-id", &timer_id)) {
> +		dev_err(dev, "device id missing\n");
> +		return NULL;
> +	}
> +	if (timer_id >= ARRAY_SIZE(sh_cmt_offset_multiplier)) {
> +		dev_err(dev, "invalid device id\n");
> +		return NULL;
> +	}
> +
> +	if (of_property_read_u32(np, "renesas,channel-id", &channel_id)) {
> +		dev_err(dev, "channel id missing\n");
> +		return NULL;
> +	}
> +	if (channel_id >= CMT_MAX_CHANNELS) {
> +		dev_err(dev, "invalid channel id\n");
> +		return NULL;
> +	}
> +
> +	cfg->channel_offset = sh_cmt_offset_multiplier[timer_id] *
> +							(channel_id + 1);
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
> +static int sh_cmt_setup(struct sh_cmt_priv *p, struct platform_device *pdev,
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
> @@ -777,7 +853,7 @@ err0:
>  static int sh_cmt_probe(struct platform_device *pdev)
>  {
>  	struct sh_cmt_priv *p = platform_get_drvdata(pdev);
> -	struct sh_timer_config *cfg = pdev->dev.platform_data;
> +	struct sh_timer_config *cfg;
>  	int ret;
>  
>  	if (!is_early_platform_device(pdev)) {
> @@ -785,6 +861,11 @@ static int sh_cmt_probe(struct platform_device *pdev)
>  		pm_runtime_enable(&pdev->dev);
>  	}
>  
> +	if (pdev->dev.of_node)
> +		cfg = sh_cmt_parse_dt(&pdev->dev);
> +	else
> +		cfg = pdev->dev.platform_data;
> +
>  	if (p) {
>  		dev_info(&pdev->dev, "kept as earlytimer\n");
>  		goto out;
> @@ -796,7 +877,7 @@ static int sh_cmt_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  	}
>  
> -	ret = sh_cmt_setup(p, pdev);
> +	ret = sh_cmt_setup(p, pdev, cfg);
>  	if (ret) {
>  		kfree(p);
>  		pm_runtime_idle(&pdev->dev);
> @@ -824,6 +905,7 @@ static struct platform_driver sh_cmt_device_driver = {
>  	.remove		= sh_cmt_remove,
>  	.driver		= {
>  		.name	= "sh_cmt",
> +		.of_match_table = of_match_ptr(of_sh_cmt_match),
>  	}
>  };
>  
> -- 
> 1.7.9.5
> 
