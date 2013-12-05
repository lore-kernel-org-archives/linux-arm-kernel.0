From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Thu, 05 Dec 2013 10:53:21 +0100
Subject: [PATCH v3] usb: ohci-at91: fix irq and iomem resource retrieval
In-Reply-To: <1386237013-22285-1-git-send-email-b.brezillon@overkiz.com>
References: <1386237013-22285-1-git-send-email-b.brezillon@overkiz.com>
Message-ID: <3152704.UEBEXU0Stl@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris,

On Thursday 05 of December 2013 10:50:13 Boris BREZILLON wrote:
> When using dt resources retrieval (interrupts and reg properties) there is
> no predefined order for these resources in the platform dev resources
> table.
> 
> Retrieve resources using the platform_get_resource function instead of
> direct resource table entries to avoid resource type mismatch.
> 
> Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> ---
> Changes since v2:
>  - split the patch series to isolate the urgent fix provided by this patch
> 
> Changes since v1:
>  - none
> 
>  drivers/usb/host/ohci-at91.c |   19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/usb/host/ohci-at91.c b/drivers/usb/host/ohci-at91.c
> index 418444e..7aec6ca 100644
> --- a/drivers/usb/host/ohci-at91.c
> +++ b/drivers/usb/host/ohci-at91.c
> @@ -136,23 +136,26 @@ static int usb_hcd_at91_probe(const struct hc_driver *driver,
>  	struct ohci_hcd *ohci;
>  	int retval;
>  	struct usb_hcd *hcd = NULL;
> +	struct device *dev = &pdev->dev;
> +	struct resource *mem_r, *irq_r;
>  
> -	if (pdev->num_resources != 2) {
> -		pr_debug("hcd probe: invalid num_resources");
> +	mem_r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!mem_r) {
> +		dev_dbg(dev, "hcd probe: missing memory resource\n");
>  		return -ENODEV;
>  	}
>  
> -	if ((pdev->resource[0].flags != IORESOURCE_MEM)
> -			|| (pdev->resource[1].flags != IORESOURCE_IRQ)) {
> -		pr_debug("hcd probe: invalid resource type\n");
> +	irq_r = platform_get_resource(pdev, IORESOURCE_IRQ, 0);

You could have simply used platform_get_irq() here, but I guess it's just
a matter of preference, so:

Reviewed-by: Tomasz Figa <tomasz.figa@gmail.com>

Best regards,
Tomasz
