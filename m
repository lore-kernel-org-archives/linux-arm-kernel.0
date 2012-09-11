From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 11 Sep 2012 14:27:21 +0200
Subject: [PATCH v4 08/17] arm: mach-orion5x: use IOMEM() for base address
 definitions
In-Reply-To: <1347366450-26644-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1347366450-26644-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1347366450-26644-9-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We now define all virtual base address constants using IOMEM() so that
those are naturally typed as void __iomem pointers, and we do the
necessary adjustements in the mach-orion5x code.

Note that we introduce a few temporary additional "unsigned long"
casts when calling into plat-orion functions. Those are removed by
followup patches converting plat-orion functions to void __iomem
pointers as well.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-orion5x/addr-map.c             |    2 +-
 arch/arm/mach-orion5x/common.c               |   19 +++++++++++--------
 arch/arm/mach-orion5x/dns323-setup.c         |    2 +-
 arch/arm/mach-orion5x/include/mach/orion5x.h |    8 ++++----
 arch/arm/mach-orion5x/irq.c                  |    5 +++--
 arch/arm/mach-orion5x/mpp.c                  |    3 ++-
 arch/arm/mach-orion5x/pci.c                  |    4 ++--
 7 files changed, 24 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-orion5x/addr-map.c b/arch/arm/mach-orion5x/addr-map.c
