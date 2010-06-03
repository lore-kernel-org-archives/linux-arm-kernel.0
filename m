From: saeed@marvell.com (Saeed Bishara)
Date: Thu,  3 Jun 2010 14:58:47 +0300
Subject: [PATCH 4/4 v2] [ARM] Kirkwood: add support for PCIe1
In-Reply-To: <1275566327-1764-1-git-send-email-saeed@marvell.com>
References: <1275566327-1764-1-git-send-email-saeed@marvell.com>
Message-ID: <1275566327-1764-2-git-send-email-saeed@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch extens the kirkwood's PCIe support up to 2 controllers as in the 6282 devices.

Signed-off-by: Saeed Bishara <saeed@marvell.com>
---
 arch/arm/mach-kirkwood/addr-map.c                 |   10 +-
 arch/arm/mach-kirkwood/common.h                   |    2 +-
 arch/arm/mach-kirkwood/db88f6281-bp-setup.c       |   10 +-
 arch/arm/mach-kirkwood/include/mach/bridge-regs.h |    1 +
 arch/arm/mach-kirkwood/include/mach/irqs.h        |    1 +
 arch/arm/mach-kirkwood/include/mach/kirkwood.h    |   10 +
 arch/arm/mach-kirkwood/mv88f6281gtw_ge-setup.c    |    2 +-
 arch/arm/mach-kirkwood/openrd-setup.c             |    2 +-
 arch/arm/mach-kirkwood/pcie.c                     |  187 +++++++++++++++-----
 arch/arm/mach-kirkwood/rd88f6192-nas-setup.c      |    2 +-
 arch/arm/mach-kirkwood/rd88f6281-setup.c          |    2 +-
 arch/arm/mach-kirkwood/ts219-setup.c              |    6 +-
 arch/arm/mach-kirkwood/ts41x-setup.c              |    2 +-
 13 files changed, 177 insertions(+), 60 deletions(-)

diff --git a/arch/arm/mach-kirkwood/addr-map.c b/arch/arm/mach-kirkwood/addr-map.c
index 2e69168..8d03bce 100644
--- a/arch/arm/mach-kirkwood/addr-map.c
+++ b/arch/arm/mach-kirkwood/addr-map.c
@@ -31,6 +31,8 @@
 #define ATTR_DEV_CS0		0x3e
 #define ATTR_PCIE_IO		0xe0
 #define ATTR_PCIE_MEM		0xe8
+#define ATTR_PCIE1_IO		0xd0
+#define ATTR_PCIE1_MEM		0xd8
 #define ATTR_SRAM		0x01
 
 /*
@@ -106,17 +108,21 @@ void __init kirkwood_setup_cpu_mbus(void)
 		      TARGET_PCIE, ATTR_PCIE_IO, KIRKWOOD_PCIE_IO_BUS_BASE);
 	setup_cpu_win(1, KIRKWOOD_PCIE_MEM_PHYS_BASE, KIRKWOOD_PCIE_MEM_SIZE,
 		      TARGET_PCIE, ATTR_PCIE_MEM, KIRKWOOD_PCIE_MEM_BUS_BASE);
+	setup_cpu_win(2, KIRKWOOD_PCIE1_IO_PHYS_BASE, KIRKWOOD_PCIE1_IO_SIZE,
+		      TARGET_PCIE, ATTR_PCIE1_IO, KIRKWOOD_PCIE1_IO_BUS_BASE);
+	setup_cpu_win(3, KIRKWOOD_PCIE1_MEM_PHYS_BASE, KIRKWOOD_PCIE1_MEM_SIZE,
+		      TARGET_PCIE, ATTR_PCIE1_MEM, KIRKWOOD_PCIE1_MEM_BUS_BASE);
 
 	/*
 	 * Setup window for NAND controller.
 	 */
