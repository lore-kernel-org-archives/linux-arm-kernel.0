From: gabriele.paoloni@huawei.com (Gabriele Paoloni)
Date: Fri, 3 Jun 2016 15:32:32 +0000
Subject: [RFC PATCH 1/3] pci, acpi: Match PCI config space accessors
 against platfrom specific ECAM quirks.
In-Reply-To: <57519F09.2010201@codeaurora.org>
References: <1464856864-18049-1-git-send-email-tn@semihalf.com>
 <1464856864-18049-2-git-send-email-tn@semihalf.com>
 <57519F09.2010201@codeaurora.org>
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E1F76E9D7@lhreml507-mbx>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Cov

> -----Original Message-----
> From: linux-pci-owner at vger.kernel.org [mailto:linux-pci-
> owner at vger.kernel.org] On Behalf Of Christopher Covington
> Sent: 03 June 2016 16:15
> To: Tomasz Nowicki; helgaas at kernel.org; arnd at arndb.de;
> will.deacon at arm.com; catalin.marinas at arm.com; rafael at kernel.org;
> hanjun.guo at linaro.org; Lorenzo.Pieralisi at arm.com; okaya at codeaurora.org;
> jchandra at broadcom.com
> Cc: jcm at redhat.com; linaro-acpi at lists.linaro.org; linux-
> pci at vger.kernel.org; dhdang at apm.com; Liviu.Dudau at arm.com;
> ddaney at caviumnetworks.com; jeremy.linton at arm.com; linux-
> kernel at vger.kernel.org; linux-acpi at vger.kernel.org;
> robert.richter at caviumnetworks.com; Suravee.Suthikulpanit at amd.com;
> msalter at redhat.com; Wangyijing; mw at semihalf.com;
> andrea.gallo at linaro.org; linux-arm-kernel at lists.infradead.org;
> liudongdong (C); Gabriele Paoloni
> Subject: Re: [RFC PATCH 1/3] pci, acpi: Match PCI config space
> accessors against platfrom specific ECAM quirks.
> 
> Hi Tomasz,
> 
> Thanks for your work on this.
> 
> On 06/02/2016 04:41 AM, Tomasz Nowicki wrote:
> > Some platforms may not be fully compliant with generic set of PCI
> config
> > accessors. For these cases we implement the way to overwrite
> accessors
> > set. Algorithm traverses available quirk list, matches against
> > <oem_id, oem_rev, domain, bus number> tuple and returns corresponding
> > PCI config ops. oem_id and oem_rev come from MCFG table standard
> header.
> > All quirks can be defined using DECLARE_ACPI_MCFG_FIXUP() macro and
> > kept self contained. Example:
> >
> > /* Custom PCI config ops */
> > static struct pci_generic_ecam_ops foo_pci_ops = {
> > 	.bus_shift	= 24,
> > 	.pci_ops = {
> > 		.map_bus = pci_ecam_map_bus,
> > 		.read = foo_ecam_config_read,
> > 		.write = foo_ecam_config_write,
> > 	}
> > };
> >
> > DECLARE_ACPI_MCFG_FIXUP(&foo_pci_ops, <oem_id_str>, <oem_rev>,
> <domain_nr>, <bus_nr>);
> >
> > Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
> > ---
> >  drivers/acpi/pci_mcfg.c           | 32
> ++++++++++++++++++++++++++++++++
> >  include/asm-generic/vmlinux.lds.h |  7 +++++++
> >  include/linux/pci-acpi.h          | 19 +++++++++++++++++++
> >  3 files changed, 58 insertions(+)
> >
> > diff --git a/drivers/acpi/pci_mcfg.c b/drivers/acpi/pci_mcfg.c
> > index 1847f74..f3d4570 100644
> > --- a/drivers/acpi/pci_mcfg.c
> > +++ b/drivers/acpi/pci_mcfg.c
> > @@ -22,11 +22,43 @@
> >  #include <linux/kernel.h>
> >  #include <linux/pci.h>
> >  #include <linux/pci-acpi.h>
> > +#include <linux/pci-ecam.h>
> >
> >  /* Root pointer to the mapped MCFG table */
> >  static struct acpi_table_mcfg *mcfg_table;
> >  static int mcfg_entries;
> >
> > +extern struct pci_cfg_fixup __start_acpi_mcfg_fixups[];
> > +extern struct pci_cfg_fixup __end_acpi_mcfg_fixups[];
> > +
> > +struct pci_ecam_ops *pci_mcfg_get_ops(struct acpi_pci_root *root)
> > +{
> > +	int bus_num = root->secondary.start;
> > +	int domain = root->segment;
> > +	struct pci_cfg_fixup *f;
> > +
> > +	if (!mcfg_table)
> > +		return &pci_generic_ecam_ops;
> > +
> > +	/*
> > +	 * Match against platform specific quirks and return
> corresponding
> > +	 * CAM ops.
> > +	 *
> > +	 * First match against PCI topology <domain:bus> then use OEM ID
> and
> > +	 * OEM revision from MCFG table standard header.
> > +	 */
> > +	for (f = __start_acpi_mcfg_fixups; f < __end_acpi_mcfg_fixups;
> f++) {
> > +		if ((f->domain == domain || f->domain ==
> PCI_MCFG_DOMAIN_ANY) &&
> > +		    (f->bus_num == bus_num || f->bus_num ==
> PCI_MCFG_BUS_ANY) &&
> > +		    (!strncmp(f->oem_id, mcfg_table->header.oem_id,
> > +			      ACPI_OEM_ID_SIZE)) &&
> > +		    (f->oem_revision == mcfg_table->header.oem_revision))
> 
> Is this more likely to be updated between quirky and fixed platforms
> than oem_table_id? What do folks think about using oem_table_id instead
> of, or in addition to, oem_revision?

>From my understanding we need to stick to this mechanism as (otherwise)
there are platforms out in the field that would need a FW update.

So I don't think that using oem_table_id "instead" is possible; about
"in addition" I think it is doable, but I do not see the advantage much.
I mean that if a platform gets fixed the oem revision should change too,
Right?   

Thanks

Gab

> 
> In case these details are helpful, here was my simple prototype of an
> MCFG based approach:
> 
> https://codeaurora.org/cgit/quic/server/kernel/commit/?h=cov/4.7-rc1-
> testing&id=c5d8bc49a198fd8f61f82c7d8f169564d6176b07
> https://codeaurora.org/cgit/quic/server/kernel/commit/?h=cov/4.7-rc1-
> testing&id=50bfe77ccd1639e6ce8c7c4fcca187d50e0bead4
> 
> Thanks,
> Cov
> 
> --
> Qualcomm Innovation Center, Inc.
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
