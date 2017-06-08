From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu, 8 Jun 2017 11:39:56 +0100
Subject: [PATCH v2 pci] PCI/MSI: pci-xgene-msi: Enable MSI support in
 ACPI boot for X-Gene v1
In-Reply-To: <CAAsHzqvnGWkG_KN6m_+HzGFaNOHU-m2FocTxy3pyM7Hhd9rz7w@mail.gmail.com>
References: <1493340847-25720-1-git-send-email-kdinh@apm.com>
 <f5cb58a5-7c06-8d54-6293-1a72ee0a4707@arm.com>
 <CAAsHzquFJE7X0MQyZCP4+UW_E+WK2ORe1EK6yxiq-ev81i1-xg@mail.gmail.com>
 <20170505165119.GA8614@red-moon>
 <CAAsHzqttOoWOCAEmYaWjWmH4a--o0FXCRKfFC9S-+3KGiZVuHQ@mail.gmail.com>
 <CAAsHzqvnGWkG_KN6m_+HzGFaNOHU-m2FocTxy3pyM7Hhd9rz7w@mail.gmail.com>
Message-ID: <20170608103956.GB8644@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 06, 2017 at 09:44:15AM -0700, Khuong Dinh wrote:
> Hi Lorenzo,
> 
> On Tue, May 9, 2017 at 3:55 PM, Khuong Dinh <kdinh@apm.com> wrote:
> > Hi Lorenzo,
> >
> > On Fri, May 5, 2017 at 9:51 AM, Lorenzo Pieralisi
> > <lorenzo.pieralisi@arm.com> wrote:
> >> On Thu, May 04, 2017 at 05:36:06PM -0700, Khuong Dinh wrote:
> >>> Hi Marc,
> >>> There's no explicit dependency between pcie driver and msi
> >>> controller.  The current solution that we did is relying on the
> >>> node ordering in BIOS.  ACPI 5.0 introduced _DEP method to assign a
> >>> higher priority in start ordering.  This method could be applied in
> >>> case of msi and pcie are the same level of subsys_init (in ACPI
> >>> boot).  However, PCIe driver has not supported for this dependency
> >>> check yet.  How do you think about this solution.
> >>
> >> First off, you can't post emails with confidentiality notices on
> >> mailing lists so remove it from now onwards.
> >
> > Fixed
> >
> >> Secondly, I commented on this before, so you know what my opinion is.
> >
> > I got your opinion. I'll implement as your suggestion.
> >
> 
>   Regarding to your previous suggestion to add a hook walking the ACPI
>   namespace before acpi_bus_scan() in acpi_scan_init() to make MSI
>   controllers must be probed before PCI.  I have a concern that the
>   MSI namespace ? _SB.MSIX? is not a unique name and how can we walk
>   the ACPI namespace and use this name to make MSI probed before PCI.
>   May you have little bit more information for this or do you have
>   another suggestion for this?
> 
>    There?s another solution which makes this simpler and I?d like to
>    ask your opinion about this.
>    The solution is to make an hierarchy between MSI and PCI nodes  as below:
> Device(\_SB.MSIX) {
>    Device(\_SB.PCI0)
>    Device(\_SB.PCI1)
>    ??
> }
>   In other word, MSIX node is a parent node of PCI nodes in ACPI
>   table.  In this sense, there?s an explicit dependency between MSI
>   and PCI, MSI controller must be probed before PCI and it will
>   guarantee not breaking next kernel releases.  How do you think about
>   this solution.

I think that's a plaster as ineffective as reordering nodes, in short
it is not a solution and you still rely on kernel link ordering, you
can fiddle with ACPI tables as much as you want but that does not change.

>  I also tried to use _DEP method to describe the dependency of PCIe
>  nodes, but it looks that it does not work as PCI and MSI are handed
>  by acpi_bus_scan and still having issue when we re-probe PCI.

That's a tad vague to be frank, anyway it is pretty clear to me that we
have hit a wall. In ACPI there is no way to describe probe dependencies
like the one you have, it is as simple as that, and this MSI issue you
are facing is just an example, there are more eg:

