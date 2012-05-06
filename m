From: shc_work@mail.ru (Alexander Shiyan)
Date: Sun,  6 May 2012 09:21:57 +0400
Subject: [PATCH] ARM: clps711x: Using a single definition for the PHYS and
 VIRT registers offset
In-Reply-To: <1335764876-14192-1-git-send-email-shc_work@mail.ru>
References: <1335764876-14192-1-git-send-email-shc_work@mail.ru>
Message-ID: <1336281717-5332-1-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using a single definition for the physical and virtual address register for all
variants boards clps711x. This patch also includes the use of a single function
clps_read/write in some units.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/include/asm/hardware/clps7111.h          |   11 +------
 arch/arm/include/asm/hardware/ep7211.h            |    9 -----
 arch/arm/include/asm/hardware/ep7212.h            |   12 -------
 arch/arm/mach-clps711x/common.c                   |    5 +--
 arch/arm/mach-clps711x/include/mach/debug-macro.S |    5 +--
 arch/arm/mach-clps711x/include/mach/entry-macro.S |    3 +-
 arch/arm/mach-clps711x/include/mach/hardware.h    |   36 +++++++-------------
 arch/arm/mach-clps711x/include/mach/time.h        |    2 +-
 arch/arm/mach-clps711x/include/mach/uncompress.h  |   19 +++++------
 arch/arm/mach-clps711x/p720t-leds.c               |    3 --
 drivers/mtd/nand/autcpu12.c                       |   10 ++---
 drivers/mtd/nand/h1910.c                          |    2 +-
 drivers/tty/serial/clps711x.c                     |    1 -
 drivers/video/clps711xfb.c                        |    1 -
 14 files changed, 34 insertions(+), 85 deletions(-)

diff --git a/arch/arm/include/asm/hardware/clps7111.h b/arch/arm/include/asm/hardware/clps7111.h
index 4447722..78e2856 100644
--- a/arch/arm/include/asm/hardware/clps7111.h
+++ b/arch/arm/include/asm/hardware/clps7111.h
@@ -23,16 +23,7 @@
 #ifndef __ASM_HARDWARE_CLPS7111_H
 #define __ASM_HARDWARE_CLPS7111_H
 
-#define CLPS7111_PHYS_BASE	(0x80000000)
-
-#ifndef __ASSEMBLY__
-#define clps_readb(off)		__raw_readb(CLPS7111_BASE + (off))
-#define clps_readw(off)		__raw_readw(CLPS7111_BASE + (off))
-#define clps_readl(off)		__raw_readl(CLPS7111_BASE + (off))
-#define clps_writeb(val,off)	__raw_writeb(val, CLPS7111_BASE + (off))
-#define clps_writew(val,off)	__raw_writew(val, CLPS7111_BASE + (off))
-#define clps_writel(val,off)	__raw_writel(val, CLPS7111_BASE + (off))
-#endif
+#define CLPS711X_PHYS_BASE	(0x80000000)
 
 #define PADR		(0x0000)
 #define PBDR		(0x0001)
diff --git a/arch/arm/include/asm/hardware/ep7211.h b/arch/arm/include/asm/hardware/ep7211.h
index 654d5f6..4b3f86b 100644
--- a/arch/arm/include/asm/hardware/ep7211.h
+++ b/arch/arm/include/asm/hardware/ep7211.h
@@ -23,15 +23,6 @@
 #ifndef __ASM_HARDWARE_EP7211_H
 #define __ASM_HARDWARE_EP7211_H
 
-#include <asm/hardware/clps7111.h>
-
-/*
- * define EP7211_BASE to be the base address of the region
- * you want to access.
- */
-
-#define EP7211_PHYS_BASE	(0x80000000)
-
 /*
  * XXX miket at bluemug.com: need to introduce EP7211 registers (those not
  * present in 7212) here.
diff --git a/arch/arm/include/asm/hardware/ep7212.h b/arch/arm/include/asm/hardware/ep7212.h
index 3b43bbe..aad07f7 100644
--- a/arch/arm/include/asm/hardware/ep7212.h
+++ b/arch/arm/include/asm/hardware/ep7212.h
@@ -24,18 +24,6 @@
 #define __ASM_HARDWARE_EP7212_H
 
 /*
- * define EP7212_BASE to be the base address of the region
- * you want to access.
- */
-
-#define EP7212_PHYS_BASE	(0x80000000)
-
-#ifndef __ASSEMBLY__
-#define ep_readl(off)		__raw_readl(EP7212_BASE + (off))
-#define ep_writel(val,off)	__raw_writel(val, EP7212_BASE + (off))
-#endif
-
-/*
  * These registers are specific to the EP7212 only
  */
 #define DAIR			0x2000
