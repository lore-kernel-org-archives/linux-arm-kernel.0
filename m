From: helgaas@kernel.org (Bjorn Helgaas)
Date: Fri, 10 Feb 2017 15:58:29 -0600
Subject: [PATCH v1 1/3] PCI: xilinx: Configure PCIe MPS settings
In-Reply-To: <20170209071956.GA21656@infradead.org>
References: <20170208224632.14351.89895.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20170208224930.14351.91597.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20170209071956.GA21656@infradead.org>
Message-ID: <20170210215829.GQ29169@bhelgaas-glaptop.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 08, 2017 at 11:19:56PM -0800, Christoph Hellwig wrote:
> On Wed, Feb 08, 2017 at 04:49:30PM -0600, Bjorn Helgaas wrote:
> > +	list_for_each_entry(child, &bus->children, node)
> > +		pcie_bus_configure_settings(child);
> 
> This loop is duplicated in just about every driver, so it it
> might be a good idea to provide a littler helper for it.

Yeah, you're right.  One reason I didn't is because I would like to
remove these if we can move the MPS setup into the pci_device_add()
path.

We ought to be able to do at least the minimal "configure this new
device to match the existing hierarchy; if that's impossible, disable
the device" sort of thing there.

We probably would still want some sort of bus- or root port- or host
bridge-level configuration that can take a broader view, and that
might be done where we currently have this loop.  But I don't know 
exactly what that should look like.

Bjorn
