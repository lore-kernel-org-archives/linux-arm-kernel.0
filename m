From: hdegoede@redhat.com (Hans de Goede)
Date: Thu, 06 Feb 2014 12:14:21 +0100
Subject: [PATCH 1/3] wdt: sunxi: Introduce a new compatible for the A10
 and A31
In-Reply-To: <1391349325-11132-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1391349325-11132-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <52F36E8D.4050503@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 02/02/2014 02:55 PM, Maxime Ripard wrote:
> For historical reasons, the Allwinner A10 compatibles are not following the
> patterns used for this other Allwinner SoCs.
>
> Introduce a new compatible following the usual pattern, and deprecate the olders.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>   Documentation/devicetree/bindings/watchdog/sunxi-wdt.txt | 7 ++++---
>   drivers/watchdog/sunxi_wdt.c                             | 1 +
>   2 files changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/watchdog/sunxi-wdt.txt b/Documentation/devicetree/bindings/watchdog/sunxi-wdt.txt
> index e39cb26..6e8c937 100644
> --- a/Documentation/devicetree/bindings/watchdog/sunxi-wdt.txt
> +++ b/Documentation/devicetree/bindings/watchdog/sunxi-wdt.txt
> @@ -2,13 +2,14 @@ Allwinner SoCs Watchdog timer
>
>   Required properties:
>
> -- compatible : should be "allwinner,<soc-family>-wdt", the currently supported
> -  SoC families being sun4i and sun6i
> +- compatible : should be either "allwinner,sun4i-a10-wdt" or
> +               "allwinner,sun6i-a31-wdt" (deprecated:
> +               "allwinner,sun4i-wdt", "allwinner,sun6i-wdt")
>   - reg : Specifies base physical address and size of the registers.
>
>   Example:
>
>   wdt: watchdog at 01c20c90 {
> -	compatible = "allwinner,sun4i-wdt";
> +	compatible = "allwinner,sun4i-a10-wdt";
>   	reg = <0x01c20c90 0x10>;
>   };

You talk about deprecating the old compat strings in the commit message, but
here you outright replace them, which will break things with old dtb files ?

Other 2 patches in the series look good and are:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>


> diff --git a/drivers/watchdog/sunxi_wdt.c b/drivers/watchdog/sunxi_wdt.c
> index 76332d8..7c8923d 100644
> --- a/drivers/watchdog/sunxi_wdt.c
> +++ b/drivers/watchdog/sunxi_wdt.c
> @@ -206,6 +206,7 @@ static void sunxi_wdt_shutdown(struct platform_device *pdev)
>
>   static const struct of_device_id sunxi_wdt_dt_ids[] = {
>   	{ .compatible = "allwinner,sun4i-wdt" },
> +	{ .compatible = "allwinner,sun4i-a10-wdt" },
>   	{ /* sentinel */ }
>   };
>   MODULE_DEVICE_TABLE(of, sunxi_wdt_dt_ids);
>

Regards,

Hans