index eaac83d..d309f53 100644
--- a/arch/arm/mach-orion5x/addr-map.c
+++ b/arch/arm/mach-orion5x/addr-map.c
@@ -79,7 +79,7 @@ static int __init cpu_win_can_remap(const struct orion_addr_map_cfg *cfg,
 static struct orion_addr_map_cfg addr_map_cfg __initdata = {
 	.num_wins = 8,
 	.cpu_win_can_remap = cpu_win_can_remap,
-	.bridge_virt_base = ORION5X_BRIDGE_VIRT_BASE,
+	.bridge_virt_base = (unsigned long) ORION5X_BRIDGE_VIRT_BASE,
 };
 
 static const struct __initdata orion_addr_map_info addr_map_info[] = {
diff --git a/arch/arm/mach-orion5x/common.c b/arch/arm/mach-orion5x/common.c
index 410291c..a890cb0 100644
--- a/arch/arm/mach-orion5x/common.c
+++ b/arch/arm/mach-orion5x/common.c
@@ -42,22 +42,22 @@
  ****************************************************************************/
 static struct map_desc orion5x_io_desc[] __initdata = {
 	{
-		.virtual	= ORION5X_REGS_VIRT_BASE,
+		.virtual	= (unsigned long) ORION5X_REGS_VIRT_BASE,
 		.pfn		= __phys_to_pfn(ORION5X_REGS_PHYS_BASE),
 		.length		= ORION5X_REGS_SIZE,
 		.type		= MT_DEVICE,
 	}, {
-		.virtual	= ORION5X_PCIE_IO_VIRT_BASE,
+		.virtual	= (unsigned long) ORION5X_PCIE_IO_VIRT_BASE,
 		.pfn		= __phys_to_pfn(ORION5X_PCIE_IO_PHYS_BASE),
 		.length		= ORION5X_PCIE_IO_SIZE,
 		.type		= MT_DEVICE,
 	}, {
-		.virtual	= ORION5X_PCI_IO_VIRT_BASE,
+		.virtual	= (unsigned long) ORION5X_PCI_IO_VIRT_BASE,
 		.pfn		= __phys_to_pfn(ORION5X_PCI_IO_PHYS_BASE),
 		.length		= ORION5X_PCI_IO_SIZE,
 		.type		= MT_DEVICE,
 	}, {
-		.virtual	= ORION5X_PCIE_WA_VIRT_BASE,
+		.virtual	= (unsigned long) ORION5X_PCIE_WA_VIRT_BASE,
 		.pfn		= __phys_to_pfn(ORION5X_PCIE_WA_PHYS_BASE),
 		.length		= ORION5X_PCIE_WA_SIZE,
 		.type		= MT_DEVICE,
@@ -156,7 +156,8 @@ void __init orion5x_spi_init()
  ****************************************************************************/
 void __init orion5x_uart0_init(void)
 {
-	orion_uart0_init(UART0_VIRT_BASE, UART0_PHYS_BASE,
+	orion_uart0_init((unsigned long) UART0_VIRT_BASE,
+			 UART0_PHYS_BASE,
 			 IRQ_ORION5X_UART0, tclk);
 }
 
@@ -165,7 +166,8 @@ void __init orion5x_uart0_init(void)
  ****************************************************************************/
 void __init orion5x_uart1_init(void)
 {
-	orion_uart1_init(UART1_VIRT_BASE, UART1_PHYS_BASE,
+	orion_uart1_init((unsigned long) UART1_VIRT_BASE,
+			 UART1_PHYS_BASE,
 			 IRQ_ORION5X_UART1, tclk);
 }
 
@@ -203,7 +205,7 @@ void __init orion5x_wdt_init(void)
  ****************************************************************************/
 void __init orion5x_init_early(void)
 {
-	orion_time_set_base(TIMER_VIRT_BASE);
+	orion_time_set_base((unsigned long) TIMER_VIRT_BASE);
 }
 
 int orion5x_tclk;
@@ -224,7 +226,8 @@ static void __init orion5x_timer_init(void)
 {
 	orion5x_tclk = orion5x_find_tclk();
 
-	orion_time_init(ORION5X_BRIDGE_VIRT_BASE, BRIDGE_INT_TIMER1_CLR,
+	orion_time_init((unsigned long) ORION5X_BRIDGE_VIRT_BASE,
+			BRIDGE_INT_TIMER1_CLR,
 			IRQ_ORION5X_BRIDGE, orion5x_tclk);
 }
 
diff --git a/arch/arm/mach-orion5x/dns323-setup.c b/arch/arm/mach-orion5x/dns323-setup.c
index d470864..3a5e6fc 100644
--- a/arch/arm/mach-orion5x/dns323-setup.c
+++ b/arch/arm/mach-orion5x/dns323-setup.c
@@ -700,7 +700,7 @@ static void __init dns323_init(void)
 		 * Note: AFAIK, rev B1 needs the same treatement but I'll let
 		 * somebody else test it.
 		 */
-		writel(0x5, ORION5X_SATA_VIRT_BASE | 0x2c);
+		writel(0x5, ORION5X_SATA_VIRT_BASE + 0x2c);
 		break;
 	}
 }
diff --git a/arch/arm/mach-orion5x/include/mach/orion5x.h b/arch/arm/mach-orion5x/include/mach/orion5x.h
index 87bd378..6fd38ab 100644
--- a/arch/arm/mach-orion5x/include/mach/orion5x.h
+++ b/arch/arm/mach-orion5x/include/mach/orion5x.h
@@ -37,16 +37,16 @@
  * fe000000	f0000000	16M	PCIe WA space (Orion-1/Orion-NAS only)
  ****************************************************************************/
 #define ORION5X_REGS_PHYS_BASE		0xf1000000
-#define ORION5X_REGS_VIRT_BASE		0xfdd00000
+#define ORION5X_REGS_VIRT_BASE		IOMEM(0xfdd00000)
 #define ORION5X_REGS_SIZE		SZ_1M
 
 #define ORION5X_PCIE_IO_PHYS_BASE	0xf2000000
-#define ORION5X_PCIE_IO_VIRT_BASE	0xfde00000
+#define ORION5X_PCIE_IO_VIRT_BASE	IOMEM(0xfde00000)
 #define ORION5X_PCIE_IO_BUS_BASE	0x00000000
 #define ORION5X_PCIE_IO_SIZE		SZ_1M
 
 #define ORION5X_PCI_IO_PHYS_BASE	0xf2100000
-#define ORION5X_PCI_IO_VIRT_BASE	0xfdf00000
+#define ORION5X_PCI_IO_VIRT_BASE	IOMEM(0xfdf00000)
 #define ORION5X_PCI_IO_BUS_BASE		0x00100000
 #define ORION5X_PCI_IO_SIZE		SZ_1M
 
@@ -55,7 +55,7 @@
 
 /* Relevant only for Orion-1/Orion-NAS */
 #define ORION5X_PCIE_WA_PHYS_BASE	0xf0000000
-#define ORION5X_PCIE_WA_VIRT_BASE	0xfe000000
+#define ORION5X_PCIE_WA_VIRT_BASE	IOMEM(0xfe000000)
 #define ORION5X_PCIE_WA_SIZE		SZ_16M
 
 #define ORION5X_PCIE_MEM_PHYS_BASE	0xe0000000
diff --git a/arch/arm/mach-orion5x/irq.c b/arch/arm/mach-orion5x/irq.c
index 17da709..bf9ff4f 100644
--- a/arch/arm/mach-orion5x/irq.c
+++ b/arch/arm/mach-orion5x/irq.c
@@ -12,6 +12,7 @@
 #include <linux/gpio.h>
 #include <linux/kernel.h>
 #include <linux/irq.h>
+#include <linux/io.h>
 #include <mach/bridge-regs.h>
 #include <plat/irq.h>
 
@@ -24,11 +25,11 @@ static int __initdata gpio0_irqs[4] = {
 
 void __init orion5x_init_irq(void)
 {
-	orion_irq_init(0, (void __iomem *)MAIN_IRQ_MASK);
+	orion_irq_init(0, MAIN_IRQ_MASK);
 
 	/*
 	 * Initialize gpiolib for GPIOs 0-31.
 	 */
-	orion_gpio_init(NULL, 0, 32, (void __iomem *)GPIO_VIRT_BASE, 0,
+	orion_gpio_init(NULL, 0, 32, GPIO_VIRT_BASE, 0,
 			IRQ_ORION5X_GPIO_START, gpio0_irqs);
 }
diff --git a/arch/arm/mach-orion5x/mpp.c b/arch/arm/mach-orion5x/mpp.c
index 5b70026..30f5ef6 100644
--- a/arch/arm/mach-orion5x/mpp.c
+++ b/arch/arm/mach-orion5x/mpp.c
@@ -40,5 +40,6 @@ static unsigned int __init orion5x_variant(void)
 void __init orion5x_mpp_conf(unsigned int *mpp_list)
 {
 	orion_mpp_conf(mpp_list, orion5x_variant(),
-		       MPP_MAX, ORION5X_DEV_BUS_VIRT_BASE);
+		       MPP_MAX,
+		       (unsigned long) ORION5X_DEV_BUS_VIRT_BASE);
 }
diff --git a/arch/arm/mach-orion5x/pci.c b/arch/arm/mach-orion5x/pci.c
index b36f928..b0822a8 100644
--- a/arch/arm/mach-orion5x/pci.c
+++ b/arch/arm/mach-orion5x/pci.c
@@ -38,7 +38,7 @@
 /*****************************************************************************
  * PCIe controller
  ****************************************************************************/
-#define PCIE_BASE	((void __iomem *)ORION5X_PCIE_VIRT_BASE)
+#define PCIE_BASE	(ORION5X_PCIE_VIRT_BASE)
 
 void __init orion5x_pcie_id(u32 *dev, u32 *rev)
 {
@@ -111,7 +111,7 @@ static int pcie_rd_conf_wa(struct pci_bus *bus, u32 devfn,
 		return PCIBIOS_DEVICE_NOT_FOUND;
 	}
 
-	ret = orion_pcie_rd_conf_wa((void __iomem *)ORION5X_PCIE_WA_VIRT_BASE,
+	ret = orion_pcie_rd_conf_wa(ORION5X_PCIE_WA_VIRT_BASE,
 				    bus, devfn, where, size, val);
 
 	return ret;
-- 
1.7.9.5
