From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Thu, 26 Apr 2012 11:18:57 +0100
Subject: [PATCH 7/8] ARM: PCI: dove/kirkwood/mv78xx0: use sys->private_data
In-Reply-To: <20120426101626.GE24211@n2100.arm.linux.org.uk>
References: <20120426101626.GE24211@n2100.arm.linux.org.uk>
Message-ID: <E1SNLmr-00081B-FT@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use sys->private_data to store the PCIe port data structure.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-dove/pcie.c     |   23 +++++++----------------
 arch/arm/mach-kirkwood/pcie.c |   15 ++++++---------
 arch/arm/mach-mv78xx0/pcie.c  |   23 +++++++----------------
 3 files changed, 20 insertions(+), 41 deletions(-)

diff --git a/arch/arm/mach-dove/pcie.c b/arch/arm/mach-dove/pcie.c
index cebf6a3..47921b0 100644
--- a/arch/arm/mach-dove/pcie.c
+++ b/arch/arm/mach-dove/pcie.c
@@ -43,6 +43,7 @@ static int __init dove_pcie_setup(int nr, struct pci_sys_data *sys)
 		return 0;
 
 	pp = &pcie_port[nr];
+	sys->private_data = pp;
 	pp->root_bus_nr = sys->busnr;
 
 	/*
@@ -93,19 +94,6 @@ static int __init dove_pcie_setup(int nr, struct pci_sys_data *sys)
 	return 1;
 }
 
-static struct pcie_port *bus_to_port(int bus)
-{
-	int i;
-
-	for (i = num_pcie_ports - 1; i >= 0; i--) {
-		int rbus = pcie_port[i].root_bus_nr;
-		if (rbus != -1 && rbus <= bus)
-			break;
-	}
-
-	return i >= 0 ? pcie_port + i : NULL;
-}
-
 static int pcie_valid_config(struct pcie_port *pp, int bus, int dev)
 {
 	/*
@@ -121,7 +109,8 @@ static int pcie_valid_config(struct pcie_port *pp, int bus, int dev)
 static int pcie_rd_conf(struct pci_bus *bus, u32 devfn, int where,
 			int size, u32 *val)
 {
-	struct pcie_port *pp = bus_to_port(bus->number);
+	struct pci_sys_data *sys = bus->sysdata;
+	struct pcie_port *pp = sys->private_data;
 	unsigned long flags;
 	int ret;
 
@@ -140,7 +129,8 @@ static int pcie_rd_conf(struct pci_bus *bus, u32 devfn, int where,
 static int pcie_wr_conf(struct pci_bus *bus, u32 devfn,
 			int where, int size, u32 val)
 {
-	struct pcie_port *pp = bus_to_port(bus->number);
+	struct pci_sys_data *sys = bus->sysdata;
+	struct pcie_port *pp = sys->private_data;
 	unsigned long flags;
 	int ret;
 
@@ -194,7 +184,8 @@ dove_pcie_scan_bus(int nr, struct pci_sys_data *sys)
 
 static int __init dove_pcie_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
-	struct pcie_port *pp = bus_to_port(dev->bus->number);
+	struct pci_sys_data *sys = dev->sysdata;
+	struct pcie_port *pp = sys->private_data;
 
 	return pp->index ? IRQ_DOVE_PCIE1 : IRQ_DOVE_PCIE0;
 }
diff --git a/arch/arm/mach-kirkwood/pcie.c b/arch/arm/mach-kirkwood/pcie.c
index b1034b0..de37317 100644
--- a/arch/arm/mach-kirkwood/pcie.c
+++ b/arch/arm/mach-kirkwood/pcie.c
@@ -44,12 +44,6 @@ struct pcie_port {
 static int pcie_port_map[2];
 static int num_pcie_ports;
 
-static inline struct pcie_port *bus_to_port(struct pci_bus *bus)
-{
-	struct pci_sys_data *sys = bus->sysdata;
-	return sys->private_data;
-}
-
 static int pcie_valid_config(struct pcie_port *pp, int bus, int dev)
 {
 	/*
@@ -79,7 +73,8 @@ static int pcie_valid_config(struct pcie_port *pp, int bus, int dev)
 static int pcie_rd_conf(struct pci_bus *bus, u32 devfn, int where,
 			int size, u32 *val)
 {
-	struct pcie_port *pp = bus_to_port(bus);
+	struct pci_sys_data *sys = bus->sysdata;
+	struct pcie_port *pp = sys->private_data;
 	unsigned long flags;
 	int ret;
 
@@ -98,7 +93,8 @@ static int pcie_rd_conf(struct pci_bus *bus, u32 devfn, int where,
 static int pcie_wr_conf(struct pci_bus *bus, u32 devfn,
 			int where, int size, u32 val)
 {
-	struct pcie_port *pp = bus_to_port(bus);
+	struct pci_sys_data *sys = bus->sysdata;
+	struct pcie_port *pp = sys->private_data;
 	unsigned long flags;
 	int ret;
 
@@ -248,7 +244,8 @@ kirkwood_pcie_scan_bus(int nr, struct pci_sys_data *sys)
 static int __init kirkwood_pcie_map_irq(const struct pci_dev *dev, u8 slot,
 	u8 pin)
 {
-	struct pcie_port *pp = bus_to_port(dev->bus);
+	struct pci_sys_data *sys = dev->sysdata;
+	struct pcie_port *pp = sys->private_data;
 
 	return pp->irq;
 }
diff --git a/arch/arm/mach-mv78xx0/pcie.c b/arch/arm/mach-mv78xx0/pcie.c
index 53f2fb5..67357d1 100644
--- a/arch/arm/mach-mv78xx0/pcie.c
+++ b/arch/arm/mach-mv78xx0/pcie.c
@@ -147,6 +147,7 @@ static int __init mv78xx0_pcie_setup(int nr, struct pci_sys_data *sys)
 		return 0;
 
 	pp = &pcie_port[nr];
+	sys->private_data = pp;
 	pp->root_bus_nr = sys->busnr;
 
 	/*
@@ -161,19 +162,6 @@ static int __init mv78xx0_pcie_setup(int nr, struct pci_sys_data *sys)
 	return 1;
 }
 
-static struct pcie_port *bus_to_port(int bus)
-{
-	int i;
-
-	for (i = num_pcie_ports - 1; i >= 0; i--) {
-		int rbus = pcie_port[i].root_bus_nr;
-		if (rbus != -1 && rbus <= bus)
-			break;
-	}
-
-	return i >= 0 ? pcie_port + i : NULL;
-}
-
 static int pcie_valid_config(struct pcie_port *pp, int bus, int dev)
 {
 	/*
@@ -189,7 +177,8 @@ static int pcie_valid_config(struct pcie_port *pp, int bus, int dev)
 static int pcie_rd_conf(struct pci_bus *bus, u32 devfn, int where,
 			int size, u32 *val)
 {
-	struct pcie_port *pp = bus_to_port(bus->number);
+	struct pci_sys_data *sys = bus->sysdata;
+	struct pcie_port *pp = sys->private_data;
 	unsigned long flags;
 	int ret;
 
@@ -208,7 +197,8 @@ static int pcie_rd_conf(struct pci_bus *bus, u32 devfn, int where,
 static int pcie_wr_conf(struct pci_bus *bus, u32 devfn,
 			int where, int size, u32 val)
 {
-	struct pcie_port *pp = bus_to_port(bus->number);
+	struct pci_sys_data *sys = bus->sysdata;
+	struct pcie_port *pp = sys->private_data;
 	unsigned long flags;
 	int ret;
 
@@ -263,7 +253,8 @@ mv78xx0_pcie_scan_bus(int nr, struct pci_sys_data *sys)
 static int __init mv78xx0_pcie_map_irq(const struct pci_dev *dev, u8 slot,
 	u8 pin)
 {
-	struct pcie_port *pp = bus_to_port(dev->bus->number);
+	struct pci_sys_data *sys = bus->sysdata;
+	struct pcie_port *pp = sys->private_data;
 
 	return IRQ_MV78XX0_PCIE_00 + (pp->maj << 2) + pp->min;
 }
-- 
1.7.4.4
