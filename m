From: balbi@ti.com (Felipe Balbi)
Date: Sat, 19 Apr 2014 22:15:17 -0500
Subject: [PATCH 1/8] usb: host: xhci-plat: Allow to register glue code
 using the device tree
In-Reply-To: <1397816563-9000-2-git-send-email-gregory.clement@free-electrons.com>
References: <1397816563-9000-1-git-send-email-gregory.clement@free-electrons.com>
 <1397816563-9000-2-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20140420031517.GA26893@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Apr 18, 2014 at 12:22:36PM +0200, Gregory CLEMENT wrote:
> This patch allow to register specific glue code for xhci controller.
> It creates a structure called xhci_plat_ops to register functions
> specific to an SoC. Currently there are only probe() and remove() but

What SoC-specific code do you need ?

> it can be extended later, it was the point to create such a structure.
> 
> Each compatible string can then be associated to an instance of this
> structure. In the non device tree case a default structure is used.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  drivers/usb/host/xhci-plat.c | 72 +++++++++++++++++++++++++++++++++++++++++---
>  drivers/usb/host/xhci.h      |  4 +++
>  2 files changed, 72 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
> index 151901ce1ba9..8029cc82edc4 100644
> --- a/drivers/usb/host/xhci-plat.c
> +++ b/drivers/usb/host/xhci-plat.c
> @@ -16,6 +16,7 @@
>  #include <linux/slab.h>
>  #include <linux/of.h>
>  #include <linux/dma-mapping.h>
> +#include <linux/of_device.h>
>  
>  #include "xhci.h"
>  
> @@ -85,7 +86,7 @@ static const struct hc_driver xhci_plat_xhci_driver = {
>  	.bus_resume =		xhci_bus_resume,
>  };
>  
> -static int xhci_plat_probe(struct platform_device *pdev)
> +int common_xhci_plat_probe(struct platform_device *pdev, void *priv)

no, I rather not see this sort of hack.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140419/c03b4c88/attachment.sig>
