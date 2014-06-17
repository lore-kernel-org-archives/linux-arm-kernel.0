From: horms@verge.net.au (Simon Horman)
Date: Tue, 17 Jun 2014 10:11:54 +0900
Subject: [PATCH v4 10/19] clocksource: sh_tmu: Add DT support
In-Reply-To: <1402931251-22581-11-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1402931251-22581-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1402931251-22581-11-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <20140617011154.GA32454@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laurent,

This version looks good to me.

On Mon, Jun 16, 2014 at 05:07:22PM +0200, Laurent Pinchart wrote:
> Document DT bindings and parse them in the TMU driver.
> 
> Cc: devicetree at vger.kernel.org
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Tested-by: Simon Horman <horms+renesas@verge.net.au>

> ---
>  .../devicetree/bindings/timer/renesas,tmu.txt      | 39 +++++++++++++++++
>  drivers/clocksource/sh_tmu.c                       | 51 +++++++++++++++++-----
>  2 files changed, 80 insertions(+), 10 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/timer/renesas,tmu.txt
> 
> diff --git a/Documentation/devicetree/bindings/timer/renesas,tmu.txt b/Documentation/devicetree/bindings/timer/renesas,tmu.txt
> new file mode 100644
> index 0000000..425d0c5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/timer/renesas,tmu.txt
> @@ -0,0 +1,39 @@
> +* Renesas R-Car Timer Unit (TMU)
> +
> +The TMU is a 32-bit timer/counter with configurable clock inputs and
> +programmable compare match.
> +
> +Channels share hardware resources but their counter and compare match value
> +are independent. The TMU hardware supports up to three channels.
> +
> +Required Properties:
> +
> +  - compatible: must contain "renesas,tmu"
> +
> +  - reg: base address and length of the registers block for the timer module.
> +
> +  - interrupts: interrupt-specifier for the timer, one per channel.
> +
> +  - clocks: a list of phandle + clock-specifier pairs, one for each entry
> +    in clock-names.
> +  - clock-names: must contain "fck" for the functional clock.
> +
> +Optional Properties:
> +
> +  - #renesas,channels: number of channels implemented by the timer, must be 2
> +    or 3 (if not specified the value defaults to 3).
> +
> +
> +Example: R8A7779 (R-Car H1) TMU0 node
> +
> +	tmu0: timer at ffd80000 {
> +		compatible = "renesas,tmu";
> +		reg = <0xffd80000 0x30>;
> +		interrupts = <0 32 IRQ_TYPE_LEVEL_HIGH>,
> +			     <0 33 IRQ_TYPE_LEVEL_HIGH>,
> +			     <0 34 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&mstp0_clks R8A7779_CLK_TMU0>;
> +		clock-names = "fck";
> +
> +		#renesas,channels = <3>;
> +	};
> diff --git a/drivers/clocksource/sh_tmu.c b/drivers/clocksource/sh_tmu.c
> index ef8fb0b..ed61ed2 100644
> --- a/drivers/clocksource/sh_tmu.c
> +++ b/drivers/clocksource/sh_tmu.c
> @@ -24,6 +24,7 @@
>  #include <linux/ioport.h>
>  #include <linux/irq.h>
>  #include <linux/module.h>
> +#include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_domain.h>
>  #include <linux/pm_runtime.h>
> @@ -509,23 +510,48 @@ static int sh_tmu_map_memory(struct sh_tmu_device *tmu)
>  	return 0;
>  }
>  
> +static int sh_tmu_parse_dt(struct sh_tmu_device *tmu)
> +{
> +	struct device_node *np = tmu->pdev->dev.of_node;
> +
> +	tmu->model = SH_TMU;
> +	tmu->num_channels = 3;
> +
> +	of_property_read_u32(np, "#renesas,channels", &tmu->num_channels);
> +
> +	if (tmu->num_channels != 2 && tmu->num_channels != 3) {
> +		dev_err(&tmu->pdev->dev, "invalid number of channels %u\n",
> +			tmu->num_channels);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
>  static int sh_tmu_setup(struct sh_tmu_device *tmu, struct platform_device *pdev)
>  {
> -	struct sh_timer_config *cfg = pdev->dev.platform_data;
> -	const struct platform_device_id *id = pdev->id_entry;
>  	unsigned int i;
>  	int ret;
>  
> -	if (!cfg) {
> -		dev_err(&tmu->pdev->dev, "missing platform data\n");
> -		return -ENXIO;
> -	}
> -
>  	tmu->pdev = pdev;
> -	tmu->model = id->driver_data;
>  
>  	raw_spin_lock_init(&tmu->lock);
>  
> +	if (IS_ENABLED(CONFIG_OF) && pdev->dev.of_node) {
> +		ret = sh_tmu_parse_dt(tmu);
> +		if (ret < 0)
> +			return ret;
> +	} else if (pdev->dev.platform_data) {
> +		const struct platform_device_id *id = pdev->id_entry;
> +		struct sh_timer_config *cfg = pdev->dev.platform_data;
> +
> +		tmu->model = id->driver_data;
> +		tmu->num_channels = hweight8(cfg->channels_mask);
> +	} else {
> +		dev_err(&tmu->pdev->dev, "missing platform data\n");
> +		return -ENXIO;
> +	}
> +
>  	/* Get hold of clock. */
>  	tmu->clk = clk_get(&tmu->pdev->dev, "fck");
>  	if (IS_ERR(tmu->clk)) {
> @@ -545,8 +571,6 @@ static int sh_tmu_setup(struct sh_tmu_device *tmu, struct platform_device *pdev)
>  	}
>  
>  	/* Allocate and setup the channels. */
> -	tmu->num_channels = hweight8(cfg->channels_mask);
> -
>  	tmu->channels = kzalloc(sizeof(*tmu->channels) * tmu->num_channels,
>  				GFP_KERNEL);
>  	if (tmu->channels == NULL) {
> @@ -630,11 +654,18 @@ static const struct platform_device_id sh_tmu_id_table[] = {
>  };
>  MODULE_DEVICE_TABLE(platform, sh_tmu_id_table);
>  
> +static const struct of_device_id sh_tmu_of_table[] __maybe_unused = {
> +	{ .compatible = "renesas,tmu" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, sh_tmu_of_table);
> +
>  static struct platform_driver sh_tmu_device_driver = {
>  	.probe		= sh_tmu_probe,
>  	.remove		= sh_tmu_remove,
>  	.driver		= {
>  		.name	= "sh_tmu",
> +		.of_match_table = of_match_ptr(sh_tmu_of_table),
>  	},
>  	.id_table	= sh_tmu_id_table,
>  };
> -- 
> 1.8.5.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
