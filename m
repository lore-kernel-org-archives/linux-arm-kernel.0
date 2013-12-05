From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 05 Dec 2013 23:33:56 +0300
Subject: [PATCH v3 1/3] usb: ohci-at91: replace request_mem_region +
 ioremap by devm_request_and_ioremap
In-Reply-To: <1386237282-22385-2-git-send-email-b.brezillon@overkiz.com>
References: <1386237282-22385-1-git-send-email-b.brezillon@overkiz.com>
 <1386237282-22385-2-git-send-email-b.brezillon@overkiz.com>
Message-ID: <52A0E334.5080002@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 12/05/2013 12:54 PM, Boris BREZILLON wrote:

> Replace the request_mem_region + ioremap calls by the
> devm_request_and_ioremap call which does the same things but with device
> managed resources.

> Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> ---
>   drivers/usb/host/ohci-at91.c |   24 +++++-------------------
>   1 file changed, 5 insertions(+), 19 deletions(-)

> diff --git a/drivers/usb/host/ohci-at91.c b/drivers/usb/host/ohci-at91.c
> index 7aec6ca..8528895 100644
> --- a/drivers/usb/host/ohci-at91.c
> +++ b/drivers/usb/host/ohci-at91.c
> @@ -157,24 +157,18 @@ static int usb_hcd_at91_probe(const struct hc_driver *driver,
>   	hcd->rsrc_start = mem_r->start;
>   	hcd->rsrc_len = resource_size(mem_r);
>
> -	if (!request_mem_region(hcd->rsrc_start, hcd->rsrc_len, hcd_name)) {
> -		pr_debug("request_mem_region failed\n");
> -		retval = -EBUSY;
> -		goto err1;
> -	}
> -
> -	hcd->regs = ioremap(hcd->rsrc_start, hcd->rsrc_len);
> +	hcd->regs = devm_request_and_ioremap(dev, mem_r);

    This function is already deprecated, use devm_ioremap_resource() instead 
(it returns error pointer, not NULL on error).

>   	if (!hcd->regs) {
> -		pr_debug("ioremap failed\n");
> +		dev_dbg(dev, "devm_request_and_ioremap failed\n");

    There's no need -- those functions print error messages themselves.

>   		retval = -EIO;
> -		goto err2;
> +		goto err;
>   	}
[...]

WBR, Sergei
