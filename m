From: helgaas@kernel.org (Bjorn Helgaas)
Date: Thu, 1 Dec 2016 13:41:14 -0600
Subject: [PATCH v3] PCI/ACPI: xgene: Add ECAM quirk for X-Gene PCIe
 controller
In-Reply-To: <1480620053.4751.30.camel@redhat.com>
References: <1480549373-2123-1-git-send-email-dhdang@apm.com>
 <20161201183350.GF30746@bhelgaas-glaptop.roam.corp.google.com>
 <1480620053.4751.30.camel@redhat.com>
Message-ID: <20161201194114.GA8263@bhelgaas-glaptop.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 01, 2016 at 02:20:53PM -0500, Mark Salter wrote:
> On Thu, 2016-12-01 at 12:33 -0600, Bjorn Helgaas wrote:
> > On Wed, Nov 30, 2016 at 03:42:53PM -0800, Duc Dang wrote:

> > > +static struct resource xgene_v1_csr_res[] = {
> > > +	[0] = DEFINE_RES_MEM_NAMED(0x1f2b0000UL, SZ_64K, "PCIe CSR"),
> > > +	[1] = DEFINE_RES_MEM_NAMED(0x1f2c0000UL, SZ_64K, "PCIe CSR"),
> > > +	[2] = DEFINE_RES_MEM_NAMED(0x1f2d0000UL, SZ_64K, "PCIe CSR"),
> > > +	[3] = DEFINE_RES_MEM_NAMED(0x1f500000UL, SZ_64K, "PCIe CSR"),
> > > +	[4] = DEFINE_RES_MEM_NAMED(0x1f510000UL, SZ_64K, "PCIe CSR"),
> > I assume these ranges are not the actual ECAM space, right?
> > If they *were* ECAM, I assume you would have included them in the
> > quirk itself in the mcfg_quirks[] table.
> 
> These are base addresses for some RC mmio registers.
> > 
> > > 
> > > +static int xgene_v1_pcie_ecam_init(struct pci_config_window *cfg)
> > > +{
> > > +	struct acpi_device *adev = to_acpi_device(cfg->parent);
> > > +	struct acpi_pci_root *root = acpi_driver_data(adev);
> > > +	struct device *dev = cfg->parent;
> > > +	struct xgene_pcie_port *port;
> > > +	struct resource *csr;
> > > +
> > > +	port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
> > > +	if (!port)
> > > +		return -ENOMEM;
> > > +
> > > +	csr = &xgene_v1_csr_res[root->segment];
> > This makes me nervous because root->segment comes from the ACPI _SEG,
> > and if firmware gives us junk in _SEG, we will reference something in
> > the weeds.
> 
> The SoC provide some number of RC bridges, each with a different base
> for some mmio registers. Even if segment is legitimate in MCFG, there
> is still a problem if a platform doesn't use the segment ordering
> implied by the code. But the PNP0A03 _CRS does have this base address
> as the first memory resource, so we could get it from there and not
> have hard-coded addresses and implied ording in the quirk code.

I'm confused.  Doesn't the current code treat every item in PNP0A03
_CRS as a window?  Do you mean the first resource is handled
differently somehow?  The Consumer/Producer bit could allow us to do
this by marking the RC MMIO space as "Consumer", but I didn't think
that strategy was quite working yet.

> I have tested a modified version of these quirks using this to
> get the CSR base and it works on the 3 different platforms I have
> access to.
> 
> static int xgene_pcie_get_csr(struct device *dev, struct resource *r)
> {
> 	struct acpi_device *adev = to_acpi_device(dev);
> 	unsigned long flags;
> 	struct list_head list;
> 	struct resource_entry *entry;
> 	int ret;
> 
> 	INIT_LIST_HEAD(&list);
> 	flags = IORESOURCE_MEM;
> 	ret = acpi_dev_get_resources(adev, &list,
> 				?????acpi_dev_filter_resource_type_cb,
> 				?????(void *)flags);
> 	if (ret < 0) {
> 		dev_err(dev, "failed to parse _CRS, error: %d\n", ret);
> 		return ret;
> 	} else if (ret == 0) {
> 		dev_err(dev, "no memory resources present in _CRS\n");
> 		return -EINVAL;
> 	}
> 
> 	entry = list_first_entry(&list, struct resource_entry, node);
> 	*r = *entry->res;
> 	acpi_dev_free_resource_list(&list);
> 	return 0;
> }

The code above is identical to acpi_get_rc_addr(), which is used in
the acpi_get_rc_resources() path by the other quirks.  Can you use
that path, too, instead of reimplementing it here?
