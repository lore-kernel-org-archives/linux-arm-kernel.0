From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 06 Aug 2015 16:26:10 +0100
Subject: [PATCH v5 9/9] PCI: xgene: Use pci_scan_root_bus_msi()
In-Reply-To: <20150804215457.9189.27595.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20150804214234.9189.42548.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20150804215457.9189.27595.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Message-ID: <55C37C92.1020509@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bjorn,

On 04/08/15 22:54, Bjorn Helgaas wrote:
> Previously there was no way to specify the MSI controller when creating a
> new PCI root bus, so we had to create the bus, set its MSI controller, then
> scan the bus.  With the new pci_scan_root_bus_msi() interface, we can
> specify the MSI controller up front and get rid of that intermediate step.
> 
> Look up the MSI controller first, then use pci_scan_root_bus_msi() to
> create and scan the root PCI bus.

I'm wondering about these XGene patches.

With the code that is queued for v4.3 in tip/irq/core, the X-Gene MSI
driver doesn't export a struct msi_controller anymore, and entirely
relies on IRQ domains to identify to be matched with the actual PCI driver.

Do you intend this as a cleanup until everything lands in mainline? At
that point, we'd be able to remove all traces of struct msi_controller
from this driver.

Alternatively, we could ask tglx to add an extra patch to the existing
queue in order to clean up pci-xgene.c (nuking the whole
xgene_pcie_msi_enable function).

Thoughts?

	M.
-- 
Jazz is not dead. It just smells funny...
