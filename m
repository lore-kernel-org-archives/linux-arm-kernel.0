From: b.brezillon@overkiz.com (boris brezillon)
Date: Tue, 17 Dec 2013 20:53:54 +0100
Subject: [PATCH v4] usb: ohci-at91: fix irq and iomem resource retrieval
In-Reply-To: <1386514799-6295-1-git-send-email-b.brezillon@overkiz.com>
References: <1386514799-6295-1-git-send-email-b.brezillon@overkiz.com>
Message-ID: <52B0ABD2.3080907@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Greg,

Just a reminder to let you know this patch fixes a bug in the at91 ohci 
driver
which appenrently showed up in 3.13-rc1 release, but is caused by bad
assumptions on platform device resources order.

Without this patch the ohci usb host controller is completely unusable 
on at91
platforms.

Best Regards,

Boris

On 08/12/2013 15:59, Boris BREZILLON wrote:
> When using dt resources retrieval (interrupts and reg properties) there is
> no predefined order for these resources in the platform dev resources
> table.
>
> Retrieve resources using platform_get_resource and platform_get_irq
> functions instead of direct resource table entries to avoid resource type
> mismatch.
>
> Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> Reviewed-by: Tomasz Figa <tomasz.figa@gmail.com>
> ---
> Changes since v3:
>   - replace platform_get_resource call with IORESOURCE_IRQ argument by
>     platform_get_irq
>
> Changes since v2:
>   - split the patch series to isolate the urgent fix provided by this patch
>
> Changes since v1:
>   - none
>
>   drivers/usb/host/ohci-at91.c |   26 +++++++++++++++-----------
>   1 file changed, 15 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/usb/host/ohci-at91.c b/drivers/usb/host/ohci-at91.c
> index 418444e..8c356af 100644
> --- a/drivers/usb/host/ohci-at91.c
> +++ b/drivers/usb/host/ohci-at91.c
> @@ -136,23 +136,27 @@ static int usb_hcd_at91_probe(const struct hc_driver *driver,
>   	struct ohci_hcd *ohci;
>   	int retval;
>   	struct usb_hcd *hcd = NULL;
> -
> -	if (pdev->num_resources != 2) {
> -		pr_debug("hcd probe: invalid num_resources");
> -		return -ENODEV;
> +	struct device *dev = &pdev->dev;
> +	struct resource *res;
> +	int irq;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res) {
> +		dev_dbg(dev, "hcd probe: missing memory resource\n");
> +		return -ENXIO;
>   	}
>   
> -	if ((pdev->resource[0].flags != IORESOURCE_MEM)
> -			|| (pdev->resource[1].flags != IORESOURCE_IRQ)) {
> -		pr_debug("hcd probe: invalid resource type\n");
> -		return -ENODEV;
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0) {
> +		dev_dbg(dev, "hcd probe: missing irq resource\n");
> +		return irq;
>   	}
>   
>   	hcd = usb_create_hcd(driver, &pdev->dev, "at91");
>   	if (!hcd)
>   		return -ENOMEM;
> -	hcd->rsrc_start = pdev->resource[0].start;
> -	hcd->rsrc_len = resource_size(&pdev->resource[0]);
> +	hcd->rsrc_start = res->start;
> +	hcd->rsrc_len = resource_size(res);
>   
>   	if (!request_mem_region(hcd->rsrc_start, hcd->rsrc_len, hcd_name)) {
>   		pr_debug("request_mem_region failed\n");
> @@ -199,7 +203,7 @@ static int usb_hcd_at91_probe(const struct hc_driver *driver,
>   	ohci->num_ports = board->ports;
>   	at91_start_hc(pdev);
>   
> -	retval = usb_add_hcd(hcd, pdev->resource[1].start, IRQF_SHARED);
> +	retval = usb_add_hcd(hcd, irq, IRQF_SHARED);
>   	if (retval == 0)
>   		return retval;
>   
