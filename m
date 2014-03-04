From: tharvey@gateworks.com (Tim Harvey)
Date: Tue, 4 Mar 2014 07:05:06 -0800
Subject: [PATCH 6/7] PCI: designware: use new OF interrupt mapping when
 possible
In-Reply-To: <1393608523-17509-7-git-send-email-l.stach@pengutronix.de>
References: <1393608523-17509-1-git-send-email-l.stach@pengutronix.de>
 <1393608523-17509-7-git-send-email-l.stach@pengutronix.de>
Message-ID: <CAJ+vNU1EBFWiX7GLeV7LsaWY9_d_r_RBCu9tz3e-s0nAcAjOfA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 28, 2014 at 9:28 AM, Lucas Stach <l.stach@pengutronix.de> wrote:
> This is the recommended method of doing the IRQ
> mapping. For old devicetrees we fall back to the
> previous practice.
>
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
>  drivers/pci/host/pcie-designware.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
> index 17ce88f79d2b..3e0c2af11528 100644
> --- a/drivers/pci/host/pcie-designware.c
> +++ b/drivers/pci/host/pcie-designware.c
> @@ -17,6 +17,7 @@
>  #include <linux/module.h>
>  #include <linux/msi.h>
>  #include <linux/of_address.h>
> +#include <linux/of_pci.h>
>  #include <linux/pci.h>
>  #include <linux/pci_regs.h>
>  #include <linux/types.h>
> @@ -738,8 +739,13 @@ static struct pci_bus *dw_pcie_scan_bus(int nr, struct pci_sys_data *sys)
>  static int dw_pcie_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
>  {
>         struct pcie_port *pp = sys_to_pcie(dev->bus->sysdata);
> +       int irq;
>
> -       return pp->irq;
> +       irq = of_irq_parse_and_map_pci(dev, slot, pin);
> +       if (!irq)
> +               irq = pp->irq;
> +
> +       return irq;
>  }
>
>  static void dw_pcie_add_bus(struct pci_bus *bus)
> --
> 1.8.5.3
>

Lucas,

Please add the following which are required (at least the second one
is required) for of_irq_parse_and_map_pci() to work properly for P2P
bridges.  With the changes below as well as my of/irq fix
(https://patchwork.kernel.org/patch/3762591/) I can now use devices
behind a properly connected P2P bridge.

+++ b/drivers/pci/host/pcie-designware.c
@@ -493,7 +493,7 @@ int __init dw_pcie_host_init(struct pcie_port *pp)
        dw_pci.nr_controllers = 1;
        dw_pci.private_data = (void **)&pp;

-       pci_common_init(&dw_pci);
+       pci_common_init_dev(pp->dev, &dw_pci);
        pci_assign_unassigned_resources();
 #ifdef CONFIG_PCI_DOMAINS
        dw_pci.domain++;
@@ -726,7 +726,7 @@ static struct pci_bus *dw_pcie_scan_bus(int nr, struct pci_s

        if (pp) {
                pp->root_bus_nr = sys->busnr;
-               bus = pci_scan_root_bus(NULL, sys->busnr, &dw_pcie_ops,
+               bus = pci_scan_root_bus(pp->dev, sys->busnr, &dw_pcie_ops,
                                        sys, &sys->resources);
        } else {
                bus = NULL;

Thanks,

Tim
