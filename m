From: helgaas@kernel.org (Bjorn Helgaas)
Date: Mon, 21 Aug 2017 14:18:06 -0500
Subject: [PATCH v11 2/4] PCI: Factor out pci_bus_wait_crs()
In-Reply-To: <9cb3006d-31d0-e57a-fd3e-c32914e8ba42@codeaurora.org>
References: <20170818212310.15145.21732.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20170818213210.15145.15340.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <9cb3006d-31d0-e57a-fd3e-c32914e8ba42@codeaurora.org>
Message-ID: <20170821191806.GC28977@bhelgaas-glaptop.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 21, 2017 at 09:53:56AM -0400, Sinan Kaya wrote:
> On 8/18/2017 5:32 PM, Bjorn Helgaas wrote:
> > +	if ((*l & 0xffff) != 0x0001)
> > +		return true;	/* not a CRS completion */
> >  
> 
> This version certainly looks cleaner. However, it breaks pci_flr_wait().
> 
> If some root port doesn't support CRS and returns 0xFFFFFFFF, pci_bus_wait_crs()
> function returns true. pci_flr_wait() prematurely bails out from here.
> 
> 
> pci_flr_wait()
> {
> 
> +	ret = pci_bus_wait_crs(dev->bus, dev->devfn, &id, 60000);
> +	if (ret)
> +		return;
> 
> }
> 
> We can change the return code to false above but then we break pci_bus_read_dev_vendor_id()
> function. 
> 
> That's why, I was interested in creating a pci_bus_crs_visibility_supported() helper
> function that would check for the magic 0x0001 value and return true. Otherwise, false. 
> 
> pci_bus_read_dev_vendor_id() would do this
> 
> pci_bus_read_dev_vendor_id()
> {
> 	...
> 	if (pci_bus_crs_visibility_supported())
> 		return pci_bus_wait_crs(dev->bus, dev->devfn, &id, 60000);
> 
> 	return true
> }
> 
> Similar pattern for pci_flr_wait().

I think that makes sense.  We'd want to check for CRS SV being
enabled, e.g., maybe read PCI_EXP_RTCTL_CRSSVE back in
pci_enable_crs() and cache it somewhere.  Maybe a crs_sv_enabled bit
in the root port's pci_dev, and check it with something like what
pcie_root_rcb_set() does?
