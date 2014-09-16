From: khalasa@piap.pl (Krzysztof =?utf-8?Q?Ha=C5=82asa?=)
Date: Tue, 16 Sep 2014 12:36:32 +0200
Subject: [PATCH 2/3] CNS3xxx: Fix logical PCIe topology.
In-Reply-To: <m3d2av3lgt.fsf@t19.piap.pl> ("Krzysztof =?utf-8?Q?Ha=C5=82as?=
 =?utf-8?Q?a=22's?= message of "Tue, 16 Sep 2014 12:31:46 +0200")
References: <m3d2av3lgt.fsf@t19.piap.pl>
Message-ID: <m34mw73l8v.fsf@t19.piap.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Without this patch, each root port and the device connected directly to it seem
to be located on a shared (virtual) bus #0. It creates problems with enabling
devices (the PCI code doesn't know that the root bridge must be enabled in order
to access other devices).
The PCIe topology shown by lspci doesn't reflect reality, e.g.:

0000:00:00.0 PCI bridge: Cavium Networks Device 3400
0000:00:01.0 PCI bridge: Texas Instruments XIO2001 PCI Express-to-PCI Bridge
0000:02:...
0001:00:00.0 PCI bridge: Cavium Networks Device 3400 (for the second lane/bus)

-+-[0001:00]---00.0-[01]--
 \-[0000:00]-+-00.0-[01]--
             | ^^^^ root bridge
             \-01.0-[02]----...
               ^^^^ first external device

With this patch, the first external PCIe device is connected to bus #1
(behind the root bridge).

-+-[0001:00]---00.0-[01]--
 \-[0000:00]---00.0-[01-02]----------00.0-[02]----...
               ^^^^ root bridge      ^^^^ first external device

Signed-off-by: Krzysztof Ha?asa <khalasa@piap.pl>

diff --git a/arch/arm/mach-cns3xxx/pcie.c b/arch/arm/mach-cns3xxx/pcie.c
index 413134c..4ddb974 100644
--- a/arch/arm/mach-cns3xxx/pcie.c
+++ b/arch/arm/mach-cns3xxx/pcie.c
@@ -60,11 +60,10 @@ static void __iomem *cns3xxx_pci_cfg_base(struct pci_bus *bus,
 	struct cns3xxx_pcie *cnspci = pbus_to_cnspci(bus);
 	int busno = bus->number;
 	int slot = PCI_SLOT(devfn);
-	int offset;
 	void __iomem *base;
 
 	/* If there is no link, just show the CNS PCI bridge. */
-	if (!cnspci->linked && (busno > 0 || slot > 0))
+	if (!cnspci->linked && busno > 0)
 		return NULL;
 
 	/*
@@ -72,22 +71,21 @@ static void __iomem *cns3xxx_pci_cfg_base(struct pci_bus *bus,
 	 * we still want to access it. For this to work, we must place
 	 * the first device on the same bus as the CNS PCI bridge.
 	 */
-	if (busno == 0) { /* directly connected PCIe bus */
-		switch (slot) {
-		case 0: /* host bridge device, function 0 only */
+	if (busno == 0) { /* internal PCIe bus, host bridge device */
+		if (devfn == 0) /* device# and function# are ignored by hw */
 			base = cnspci->host_regs;
-			break;
-		case 1: /* directly connected device */
+		else
+			return NULL; /* no such device */
+
+	} else if (busno == 1) { /* directly connected PCIe device */
+		if (slot == 0) /* device# is ignored by hw */
 			base = cnspci->cfg0_regs;
-			break;
-		default:
+		else
 			return NULL; /* no such device */
-		}
 	} else /* remote PCI bus */
-		base = cnspci->cfg1_regs;
+		base = cnspci->cfg1_regs + ((busno & 0xf) << 20);
 
-	offset = ((busno & 0xf) << 20) | (devfn << 12) | (where & 0xffc);
-	return base + offset;
+	return base + (where & 0xffc) + (devfn << 12);
 }
 
 static int cns3xxx_pci_read_config(struct pci_bus *bus, unsigned int devfn,
@@ -167,7 +165,7 @@ static struct pci_ops cns3xxx_pcie_ops = {
 static int cns3xxx_pcie_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
 	struct cns3xxx_pcie *cnspci = pdev_to_cnspci(dev);
-	int irq = cnspci->irqs[slot];
+	int irq = cnspci->irqs[!!dev->bus->number];
 
 	pr_info("PCIe map irq: %04d:%02x:%02x.%02x slot %d, pin %d, irq: %d\n",
 		pci_domain_nr(dev->bus), dev->bus->number, PCI_SLOT(dev->devfn),
@@ -297,7 +295,8 @@ static void __init cns3xxx_pcie_hw_init(struct cns3xxx_pcie *cnspci)
 		return;
 
 	/* Set Device Max_Read_Request_Size to 128 byte */
-	devfn = PCI_DEVFN(1, 0);
+	bus.number = 1; /* directly connected PCIe device */
+	devfn = PCI_DEVFN(0, 0);
 	pos = pci_bus_find_capability(&bus, devfn, PCI_CAP_ID_EXP);
 	pci_bus_read_config_word(&bus, devfn, pos + PCI_EXP_DEVCTL, &dc);
 	dc &= ~(0x3 << 12);	/* Clear Device Control Register [14:12] */
