From: vivek.gautam@codeaurora.org (Vivek Gautam)
Date: Mon, 28 Aug 2017 23:27:45 +0530
Subject: [PATCH V2] usb: dwc3: Initialize DMA ops/mask for xhci-hcd
In-Reply-To: <1503938110-23712-1-git-send-email-awallis@codeaurora.org>
References: <1503938110-23712-1-git-send-email-awallis@codeaurora.org>
Message-ID: <CAFp+6iEqkZGBF5z0QS6p-EuqDPj9TzH5Zej+f6006UP=0t0PAg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Adam,


On Mon, Aug 28, 2017 at 10:05 PM, Adam Wallis <awallis@codeaurora.org> wrote:
> The dma ops from the parent DWC device are not getting passed to the
> child xhci-hcd device. This patch makes use of
> platform_device_register_full to set the DMA ops. For the DT/OF case,
> dma_ops were still null after the the device register, so
> of_dma_configure is called in only the OF case.
>
> Signed-off-by: Adam Wallis <awallis@codeaurora.org>
> ---
>  drivers/usb/dwc3/host.c | 39 +++++++++++++++++----------------------
>  1 file changed, 17 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/usb/dwc3/host.c b/drivers/usb/dwc3/host.c
> index 76f0b0d..c289da1 100644
> --- a/drivers/usb/dwc3/host.c
> +++ b/drivers/usb/dwc3/host.c
> @@ -16,6 +16,7 @@
>   */
>
>  #include <linux/platform_device.h>
> +#include <linux/of_platform.h>
>
>  #include "core.h"
>
> @@ -56,6 +57,7 @@ int dwc3_host_init(struct dwc3 *dwc)
>  {
>         struct property_entry   props[3];
>         struct platform_device  *xhci;
> +       struct platform_device_info dwc_plat_info = {};
>         int                     ret, irq;
>         struct resource         *res;
>         struct platform_device  *dwc3_pdev = to_platform_device(dwc->dev);
> @@ -79,22 +81,22 @@ int dwc3_host_init(struct dwc3 *dwc)
>         dwc->xhci_resources[1].flags = res->flags;
>         dwc->xhci_resources[1].name = res->name;
>
> -       xhci = platform_device_alloc("xhci-hcd", PLATFORM_DEVID_AUTO);
> -       if (!xhci) {
> -               dev_err(dwc->dev, "couldn't allocate xHCI device\n");
> -               return -ENOMEM;
> -       }
> +       dwc_plat_info.name = "xhci-hcd";
> +       dwc_plat_info.parent = dwc->sysdev;
> +       dwc_plat_info.res = dwc->xhci_resources;
> +       dwc_plat_info.num_res = DWC3_XHCI_RESOURCES_NUM;
> +       dwc_plat_info.fwnode = dwc->sysdev->fwnode;
> +       dwc_plat_info.dma_mask = *dwc->sysdev->dma_mask;
>
> -       xhci->dev.parent        = dwc->dev;
> +       xhci = platform_device_register_full(&dwc_plat_info);
> +       if (IS_ERR(xhci)) {
> +               dev_err(dwc->dev, "failed to register xHCI device\n");
> +               return PTR_ERR(xhci);
> +       }
>
>         dwc->xhci = xhci;
> -
> -       ret = platform_device_add_resources(xhci, dwc->xhci_resources,
> -                                               DWC3_XHCI_RESOURCES_NUM);
> -       if (ret) {
> -               dev_err(dwc->dev, "couldn't add resources to xHCI device\n");
> -               goto err1;
> -       }
> +       if (dwc->sysdev->of_node)
> +               of_dma_configure(&xhci->dev, dwc->sysdev->of_node);

Isn't this code doing the same thing what the xhci-plat also does right now
since dwc->sysdev is either dwc->dev or dwc->dev->parent.

>From xhci_plat_probe():
        sysdev = &pdev->dev;
        if (sysdev->parent && !sysdev->of_node && sysdev->parent->of_node)
                sysdev = sysdev->parent;

after which it tries to set the dma masks.

<snip>


regards
Vivek
-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
