From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 26 Apr 2017 17:13:35 +0100
Subject: [RFC/RFT PATCH 07/18] ARM: PCI: orion5x: Convert PCI scan API to
 pci_scan_root_bus_bridge()
In-Reply-To: <20170426151257.GA4489@lunn.ch>
References: <20170426111809.19922-1-lorenzo.pieralisi@arm.com>
 <20170426111809.19922-8-lorenzo.pieralisi@arm.com>
 <20170426151257.GA4489@lunn.ch>
Message-ID: <20170426161335.GA12240@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 26, 2017 at 05:12:57PM +0200, Andrew Lunn wrote:
> On Wed, Apr 26, 2017 at 12:17:58PM +0100, Lorenzo Pieralisi wrote:
> > The introduction of pci_scan_root_bus_bridge() provides a PCI core
> > API to scan a PCI root bus backed by an already initialized
> > struct pci_host_bridge object, which simplifies the bus scan
> > interface and makes the PCI scan root bus interface easier to
> > generalize as members are added to the struct pci_host_bridge().
> > 
> > Convert ARM orion5x platform code to pci_scan_root_bus_bridge() to
> > improve the PCI root bus scanning interface.
> 
> Hi Lorenzo
> 
> Maybe there is something not right here.
> 
> With plain 4.11-rc7 i get:
> 
> root at orion5x:~# lspci -v
> 0000:00:00.0 Memory controller: Marvell Technology Group Ltd. 88f5182 [Orion-NAS] ARM SoC (rev 02)
>         Subsystem: Marvell Technology Group Ltd. Device 11ab
>         Flags: bus master, fast devsel, latency 0, IRQ 12
>         Memory at <ignored> (64-bit, prefetchable)
>         Capabilities: [40] Power Management version 2
>         Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit+
>         Capabilities: [60] Express Root Port (Slot-), MSI 00
> 
> 0001:01:00.0 Memory controller: Marvell Technology Group Ltd. 88f5182 [Orion-NAS] ARM SoC (rev 02)
>         Flags: bus master, fast Back2Back, 66MHz, medium devsel, latency 0
>         BIST result: 00
>         Memory at <unassigned> (64-bit, prefetchable)
>         Memory at <ignored> (64-bit, prefetchable)
>         Memory at <ignored> (64-bit, non-prefetchable)
>         Expansion ROM at <ignored> [disabled]
>         Capabilities: [40] Power Management version 2
>         Capabilities: [48] Vital Product Data
>         Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit+
>         Capabilities: [60] PCI-X non-bridge device
>         Capabilities: [68] CompactPCI hot-swap <?>
> 
> However, with your patches applied i get:
> 
> 0000:00:00.0 Memory controller: Marvell Technology Group Ltd. 88f5182 [Orion-NAS] ARM SoC (rev 02)
>         Subsystem: Marvell Technology Group Ltd. Device 11ab
>         Flags: bus master, fast devsel, latency 0
>         Memory at <ignored> (64-bit, prefetchable)
>         Capabilities: [40] Power Management version 2
>         Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit+
>         Capabilities: [60] Express Root Port (Slot-), MSI 00
> 
> 0001:01:00.0 Memory controller: Marvell Technology Group Ltd. 88f5182 [Orion-NAS] ARM SoC (rev 02)
>         Flags: bus master, fast Back2Back, 66MHz, medium devsel, latency 0
>         BIST result: 00
>         Memory at <unassigned> (64-bit, prefetchable)
>         Memory at <ignored> (64-bit, prefetchable)
>         Memory at <ignored> (64-bit, non-prefetchable)
>         Expansion ROM at <ignored> [disabled]
>         Capabilities: [40] Power Management version 2
>         Capabilities: [48] Vital Product Data
>         Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit+
>         Capabilities: [60] PCI-X non-bridge device
>         Capabilities: [68] CompactPCI hot-swap <?>
> 
> Note that IRQ 12 has disappeared from Flags: on 0000:00:00.0.

Thank you for testing it, that's exactly what we need.

To check if the plumbing is working (ie to check I have not messed
up the bus scan API rework), mind testing the patch below please
and report back (it applies on top of this series) ?

Thanks !
Lorenzo

-- >8 --
diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 4632fa4..afa7271 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -400,8 +400,6 @@ static int pci_device_probe(struct device *dev)
 	struct pci_dev *pci_dev = to_pci_dev(dev);
 	struct pci_driver *drv = to_pci_driver(dev->driver);
 
-	pci_assign_irq(pci_dev);
-
 	error = pcibios_alloc_irq(pci_dev);
 	if (error < 0)
 		return error;
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index de259f3..dc9a1b6 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1967,6 +1967,8 @@ void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
 	ret = pcibios_add_device(dev);
 	WARN_ON(ret < 0);
 
+	pci_assign_irq(dev);
+
 	/* Setup MSI irq domain */
 	pci_set_msi_domain(dev);
 
