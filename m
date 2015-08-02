From: hauke@hauke-m.de (Hauke Mehrtens)
Date: Sun, 02 Aug 2015 20:03:46 +0200
Subject: [PATCH] bcma: populate bus DT subnodes as platform_device-s
In-Reply-To: <1435504633-20831-1-git-send-email-zajec5@gmail.com>
References: <1435504633-20831-1-git-send-email-zajec5@gmail.com>
Message-ID: <55BE5B82.7060301@hauke-m.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/28/2015 05:17 PM, Rafa? Mi?ecki wrote:
> Our bus should allow defining children nodes as we may want to specify
> devices attached to the bus. This is required e.g. to specify NAND or
> ChipCommon cores and use bus's address and IRQ mappings.
> 
> Signed-off-by: Rafa? Mi?ecki <zajec5@gmail.com>
> ---
>  drivers/bcma/main.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/bcma/main.c b/drivers/bcma/main.c
> index 9635f10..5912847 100644
> --- a/drivers/bcma/main.c
> +++ b/drivers/bcma/main.c
> @@ -12,6 +12,7 @@
>  #include <linux/slab.h>
>  #include <linux/of_address.h>
>  #include <linux/of_irq.h>
> +#include <linux/of_platform.h>
>  
>  MODULE_DESCRIPTION("Broadcom's specific AMBA driver");
>  MODULE_LICENSE("GPL");
> @@ -409,6 +410,13 @@ int bcma_bus_register(struct bcma_bus *bus)
>  		bcma_core_pci_early_init(&bus->drv_pci[0]);
>  	}
>  
> +	if (bus->host_pdev) {

Here is an other problem. So many bugs in this line. ;-)
host_pdev is in a union so this is also true for PCIe devices, but then
the offset of the dev structure probably is wrong. You should check for
the hosttype. I will send a patch.

> +		struct device *dev = &bus->host_pdev->dev;
> +
> +		of_platform_populate(dev->of_node, of_default_bus_match_table,
> +				     NULL, dev);
> +	}
> +
>  	/* Cores providing flash access go before SPROM init */
>  	list_for_each_entry(core, &bus->cores, list) {
>  		if (bcma_is_core_needed_early(core->id.id))
> 
