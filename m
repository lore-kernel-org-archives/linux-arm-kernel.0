From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 21 Jul 2010 18:36:12 +0200
Subject: [PATCH] arm: remove __io() abuses
In-Reply-To: <201007202322.16615.arnd@arndb.de>
References: <201007201123.38709.arnd@arndb.de>
	<201007201309.36898.arnd@arndb.de>
	<201007202322.16615.arnd@arndb.de>
Message-ID: <201007211836.13029.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The __io macros are used for PCI and ISA I/O space accesses, which are
not present on most of the platforms in ARM.

However, some of the platforms use the same macro for mapping random virtial
addresses for MMIO register from integer to __iomem pointers.
This makes the use of __io more consistent by removing all uses that
are unrelated to I/O space.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

--- a/arch/arm/mach-cns3xxx/core.c
+++ b/arch/arm/mach-cns3xxx/core.c
@@ -73,14 +73,14 @@ void __iomem *gic_cpu_base_addr;
 
 void __init cns3xxx_init_irq(void)
 {
-	gic_cpu_base_addr = __io(CNS3XXX_TC11MP_GIC_CPU_BASE_VIRT);
-	gic_dist_init(0, __io(CNS3XXX_TC11MP_GIC_DIST_BASE_VIRT), 29);
+	gic_cpu_base_addr = (void __iomem *)CNS3XXX_TC11MP_GIC_CPU_BASE_VIRT;
+	gic_dist_init(0, (void __iomem *)CNS3XXX_TC11MP_GIC_DIST_BASE_VIRT, 29);
 	gic_cpu_init(0, gic_cpu_base_addr);
 }
 
 void cns3xxx_power_off(void)
 {
-	u32 __iomem *pm_base = __io(CNS3XXX_PM_BASE_VIRT);
+	u32 __iomem *pm_base = (void __iomem *)CNS3XXX_PM_BASE_VIRT;
 	u32 clkctrl;
 
 	printk(KERN_INFO "powering system down...\n");
@@ -239,7 +239,7 @@ static void __init __cns3xxx_timer_init(unsigned int timer_irq)
 
 static void __init cns3xxx_timer_init(void)
 {
-	cns3xxx_tmr1 = __io(CNS3XXX_TIMER1_2_3_BASE_VIRT);
+	cns3xxx_tmr1 = (void __iomem *)CNS3XXX_TIMER1_2_3_BASE_VIRT;
 
 	__cns3xxx_timer_init(IRQ_CNS3XXX_TIMER0);
 }
diff --git a/arch/arm/mach-netx/generic.c b/arch/arm/mach-netx/generic.c
index 43da8bb..fee2ea3 100644
--- a/arch/arm/mach-netx/generic.c
+++ b/arch/arm/mach-netx/generic.c
@@ -168,7 +168,7 @@ void __init netx_init_irq(void)
 {
 	int irq;
 
-	vic_init(__io(io_p2v(NETX_PA_VIC)), 0, ~0, 0);
+	vic_init((void __iomem *)io_p2v(NETX_PA_VIC), 0, ~0, 0);
 
 	for (irq = NETX_IRQ_HIF_CHAINED(0); irq <= NETX_IRQ_HIF_LAST; irq++) {
 		set_irq_chip(irq, &netx_hif_chip);
diff --git a/arch/arm/mach-netx/include/mach/hardware.h b/arch/arm/mach-netx/include/mach/hardware.h
index 517a2bd..f196a16 100644
--- a/arch/arm/mach-netx/include/mach/hardware.h
+++ b/arch/arm/mach-netx/include/mach/hardware.h
@@ -20,7 +20,7 @@
 #define __ASM_ARCH_HARDWARE_H
 
 #define NETX_IO_PHYS	0x00100000
-#define NETX_IO_VIRT	0xe0000000
+#define NETX_IO_VIRT	(void __iomem *)0xe0000000
 #define NETX_IO_SIZE	0x00100000
 
 #define SRAM_INTERNAL_PHYS_0 0x00000
diff --git a/arch/arm/mach-netx/include/mach/netx-regs.h b/arch/arm/mach-netx/include/mach/netx-regs.h
index 5a03e7c..ebeb8a4 100644
--- a/arch/arm/mach-netx/include/mach/netx-regs.h
+++ b/arch/arm/mach-netx/include/mach/netx-regs.h
@@ -115,7 +115,7 @@
  *********************************/
 
 /* Registers */
-#define NETX_SYSTEM_REG(ofs)            __io(NETX_VA_SYSTEM + (ofs))
+#define NETX_SYSTEM_REG(ofs)        (NETX_VA_SYSTEM + (ofs))
 #define NETX_SYSTEM_BOO_SR          NETX_SYSTEM_REG(0x00)
 #define NETX_SYSTEM_IOC_CR          NETX_SYSTEM_REG(0x04)
 #define NETX_SYSTEM_IOC_MR          NETX_SYSTEM_REG(0x08)
@@ -185,7 +185,7 @@
  *******************************/
 
 /* Registers */
-#define NETX_GPIO_REG(ofs)                     __io(NETX_VA_GPIO + (ofs))
+#define NETX_GPIO_REG(ofs)                 (NETX_VA_GPIO + (ofs))
 #define NETX_GPIO_CFG(gpio)                NETX_GPIO_REG(0x0  + ((gpio)<<2))
 #define NETX_GPIO_THRESHOLD_CAPTURE(gpio)  NETX_GPIO_REG(0x40 + ((gpio)<<2))
 #define NETX_GPIO_COUNTER_CTRL(counter)    NETX_GPIO_REG(0x80 + ((counter)<<2))
@@ -230,7 +230,7 @@
  *******************************/
 
 /* Registers */
-#define NETX_PIO_REG(ofs)        __io(NETX_VA_PIO + (ofs))
+#define NETX_PIO_REG(ofs)        (NETX_VA_PIO + (ofs))
 #define NETX_PIO_INPIO       NETX_PIO_REG(0x0)
 #define NETX_PIO_OUTPIO      NETX_PIO_REG(0x4)
 #define NETX_PIO_OEPIO       NETX_PIO_REG(0x8)
@@ -240,7 +240,7 @@
  *******************************/
 
 /* Registers */
-#define NETX_MIIMU           __io(NETX_VA_MIIMU)
+#define NETX_MIIMU           (NETX_VA_MIIMU)
 
 /* Bits */
 #define MIIMU_SNRDY        (1<<0)
@@ -317,7 +317,7 @@
  *******************************/
 
 /* Registers */
-#define NETX_PFIFO_REG(ofs)               __io(NETX_VA_PFIFO + (ofs))
+#define NETX_PFIFO_REG(ofs)           (NETX_VA_PFIFO + (ofs))
 #define NETX_PFIFO_BASE(pfifo)        NETX_PFIFO_REG(0x00 + ((pfifo)<<2))
 #define NETX_PFIFO_BORDER_BASE(pfifo) NETX_PFIFO_REG(0x80 + ((pfifo)<<2))
 #define NETX_PFIFO_RESET              NETX_PFIFO_REG(0x100)
@@ -334,7 +334,7 @@
  *******************************/
 
 /* Registers */
-#define NETX_MEMCR_REG(ofs)               __io(NETX_VA_MEMCR + (ofs))
+#define NETX_MEMCR_REG(ofs)           (NETX_VA_MEMCR + (ofs))
 #define NETX_MEMCR_SRAM_CTRL(cs)      NETX_MEMCR_REG(0x0 + 4 * (cs)) /* SRAM for CS 0..2 */
 #define NETX_MEMCR_SDRAM_CFG_CTRL     NETX_MEMCR_REG(0x40)
 #define NETX_MEMCR_SDRAM_TIMING_CTRL  NETX_MEMCR_REG(0x44)
@@ -355,7 +355,7 @@
  *******************************/
 
 /* Registers */
-#define NETX_DPMAS_REG(ofs)               __io(NETX_VA_DPMAS + (ofs))
+#define NETX_DPMAS_REG(ofs)           (NETX_VA_DPMAS + (ofs))
 #define NETX_DPMAS_SYS_STAT           NETX_DPMAS_REG(0x4d8)
 #define NETX_DPMAS_INT_STAT           NETX_DPMAS_REG(0x4e0)
 #define NETX_DPMAS_INT_EN             NETX_DPMAS_REG(0x4f0)
@@ -425,7 +425,7 @@
 /*******************************
  * I2C                         *
  *******************************/
-#define NETX_I2C_REG(ofs)	__io(NETX_VA_I2C, (ofs))
+#define NETX_I2C_REG(ofs) (NETX_VA_I2C, (ofs))
 #define NETX_I2C_CTRL	NETX_I2C_REG(0x0)
 #define NETX_I2C_DATA	NETX_I2C_REG(0x4)
 
diff --git a/arch/arm/mach-realview/include/mach/hardware.h b/arch/arm/mach-realview/include/mach/hardware.h
index 8a638d1..873f721 100644
--- a/arch/arm/mach-realview/include/mach/hardware.h
+++ b/arch/arm/mach-realview/include/mach/hardware.h
@@ -37,6 +37,6 @@
 #else
 #define IO_ADDRESS(x)		(x)
 #endif
-#define __io_address(n)		__io(IO_ADDRESS(n))
+#define __io_address(n)		((void __iomem *)(IO_ADDRESS(n)))
 
 #endif
diff --git a/arch/arm/mach-ux500/include/mach/hardware.h b/arch/arm/mach-ux500/include/mach/hardware.h
index 8656379..719140d 100644
--- a/arch/arm/mach-ux500/include/mach/hardware.h
+++ b/arch/arm/mach-ux500/include/mach/hardware.h
@@ -22,7 +22,7 @@
 	(((x) & 0x0fffffff) + (((x) >> 4) & 0x0f000000) + U8500_IO_VIRTUAL)
 
 /* typesafe io address */
-#define __io_address(n)		__io(IO_ADDRESS(n))
+#define __io_address(n)		(void __iomem *)(IO_ADDRESS(n))
 /* used by some plat-nomadik code */
 #define io_p2v(n)		__io_address(n)
 
