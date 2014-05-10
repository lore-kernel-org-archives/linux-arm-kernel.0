From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sat, 10 May 2014 23:43:10 +0400
Subject: [PATCH 5/6] usb: host: ehci-tegra: Use devm_ioremap_resource
 instead of devm_ioremap
In-Reply-To: <1399715823-19839-6-git-send-email-gautam.vivek@samsung.com>
References: <1399715823-19839-1-git-send-email-gautam.vivek@samsung.com>
 <1399715823-19839-6-git-send-email-gautam.vivek@samsung.com>
Message-ID: <536E814E.4020805@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 05/10/2014 01:57 PM, Vivek Gautam wrote:

> Using devm_ioremap_resource() API should actually be preferred over
> devm_ioremap(), since the former request the mem region first and then
> gives back the ioremap'ed memory pointer.
> devm_ioremap_resource() calls request_mem_region(), therby preventing
> other drivers to make any overlapping call to the same region.

> Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
> ---
>   drivers/usb/host/ehci-tegra.c |    3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)

> diff --git a/drivers/usb/host/ehci-tegra.c b/drivers/usb/host/ehci-tegra.c
> index 572634c..ccc6433 100644
> --- a/drivers/usb/host/ehci-tegra.c
> +++ b/drivers/usb/host/ehci-tegra.c
> @@ -411,9 +411,8 @@ static int tegra_ehci_probe(struct platform_device *pdev)
>   	}
>   	hcd->rsrc_start = res->start;
>   	hcd->rsrc_len = resource_size(res);
> -	hcd->regs = devm_ioremap(&pdev->dev, res->start, resource_size(res));
> +	hcd->regs = devm_ioremap_resource(&pdev->dev, res);
>   	if (!hcd->regs) {

    This has to be changed as well as devm_ioremap_resource() returns error, 
not NULL.

> -		dev_err(&pdev->dev, "Failed to remap I/O memory\n");
>   		err = -ENOMEM;

    This needs to be changed as well, to pass up the error code 
devm_ioremap_resource() returned.

WBR, Sergei
