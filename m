From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 4 Jan 2012 11:13:09 -0700
Subject: [PATCH v2 04/10] rtc: rtc-twl: Add DT support for RTC inside
 twl4030/twl6030
In-Reply-To: <1323439361-1647-5-git-send-email-b-cousson@ti.com>
References: <1323439361-1647-1-git-send-email-b-cousson@ti.com>
 <1323439361-1647-5-git-send-email-b-cousson@ti.com>
Message-ID: <20120104181309.GK15503@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 09, 2011 at 03:02:35PM +0100, Benoit Cousson wrote:
> Add the DT support for the TI rtc-twl present in the twl4030
> and twl6030 devices.
> 
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Cc: Alessandro Zummo <a.zummo@towertech.it>

Acked-by: Grant Likely <grant.likely@secretlab.ca>

> ---
>  Documentation/devicetree/bindings/rtc/twl-rtc.txt |   12 ++++++++++++
>  drivers/rtc/rtc-twl.c                             |   10 ++++++++--
>  2 files changed, 20 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/rtc/twl-rtc.txt
> 
> diff --git a/Documentation/devicetree/bindings/rtc/twl-rtc.txt b/Documentation/devicetree/bindings/rtc/twl-rtc.txt
> new file mode 100644
> index 0000000..596e0c9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/twl-rtc.txt
> @@ -0,0 +1,12 @@
> +* TI twl RTC
> +
> +The TWL family (twl4030/6030) contains a RTC.
> +
> +Required properties:
> +- compatible : Should be twl4030-rtc
> +
> +Examples:
> +
> +rtc at 0 {
> +    compatible = "ti,twl4030-rtc";
> +};
> diff --git a/drivers/rtc/rtc-twl.c b/drivers/rtc/rtc-twl.c
> index 20687d5..d43b4f6 100644
> --- a/drivers/rtc/rtc-twl.c
> +++ b/drivers/rtc/rtc-twl.c
> @@ -550,6 +550,11 @@ static int twl_rtc_resume(struct platform_device *pdev)
>  #define twl_rtc_resume  NULL
>  #endif
>  
> +static const struct of_device_id twl_rtc_of_match[] = {
> +	{.compatible = "ti,twl4030-rtc", },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, twl_rtc_of_match);
>  MODULE_ALIAS("platform:twl_rtc");
>  
>  static struct platform_driver twl4030rtc_driver = {
> @@ -559,8 +564,9 @@ static struct platform_driver twl4030rtc_driver = {
>  	.suspend	= twl_rtc_suspend,
>  	.resume		= twl_rtc_resume,
>  	.driver		= {
> -		.owner	= THIS_MODULE,
> -		.name	= "twl_rtc",
> +		.owner		= THIS_MODULE,
> +		.name		= "twl_rtc",
> +		.of_match_table = twl_rtc_of_match,
>  	},
>  };
>  
> -- 
> 1.7.0.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
