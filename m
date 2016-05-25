From: dhdang@apm.com (Duc Dang)
Date: Wed, 25 May 2016 16:13:35 -0700
Subject: [PATCH] PCI/MSI: pci-xgene-msi: Enable MSI support in ACPI boot
 for X-Gene v1
In-Reply-To: <20160225173822.GA6349@red-moon>
References: <1455069384-22323-1-git-send-email-dhdang@apm.com>
 <1456330151.5681.46.camel@redhat.com> <56CDD767.6020103@arm.com>
 <CADaLND=mrkxOWOzcEb8os16Rb=SDHfnn_8eSgB4bQYH3UguS3w@mail.gmail.com>
 <20160225173822.GA6349@red-moon>
Message-ID: <CADaLNDnywVPER9QhmK4C6JyCLhta_M_cVSOuSkEHnmnLPFo3JA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 25, 2016 at 9:38 AM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
> On Wed, Feb 24, 2016 at 02:28:10PM -0800, Duc Dang wrote:
>> On Wed, Feb 24, 2016 at 8:16 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
>> > On 24/02/16 16:09, Mark Salter wrote:
>> >> On Tue, 2016-02-09 at 17:56 -0800, Duc Dang wrote:
>> >>> This patch makes pci-xgene-msi driver ACPI-aware and provides
>> >>> MSI capability for X-Gene v1 PCIe controllers in ACPI boot mode.
>> >>>
>> >>> Signed-off-by: Duc Dang <dhdang@apm.com>
>> >>> ---
>> >>>  drivers/pci/host/pci-xgene-msi.c | 35 ++++++++++++++++++++++++++++++++---
>> >>>  1 file changed, 32 insertions(+), 3 deletions(-)
>> >>>
>> >>> diff --git a/drivers/pci/host/pci-xgene-msi.c b/drivers/pci/host/pci-xgene-msi.c
>> >>> index a6456b5..466aa93 100644
>> >>> --- a/drivers/pci/host/pci-xgene-msi.c
>> >>> +++ b/drivers/pci/host/pci-xgene-msi.c
>> >>> @@ -24,6 +24,7 @@
>> >>>  #include <linux/pci.h>
>> >>>  #include <linux/platform_device.h>
>> >>>  #include <linux/of_pci.h>
>> >>> +#include <linux/acpi.h>
>> >>>
>> >>>  #define MSI_IR0                     0x000000
>> >>>  #define MSI_INT0            0x800000
>> >>> @@ -39,7 +40,7 @@ struct xgene_msi_group {
>> >>>  };
>> >>>
>> >>>  struct xgene_msi {
>> >>> -    struct device_node      *node;
>> >>> +    struct fwnode_handle    *fwnode;
>> >>>      struct irq_domain       *inner_domain;
>> >>>      struct irq_domain       *msi_domain;
>> >>>      u64                     msi_addr;
>> >>> @@ -249,6 +250,13 @@ static const struct irq_domain_ops msi_domain_ops = {
>> >>>      .free   = xgene_irq_domain_free,
>> >>>  };
>> >>>
>> >>> +#ifdef CONFIG_ACPI
>> >>> +static struct fwnode_handle *xgene_msi_get_fwnode(struct device *dev)
>> >>> +{
>> >>> +    return xgene_msi_ctrl.fwnode;
>> >>> +}
>> >>> +#endif
>> >>> +
>> >>>  static int xgene_allocate_domains(struct xgene_msi *msi)
>> >>>  {
>> >>>      msi->inner_domain = irq_domain_add_linear(NULL, NR_MSI_VEC,
>> >>> @@ -256,7 +264,7 @@ static int xgene_allocate_domains(struct xgene_msi *msi)
>> >>>      if (!msi->inner_domain)
>> >>>              return -ENOMEM;
>> >>>
>> >>> -    msi->msi_domain = pci_msi_create_irq_domain(of_node_to_fwnode(msi->node),
>> >>> +    msi->msi_domain = pci_msi_create_irq_domain(msi->fwnode,
>> >>>                                                  &xgene_msi_domain_info,
>> >>>                                                  msi->inner_domain);
>> >>
>> >> This doesn't work for me (ACPI probing on Mustang) unless I change this
>> >> to be pci_msi_create_default_irq_domain(). The problem seems to be that
>> >> the MSI probe happens after the PCIe RC is probed so there is no MSI domain
>> >> at the time the PCIe root is initialized by ACPI.
>> >
>> > pci_msi_create_default_irq_domain is the wrong thing do use, specially
>> > if you have multiple MSI controllers in the system. I certainly wouldn't
>> > want to see it being used on arm64.
>> >
>> > This is the usual dependency hell. You try moving the probing earlier,
>> > but that may break something else in the process.
>>
>> Hi Mark and Marc,
>>
>> I have modified Tianocore firmware to have MSI node declared before
>> PCIe node in Dsdt table. With this modification, the MSI driver will
>> be loaded before PCIe driver and MSI domain is available at the time
>> PCIe root is initialized.
>
> I am totally against this. We should not hack ACPI tables to make
> the kernel work (on top of that with unwritten ordering rules that may
> well require changes as kernel evolves), we should have a standard set
> of bindings that people use to describe HW in the DSDT and the kernel(s)
> has to cope with that. If there is a dependency problem in the description
> we may solve it at bindings level, but I absolutely do not want to rely
> on DSDT nodes ordering for things to work, that's fragile, no shortcuts
> please.

Hi Lorenzo, Bjorn,

(Refresh this thread on this merge cycle)

I tried to use _DEP method to describe the dependency of PCIe node to
MSI node but it turns out that PCIe driver does not check for the
dependency (only EC (ec.c) and I2C core (i2c-core.c) use
acpi_walk_dep_device_list to check for dependency before loading
dependent drivers)

Do you have other suggestion/example about how to ensure strict
ordering on driver loading in ACPI boot mode without changing the
order of ACPI nodes in DSDT?

Regards,
Duc Dang.
>
> Thanks,
> Lorenzo
