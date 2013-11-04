From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 4 Nov 2013 14:54:07 +0100
Subject: [PATCH] USB: ehci-atmel: add usb_clk for transition to CCF
In-Reply-To: <1382124411-29023-1-git-send-email-b.brezillon@overkiz.com>
References: <1382124411-29023-1-git-send-email-b.brezillon@overkiz.com>
Message-ID: <5277A6FF.5050404@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/10/2013 21:26, Boris BREZILLON :
> The AT91 PMC (Power Management Controller) provides a USB clock used by
> the different USB controllers (ehci, ohci and udc).
> The atmel-ehci driver must configure the usb clock rate to 48Mhz in order
> to get a fully functionnal USB host controller.
> This configuration was formely done in mach-at91/clock.c, but will be
> bypassed when moving to common clk framework.
>
> This patch adds support for usb clock retrieval and configuration only if
> CCF is enabled (CONFIG_COMMON_CLK).
>
> Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Greg, as this patch is already in your tree, it is only for the record. 
I have tested it and it works now.

Thanks Boris, bye.


> ---
>   drivers/usb/host/ehci-atmel.c |   16 +++++++++++++++-
>   1 file changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/usb/host/ehci-atmel.c b/drivers/usb/host/ehci-atmel.c
> index 3b645ff..f417526 100644
> --- a/drivers/usb/host/ehci-atmel.c
> +++ b/drivers/usb/host/ehci-atmel.c
> @@ -30,13 +30,17 @@ static const char hcd_name[] = "ehci-atmel";
>   static struct hc_driver __read_mostly ehci_atmel_hc_driver;
>
>   /* interface and function clocks */
> -static struct clk *iclk, *fclk;
> +static struct clk *iclk, *fclk, *uclk;
>   static int clocked;
>
>   /*-------------------------------------------------------------------------*/
>
>   static void atmel_start_clock(void)
>   {
> +	if (IS_ENABLED(CONFIG_COMMON_CLK)) {
> +		clk_set_rate(uclk, 48000000);
> +		clk_prepare_enable(uclk);
> +	}
>   	clk_prepare_enable(iclk);
>   	clk_prepare_enable(fclk);
>   	clocked = 1;
> @@ -46,6 +50,8 @@ static void atmel_stop_clock(void)
>   {
>   	clk_disable_unprepare(fclk);
>   	clk_disable_unprepare(iclk);
> +	if (IS_ENABLED(CONFIG_COMMON_CLK))
> +		clk_disable_unprepare(uclk);
>   	clocked = 0;
>   }
>
> @@ -130,6 +136,14 @@ static int ehci_atmel_drv_probe(struct platform_device *pdev)
>   		retval = -ENOENT;
>   		goto fail_request_resource;
>   	}
> +	if (IS_ENABLED(CONFIG_COMMON_CLK)) {
> +		uclk = devm_clk_get(&pdev->dev, "usb_clk");
> +		if (IS_ERR(uclk)) {
> +			dev_err(&pdev->dev, "failed to get uclk\n");
> +			retval = PTR_ERR(uclk);
> +			goto fail_request_resource;
> +		}
> +	}
>
>   	ehci = hcd_to_ehci(hcd);
>   	/* registers start at offset 0x0 */
>


-- 
Nicolas Ferre