-	setup_cpu_win(2, KIRKWOOD_NAND_MEM_PHYS_BASE, KIRKWOOD_NAND_MEM_SIZE,
+	setup_cpu_win(4, KIRKWOOD_NAND_MEM_PHYS_BASE, KIRKWOOD_NAND_MEM_SIZE,
 		      TARGET_DEV_BUS, ATTR_DEV_NAND, -1);
 
 	/*
 	 * Setup window for SRAM.
 	 */
-	setup_cpu_win(3, KIRKWOOD_SRAM_PHYS_BASE, KIRKWOOD_SRAM_SIZE,
+	setup_cpu_win(5, KIRKWOOD_SRAM_PHYS_BASE, KIRKWOOD_SRAM_SIZE,
 		      TARGET_SRAM, ATTR_SRAM, -1);
 
 	/*
diff --git a/arch/arm/mach-kirkwood/common.h b/arch/arm/mach-kirkwood/common.h
index 05e8a8a..876f71a 100644
--- a/arch/arm/mach-kirkwood/common.h
+++ b/arch/arm/mach-kirkwood/common.h
@@ -34,7 +34,7 @@ void kirkwood_ehci_init(void);
 void kirkwood_ge00_init(struct mv643xx_eth_platform_data *eth_data);
 void kirkwood_ge01_init(struct mv643xx_eth_platform_data *eth_data);
 void kirkwood_ge00_switch_init(struct dsa_platform_data *d, int irq);
-void kirkwood_pcie_init(void);
+void kirkwood_pcie_init(int init_port0, int init_port1);
 void kirkwood_sata_init(struct mv_sata_platform_data *sata_data);
 void kirkwood_sdio_init(struct mvsdio_platform_data *mvsdio_data);
 void kirkwood_spi_init(void);
diff --git a/arch/arm/mach-kirkwood/db88f6281-bp-setup.c b/arch/arm/mach-kirkwood/db88f6281-bp-setup.c
index 39bdf4b..b11b5fe 100644
--- a/arch/arm/mach-kirkwood/db88f6281-bp-setup.c
+++ b/arch/arm/mach-kirkwood/db88f6281-bp-setup.c
@@ -74,9 +74,15 @@ static void __init db88f6281_init(void)
 
 static int __init db88f6281_pci_init(void)
 {
-	if (machine_is_db88f6281_bp())
-		kirkwood_pcie_init();
+	if (machine_is_db88f6281_bp()) {
+		u32 dev, rev;
+		int init_port1 = 0;
 
+		kirkwood_pcie_id(&dev, &rev);
+		if (dev == MV88F6282_DEV_ID)
+			init_port1 = 1;
+		kirkwood_pcie_init(1, init_port1);
+	}
 	return 0;
 }
 subsys_initcall(db88f6281_pci_init);
diff --git a/arch/arm/mach-kirkwood/include/mach/bridge-regs.h b/arch/arm/mach-kirkwood/include/mach/bridge-regs.h
index 418f501..2026b30 100644
--- a/arch/arm/mach-kirkwood/include/mach/bridge-regs.h
+++ b/arch/arm/mach-kirkwood/include/mach/bridge-regs.h
@@ -59,6 +59,7 @@
 #define CGC_SATA1		(1 << 15)
 #define CGC_XOR1		(1 << 16)
 #define CGC_CRYPTO		(1 << 17)
+#define CGC_PEX1		(1 << 18)
 #define CGC_GE1			(1 << 19)
 #define CGC_TDM			(1 << 20)
 #define CGC_RESERVED		((1 << 18) | (0x6 << 21))
diff --git a/arch/arm/mach-kirkwood/include/mach/irqs.h b/arch/arm/mach-kirkwood/include/mach/irqs.h
index f00a0a4..9da2eb5 100644
--- a/arch/arm/mach-kirkwood/include/mach/irqs.h
+++ b/arch/arm/mach-kirkwood/include/mach/irqs.h
@@ -23,6 +23,7 @@
 #define IRQ_KIRKWOOD_XOR_10	7
 #define IRQ_KIRKWOOD_XOR_11	8
 #define IRQ_KIRKWOOD_PCIE	9
+#define IRQ_KIRKWOOD_PCIE1	10
 #define IRQ_KIRKWOOD_GE00_SUM	11
 #define IRQ_KIRKWOOD_GE01_SUM	15
 #define IRQ_KIRKWOOD_USB	19
diff --git a/arch/arm/mach-kirkwood/include/mach/kirkwood.h b/arch/arm/mach-kirkwood/include/mach/kirkwood.h
index dd7eddb..058f06b 100644
--- a/arch/arm/mach-kirkwood/include/mach/kirkwood.h
+++ b/arch/arm/mach-kirkwood/include/mach/kirkwood.h
@@ -38,6 +38,11 @@
 #define KIRKWOOD_PCIE_IO_BUS_BASE	0x00000000
 #define KIRKWOOD_PCIE_IO_SIZE		SZ_1M
 
+#define KIRKWOOD_PCIE1_IO_PHYS_BASE	0xf5000000
+#define KIRKWOOD_PCIE1_IO_VIRT_BASE	0xfed00000
+#define KIRKWOOD_PCIE1_IO_BUS_BASE	0x00000000
+#define KIRKWOOD_PCIE1_IO_SIZE		SZ_1M
+
 #define KIRKWOOD_REGS_PHYS_BASE		0xf1000000
 #define KIRKWOOD_REGS_VIRT_BASE		0xfee00000
 #define KIRKWOOD_REGS_SIZE		SZ_1M
@@ -46,6 +51,10 @@
 #define KIRKWOOD_PCIE_MEM_BUS_BASE	0xe0000000
 #define KIRKWOOD_PCIE_MEM_SIZE		SZ_128M
 
+#define KIRKWOOD_PCIE1_MEM_PHYS_BASE	0xd8000000
+#define KIRKWOOD_PCIE1_MEM_BUS_BASE	0xd8000000
+#define KIRKWOOD_PCIE1_MEM_SIZE		SZ_128M
+
 /*
  * Register Map
  */
@@ -72,6 +81,7 @@
 #define PCIE_VIRT_BASE		(KIRKWOOD_REGS_VIRT_BASE | 0x40000)
 #define PCIE_LINK_CTRL		(PCIE_VIRT_BASE | 0x70)
 #define PCIE_STATUS		(PCIE_VIRT_BASE | 0x1a04)
+#define PCIE1_VIRT_BASE		(KIRKWOOD_REGS_VIRT_BASE | 0x44000)
 
 #define USB_PHYS_BASE		(KIRKWOOD_REGS_PHYS_BASE | 0x50000)
 
diff --git a/arch/arm/mach-kirkwood/mv88f6281gtw_ge-setup.c b/arch/arm/mach-kirkwood/mv88f6281gtw_ge-setup.c
index 5e6f711..079eed9 100644
--- a/arch/arm/mach-kirkwood/mv88f6281gtw_ge-setup.c
+++ b/arch/arm/mach-kirkwood/mv88f6281gtw_ge-setup.c
@@ -155,7 +155,7 @@ static void __init mv88f6281gtw_ge_init(void)
 static int __init mv88f6281gtw_ge_pci_init(void)
 {
 	if (machine_is_mv88f6281gtw_ge())
-		kirkwood_pcie_init();
+		kirkwood_pcie_init(1, 0);
 
 	return 0;
 }
diff --git a/arch/arm/mach-kirkwood/openrd-setup.c b/arch/arm/mach-kirkwood/openrd-setup.c
index ad3f1ec..4174f48 100644
--- a/arch/arm/mach-kirkwood/openrd-setup.c
+++ b/arch/arm/mach-kirkwood/openrd-setup.c
@@ -85,7 +85,7 @@ static void __init openrd_init(void)
 static int __init openrd_pci_init(void)
 {
 	if (machine_is_openrd_base() || machine_is_openrd_client())
-		kirkwood_pcie_init();
+		kirkwood_pcie_init(0, 1);
 
 	return 0;
 }
diff --git a/arch/arm/mach-kirkwood/pcie.c b/arch/arm/mach-kirkwood/pcie.c
index dee1eff..703e6c8 100644
--- a/arch/arm/mach-kirkwood/pcie.c
+++ b/arch/arm/mach-kirkwood/pcie.c
@@ -18,29 +18,43 @@
 #include <mach/bridge-regs.h>
 #include "common.h"
 
+void __init kirkwood_pcie_id(u32 *dev, u32 *rev)
+{
+	*dev = orion_pcie_dev_id((void __iomem *)PCIE_VIRT_BASE);
+	*rev = orion_pcie_rev((void __iomem *)PCIE_VIRT_BASE);
+}
 
-#define PCIE_BASE	((void __iomem *)PCIE_VIRT_BASE)
+struct pcie_port {
+	u8			root_bus_nr;
+	void __iomem		*base;
+	spinlock_t		conf_lock;
+	int			irq;
+	struct resource		res[2];
+};
 
-void __init kirkwood_pcie_id(u32 *dev, u32 *rev)
+static int pcie_port_map[2];
+static int num_pcie_ports;
+
+static inline struct pcie_port *bus_to_port(struct pci_bus *bus)
 {
-	*dev = orion_pcie_dev_id(PCIE_BASE);
-	*rev = orion_pcie_rev(PCIE_BASE);
+	struct pci_sys_data *sys = bus->sysdata;
+	return sys->private_data;
 }
 
-static int pcie_valid_config(int bus, int dev)
+static int pcie_valid_config(struct pcie_port *pp, int bus, int dev)
 {
 	/*
 	 * Don't go out when trying to access --
 	 * 1. nonexisting device on local bus
 	 * 2. where there's no device connected (no link)
 	 */
-	if (bus == 0 && dev == 0)
+	if (bus == pp->root_bus_nr && dev == 0)
 		return 1;
 
-	if (!orion_pcie_link_up(PCIE_BASE))
+	if (!orion_pcie_link_up(pp->base))
 		return 0;
 
-	if (bus == 0 && dev != 1)
+	if (bus == pp->root_bus_nr && dev != 1)
 		return 0;
 
 	return 1;
@@ -52,22 +66,22 @@ static int pcie_valid_config(int bus, int dev)
  * and then reading the PCIE_CONF_DATA register. Need to make sure these
  * transactions are atomic.
  */
-static DEFINE_SPINLOCK(kirkwood_pcie_lock);
 
 static int pcie_rd_conf(struct pci_bus *bus, u32 devfn, int where,
 			int size, u32 *val)
 {
+	struct pcie_port *pp = bus_to_port(bus);
 	unsigned long flags;
 	int ret;
 
-	if (pcie_valid_config(bus->number, PCI_SLOT(devfn)) == 0) {
+	if (pcie_valid_config(pp, bus->number, PCI_SLOT(devfn)) == 0) {
 		*val = 0xffffffff;
 		return PCIBIOS_DEVICE_NOT_FOUND;
 	}
 
-	spin_lock_irqsave(&kirkwood_pcie_lock, flags);
-	ret = orion_pcie_rd_conf(PCIE_BASE, bus, devfn, where, size, val);
-	spin_unlock_irqrestore(&kirkwood_pcie_lock, flags);
+	spin_lock_irqsave(&pp->conf_lock, flags);
+	ret = orion_pcie_rd_conf(pp->base, bus, devfn, where, size, val);
+	spin_unlock_irqrestore(&pp->conf_lock, flags);
 
 	return ret;
 }
@@ -75,15 +89,16 @@ static int pcie_rd_conf(struct pci_bus *bus, u32 devfn, int where,
 static int pcie_wr_conf(struct pci_bus *bus, u32 devfn,
 			int where, int size, u32 val)
 {
+	struct pcie_port *pp = bus_to_port(bus);
 	unsigned long flags;
 	int ret;
 
-	if (pcie_valid_config(bus->number, PCI_SLOT(devfn)) == 0)
+	if (pcie_valid_config(pp, bus->number, PCI_SLOT(devfn)) == 0)
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
-	spin_lock_irqsave(&kirkwood_pcie_lock, flags);
-	ret = orion_pcie_wr_conf(PCIE_BASE, bus, devfn, where, size, val);
-	spin_unlock_irqrestore(&kirkwood_pcie_lock, flags);
+	spin_lock_irqsave(&pp->conf_lock, flags);
+	ret = orion_pcie_wr_conf(pp->base, bus, devfn, where, size, val);
+	spin_unlock_irqrestore(&pp->conf_lock, flags);
 
 	return ret;
 }
@@ -93,50 +108,109 @@ static struct pci_ops pcie_ops = {
 	.write = pcie_wr_conf,
 };
 
-
-static int __init kirkwood_pcie_setup(int nr, struct pci_sys_data *sys)
+static int __init pcie0_ioresouces_setup(struct pci_sys_data *sys)
 {
-	struct resource *res;
-	extern unsigned int kirkwood_clk_ctrl;
-
+	struct pcie_port *pp = (struct pcie_port *)sys->private_data;
 	/*
-	 * Generic PCIe unit setup.
+	 * IORESOURCE_IO
 	 */
-	orion_pcie_setup(PCIE_BASE, &kirkwood_mbus_dram_info);
+	pp->res[0].name = "PCIe 0 I/O Space";
+	pp->res[0].start = KIRKWOOD_PCIE_IO_PHYS_BASE;
+	pp->res[0].end = pp->res[0].start + KIRKWOOD_PCIE_IO_SIZE - 1;
+	pp->res[0].flags = IORESOURCE_IO;
+	if (request_resource(&ioport_resource, &pp->res[0]))
+		panic("Request PCIe 0 IO resource failed\n");
+	sys->resource[0] = &pp->res[0];
 
 	/*
-	 * Request resources.
+	 * IORESOURCE_MEM
 	 */
-	res = kzalloc(sizeof(struct resource) * 2, GFP_KERNEL);
-	if (!res)
-		panic("pcie_setup unable to alloc resources");
+	pp->res[1].name = "PCIe 0 MEM";
+	pp->res[1].start = KIRKWOOD_PCIE_MEM_PHYS_BASE;
+	pp->res[1].end = pp->res[1].start + KIRKWOOD_PCIE_MEM_SIZE - 1;
+	pp->res[1].flags = IORESOURCE_MEM;
+	if (request_resource(&iomem_resource, &pp->res[1]))
+		panic("Request PCIe 0 Memory resource failed\n");
+	sys->resource[1] = &pp->res[1];
+
+	sys->resource[2] = NULL;
+	sys->io_offset = 0;
 
+	return 1;
+}
+
+static int __init pcie1_ioresouces_setup(struct pci_sys_data *sys)
+{
+	struct pcie_port *pp = (struct pcie_port *)sys->private_data;
 	/*
 	 * IORESOURCE_IO
 	 */
-	res[0].name = "PCIe I/O Space";
-	res[0].flags = IORESOURCE_IO;
-	res[0].start = KIRKWOOD_PCIE_IO_BUS_BASE;
-	res[0].end = res[0].start + KIRKWOOD_PCIE_IO_SIZE - 1;
-	if (request_resource(&ioport_resource, &res[0]))
-		panic("Request PCIe IO resource failed\n");
-	sys->resource[0] = &res[0];
+	pp->res[0].name = "PCIe 1 I/O Space";
+	pp->res[0].start = KIRKWOOD_PCIE1_IO_PHYS_BASE;
+	pp->res[0].end = pp->res[0].start + KIRKWOOD_PCIE1_IO_SIZE - 1;
+	pp->res[0].flags = IORESOURCE_IO;
+	if (request_resource(&ioport_resource, &pp->res[0]))
+		panic("Request PCIe 1 IO resource failed\n");
+	sys->resource[0] = &pp->res[0];
 
 	/*
 	 * IORESOURCE_MEM
 	 */
-	res[1].name = "PCIe Memory Space";
-	res[1].flags = IORESOURCE_MEM;
-	res[1].start = KIRKWOOD_PCIE_MEM_BUS_BASE;
-	res[1].end = res[1].start + KIRKWOOD_PCIE_MEM_SIZE - 1;
-	if (request_resource(&iomem_resource, &res[1]))
-		panic("Request PCIe Memory resource failed\n");
-	sys->resource[1] = &res[1];
+	pp->res[1].name = "PCIe 1 MEM";
+	pp->res[1].start = KIRKWOOD_PCIE1_MEM_PHYS_BASE;
+	pp->res[1].end = pp->res[1].start + KIRKWOOD_PCIE1_MEM_SIZE - 1;
+	pp->res[1].flags = IORESOURCE_MEM;
+	if (request_resource(&iomem_resource, &pp->res[1]))
+		panic("Request PCIe 1 Memory resource failed\n");
+	sys->resource[1] = &pp->res[1];
 
 	sys->resource[2] = NULL;
 	sys->io_offset = 0;
 
-	kirkwood_clk_ctrl |= CGC_PEX0;
+	return 1;
+}
+
+static int __init kirkwood_pcie_setup(int nr, struct pci_sys_data *sys)
+{
+	extern unsigned int kirkwood_clk_ctrl;
+	struct pcie_port *pp;
+	int index;
+	if (nr >= num_pcie_ports)
+		return 0;
+
+	index = pcie_port_map[nr];
+	printk(KERN_INFO "PCI: bus%d uses PCIe port %d\n", sys->busnr, index);
+
+	pp = kzalloc(sizeof(*pp), GFP_KERNEL);
+	if (!pp)
+		panic("PCIe: failed to allocate pcie_port data");
+	sys->private_data = pp;
+	pp->root_bus_nr = sys->busnr;
+	spin_lock_init(&pp->conf_lock);
+
+	switch (index) {
+	case 0:
+		pp->base = (void __iomem *)PCIE_VIRT_BASE;
+		pp->irq	= IRQ_KIRKWOOD_PCIE;
+		kirkwood_clk_ctrl |= CGC_PEX0;
+		pcie0_ioresouces_setup(sys);
+		break;
+	case 1:
+		pp->base = (void __iomem *)PCIE1_VIRT_BASE;
+		pp->irq	= IRQ_KIRKWOOD_PCIE1;
+		kirkwood_clk_ctrl |= CGC_PEX1;
+		pcie1_ioresouces_setup(sys);
+		break;
+	default:
+		panic("PCIe setup: invalid controller");
+	}
+
+	/*
+	 * Generic PCIe unit setup.
+	 */
+	orion_pcie_set_local_bus_nr(pp->base, sys->busnr);
+
+	orion_pcie_setup(pp->base, &kirkwood_mbus_dram_info);
 
 	return 1;
 }
@@ -163,7 +237,7 @@ kirkwood_pcie_scan_bus(int nr, struct pci_sys_data *sys)
 {
 	struct pci_bus *bus;
 
-	if (nr == 0) {
+	if (nr < num_pcie_ports) {
 		bus = pci_scan_bus(sys->busnr, &pcie_ops, sys);
 	} else {
 		bus = NULL;
@@ -175,18 +249,37 @@ kirkwood_pcie_scan_bus(int nr, struct pci_sys_data *sys)
 
 static int __init kirkwood_pcie_map_irq(struct pci_dev *dev, u8 slot, u8 pin)
 {
-	return IRQ_KIRKWOOD_PCIE;
+	struct pcie_port *pp = bus_to_port(dev->bus);
+
+	return pp->irq;
 }
 
 static struct hw_pci kirkwood_pci __initdata = {
-	.nr_controllers	= 1,
 	.swizzle	= pci_std_swizzle,
 	.setup		= kirkwood_pcie_setup,
 	.scan		= kirkwood_pcie_scan_bus,
 	.map_irq	= kirkwood_pcie_map_irq,
 };
 
-void __init kirkwood_pcie_init(void)
+static void __init add_pcie_port(int index, unsigned long base)
+{
+	printk(KERN_INFO "Kirkwood PCIe port %d: ", index);
+
+	if (orion_pcie_link_up((void __iomem *)base)) {
+		printk(KERN_INFO "link up\n");
+		pcie_port_map[num_pcie_ports++] = index;
+	} else
+		printk(KERN_INFO "link down, ignoring\n");
+}
+
+void __init kirkwood_pcie_init(int init_port0, int init_port1)
 {
+	if (init_port0)
+		add_pcie_port(0, PCIE_VIRT_BASE);
+
+	if (init_port1)
+		add_pcie_port(1, PCIE1_VIRT_BASE);
+
+	kirkwood_pci.nr_controllers = num_pcie_ports;
 	pci_common_init(&kirkwood_pci);
 }
diff --git a/arch/arm/mach-kirkwood/rd88f6192-nas-setup.c b/arch/arm/mach-kirkwood/rd88f6192-nas-setup.c
index 3bf6304..96b7256 100644
--- a/arch/arm/mach-kirkwood/rd88f6192-nas-setup.c
+++ b/arch/arm/mach-kirkwood/rd88f6192-nas-setup.c
@@ -71,7 +71,7 @@ static void __init rd88f6192_init(void)
 static int __init rd88f6192_pci_init(void)
 {
 	if (machine_is_rd88f6192_nas())
-		kirkwood_pcie_init();
+		kirkwood_pcie_init(1, 0);
 
 	return 0;
 }
diff --git a/arch/arm/mach-kirkwood/rd88f6281-setup.c b/arch/arm/mach-kirkwood/rd88f6281-setup.c
index 31708dd..87e8fa2 100644
--- a/arch/arm/mach-kirkwood/rd88f6281-setup.c
+++ b/arch/arm/mach-kirkwood/rd88f6281-setup.c
@@ -107,7 +107,7 @@ static void __init rd88f6281_init(void)
 static int __init rd88f6281_pci_init(void)
 {
 	if (machine_is_rd88f6281())
-		kirkwood_pcie_init();
+		kirkwood_pcie_init(1, 0);
 
 	return 0;
 }
diff --git a/arch/arm/mach-kirkwood/ts219-setup.c b/arch/arm/mach-kirkwood/ts219-setup.c
index 2830f0f..5fe8811 100644
--- a/arch/arm/mach-kirkwood/ts219-setup.c
+++ b/arch/arm/mach-kirkwood/ts219-setup.c
@@ -110,10 +110,10 @@ static void __init qnap_ts219_init(void)
 
 static int __init ts219_pci_init(void)
 {
-   if (machine_is_ts219())
-           kirkwood_pcie_init();
+	if (machine_is_ts219())
+		kirkwood_pcie_init(1, 0);
 
-   return 0;
+	return 0;
 }
 subsys_initcall(ts219_pci_init);
 
diff --git a/arch/arm/mach-kirkwood/ts41x-setup.c b/arch/arm/mach-kirkwood/ts41x-setup.c
index de49c2d..8505d30 100644
--- a/arch/arm/mach-kirkwood/ts41x-setup.c
+++ b/arch/arm/mach-kirkwood/ts41x-setup.c
@@ -136,7 +136,7 @@ static void __init qnap_ts41x_init(void)
 static int __init ts41x_pci_init(void)
 {
 	if (machine_is_ts41x())
-		kirkwood_pcie_init();
+		kirkwood_pcie_init(1, 0);
 
    return 0;
 }
-- 
1.6.0.4
