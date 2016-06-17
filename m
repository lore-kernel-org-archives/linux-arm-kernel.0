From: gabriele.paoloni@huawei.com (Gabriele Paoloni)
Date: Fri, 17 Jun 2016 08:01:43 +0000
Subject: [RFC PATCH v3 2/2] ARM64/PCI: Start using quirks handling for
 ACPI based PCI host controller
In-Reply-To: <20160616174856.GB32388@red-moon>
References: <1466004851-10214-1-git-send-email-cov@codeaurora.org>
 <1466004851-10214-2-git-send-email-cov@codeaurora.org>
 <20160616174856.GB32388@red-moon>
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E1F790346@lhreml507-mbx>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lorenzo and All

> -----Original Message-----
> From: Lorenzo Pieralisi [mailto:lorenzo.pieralisi at arm.com]
> Sent: 16 June 2016 18:49
> To: Christopher Covington
> Cc: Tomasz Nowicki; Duc Dang; liudongdong (C); Sinan Kaya; Jeff Hugo;
> Gabriele Paoloni; Jon Masters; Mark Salter; Suravee Suthikulpanit;
> Jayachandran C; David Daney; Robert Richter; Hanjun Guo; linux-arm-
> kernel at lists.infradead.org; Catalin Marinas; Will Deacon; Bjorn Helgaas;
> Ganapatrao Kulkarni; linux-kernel at vger.kernel.org
> Subject: Re: [RFC PATCH v3 2/2] ARM64/PCI: Start using quirks handling
> for ACPI based PCI host controller
> 
> On Wed, Jun 15, 2016 at 11:34:11AM -0400, Christopher Covington wrote:
> > From: Tomasz Nowicki <tn@semihalf.com>
> >
> > pci_generic_ecam_ops is used by default. Since there are platforms
> > which have non-compliant ECAM space we need to overwrite these
> > accessors prior to PCI buses enumeration. In order to do that
> > we call pci_mcfg_get_ops to retrieve pci_ecam_ops structure so that
> > we can use proper PCI config space accessors and bus_shift.
> >
> > pci_generic_ecam_ops is still used for platforms free from quirks.
> >
> > Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
> > ---
> >  arch/arm64/kernel/pci.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
> > index 94cd43c..a891bda 100644
> > --- a/arch/arm64/kernel/pci.c
> > +++ b/arch/arm64/kernel/pci.c
> > @@ -139,6 +139,7 @@ pci_acpi_setup_ecam_mapping(struct acpi_pci_root
> *root)
> >  	struct pci_config_window *cfg;
> >  	struct resource cfgres;
> >  	unsigned int bsz;
> > +	struct pci_ecam_ops *ops;
> >
> >  	/* Use address from _CBA if present, otherwise lookup MCFG */
> >  	if (!root->mcfg_addr)
> > @@ -150,12 +151,12 @@ pci_acpi_setup_ecam_mapping(struct
> acpi_pci_root *root)
> >  		return NULL;
> >  	}
> >
> > -	bsz = 1 << pci_generic_ecam_ops.bus_shift;
> > +	ops = pci_mcfg_get_ops(root);
> > +	bsz = 1 << ops->bus_shift;
> >  	cfgres.start = root->mcfg_addr + bus_res->start * bsz;
> >  	cfgres.end = cfgres.start + resource_size(bus_res) * bsz - 1;
> >  	cfgres.flags = IORESOURCE_MEM;
> > -	cfg = pci_ecam_create(&root->device->dev, &cfgres, bus_res,
> > -			      &pci_generic_ecam_ops);
> > +	cfg = pci_ecam_create(&root->device->dev, &cfgres, bus_res, ops);
> 
> Arnd pointed this out already, I think that's the only pending question
> here.
> 
> pci_ecam_create() maps ECAM space for config regions retrieved from
> the MCFG, which are *supposed* to be ECAM compliant.
> 
> Do we think that's *always* correct/safe regardless of the kind
> of quirk we are currently fixing up ?

I didn't dig into the other vendors' quirk mechanism but I will 
quickly explain what we (would like to) do in HiSilicon Hip05/Hip06
SoCs.

>From our perspective we use ECAM access mechanism for all the MCFG
buses except the root ports.

For the root ports we declare additional ACPI devices marked as
"pnp0c02" (motherboard reserved resource) i.e.:

Scope(_SB) 
{
	// PCIe Root bus 
	Device (PCI1) 
	{ 
		Name (_HID, "HISI0080") // PCI Express Root Bridge 
		Name (_CID, "PNP0A03") // Compatible PCI Root Bridge 
		Name(_SEG, 1) // Segment of this Root complex 
		Name(_BBN, 64) // Base Bus Number 
		Name(_CCA, 1)
		Method (_CRS, 0, Serialized) { // Root complex resources 
			Name (RBUF, ResourceTemplate () { 
		
		[...]

				)
			}) // Name(RBUF)
			Return (RBUF)
		} // Method(_CRS)

		Device (RES1)
		{
			Name (_HID, "HISI0081") // HiSi PCIe RC config base address
			Name (_CID, "PNP0C02")  // Motherboard reserved resource
			Name (_CRS, ResourceTemplate (){
				Memory32Fixed (ReadWrite, 0xb0080000 , 0x10000)
			})
		}

	     [...]

	} // Device(PCI1)
	


Therefore we declare a perfectly ECAM compliant MCFG and we "waste"
the root ports addresses as in practice for the root ports we replace
the MCFG address with the one retrieved from the ACPI device above.

In terms of "safety" I think it should be ok as in practice we are
reserving some addresses in MCFG that we do not use and the ones
that are used are reserved as well in the ACPI namespace.

>From a general perspective it seems to me that pci_mcfg_lookup
can only parse mcfg entries that are declared according to
the standard (i.e. you cannot declare a hacky mcfg table).

Obviously the quirks allow the vendors to declare their own 
cfg_rd/wr function and therefore to do anything they want with
the MCFG addresses.

>From my perspective I think the easiest solution is to keep this
quirk mechanism in place and then review vendor by vendor solution
as they are pushed to the mailing list; if some vendors are abusing
of some addresses/resources then they can be rejected...

What do you think?

Thanks

Gab

> 
> Or we do think that configuration space regions should come from
> a different resource declared in the ACPI namespace if the regions
> are not MCFG/ECAM compliant (ie config space is not defined through
> MCFG at all - possibly through a _CRS method for a vendor specific
> _HID under the PNP0A03 node ?)
> 
> It might even be a choice we do not have anymore, but I think it
> is important to make a decision and proceed accordingly.
> 
> Comments appreciated.
> 
> Thanks,
> Lorenzo
> 
> >  	if (IS_ERR(cfg)) {
> >  		dev_err(&root->device->dev, "%04x:%pR error %ld mapping
> ECAM\n",
> >  			seg, bus_res, PTR_ERR(cfg));
> > --
> > Qualcomm Innovation Center, Inc.
> > Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> > a Linux Foundation Collaborative Project
> >
