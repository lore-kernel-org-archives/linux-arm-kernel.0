From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 11 Sep 2012 14:27:20 +0200
Subject: [PATCH v4 07/17] arm: mach-mv78xx0: use IOMEM() for base address
 definitions
In-Reply-To: <1347366450-26644-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1347366450-26644-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1347366450-26644-8-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We now define all virtual base address constants using IOMEM() so that
those are naturally typed as void __iomem pointers, and we do the
necessary adjustements in the mach-mv78xx0 code.

Note that we introduce a few temporary additional "unsigned long"
casts when calling into plat-orion functions. Those are removed by
followup patches converting plat-orion functions to void __iomem
pointers as well.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-mv78xx0/addr-map.c             |    2 +-
 arch/arm/mach-mv78xx0/common.c               |   23 ++++++++++++++---------
 arch/arm/mach-mv78xx0/include/mach/mv78xx0.h |    6 +++---
 arch/arm/mach-mv78xx0/irq.c                  |    9 +++++----
 arch/arm/mach-mv78xx0/mpp.c                  |    3 ++-
 arch/arm/mach-mv78xx0/pcie.c                 |   12 ++++++------
 6 files changed, 31 insertions(+), 24 deletions(-)

diff --git a/arch/arm/mach-mv78xx0/addr-map.c b/arch/arm/mach-mv78xx0/addr-map.c
index a9bc841..3358f07 100644
--- a/arch/arm/mach-mv78xx0/addr-map.c
+++ b/arch/arm/mach-mv78xx0/addr-map.c
@@ -47,7 +47,7 @@ static void __init __iomem *win_cfg_base(const struct orion_addr_map_cfg *cfg, i
 	 * so we don't need to take that into account here.
 	 */
 
-	return (void __iomem *)((win < 8) ? WIN0_OFF(win) : WIN8_OFF(win));
+	return (win < 8) ? WIN0_OFF(win) : WIN8_OFF(win);
 }
 
 /*
diff --git a/arch/arm/mach-mv78xx0/common.c b/arch/arm/mach-mv78xx0/common.c
index 3057f7d..c4e3458 100644
--- a/arch/arm/mach-mv78xx0/common.c
+++ b/arch/arm/mach-mv78xx0/common.c
@@ -130,17 +130,17 @@ static int get_tclk(void)
  ****************************************************************************/
 static struct map_desc mv78xx0_io_desc[] __initdata = {
 	{
-		.virtual	= MV78XX0_CORE_REGS_VIRT_BASE,
+		.virtual	= (unsigned long) MV78XX0_CORE_REGS_VIRT_BASE,
 		.pfn		= 0,
 		.length		= MV78XX0_CORE_REGS_SIZE,
 		.type		= MT_DEVICE,
 	}, {
-		.virtual	= MV78XX0_PCIE_IO_VIRT_BASE(0),
+		.virtual	= (unsigned long) MV78XX0_PCIE_IO_VIRT_BASE(0),
 		.pfn		= __phys_to_pfn(MV78XX0_PCIE_IO_PHYS_BASE(0)),
 		.length		= MV78XX0_PCIE_IO_SIZE * 8,
 		.type		= MT_DEVICE,
 	}, {
-		.virtual	= MV78XX0_REGS_VIRT_BASE,
+		.virtual	= (unsigned long) MV78XX0_REGS_VIRT_BASE,
 		.pfn		= __phys_to_pfn(MV78XX0_REGS_PHYS_BASE),
 		.length		= MV78XX0_REGS_SIZE,
 		.type		= MT_DEVICE,
@@ -300,7 +300,8 @@ void __init mv78xx0_sata_init(struct mv_sata_platform_data *sata_data)
  ****************************************************************************/
 void __init mv78xx0_uart0_init(void)
 {
-	orion_uart0_init(UART0_VIRT_BASE, UART0_PHYS_BASE,
+	orion_uart0_init((unsigned long) UART0_VIRT_BASE,
+			 UART0_PHYS_BASE,
 			 IRQ_MV78XX0_UART_0, tclk);
 }
 
@@ -310,7 +311,8 @@ void __init mv78xx0_uart0_init(void)
  ****************************************************************************/
 void __init mv78xx0_uart1_init(void)
 {
-	orion_uart1_init(UART1_VIRT_BASE, UART1_PHYS_BASE,
+	orion_uart1_init((unsigned long) UART1_VIRT_BASE,
+			 UART1_PHYS_BASE,
 			 IRQ_MV78XX0_UART_1, tclk);
 }
 
@@ -320,7 +322,8 @@ void __init mv78xx0_uart1_init(void)
  ****************************************************************************/
 void __init mv78xx0_uart2_init(void)
 {
-	orion_uart2_init(UART2_VIRT_BASE, UART2_PHYS_BASE,
+	orion_uart2_init((unsigned long) UART2_VIRT_BASE,
+			 UART2_PHYS_BASE,
 			 IRQ_MV78XX0_UART_2, tclk);
 }
 
@@ -329,7 +332,8 @@ void __init mv78xx0_uart2_init(void)
  ****************************************************************************/
 void __init mv78xx0_uart3_init(void)
 {
-	orion_uart3_init(UART3_VIRT_BASE, UART3_PHYS_BASE,
+	orion_uart3_init((unsigned long) UART3_VIRT_BASE,
+			 UART3_PHYS_BASE,
 			 IRQ_MV78XX0_UART_3, tclk);
 }
 
@@ -338,12 +342,13 @@ void __init mv78xx0_uart3_init(void)
  ****************************************************************************/
 void __init mv78xx0_init_early(void)
 {
-	orion_time_set_base(TIMER_VIRT_BASE);
+	orion_time_set_base((unsigned long) TIMER_VIRT_BASE);
 }
 
 static void mv78xx0_timer_init(void)
 {
-	orion_time_init(BRIDGE_VIRT_BASE, BRIDGE_INT_TIMER1_CLR,
+	orion_time_init((unsigned long) BRIDGE_VIRT_BASE,
+			BRIDGE_INT_TIMER1_CLR,
 			IRQ_MV78XX0_TIMER_1, get_tclk());
 }
 
diff --git a/arch/arm/mach-mv78xx0/include/mach/mv78xx0.h b/arch/arm/mach-mv78xx0/include/mach/mv78xx0.h
index a86e79e..62405e8 100644
--- a/arch/arm/mach-mv78xx0/include/mach/mv78xx0.h
+++ b/arch/arm/mach-mv78xx0/include/mach/mv78xx0.h
@@ -41,16 +41,16 @@
  */
 #define MV78XX0_CORE0_REGS_PHYS_BASE	0xf1020000
 #define MV78XX0_CORE1_REGS_PHYS_BASE	0xf1024000
-#define MV78XX0_CORE_REGS_VIRT_BASE	0xfe400000
+#define MV78XX0_CORE_REGS_VIRT_BASE	IOMEM(0xfe400000)
 #define MV78XX0_CORE_REGS_PHYS_BASE	0xfe400000
 #define MV78XX0_CORE_REGS_SIZE		SZ_16K
 
 #define MV78XX0_PCIE_IO_PHYS_BASE(i)	(0xf0800000 + ((i) << 20))
-#define MV78XX0_PCIE_IO_VIRT_BASE(i)	(0xfe700000 + ((i) << 20))
+#define MV78XX0_PCIE_IO_VIRT_BASE(i)	IOMEM(0xfe700000 + ((i) << 20))
 #define MV78XX0_PCIE_IO_SIZE		SZ_1M
 
 #define MV78XX0_REGS_PHYS_BASE		0xf1000000
-#define MV78XX0_REGS_VIRT_BASE		0xfef00000
+#define MV78XX0_REGS_VIRT_BASE		IOMEM(0xfef00000)
 #define MV78XX0_REGS_SIZE		SZ_1M
 
 #define MV78XX0_PCIE_MEM_PHYS_BASE	0xc0000000
diff --git a/arch/arm/mach-mv78xx0/irq.c b/arch/arm/mach-mv78xx0/irq.c
index eff9a75..b5c40c4 100644
--- a/arch/arm/mach-mv78xx0/irq.c
+++ b/arch/arm/mach-mv78xx0/irq.c
@@ -10,6 +10,7 @@
 #include <linux/gpio.h>
 #include <linux/kernel.h>
 #include <linux/irq.h>
+#include <linux/io.h>
 #include <mach/bridge-regs.h>
 #include <plat/irq.h>
 #include "common.h"
@@ -23,16 +24,16 @@ static int __initdata gpio0_irqs[4] = {
 
 void __init mv78xx0_init_irq(void)
 {
-	orion_irq_init(0, (void __iomem *)(IRQ_VIRT_BASE + IRQ_MASK_LOW_OFF));
-	orion_irq_init(32, (void __iomem *)(IRQ_VIRT_BASE + IRQ_MASK_HIGH_OFF));
-	orion_irq_init(64, (void __iomem *)(IRQ_VIRT_BASE + IRQ_MASK_ERR_OFF));
+	orion_irq_init(0, IRQ_VIRT_BASE + IRQ_MASK_LOW_OFF);
+	orion_irq_init(32, IRQ_VIRT_BASE + IRQ_MASK_HIGH_OFF);
+	orion_irq_init(64, IRQ_VIRT_BASE + IRQ_MASK_ERR_OFF);
 
 	/*
 	 * Initialize gpiolib for GPIOs 0-31.  (The GPIO interrupt mask
 	 * registers for core #1 are at an offset of 0x18 from those of
 	 * core #0.)
 	 */
-	orion_gpio_init(NULL, 0, 32, (void __iomem *)GPIO_VIRT_BASE,
+	orion_gpio_init(NULL, 0, 32, GPIO_VIRT_BASE,
 			mv78xx0_core_index() ? 0x18 : 0,
 			IRQ_MV78XX0_GPIO_START, gpio0_irqs);
 }
diff --git a/arch/arm/mach-mv78xx0/mpp.c b/arch/arm/mach-mv78xx0/mpp.c
index df50342..4da82f8 100644
--- a/arch/arm/mach-mv78xx0/mpp.c
+++ b/arch/arm/mach-mv78xx0/mpp.c
@@ -33,5 +33,6 @@ static unsigned int __init mv78xx0_variant(void)
 void __init mv78xx0_mpp_conf(unsigned int *mpp_list)
 {
 	orion_mpp_conf(mpp_list, mv78xx0_variant(),
-		       MPP_MAX, DEV_BUS_VIRT_BASE);
+		       MPP_MAX,
+		       (unsigned long) DEV_BUS_VIRT_BASE);
 }
diff --git a/arch/arm/mach-mv78xx0/pcie.c b/arch/arm/mach-mv78xx0/pcie.c
index 2e56e86..e2940fb 100644
--- a/arch/arm/mach-mv78xx0/pcie.c
+++ b/arch/arm/mach-mv78xx0/pcie.c
@@ -36,8 +36,8 @@ static struct resource pcie_mem_space;
 
 void __init mv78xx0_pcie_id(u32 *dev, u32 *rev)
 {
-	*dev = orion_pcie_dev_id((void __iomem *)PCIE00_VIRT_BASE);
-	*rev = orion_pcie_rev((void __iomem *)PCIE00_VIRT_BASE);
+	*dev = orion_pcie_dev_id(PCIE00_VIRT_BASE);
+	*rev = orion_pcie_rev(PCIE00_VIRT_BASE);
 }
 
 static void __init mv78xx0_pcie_preinit(void)
@@ -267,11 +267,11 @@ static struct hw_pci mv78xx0_pci __initdata = {
 	.map_irq	= mv78xx0_pcie_map_irq,
 };
 
-static void __init add_pcie_port(int maj, int min, unsigned long base)
+static void __init add_pcie_port(int maj, int min, void __iomem *base)
 {
 	printk(KERN_INFO "MV78xx0 PCIe port %d.%d: ", maj, min);
 
-	if (orion_pcie_link_up((void __iomem *)base)) {
+	if (orion_pcie_link_up(base)) {
 		struct pcie_port *pp = &pcie_port[num_pcie_ports++];
 
 		printk("link up\n");
@@ -279,7 +279,7 @@ static void __init add_pcie_port(int maj, int min, unsigned long base)
 		pp->maj = maj;
 		pp->min = min;
 		pp->root_bus_nr = -1;
-		pp->base = (void __iomem *)base;
+		pp->base = base;
 		spin_lock_init(&pp->conf_lock);
 		memset(pp->res, 0, sizeof(pp->res));
 	} else {
@@ -293,7 +293,7 @@ void __init mv78xx0_pcie_init(int init_port0, int init_port1)
 
 	if (init_port0) {
 		add_pcie_port(0, 0, PCIE00_VIRT_BASE);
-		if (!orion_pcie_x4_mode((void __iomem *)PCIE00_VIRT_BASE)) {
+		if (!orion_pcie_x4_mode(PCIE00_VIRT_BASE)) {
 			add_pcie_port(0, 1, PCIE01_VIRT_BASE);
 			add_pcie_port(0, 2, PCIE02_VIRT_BASE);
 			add_pcie_port(0, 3, PCIE03_VIRT_BASE);
-- 
1.7.9.5
