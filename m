From: zajec5@gmail.com (=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=)
Date: Thu, 23 Jul 2015 02:30:41 +0200
Subject: [PATCH] bcma: populate bus DT subnodes as platform_device-s
In-Reply-To: <1435504633-20831-1-git-send-email-zajec5@gmail.com>
References: <1435504633-20831-1-git-send-email-zajec5@gmail.com>
Message-ID: <CACna6rzFYpwbzM+s-KzFQmTym4iLVn+Ap+DWgFmAZzhWKTQfJw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28 June 2015 at 17:17, Rafa? Mi?ecki <zajec5@gmail.com> wrote:
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
>                 bcma_core_pci_early_init(&bus->drv_pci[0]);
>         }
>
> +       if (bus->host_pdev) {
> +               struct device *dev = &bus->host_pdev->dev;
> +
> +               of_platform_populate(dev->of_node, of_default_bus_match_table,
> +                                    NULL, dev);
> +       }
> +

This caused a compile error when using bcma as module:
ERROR: "of_default_bus_match_table" [drivers/bcma/bcma.ko] undefined!

There are two options I guess:
1) Export of_default_bus_match_table
2) Use some better condition like
if (IS_BUILTIN(CONFIG_BCMA) && bus->host_pdev)

Unfortunately I'm on my long holidays right now.

Hauke: do you think you can find a moment to handle this?

Sorry for the problem :|

-- 
Rafa?
