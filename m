From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 11 Sep 2012 14:27:18 +0200
Subject: [PATCH v4 05/17] arm: mach-dove: use IOMEM() for base address
 definitions
In-Reply-To: <1347366450-26644-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1347366450-26644-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1347366450-26644-6-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We now define all virtual base address constants using IOMEM() so that
those are naturally typed as void __iomem pointers, and we do the
necessary adjustements in the mach-dove code.

Note that we introduce a few temporary additional "unsigned long"
casts when calling into plat-orion functions. Those are removed by
followup patches converting plat-orion functions to void __iomem
pointers as well.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-dove/addr-map.c          |    2 +-
 arch/arm/mach-dove/common.c            |   25 +++++++++++++++----------
 arch/arm/mach-dove/include/mach/dove.h |   12 ++++++------
 arch/arm/mach-dove/irq.c               |   10 +++++-----
 arch/arm/mach-dove/mpp.c               |    3 ++-
 arch/arm/mach-dove/pcie.c              |    6 +++---
 6 files changed, 32 insertions(+), 26 deletions(-)

diff --git a/arch/arm/mach-dove/addr-map.c b/arch/arm/mach-dove/addr-map.c
index 2a06c01..b92c9c7 100644
--- a/arch/arm/mach-dove/addr-map.c
+++ b/arch/arm/mach-dove/addr-map.c
@@ -47,7 +47,7 @@ static inline void __iomem *ddr_map_sc(int i)
 static struct __initdata orion_addr_map_cfg addr_map_cfg = {
 	.num_wins = 8,
 	.remappable_wins = 4,
-	.bridge_virt_base = BRIDGE_VIRT_BASE,
+	.bridge_virt_base = (unsigned long) BRIDGE_VIRT_BASE,
 };
 
 static const struct __initdata orion_addr_map_info addr_map_info[] = {
diff --git a/arch/arm/mach-dove/common.c b/arch/arm/mach-dove/common.c
index 6321567..533fd81 100644
--- a/arch/arm/mach-dove/common.c
+++ b/arch/arm/mach-dove/common.c
@@ -40,22 +40,22 @@ static int get_tclk(void);
  ****************************************************************************/
 static struct map_desc dove_io_desc[] __initdata = {
 	{
-		.virtual	= DOVE_SB_REGS_VIRT_BASE,
+		.virtual	= (unsigned long) DOVE_SB_REGS_VIRT_BASE,
 		.pfn		= __phys_to_pfn(DOVE_SB_REGS_PHYS_BASE),
 		.length		= DOVE_SB_REGS_SIZE,
 		.type		= MT_DEVICE,
 	}, {
-		.virtual	= DOVE_NB_REGS_VIRT_BASE,
+		.virtual	= (unsigned long) DOVE_NB_REGS_VIRT_BASE,
 		.pfn		= __phys_to_pfn(DOVE_NB_REGS_PHYS_BASE),
 		.length		= DOVE_NB_REGS_SIZE,
 		.type		= MT_DEVICE,
 	}, {
-		.virtual	= DOVE_PCIE0_IO_VIRT_BASE,
+		.virtual	= (unsigned long) DOVE_PCIE0_IO_VIRT_BASE,
 		.pfn		= __phys_to_pfn(DOVE_PCIE0_IO_PHYS_BASE),
 		.length		= DOVE_PCIE0_IO_SIZE,
 		.type		= MT_DEVICE,
 	}, {
-		.virtual	= DOVE_PCIE1_IO_VIRT_BASE,
+		.virtual	= (unsigned long) DOVE_PCIE1_IO_VIRT_BASE,
 		.pfn		= __phys_to_pfn(DOVE_PCIE1_IO_PHYS_BASE),
 		.length		= DOVE_PCIE1_IO_SIZE,
 		.type		= MT_DEVICE,
@@ -128,7 +128,8 @@ void __init dove_sata_init(struct mv_sata_platform_data *sata_data)
  ****************************************************************************/
 void __init dove_uart0_init(void)
 {
-	orion_uart0_init(DOVE_UART0_VIRT_BASE, DOVE_UART0_PHYS_BASE,
+	orion_uart0_init((unsigned long) DOVE_UART0_VIRT_BASE,
+			 DOVE_UART0_PHYS_BASE,
 			 IRQ_DOVE_UART_0, tclk);
 }
 
@@ -137,7 +138,8 @@ void __init dove_uart0_init(void)
  ****************************************************************************/
 void __init dove_uart1_init(void)
 {
-	orion_uart1_init(DOVE_UART1_VIRT_BASE, DOVE_UART1_PHYS_BASE,
+	orion_uart1_init((unsigned long) DOVE_UART1_VIRT_BASE,
+			 DOVE_UART1_PHYS_BASE,
 			 IRQ_DOVE_UART_1, tclk);
 }
 
@@ -146,7 +148,8 @@ void __init dove_uart1_init(void)
  ****************************************************************************/
 void __init dove_uart2_init(void)
 {
-	orion_uart2_init(DOVE_UART2_VIRT_BASE, DOVE_UART2_PHYS_BASE,
+	orion_uart2_init((unsigned long) DOVE_UART2_VIRT_BASE,
+			 DOVE_UART2_PHYS_BASE,
 			 IRQ_DOVE_UART_2, tclk);
 }
 
@@ -155,7 +158,8 @@ void __init dove_uart2_init(void)
  ****************************************************************************/
 void __init dove_uart3_init(void)
 {
-	orion_uart3_init(DOVE_UART3_VIRT_BASE, DOVE_UART3_PHYS_BASE,
+	orion_uart3_init((unsigned long) DOVE_UART3_VIRT_BASE,
+			 DOVE_UART3_PHYS_BASE,
 			 IRQ_DOVE_UART_3, tclk);
 }
 
@@ -185,7 +189,7 @@ void __init dove_i2c_init(void)
  ****************************************************************************/
 void __init dove_init_early(void)
 {
-	orion_time_set_base(TIMER_VIRT_BASE);
+	orion_time_set_base((unsigned long) TIMER_VIRT_BASE);
 }
 
 static int get_tclk(void)
@@ -196,7 +200,8 @@ static int get_tclk(void)
 
 static void __init dove_timer_init(void)
 {
-	orion_time_init(BRIDGE_VIRT_BASE, BRIDGE_INT_TIMER1_CLR,
+	orion_time_init((unsigned long) BRIDGE_VIRT_BASE,
+			BRIDGE_INT_TIMER1_CLR,
 			IRQ_DOVE_BRIDGE, get_tclk());
 }
 
diff --git a/arch/arm/mach-dove/include/mach/dove.h b/arch/arm/mach-dove/include/mach/dove.h
index cccfd1d..735dd2e 100644
--- a/arch/arm/mach-dove/include/mach/dove.h
+++ b/arch/arm/mach-dove/include/mach/dove.h
@@ -25,7 +25,7 @@
  */
 
 #define DOVE_CESA_PHYS_BASE		0xc8000000
-#define DOVE_CESA_VIRT_BASE		0xfdb00000
+#define DOVE_CESA_VIRT_BASE		IOMEM(0xfdb00000)
 #define DOVE_CESA_SIZE			SZ_1M
 
 #define DOVE_PCIE0_MEM_PHYS_BASE	0xe0000000
@@ -38,24 +38,24 @@
 #define DOVE_BOOTROM_SIZE		SZ_128M
 
 #define DOVE_SCRATCHPAD_PHYS_BASE	0xf0000000
-#define DOVE_SCRATCHPAD_VIRT_BASE	0xfdd00000
+#define DOVE_SCRATCHPAD_VIRT_BASE	IOMEM(0xfdd00000)
 #define DOVE_SCRATCHPAD_SIZE		SZ_1M
 
 #define DOVE_SB_REGS_PHYS_BASE		0xf1000000
-#define DOVE_SB_REGS_VIRT_BASE		0xfde00000
+#define DOVE_SB_REGS_VIRT_BASE		IOMEM(0xfde00000)
 #define DOVE_SB_REGS_SIZE		SZ_8M
 
 #define DOVE_NB_REGS_PHYS_BASE		0xf1800000
-#define DOVE_NB_REGS_VIRT_BASE		0xfe600000
+#define DOVE_NB_REGS_VIRT_BASE		IOMEM(0xfe600000)
 #define DOVE_NB_REGS_SIZE		SZ_8M
 
 #define DOVE_PCIE0_IO_PHYS_BASE		0xf2000000
-#define DOVE_PCIE0_IO_VIRT_BASE		0xfee00000
+#define DOVE_PCIE0_IO_VIRT_BASE		IOMEM(0xfee00000)
 #define DOVE_PCIE0_IO_BUS_BASE		0x00000000
 #define DOVE_PCIE0_IO_SIZE		SZ_1M
 
 #define DOVE_PCIE1_IO_PHYS_BASE		0xf2100000
-#define DOVE_PCIE1_IO_VIRT_BASE		0xfef00000
+#define DOVE_PCIE1_IO_VIRT_BASE		IOMEM(0xfef00000)
 #define DOVE_PCIE1_IO_BUS_BASE		0x00100000
 #define DOVE_PCIE1_IO_SIZE		SZ_1M
 
diff --git a/arch/arm/mach-dove/irq.c b/arch/arm/mach-dove/irq.c
index 9bc97a5..4ce306a 100644
--- a/arch/arm/mach-dove/irq.c
+++ b/arch/arm/mach-dove/irq.c
@@ -99,19 +99,19 @@ void __init dove_init_irq(void)
 {
 	int i;
 
-	orion_irq_init(0, (void __iomem *)(IRQ_VIRT_BASE + IRQ_MASK_LOW_OFF));
-	orion_irq_init(32, (void __iomem *)(IRQ_VIRT_BASE + IRQ_MASK_HIGH_OFF));
+	orion_irq_init(0, IRQ_VIRT_BASE + IRQ_MASK_LOW_OFF);
+	orion_irq_init(32, IRQ_VIRT_BASE + IRQ_MASK_HIGH_OFF);
 
 	/*
 	 * Initialize gpiolib for GPIOs 0-71.
 	 */
-	orion_gpio_init(NULL, 0, 32, (void __iomem *)DOVE_GPIO_LO_VIRT_BASE, 0,
+	orion_gpio_init(NULL, 0, 32, DOVE_GPIO_LO_VIRT_BASE, 0,
 			IRQ_DOVE_GPIO_START, gpio0_irqs);
 
-	orion_gpio_init(NULL, 32, 32, (void __iomem *)DOVE_GPIO_HI_VIRT_BASE, 0,
+	orion_gpio_init(NULL, 32, 32, DOVE_GPIO_HI_VIRT_BASE, 0,
 			IRQ_DOVE_GPIO_START + 32, gpio1_irqs);
 
-	orion_gpio_init(NULL, 64, 8, (void __iomem *)DOVE_GPIO2_VIRT_BASE, 0,
+	orion_gpio_init(NULL, 64, 8, DOVE_GPIO2_VIRT_BASE, 0,
 			IRQ_DOVE_GPIO_START + 64, gpio2_irqs);
 
 	/*
diff --git a/arch/arm/mach-dove/mpp.c b/arch/arm/mach-dove/mpp.c
index 7f70afc..fc04ebe 100644
--- a/arch/arm/mach-dove/mpp.c
+++ b/arch/arm/mach-dove/mpp.c
@@ -151,7 +151,8 @@ void __init dove_mpp_conf(unsigned int *mpp_list,
 	dove_mpp_dump_regs();
 
 	/* Use platform code for pins 0-23 */
-	orion_mpp_conf(mpp_list, 0, MPP_MAX, DOVE_MPP_VIRT_BASE);
+	orion_mpp_conf(mpp_list, 0, MPP_MAX,
+		       (unsigned long) DOVE_MPP_VIRT_BASE);
 
 	dove_mpp_conf_grp(mpp_grp_list);
 	dove_mpp_cfg_au1(grp_au1_52_57);
diff --git a/arch/arm/mach-dove/pcie.c b/arch/arm/mach-dove/pcie.c
index 47921b0..b372441 100644
--- a/arch/arm/mach-dove/pcie.c
+++ b/arch/arm/mach-dove/pcie.c
@@ -197,18 +197,18 @@ static struct hw_pci dove_pci __initdata = {
 	.map_irq	= dove_pcie_map_irq,
 };
 
-static void __init add_pcie_port(int index, unsigned long base)
+static void __init add_pcie_port(int index, void __iomem *base)
 {
 	printk(KERN_INFO "Dove PCIe port %d: ", index);
 
-	if (orion_pcie_link_up((void __iomem *)base)) {
+	if (orion_pcie_link_up(base)) {
 		struct pcie_port *pp = &pcie_port[num_pcie_ports++];
 
 		printk(KERN_INFO "link up\n");
 
 		pp->index = index;
 		pp->root_bus_nr = -1;
-		pp->base = (void __iomem *)base;
+		pp->base = base;
 		spin_lock_init(&pp->conf_lock);
 		memset(pp->res, 0, sizeof(pp->res));
 	} else {
-- 
1.7.9.5
