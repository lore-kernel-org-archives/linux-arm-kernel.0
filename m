From: mathias.nyman@linux.intel.com (Mathias Nyman)
Date: Tue, 7 Mar 2017 17:10:59 +0200
Subject: [PATCH 1/2] usb: xhci-mtk: check hcc_params after adding primary
 hcd
In-Reply-To: <1488857543-9384-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1488857543-9384-1-git-send-email-chunfeng.yun@mediatek.com>
Message-ID: <58BECD83.9000205@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07.03.2017 05:32, Chunfeng Yun wrote:
> hcc_params is set in xhci_gen_setup() called from usb_add_hcd(),
> so checks the Maximum Primary Stream Array Size in the hcc_params
> register after adding primary hcd.
>
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
>   drivers/usb/host/xhci-mtk.c |    6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/usb/host/xhci-mtk.c b/drivers/usb/host/xhci-mtk.c
> index 9066ec9..6ac73a6 100644
> --- a/drivers/usb/host/xhci-mtk.c
> +++ b/drivers/usb/host/xhci-mtk.c
> @@ -678,13 +678,13 @@ static int xhci_mtk_probe(struct platform_device *pdev)
>   		goto power_off_phys;
>   	}
>
> -	if (HCC_MAX_PSA(xhci->hcc_params) >= 4)
> -		xhci->shared_hcd->can_do_streams = 1;
> -
>   	ret = usb_add_hcd(hcd, irq, IRQF_SHARED);
>   	if (ret)
>   		goto put_usb3_hcd;
>
> +	if (HCC_MAX_PSA(xhci->hcc_params) >= 4)
> +		xhci->shared_hcd->can_do_streams = 1;
> +
>   	ret = usb_add_hcd(xhci->shared_hcd, irq, IRQF_SHARED);
>   	if (ret)
>   		goto dealloc_usb2_hcd;
>

Thanks.
Looks like streams check has never worked for Mediatek xHC hosts,

Do you know if this has caused any issues?
looks like it should go usb-linus and maybe stable kernels as well.
  
-Mathias