https://www.spinics.net/lists/arm-kernel/msg585825.html

At the end of the day the choice is simple either we accept (and we
maintain because that's the problem) these hacks - and I am not willing
to do that - or we find a way to solve this from a general perspective not
as a point hack.

I can have a look at solving the whole issue but it won't happen
tomorrow.

Thanks,
Lorenzo

> Thanks,
> Khuong Dinh
> 
> >> Finally, please execute this command on the vmlinux that "works"
> >> for you:
> >>
> >> nm vmlinux | grep -E '__initcall_(xgene_pcie_msi_init|acpi_init)'
> >
> > $ nm vmlinux | grep -E '__initcall_(xgene_pcie_msi_init|acpi_init)'
> > ffff000008dab2d8 t __initcall_acpi_init4
> > ffff000008dab2c8 t __initcall_xgene_pcie_msi_init4
> >
> > Best regards,
> > Khuong Dinh
> >
> >> Even by ordering devices in the ACPI tables (that I abhor) I still do
> >> not understand how this works (I mean without relying on kernel link
> >> order to ensure that the MSI driver is probed before PCI devices are
> >> enumerated in acpi_init()).
> >>
> >> Thanks,
> >> Lorenzo
> >>
> >>> Best regards,
> >>> Khuong
> >>>
> >>> On Fri, Apr 28, 2017 at 2:27 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> >>> > On 28/04/17 01:54, Khuong Dinh wrote:
> >>> >> From: Khuong Dinh <kdinh@apm.com>
> >>> >>
> >>> >> This patch makes pci-xgene-msi driver ACPI-aware and provides
> >>> >> MSI capability for X-Gene v1 PCIe controllers in ACPI boot mode.
> >>> >>
> >>> >> Signed-off-by: Khuong Dinh <kdinh@apm.com>
> >>> >> Signed-off-by: Duc Dang <dhdang@apm.com>
> >>> >> Acked-by: Marc Zyngier <marc.zyngier@arm.com>
> >>> >> ---
> >>> >> v2:
> >>> >>  - Verify with BIOS version 3.06.25 and 3.07.09
> >>> >> v1:
> >>> >>  - Initial version
> >>> >> ---
> >>> >>  drivers/pci/host/pci-xgene-msi.c |   35 ++++++++++++++++++++++++++++++++---
> >>> >>  1 files changed, 32 insertions(+), 3 deletions(-)
> >>> >>
> >>> >> diff --git a/drivers/pci/host/pci-xgene-msi.c b/drivers/pci/host/pci-xgene-msi.c
> >>> >> index f1b633b..00aaa3d 100644
> >>> >> --- a/drivers/pci/host/pci-xgene-msi.c
> >>> >> +++ b/drivers/pci/host/pci-xgene-msi.c
> >>> >> @@ -24,6 +24,7 @@
> >>> >>  #include <linux/pci.h>
> >>> >>  #include <linux/platform_device.h>
> >>> >>  #include <linux/of_pci.h>
> >>> >> +#include <linux/acpi.h>
> >>> >>
> >>> >>  #define MSI_IR0                      0x000000
> >>> >>  #define MSI_INT0             0x800000
> >>> >> @@ -39,7 +40,7 @@ struct xgene_msi_group {
> >>> >>  };
> >>> >>
> >>> >>  struct xgene_msi {
> >>> >> -     struct device_node      *node;
> >>> >> +     struct fwnode_handle    *fwnode;
> >>> >>       struct irq_domain       *inner_domain;
> >>> >>       struct irq_domain       *msi_domain;
> >>> >>       u64                     msi_addr;
> >>> >> @@ -249,6 +250,13 @@ static void xgene_irq_domain_free(struct irq_domain *domain,
> >>> >>       .free   = xgene_irq_domain_free,
> >>> >>  };
> >>> >>
> >>> >> +#ifdef CONFIG_ACPI
> >>> >> +static struct fwnode_handle *xgene_msi_get_fwnode(struct device *dev)
> >>> >> +{
> >>> >> +     return xgene_msi_ctrl.fwnode;
> >>> >> +}
> >>> >> +#endif
> >>> >> +
> >>> >>  static int xgene_allocate_domains(struct xgene_msi *msi)
> >>> >>  {
> >>> >>       msi->inner_domain = irq_domain_add_linear(NULL, NR_MSI_VEC,
> >>> >> @@ -256,7 +264,7 @@ static int xgene_allocate_domains(struct xgene_msi *msi)
> >>> >>       if (!msi->inner_domain)
> >>> >>               return -ENOMEM;
> >>> >>
> >>> >> -     msi->msi_domain = pci_msi_create_irq_domain(of_node_to_fwnode(msi->node),
> >>> >> +     msi->msi_domain = pci_msi_create_irq_domain(msi->fwnode,
> >>> >>                                                   &xgene_msi_domain_info,
> >>> >>                                                   msi->inner_domain);
> >>> >>
> >>> >> @@ -265,6 +273,9 @@ static int xgene_allocate_domains(struct xgene_msi *msi)
> >>> >>               return -ENOMEM;
> >>> >>       }
> >>> >>
> >>> >> +#ifdef CONFIG_ACPI
> >>> >> +     pci_msi_register_fwnode_provider(&xgene_msi_get_fwnode);
> >>> >> +#endif
> >>> >>       return 0;
> >>> >>  }
> >>> >>
> >>> >> @@ -449,6 +460,13 @@ static int xgene_msi_hwirq_free(unsigned int cpu)
> >>> >>       {},
> >>> >>  };
> >>> >>
> >>> >> +#ifdef CONFIG_ACPI
> >>> >> +static const struct acpi_device_id xgene_msi_acpi_ids[] = {
> >>> >> +     {"APMC0D0E", 0},
> >>> >> +     { },
> >>> >> +};
> >>> >> +#endif
> >>> >> +
> >>> >>  static int xgene_msi_probe(struct platform_device *pdev)
> >>> >>  {
> >>> >>       struct resource *res;
> >>> >> @@ -469,7 +487,17 @@ static int xgene_msi_probe(struct platform_device *pdev)
> >>> >>               goto error;
> >>> >>       }
> >>> >>       xgene_msi->msi_addr = res->start;
> >>> >> -     xgene_msi->node = pdev->dev.of_node;
> >>> >> +
> >>> >> +     xgene_msi->fwnode = of_node_to_fwnode(pdev->dev.of_node);
> >>> >> +     if (!xgene_msi->fwnode) {
> >>> >> +             xgene_msi->fwnode = irq_domain_alloc_fwnode(NULL);
> >>> >
> >>> > Please provide something other than NULL, such as the base address if
> >>> > the device. That's quite useful for debugging.
> >>> >
> >>> >> +             if (!xgene_msi->fwnode) {
> >>> >> +                     dev_err(&pdev->dev, "Failed to create fwnode\n");
> >>> >> +                     rc = ENOMEM;
> >>> >> +                     goto error;
> >>> >> +             }
> >>> >> +     }
> >>> >> +
> >>> >>       xgene_msi->num_cpus = num_possible_cpus();
> >>> >>
> >>> >>       rc = xgene_msi_init_allocator(xgene_msi);
> >>> >> @@ -540,6 +568,7 @@ static int xgene_msi_probe(struct platform_device *pdev)
> >>> >>       .driver = {
> >>> >>               .name = "xgene-msi",
> >>> >>               .of_match_table = xgene_msi_match_table,
> >>> >> +             .acpi_match_table = ACPI_PTR(xgene_msi_acpi_ids),
> >>> >>       },
> >>> >>       .probe = xgene_msi_probe,
> >>> >>       .remove = xgene_msi_remove,
> >>> >>
> >>> >
> >>> > The code is trivial, but relies on the MSI controller to probe before
> >>> > the PCI bus. What enforces this? How is it making sure that this is not
> >>> > going to break in the next kernel release? As far as I can tell, there
> >>> > is no explicit dependency between the two, making it the whole thing
> >>> > extremely fragile.
> >>> >
> >>> > Thanks,
> >>> >
> >>> >         M.
> >>> > --
> >>> > Jazz is not dead. It just smells funny...
> >>>
> >>> --
