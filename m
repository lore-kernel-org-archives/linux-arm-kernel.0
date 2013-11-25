From: balbi@ti.com (Felipe Balbi)
Date: Mon, 25 Nov 2013 15:21:01 -0600
Subject: [PATCH v3 04/10] usb: dwc3: use quirks to know if a particualr
 platform doesn't have PHY
In-Reply-To: <1385373690-12170-5-git-send-email-kishon@ti.com>
References: <1385373690-12170-1-git-send-email-kishon@ti.com>
 <1385373690-12170-5-git-send-email-kishon@ti.com>
Message-ID: <20131125212101.GR18046@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 25, 2013 at 03:31:24PM +0530, Kishon Vijay Abraham I wrote:
> There can be systems which does not have an external phy, so get
> phy only if no quirks are added that indicates the PHY is not present.
> Introduced two quirk flags to indicate the *absence* of usb2 phy and
> usb3 phy. Also remove checking if return value is -ENXIO since it's now
> changed to always enable usb_phy layer.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/usb/dwc3/Kconfig         |    1 +
>  drivers/usb/dwc3/core.c          |   93 ++++++++++++++++++++------------------
>  drivers/usb/dwc3/core.h          |   15 ++++++
>  drivers/usb/dwc3/platform_data.h |    5 ++
>  4 files changed, 69 insertions(+), 45 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/Kconfig b/drivers/usb/dwc3/Kconfig
> index 70fc430..8e385b4 100644
> --- a/drivers/usb/dwc3/Kconfig
> +++ b/drivers/usb/dwc3/Kconfig
> @@ -1,6 +1,7 @@
>  config USB_DWC3
>  	tristate "DesignWare USB3 DRD Core Support"
>  	depends on (USB || USB_GADGET) && HAS_DMA
> +	select USB_PHY

no more selects, we've already had too many problems caused by bogus
usage of select.

> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index 986674f..f20f4a1 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -32,6 +32,7 @@
>  #include <linux/delay.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/of.h>
> +#include <linux/of_device.h>
>  
>  #include <linux/usb/ch9.h>
>  #include <linux/usb/gadget.h>
> @@ -351,13 +352,28 @@ static void dwc3_core_exit(struct dwc3 *dwc)
>  
>  #define DWC3_ALIGN_MASK		(16 - 1)
>  
> +#ifdef CONFIG_OF
> +static const struct of_device_id of_dwc3_match[] = {
> +	{
> +		.compatible = "snps,dwc3"
> +	},
> +	{
> +		.compatible = "synopsys,dwc3"
> +	},
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, of_dwc3_match);
> +#endif
> +

you can split this patch a little bit just to make it easier to review
because there are a few changes which are really obvious:

a) move of_device_id higher in source code so you can use it from probe.
	while at that, aso use of_match_device() and return early if it
	doesn't match anything.

b) introduce struct dwc3_data.

c) initialize of_id->data field.

d) start using struct dwc3_data

this will make to put all obvious changes (a-c) in separate patches so
review can focus on (d).

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131125/cbe45606/attachment-0001.sig>
