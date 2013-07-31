From: b.brezillon@overkiz.com (boris brezillon)
Date: Wed, 31 Jul 2013 09:56:11 +0200
Subject: [PATCH v2 26/42] USB: ohci-at91: add usb_clk for transition to
 common clk framework
In-Reply-To: <1374076062-20293-1-git-send-email-b.brezillon@overkiz.com>
References: <1374068069-13496-1-git-send-email-b.brezillon@overkiz.com>
 <1374076062-20293-1-git-send-email-b.brezillon@overkiz.com>
Message-ID: <51F8C31B.1020305@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Alan,

I don't know if you remember but a few days back I sent a series which
included this patch ("ARM: at91: prepare transition to common clk 
framework").

It was decided to move this patch out of the "prepare" series to avoid 
backward
compatility handling.

Things have changed a little bit.

I was asked to split the "ARM: at91: move to common clk framework" 
series into
several smaller series (one for each SoC).
This means at91 will have some SoCs supporting using common clk framework
(and thus will define the usb_clk) and other SoCs using the old at91 clk 
implementation
(which does not define usb_clk).

I was also requested to drop common clk framework support for non dt 
boards, which
means, as long as at91 keep non dt boards the at91 old clk implem will 
remain active.

For all these reasons I will have to reintroduce the backward 
compatibility hack.

Should I get this patch (and patch 27) out of the this series and back 
to the "prepare" series ?

Best Regards,

Boris

On 17/07/2013 17:47, Boris BREZILLON wrote:
> The AT91 PMC (Power Management Controller) provides an USB clock used by
> USB Full Speed host (ohci) and USB Full Speed device (udc).
> The usb drivers (ohci and udc) must configure this clock to 48Mhz.
> This configuration was formely done in mach-at91/clock.c, but this
> implementation will be removed when moving to common clk framework.
>
> This patch add support for usb clock retrieval and configuration.
>
> Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
> ---
>   drivers/usb/host/ohci-at91.c |   16 ++++++++++++++--
>   1 file changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/usb/host/ohci-at91.c b/drivers/usb/host/ohci-at91.c
> index 9677f68..ca1cdd6 100644
> --- a/drivers/usb/host/ohci-at91.c
> +++ b/drivers/usb/host/ohci-at91.c
> @@ -31,8 +31,8 @@
>   #define at91_for_each_port(index)	\
>   		for ((index) = 0; (index) < AT91_MAX_USBH_PORTS; (index)++)
>   
> -/* interface and function clocks; sometimes also an AHB clock */
> -static struct clk *iclk, *fclk, *hclk;
> +/* interface, function and usb clocks; sometimes also an AHB clock */
> +static struct clk *iclk, *fclk, *uclk, *hclk;
>   static int clocked;
>   
>   extern int usb_disabled(void);
> @@ -41,6 +41,8 @@ extern int usb_disabled(void);
>   
>   static void at91_start_clock(void)
>   {
> +	clk_set_rate(uclk, 48000000);
> +	clk_prepare_enable(uclk);
>   	clk_prepare_enable(hclk);
>   	clk_prepare_enable(iclk);
>   	clk_prepare_enable(fclk);
> @@ -52,6 +54,7 @@ static void at91_stop_clock(void)
>   	clk_disable_unprepare(fclk);
>   	clk_disable_unprepare(iclk);
>   	clk_disable_unprepare(hclk);
> +	clk_disable_unprepare(uclk);
>   	clocked = 0;
>   }
>   
> @@ -162,6 +165,12 @@ static int usb_hcd_at91_probe(const struct hc_driver *driver,
>   		retval = PTR_ERR(hclk);
>   		goto err5;
>   	}
> +	uclk = clk_get(&pdev->dev, "usb_clk");
> +	if (IS_ERR(uclk)) {
> +		dev_err(&pdev->dev, "failed to get usb_clk\n");
> +		retval = PTR_ERR(uclk);
> +		goto err6;
> +	}
>   
>   	at91_start_hc(pdev);
>   	ohci_hcd_init(hcd_to_ohci(hcd));
> @@ -173,6 +182,8 @@ static int usb_hcd_at91_probe(const struct hc_driver *driver,
>   	/* Error handling */
>   	at91_stop_hc(pdev);
>   
> +	clk_put(uclk);
> + err6:
>   	clk_put(hclk);
>    err5:
>   	clk_put(fclk);
> @@ -212,6 +223,7 @@ static void usb_hcd_at91_remove(struct usb_hcd *hcd,
>   	release_mem_region(hcd->rsrc_start, hcd->rsrc_len);
>   	usb_put_hcd(hcd);
>   
> +	clk_put(uclk);
>   	clk_put(hclk);
>   	clk_put(fclk);
>   	clk_put(iclk);
