From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 02 Jun 2016 14:32:33 +0200
Subject: [RFC PATCH 1/3] pci,
 acpi: Match PCI config space accessors against platfrom specific ECAM
 quirks.
In-Reply-To: <5750218F.9030406@semihalf.com>
References: <1464856864-18049-1-git-send-email-tn@semihalf.com>
 <4347711.qDrKz2s8lr@wuerfel> <5750218F.9030406@semihalf.com>
Message-ID: <9294389.sZPDtyjoUs@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, June 2, 2016 2:07:43 PM CEST Tomasz Nowicki wrote:
> On 02.06.2016 13:42, Arnd Bergmann wrote:
> > On Thursday, June 2, 2016 10:41:01 AM CEST Tomasz Nowicki wrote:
> >> +struct pci_ecam_ops *pci_mcfg_get_ops(struct acpi_pci_root *root)
> >> +{
> >> +       int bus_num = root->secondary.start;
> >> +       int domain = root->segment;
> >> +       struct pci_cfg_fixup *f;
> >> +
> >> +       if (!mcfg_table)
> >> +               return &pci_generic_ecam_ops;
> >> +
> >> +       /*
> >> +        * Match against platform specific quirks and return corresponding
> >> +        * CAM ops.
> >> +        *
> >> +        * First match against PCI topology <domain:bus> then use OEM ID and
> >> +        * OEM revision from MCFG table standard header.
> >> +        */
> >> +       for (f = __start_acpi_mcfg_fixups; f < __end_acpi_mcfg_fixups; f++) {
> >> +               if ((f->domain == domain || f->domain == PCI_MCFG_DOMAIN_ANY) &&
> >> +                   (f->bus_num == bus_num || f->bus_num == PCI_MCFG_BUS_ANY) &&
> >> +                   (!strncmp(f->oem_id, mcfg_table->header.oem_id,
> >> +                             ACPI_OEM_ID_SIZE)) &&
> >> +                   (f->oem_revision == mcfg_table->header.oem_revision))
> >> +                       return f->ops;
> >> +       }
> >> +       /* No quirks, use ECAM */
> >> +       return &pci_generic_ecam_ops;
> >> +}
> >> +
> >>   int pci_mcfg_lookup(struct acpi_pci_root *root)
> >
> > Can you explain the use of pci_ecam_ops instead of pci_ops here?
> >
> 
> I wanted to get associated bus_shift and use it to setup configuration 
> region properly before calling pci_ecam_create. Please see next patch.
> 

I see. It feels really odd to do it this way though, since having a
nonstandard bus_shift essentially means not using anything resembling
ECAM to start with.

I realize that a lot of the host bridges are not ECAM, but because
of this, it would be more logical to have their own pci_ops instead
of pci_ecam_ops.

	Arnd