diff --git a/arch/arm/mach-clps711x/common.c b/arch/arm/mach-clps711x/common.c
index 3c5b5bb..b6dfd2f 100644
--- a/arch/arm/mach-clps711x/common.c
+++ b/arch/arm/mach-clps711x/common.c
@@ -36,7 +36,6 @@
 #include <asm/page.h>
 #include <asm/mach/map.h>
 #include <asm/mach/time.h>
-#include <asm/hardware/clps7111.h>
 #include <asm/system_misc.h>
 
 /*
@@ -44,8 +43,8 @@
  */
 static struct map_desc clps711x_io_desc[] __initdata = {
 	{
-		.virtual	= CLPS7111_VIRT_BASE,
-		.pfn		= __phys_to_pfn(CLPS7111_PHYS_BASE),
+		.virtual	= (unsigned long)CLPS711X_VIRT_BASE,
+		.pfn		= __phys_to_pfn(CLPS711X_PHYS_BASE),
 		.length		= SZ_1M,
 		.type		= MT_DEVICE
 	}
diff --git a/arch/arm/mach-clps711x/include/mach/debug-macro.S b/arch/arm/mach-clps711x/include/mach/debug-macro.S
index b802e8a..118b3d9 100644
--- a/arch/arm/mach-clps711x/include/mach/debug-macro.S
+++ b/arch/arm/mach-clps711x/include/mach/debug-macro.S
@@ -12,7 +12,6 @@
 */
 
 #include <mach/hardware.h>
-#include <asm/hardware/clps7111.h>
 
 		.macro	addruart, rp, rv, tmp
 #ifndef CONFIG_DEBUG_CLPS711X_UART2
@@ -20,8 +19,8 @@
 #else
 		mov	\rp, #0x1000	@ UART2
 #endif
-		orr	\rv, \rp, #CLPS7111_VIRT_BASE
-		orr	\rp, \rp, #CLPS7111_PHYS_BASE
+		orr	\rv, \rp, #CLPS711X_VIRT_BASE
+		orr	\rp, \rp, #CLPS711X_PHYS_BASE
 		.endm
 
 		.macro	senduart,rd,rx
diff --git a/arch/arm/mach-clps711x/include/mach/entry-macro.S b/arch/arm/mach-clps711x/include/mach/entry-macro.S
index 125af59..56e5c2c 100644
--- a/arch/arm/mach-clps711x/include/mach/entry-macro.S
+++ b/arch/arm/mach-clps711x/include/mach/entry-macro.S
@@ -8,7 +8,6 @@
  * warranty of any kind, whether express or implied.
  */
 #include <mach/hardware.h>
-#include <asm/hardware/clps7111.h>
 
 		.macro	get_irqnr_preamble, base, tmp
 		.endm
@@ -18,7 +17,7 @@
 #endif
 
 		.macro	get_irqnr_and_base, irqnr, stat, base, mask
-		mov	\base, #CLPS7111_BASE
+		mov	\base, #CLPS711X_VIRT_BASE
 		ldr	\stat, [\base, #INTSR1]
 		ldr	\mask, [\base, #INTMR1]
 		mov	\irqnr, #4
diff --git a/arch/arm/mach-clps711x/include/mach/hardware.h b/arch/arm/mach-clps711x/include/mach/hardware.h
index d0b7d87..1026ac9 100644
--- a/arch/arm/mach-clps711x/include/mach/hardware.h
+++ b/arch/arm/mach-clps711x/include/mach/hardware.h
@@ -19,12 +19,21 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
-#ifndef __ASM_ARCH_HARDWARE_H
-#define __ASM_ARCH_HARDWARE_H
+#ifndef __MACH_HARDWARE_H
+#define __MACH_HARDWARE_H
 
+#include <asm/hardware/clps7111.h>
+
+#define CLPS711X_VIRT_BASE	IOMEM(0xff000000)
 
-#define CLPS7111_VIRT_BASE	0xff000000
-#define CLPS7111_BASE		CLPS7111_VIRT_BASE
+#ifndef __ASSEMBLY__
+#define clps_readb(off)		readb(CLPS711X_VIRT_BASE + (off))
+#define clps_readw(off)		readw(CLPS711X_VIRT_BASE + (off))
+#define clps_readl(off)		readl(CLPS711X_VIRT_BASE + (off))
+#define clps_writeb(val,off)	writeb(val, CLPS711X_VIRT_BASE + (off))
+#define clps_writew(val,off)	writew(val, CLPS711X_VIRT_BASE + (off))
+#define clps_writel(val,off)	writel(val, CLPS711X_VIRT_BASE + (off))
+#endif
 
 /*
  * The physical addresses that the external chip select signals map to is
@@ -54,14 +63,10 @@
 
 #if defined (CONFIG_ARCH_EP7211)
 
-#define EP7211_VIRT_BASE	CLPS7111_VIRT_BASE
-#define EP7211_BASE		CLPS7111_VIRT_BASE
 #include <asm/hardware/ep7211.h>
 
 #elif defined (CONFIG_ARCH_EP7212)
 
-#define EP7212_VIRT_BASE	CLPS7111_VIRT_BASE
-#define EP7212_BASE		CLPS7111_VIRT_BASE
 #include <asm/hardware/ep7212.h>
 
 #endif
@@ -71,10 +76,6 @@
 
 #if  defined (CONFIG_ARCH_AUTCPU12)
 
-#define  CS89712_VIRT_BASE	CLPS7111_VIRT_BASE
-#define  CS89712_BASE		CLPS7111_VIRT_BASE
-
-#include <asm/hardware/clps7111.h>
 #include <asm/hardware/ep7212.h>
 #include <asm/hardware/cs89712.h>
 
@@ -83,15 +84,9 @@
 
 #if defined (CONFIG_ARCH_CDB89712)
 
-#include <asm/hardware/clps7111.h>
 #include <asm/hardware/ep7212.h>
 #include <asm/hardware/cs89712.h>
 
-/* static cdb89712_map_io() areas */
-#define REGISTER_START   0x80000000
-#define REGISTER_SIZE    0x4000
-#define REGISTER_BASE    0xff000000
-
 #define ETHER_START      0x20000000
 #define ETHER_SIZE       0x1000
 #define ETHER_BASE       0xfe000000
@@ -154,13 +149,8 @@
 
 #if defined (CONFIG_ARCH_CEIVA)
 
-#define  CEIVA_VIRT_BASE	CLPS7111_VIRT_BASE
-#define  CEIVA_BASE		CLPS7111_VIRT_BASE
-
-#include <asm/hardware/clps7111.h>
 #include <asm/hardware/ep7212.h>
 
-
 /*
  * The two flash banks are wired to chip selects 0 and 1. This is the mapping
  * for them.
diff --git a/arch/arm/mach-clps711x/include/mach/time.h b/arch/arm/mach-clps711x/include/mach/time.h
index 61fef91..5f65865 100644
--- a/arch/arm/mach-clps711x/include/mach/time.h
+++ b/arch/arm/mach-clps711x/include/mach/time.h
@@ -18,7 +18,7 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 #include <asm/leds.h>
-#include <asm/hardware/clps7111.h>
+#include <mach/hardware.h>
 
 extern void clps711x_setup_timer(void);
 
diff --git a/arch/arm/mach-clps711x/include/mach/uncompress.h b/arch/arm/mach-clps711x/include/mach/uncompress.h
index 35ed731..263f839 100644
--- a/arch/arm/mach-clps711x/include/mach/uncompress.h
+++ b/arch/arm/mach-clps711x/include/mach/uncompress.h
@@ -17,15 +17,8 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
-#include <mach/hardware.h>
 #include <asm/hardware/clps7111.h>
 
-#undef CLPS7111_BASE
-#define CLPS7111_BASE CLPS7111_PHYS_BASE
-
-#define __raw_readl(p)		(*(unsigned long *)(p))
-#define __raw_writel(v,p)	(*(unsigned long *)(p) = (v))
-
 #ifdef CONFIG_DEBUG_CLPS711X_UART2
 #define SYSFLGx	SYSFLG2
 #define UARTDRx	UARTDR2
@@ -34,19 +27,25 @@
 #define UARTDRx	UARTDR1
 #endif
 
+#define phys_reg(x)	(*(volatile u32 *)(CLPS711X_PHYS_BASE + (x)))
+
 /*
+ * The following code assumes the serial port has already been
+ * initialized by the bootloader.  If you didn't setup a port in
+ * your bootloader then nothing will appear (which might be desired).
+ *
  * This does not append a newline
  */
 static inline void putc(int c)
 {
-	while (clps_readl(SYSFLGx) & SYSFLG_UTXFF)
+	while (phys_reg(SYSFLGx) & SYSFLG_UTXFF)
 		barrier();
-	clps_writel(c, UARTDRx);
+	phys_reg(UARTDRx) = c;
 }
 
 static inline void flush(void)
 {
-	while (clps_readl(SYSFLGx) & SYSFLG_UBUSY)
+	while (phys_reg(SYSFLGx) & SYSFLG_UBUSY)
 		barrier();
 }
 
diff --git a/arch/arm/mach-clps711x/p720t-leds.c b/arch/arm/mach-clps711x/p720t-leds.c
index dd9a6cd..bbc449f 100644
--- a/arch/arm/mach-clps711x/p720t-leds.c
+++ b/arch/arm/mach-clps711x/p720t-leds.c
@@ -27,9 +27,6 @@
 #include <asm/leds.h>
 #include <asm/mach-types.h>
 
-#include <asm/hardware/clps7111.h>
-#include <asm/hardware/ep7212.h>
-
 static void p720t_leds_event(led_event_t ledevt)
 {
 	unsigned long flags;
diff --git a/drivers/mtd/nand/autcpu12.c b/drivers/mtd/nand/autcpu12.c
index 2e42ec2..04769a4 100644
--- a/drivers/mtd/nand/autcpu12.c
+++ b/drivers/mtd/nand/autcpu12.c
@@ -102,10 +102,10 @@ static void autcpu12_hwcontrol(struct mtd_info *mtd, int cmd,
 		void __iomem *addr;
 		unsigned char bits;
 
-		addr = CS89712_VIRT_BASE + AUTCPU12_SMC_PORT_OFFSET;
-		bits = (ctrl & NAND_CLE) << 4;
+		bits = clps_readb(AUTCPU12_SMC_PORT_OFFSET) & ~0x30;
+		bits |= (ctrl & NAND_CLE) << 4;
 		bits |= (ctrl & NAND_ALE) << 2;
-		writeb((readb(addr) & ~0x30) | bits, addr);
+		clps_writeb(bits, AUTCPU12_SMC_PORT_OFFSET);
 
 		addr = autcpu12_fio_base + AUTCPU12_SMC_SELECT_OFFSET;
 		writeb((readb(addr) & ~0x1) | (ctrl & NAND_NCE), addr);
@@ -120,9 +120,7 @@ static void autcpu12_hwcontrol(struct mtd_info *mtd, int cmd,
  */
 int autcpu12_device_ready(struct mtd_info *mtd)
 {
-	void __iomem *addr = CS89712_VIRT_BASE + AUTCPU12_SMC_PORT_OFFSET;
-
-	return readb(addr) & AUTCPU12_SMC_RDY;
+	return clps_readb(AUTCPU12_SMC_PORT_OFFSET) & AUTCPU12_SMC_RDY;
 }
 
 /*
diff --git a/drivers/mtd/nand/h1910.c b/drivers/mtd/nand/h1910.c
index 11e4878..9bf5ce5 100644
--- a/drivers/mtd/nand/h1910.c
+++ b/drivers/mtd/nand/h1910.c
@@ -24,7 +24,7 @@
 #include <linux/mtd/nand.h>
 #include <linux/mtd/partitions.h>
 #include <asm/io.h>
-#include <mach/hardware.h>	/* for CLPS7111_VIRT_BASE */
+#include <mach/hardware.h>
 #include <asm/sizes.h>
 #include <mach/h1900-gpio.h>
 #include <mach/ipaq.h>
diff --git a/drivers/tty/serial/clps711x.c b/drivers/tty/serial/clps711x.c
index 836fe273..d0f719f 100644
--- a/drivers/tty/serial/clps711x.c
+++ b/drivers/tty/serial/clps711x.c
@@ -40,7 +40,6 @@
 
 #include <mach/hardware.h>
 #include <asm/irq.h>
-#include <asm/hardware/clps7111.h>
 
 #define UART_NR		2
 
diff --git a/drivers/video/clps711xfb.c b/drivers/video/clps711xfb.c
index 99b354b..f994c8b 100644
--- a/drivers/video/clps711xfb.c
+++ b/drivers/video/clps711xfb.c
@@ -33,7 +33,6 @@
 #include <asm/mach-types.h>
 #include <linux/uaccess.h>
 
-#include <asm/hardware/clps7111.h>
 #include <mach/syspld.h>
 
 struct fb_info	*cfb;
-- 
1.7.3.4
