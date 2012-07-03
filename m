From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 3 Jul 2012 15:43:11 +0800
Subject: [PATCH v3] rtc: stmp3xxx: Add simple binding for the stmp3xxx-rtc
In-Reply-To: <1340699726-7852-1-git-send-email-shawn.guo@linaro.org>
References: <1340699726-7852-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20120703074309.GC22705@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alessandro,

I queued this one on mxs arch tree.  Please let me know if you have
problem with that.

Regards,
Shawn

On Tue, Jun 26, 2012 at 04:35:26PM +0800, Shawn Guo wrote:
> From: Marek Vasut <marex@denx.de>
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Alessandro Zummo <a.zummo@towertech.it>
> Cc: devicetree-discuss at lists.ozlabs.org
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: rtc-linux at googlegroups.com
> Acked-by: Rob Herring <rob.herring@calxeda.com>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
> Changes since v2:
> 
> * Back out the dts changes from the patch, so that it could be merged
>   through rtc tree if that's the case.
> 
> * The first interrupt has to be rtc alarm interrupt, and that's the
>   only one that driver tries to get.  Fix binding document for that.
> 
>  .../devicetree/bindings/rtc/stmp3xxx-rtc.txt       |   16 ++++++++++++++++
>  drivers/rtc/rtc-stmp3xxx.c                         |    8 ++++++++
>  2 files changed, 24 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/rtc/stmp3xxx-rtc.txt
> 
> diff --git a/Documentation/devicetree/bindings/rtc/stmp3xxx-rtc.txt b/Documentation/devicetree/bindings/rtc/stmp3xxx-rtc.txt
> new file mode 100644
> index 0000000..b800070
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/stmp3xxx-rtc.txt
> @@ -0,0 +1,16 @@
> +* STMP3xxx/i.MX28 Time Clock controller
> +
> +Required properties:
> +- compatible: should be one of the following.
> +    * "fsl,stmp3xxx-rtc"
> +- reg: physical base address of the controller and length of memory mapped
> +  region.
> +- interrupts: rtc alarm interrupt
> +
> +Example:
> +
> +rtc at 80056000 {
> +	compatible = "fsl,imx28-rtc", "fsl,stmp3xxx-rtc";
> +	reg = <0x80056000 2000>;
> +	interrupts = <29>;
> +};
> diff --git a/drivers/rtc/rtc-stmp3xxx.c b/drivers/rtc/rtc-stmp3xxx.c
> index 1028786..739ef556 100644
> --- a/drivers/rtc/rtc-stmp3xxx.c
> +++ b/drivers/rtc/rtc-stmp3xxx.c
> @@ -25,6 +25,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/rtc.h>
>  #include <linux/slab.h>
> +#include <linux/of_device.h>
>  
>  #include <mach/common.h>
>  
> @@ -265,6 +266,12 @@ static int stmp3xxx_rtc_resume(struct platform_device *dev)
>  #define stmp3xxx_rtc_resume	NULL
>  #endif
>  
> +static const struct of_device_id rtc_dt_ids[] = {
> +	{ .compatible = "fsl,stmp3xxx-rtc", },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, rtc_dt_ids);
> +
>  static struct platform_driver stmp3xxx_rtcdrv = {
>  	.probe		= stmp3xxx_rtc_probe,
>  	.remove		= stmp3xxx_rtc_remove,
> @@ -273,6 +280,7 @@ static struct platform_driver stmp3xxx_rtcdrv = {
>  	.driver		= {
>  		.name	= "stmp3xxx-rtc",
>  		.owner	= THIS_MODULE,
> +		.of_match_table = rtc_dt_ids,
>  	},
>  };
>  
> -- 
> 1.7.5.4
> 
> 
