From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 11 Sep 2012 14:27:19 +0200
Subject: [PATCH v4 06/17] arm: mach-kirkwood: use IOMEM() for base address
 definitions
In-Reply-To: <1347366450-26644-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1347366450-26644-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1347366450-26644-7-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We now define all virtual base address constants using IOMEM() so that
those are naturally typed as void __iomem pointers, and we do the
necessary adjustements in the mach-kirkwood code.

Note that we introduce a few temporary additional "unsigned long"
casts when calling into plat-orion functions. Those are removed by
followup patches converting plat-orion functions to void __iomem
pointers as well.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-kirkwood/addr-map.c              |    2 +-
 arch/arm/mach-kirkwood/common.c                |   23 ++++++++++++-----------
 arch/arm/mach-kirkwood/include/mach/kirkwood.h |    6 +++---
 arch/arm/mach-kirkwood/irq.c                   |    9 +++++----
 arch/arm/mach-kirkwood/mpp.c                   |    3 ++-
 arch/arm/mach-kirkwood/pcie.c                  |   12 ++++++------
 arch/arm/mach-kirkwood/ts41x-setup.c           |    3 ++-
 7 files changed, 31 insertions(+), 27 deletions(-)

diff --git a/arch/arm/mach-kirkwood/addr-map.c b/arch/arm/mach-kirkwood/addr-map.c
index e9a7180..1b8c75c 100644
--- a/arch/arm/mach-kirkwood/addr-map.c
+++ b/arch/arm/mach-kirkwood/addr-map.c
@@ -41,7 +41,7 @@
 static struct __initdata orion_addr_map_cfg addr_map_cfg = {
 	.num_wins = 8,
 	.remappable_wins = 4,
-	.bridge_virt_base = BRIDGE_VIRT_BASE,
+	.bridge_virt_base = (unsigned long) BRIDGE_VIRT_BASE,
 };
 
 static const struct __initdata orion_addr_map_info addr_map_info[] = {
diff --git a/arch/arm/mach-kirkwood/common.c b/arch/arm/mach-kirkwood/common.c
index 1201191..75bc04d 100644
--- a/arch/arm/mach-kirkwood/common.c
+++ b/arch/arm/mach-kirkwood/common.c
@@ -42,17 +42,17 @@
  ****************************************************************************/
 static struct map_desc kirkwood_io_desc[] __initdata = {
 	{
-		.virtual	= KIRKWOOD_PCIE_IO_VIRT_BASE,
+		.virtual	= (unsigned long) KIRKWOOD_PCIE_IO_VIRT_BASE,
 		.pfn		= __phys_to_pfn(KIRKWOOD_PCIE_IO_PHYS_BASE),
 		.length		= KIRKWOOD_PCIE_IO_SIZE,
 		.type		= MT_DEVICE,
 	}, {
-		.virtual	= KIRKWOOD_PCIE1_IO_VIRT_BASE,
+		.virtual	= (unsigned long) KIRKWOOD_PCIE1_IO_VIRT_BASE,
 		.pfn		= __phys_to_pfn(KIRKWOOD_PCIE1_IO_PHYS_BASE),
 		.length		= KIRKWOOD_PCIE1_IO_SIZE,
 		.type		= MT_DEVICE,
 	}, {
-		.virtual	= KIRKWOOD_REGS_VIRT_BASE,
+		.virtual	= (unsigned long) KIRKWOOD_REGS_VIRT_BASE,
 		.pfn		= __phys_to_pfn(KIRKWOOD_REGS_PHYS_BASE),
 		.length		= KIRKWOOD_REGS_SIZE,
 		.type		= MT_DEVICE,
@@ -215,8 +215,7 @@ static struct clk *tclk;
 
 static struct clk __init *kirkwood_register_gate(const char *name, u8 bit_idx)
 {
-	return clk_register_gate(NULL, name, "tclk", 0,
-				 (void __iomem *)CLOCK_GATING_CTRL,
+	return clk_register_gate(NULL, name, "tclk", 0, CLOCK_GATING_CTRL,
 				 bit_idx, 0, &gating_lock);
 }
 
@@ -225,8 +224,7 @@ static struct clk __init *kirkwood_register_gate_fn(const char *name,
 						    void (*fn_en)(void),
 						    void (*fn_dis)(void))
 {
-	return clk_register_gate_fn(NULL, name, "tclk", 0,
-				    (void __iomem *)CLOCK_GATING_CTRL,
+	return clk_register_gate_fn(NULL, name, "tclk", 0, CLOCK_GATING_CTRL,
 				    bit_idx, 0, &gating_lock, fn_en, fn_dis);
 }
 
@@ -458,7 +456,8 @@ void __init kirkwood_i2c_init(void)
 
 void __init kirkwood_uart0_init(void)
 {
-	orion_uart0_init(UART0_VIRT_BASE, UART0_PHYS_BASE,
+	orion_uart0_init((unsigned long) UART0_VIRT_BASE,
+			 UART0_PHYS_BASE,
 			 IRQ_KIRKWOOD_UART_0, tclk);
 }
 
@@ -468,7 +467,8 @@ void __init kirkwood_uart0_init(void)
  ****************************************************************************/
 void __init kirkwood_uart1_init(void)
 {
-	orion_uart1_init(UART1_VIRT_BASE, UART1_PHYS_BASE,
+	orion_uart1_init((unsigned long) UART1_VIRT_BASE,
+			 UART1_PHYS_BASE,
 			 IRQ_KIRKWOOD_UART_1, tclk);
 }
 
@@ -516,7 +516,7 @@ void __init kirkwood_wdt_init(void)
  ****************************************************************************/
 void __init kirkwood_init_early(void)
 {
-	orion_time_set_base(TIMER_VIRT_BASE);
+	orion_time_set_base((unsigned long) TIMER_VIRT_BASE);
 
 	/*
 	 * Some Kirkwood devices allocate their coherent buffers from atomic
@@ -545,7 +545,8 @@ static void __init kirkwood_timer_init(void)
 {
 	kirkwood_tclk = kirkwood_find_tclk();
 
-	orion_time_init(BRIDGE_VIRT_BASE, BRIDGE_INT_TIMER1_CLR,
+	orion_time_init((unsigned long) BRIDGE_VIRT_BASE,
+			BRIDGE_INT_TIMER1_CLR,
 			IRQ_KIRKWOOD_BRIDGE, kirkwood_tclk);
 }
 
diff --git a/arch/arm/mach-kirkwood/include/mach/kirkwood.h b/arch/arm/mach-kirkwood/include/mach/kirkwood.h
index 9695592..d3ea682 100644
--- a/arch/arm/mach-kirkwood/include/mach/kirkwood.h
+++ b/arch/arm/mach-kirkwood/include/mach/kirkwood.h
@@ -37,17 +37,17 @@
 #define KIRKWOOD_NAND_MEM_SIZE		SZ_1K
 
 #define KIRKWOOD_PCIE1_IO_PHYS_BASE	0xf3000000
-#define KIRKWOOD_PCIE1_IO_VIRT_BASE	0xfef00000
+#define KIRKWOOD_PCIE1_IO_VIRT_BASE	IOMEM(0xfef00000)
 #define KIRKWOOD_PCIE1_IO_BUS_BASE	0x00100000
 #define KIRKWOOD_PCIE1_IO_SIZE		SZ_1M
 
 #define KIRKWOOD_PCIE_IO_PHYS_BASE	0xf2000000
-#define KIRKWOOD_PCIE_IO_VIRT_BASE	0xfee00000
+#define KIRKWOOD_PCIE_IO_VIRT_BASE	IOMEM(0xfee00000)
 #define KIRKWOOD_PCIE_IO_BUS_BASE	0x00000000
 #define KIRKWOOD_PCIE_IO_SIZE		SZ_1M
 
 #define KIRKWOOD_REGS_PHYS_BASE		0xf1000000
-#define KIRKWOOD_REGS_VIRT_BASE		0xfed00000
+#define KIRKWOOD_REGS_VIRT_BASE		IOMEM(0xfed00000)
 #define KIRKWOOD_REGS_SIZE		SZ_1M
 
 #define KIRKWOOD_PCIE_MEM_PHYS_BASE	0xe0000000
diff --git a/arch/arm/mach-kirkwood/irq.c b/arch/arm/mach-kirkwood/irq.c
index 720063f..f4ac804 100644
--- a/arch/arm/mach-kirkwood/irq.c
+++ b/arch/arm/mach-kirkwood/irq.c
@@ -10,6 +10,7 @@
 #include <linux/gpio.h>
 #include <linux/kernel.h>
 #include <linux/irq.h>
+#include <linux/io.h>
 #include <mach/bridge-regs.h>
 #include <plat/irq.h>
 
@@ -29,14 +30,14 @@ static int __initdata gpio1_irqs[4] = {
 
 void __init kirkwood_init_irq(void)
 {
-	orion_irq_init(0, (void __iomem *)(IRQ_VIRT_BASE + IRQ_MASK_LOW_OFF));
-	orion_irq_init(32, (void __iomem *)(IRQ_VIRT_BASE + IRQ_MASK_HIGH_OFF));
+	orion_irq_init(0, IRQ_VIRT_BASE + IRQ_MASK_LOW_OFF);
+	orion_irq_init(32, IRQ_VIRT_BASE + IRQ_MASK_HIGH_OFF);
 
 	/*
 	 * Initialize gpiolib for GPIOs 0-49.
 	 */
-	orion_gpio_init(NULL, 0, 32, (void __iomem *)GPIO_LOW_VIRT_BASE, 0,
+	orion_gpio_init(NULL, 0, 32, GPIO_LOW_VIRT_BASE, 0,
 			IRQ_KIRKWOOD_GPIO_START, gpio0_irqs);
-	orion_gpio_init(NULL, 32, 18, (void __iomem *)GPIO_HIGH_VIRT_BASE, 0,
+	orion_gpio_init(NULL, 32, 18, GPIO_HIGH_VIRT_BASE, 0,
 			IRQ_KIRKWOOD_GPIO_START + 32, gpio1_irqs);
 }
diff --git a/arch/arm/mach-kirkwood/mpp.c b/arch/arm/mach-kirkwood/mpp.c
index 0c6ad63..6774279 100644
--- a/arch/arm/mach-kirkwood/mpp.c
+++ b/arch/arm/mach-kirkwood/mpp.c
@@ -38,5 +38,6 @@ static unsigned int __init kirkwood_variant(void)
 void __init kirkwood_mpp_conf(unsigned int *mpp_list)
 {
 	orion_mpp_conf(mpp_list, kirkwood_variant(),
-		       MPP_MAX, DEV_BUS_VIRT_BASE);
+		       MPP_MAX,
+		       (unsigned long) DEV_BUS_VIRT_BASE);
 }
diff --git a/arch/arm/mach-kirkwood/pcie.c b/arch/arm/mach-kirkwood/pcie.c
index 6e8b2ef..df6399d 100644
--- a/arch/arm/mach-kirkwood/pcie.c
+++ b/arch/arm/mach-kirkwood/pcie.c
@@ -47,8 +47,8 @@ void kirkwood_enable_pcie(void)
 void kirkwood_pcie_id(u32 *dev, u32 *rev)
 {
 	kirkwood_enable_pcie();
-	*dev = orion_pcie_dev_id((void __iomem *)PCIE_VIRT_BASE);
-	*rev = orion_pcie_rev((void __iomem *)PCIE_VIRT_BASE);
+	*dev = orion_pcie_dev_id(PCIE_VIRT_BASE);
+	*rev = orion_pcie_rev(PCIE_VIRT_BASE);
 }
 
 struct pcie_port {
@@ -133,7 +133,7 @@ static struct pci_ops pcie_ops = {
 
 static void __init pcie0_ioresources_init(struct pcie_port *pp)
 {
-	pp->base = (void __iomem *)PCIE_VIRT_BASE;
+	pp->base = PCIE_VIRT_BASE;
 	pp->irq	= IRQ_KIRKWOOD_PCIE;
 
 	/*
@@ -155,7 +155,7 @@ static void __init pcie0_ioresources_init(struct pcie_port *pp)
 
 static void __init pcie1_ioresources_init(struct pcie_port *pp)
 {
-	pp->base = (void __iomem *)PCIE1_VIRT_BASE;
+	pp->base = PCIE1_VIRT_BASE;
 	pp->irq	= IRQ_KIRKWOOD_PCIE1;
 
 	/*
@@ -273,11 +273,11 @@ static struct hw_pci kirkwood_pci __initdata = {
 	.map_irq	= kirkwood_pcie_map_irq,
 };
 
-static void __init add_pcie_port(int index, unsigned long base)
+static void __init add_pcie_port(int index, void __iomem *base)
 {
 	printk(KERN_INFO "Kirkwood PCIe port %d: ", index);
 
-	if (orion_pcie_link_up((void __iomem *)base)) {
+	if (orion_pcie_link_up(base)) {
 		printk(KERN_INFO "link up\n");
 		pcie_port_map[num_pcie_ports++] = index;
 	} else
diff --git a/arch/arm/mach-kirkwood/ts41x-setup.c b/arch/arm/mach-kirkwood/ts41x-setup.c
index 5bbca26..367a940 100644
--- a/arch/arm/mach-kirkwood/ts41x-setup.c
+++ b/arch/arm/mach-kirkwood/ts41x-setup.c
@@ -20,6 +20,7 @@
 #include <linux/gpio.h>
 #include <linux/gpio_keys.h>
 #include <linux/input.h>
+#include <linux/io.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <mach/kirkwood.h>
@@ -161,7 +162,7 @@ static int __init ts41x_pci_init(void)
 		 * (Marvell 88sx7042/sata_mv) is known to stop working
 		 * after a few minutes.
 		 */
-		orion_pcie_reset((void __iomem *)PCIE_VIRT_BASE);
+		orion_pcie_reset(PCIE_VIRT_BASE);
 
 		kirkwood_pcie_id(&dev, &rev);
 		if (dev == MV88F6282_DEV_ID)
-- 
1.7.9.5
