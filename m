From: ben-linux@fluff.org (Ben Dooks)
Date: Fri,  8 Jan 2010 02:37:03 +0000
Subject: [PATCH] ARM: Add common entry code for system with two VICs
In-Reply-To: <1262918223-26529-1-git-send-email-ben-linux@fluff.org>
References: <1262918223-26529-1-git-send-email-ben-linux@fluff.org>
Message-ID: <1262918223-26529-7-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a common entry-macro-vic2.S for systems where there are two VICs
so that the machine or platform directories just need to setup the
correct information before including <asm/entry-macro-vic2.S> into
their own entry-macro.S file.

Since this code is from the S3C64XX project, we update the S3C64XX
machine entry code to use this new header.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/include/asm/entry-macro-vic2.S          |   57 ++++++++++++++++++++++
 arch/arm/mach-s3c6400/include/mach/entry-macro.S |   28 +----------
 arch/arm/mach-s3c6400/include/mach/map.h         |    4 +-
 arch/arm/mach-s3c6400/include/mach/tick.h        |    2 +-
 arch/arm/plat-s3c64xx/cpu.c                      |    4 +-
 arch/arm/plat-s3c64xx/include/plat/irqs.h        |    8 ++--
 arch/arm/plat-s3c64xx/irq.c                      |    4 +-
 7 files changed, 69 insertions(+), 38 deletions(-)
 create mode 100644 arch/arm/include/asm/entry-macro-vic2.S

diff --git a/arch/arm/include/asm/entry-macro-vic2.S b/arch/arm/include/asm/entry-macro-vic2.S
new file mode 100644
index 0000000..3ceb85e
--- /dev/null
+++ b/arch/arm/include/asm/entry-macro-vic2.S
@@ -0,0 +1,57 @@
+/* arch/arm/include/asm/entry-macro-vic2.S
+ *
+ * Originally arch/arm/mach-s3c6400/include/mach/entry-macro.S
+ *
+ * Copyright 2008 Openmoko, Inc.
+ * Copyright 2008 Simtec Electronics
+ *	http://armlinux.simtec.co.uk/
+ *	Ben Dooks <ben@simtec.co.uk>
+ *
+ * Low-level IRQ helper macros for a device with two VICs
+ *
+ * This file is licensed under  the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+*/
+
+/* This should be included from <mach/entry-macro.S> with the necessary
+ * defines for virtual addresses and IRQ bases for the two vics.
+ *
+ * The code needs the following defined:
+ *	IRQ_VIC0_BASE	IRQ number of VIC0's first IRQ
+ *	IRQ_VIC1_BASE	IRQ number of VIC1's first IRQ
+ *	VA_VIC0		Virtual address of VIC0
+ *	VA_VIC1		Virtual address of VIC1
+ *
+ * Note, code assumes VIC0's virtual address is an ARM immediate constant
+ * away from VIC1.
+*/
+
+#include <asm/hardware/vic.h>
+
+	.macro	disable_fiq
+	.endm
+
+	.macro	get_irqnr_preamble, base, tmp
+	ldr	\base, =VA_VIC0
+	.endm
+
+	.macro	arch_ret_to_user, tmp1, tmp2
+	.endm
+
+	.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
+
+	@ check the vic0
+	mov	\irqnr, #IRQ_VIC0_BASE + 31
+	ldr	\irqstat, [ \base, # VIC_IRQ_STATUS ]
+	teq	\irqstat, #0
+
+	@ otherwise try vic1
+	addeq	\tmp, \base, #(VA_VIC1 - VA_VIC0)
+	addeq	\irqnr, \irqnr, #(IRQ_VIC1_BASE - IRQ_VIC0_BASE)
+	ldreq	\irqstat, [ \tmp, # VIC_IRQ_STATUS ]
+	teqeq	\irqstat, #0
+
+	clzne	\irqstat, \irqstat
+	subne	\irqnr, \irqnr, \irqstat
+	.endm
diff --git a/arch/arm/mach-s3c6400/include/mach/entry-macro.S b/arch/arm/mach-s3c6400/include/mach/entry-macro.S
index fbd90d2..33a8fe2 100644
--- a/arch/arm/mach-s3c6400/include/mach/entry-macro.S
+++ b/arch/arm/mach-s3c6400/include/mach/entry-macro.S
@@ -12,33 +12,7 @@
  * warranty of any kind, whether express or implied.
 */
 
-#include <asm/hardware/vic.h>
 #include <mach/map.h>
 #include <plat/irqs.h>
 
-	.macro	disable_fiq
-	.endm
-
-	.macro	get_irqnr_preamble, base, tmp
-	ldr	\base, =S3C_VA_VIC0
-	.endm
-
-	.macro	arch_ret_to_user, tmp1, tmp2
-	.endm
-
-	.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
-
-	@ check the vic0
-	mov	\irqnr, # S3C_IRQ_OFFSET + 31
-	ldr	\irqstat, [ \base, # VIC_IRQ_STATUS ]
-	teq	\irqstat, #0
-
-	@ otherwise try vic1
-	addeq	\tmp, \base, #(S3C_VA_VIC1 - S3C_VA_VIC0)
-	addeq	\irqnr, \irqnr, #32
-	ldreq	\irqstat, [ \tmp, # VIC_IRQ_STATUS ]
-	teqeq	\irqstat, #0
-
-	clzne	\irqstat, \irqstat
-	subne	\irqnr, \irqnr, \irqstat
-	.endm
+#include <asm/entry-macro-vic2.S>
diff --git a/arch/arm/mach-s3c6400/include/mach/map.h b/arch/arm/mach-s3c6400/include/mach/map.h
index 106ee13..d4cd3ab 100644
--- a/arch/arm/mach-s3c6400/include/mach/map.h
+++ b/arch/arm/mach-s3c6400/include/mach/map.h
@@ -70,8 +70,8 @@
 #define S3C64XX_VA_USB_HSPHY	S3C_ADDR_CPU(0x00200000)
 
 /* place VICs close together */
-#define S3C_VA_VIC0		(S3C_VA_IRQ + 0x00)
-#define S3C_VA_VIC1		(S3C_VA_IRQ + 0x10000)
+#define VA_VIC0			(S3C_VA_IRQ + 0x00)
+#define VA_VIC1			(S3C_VA_IRQ + 0x10000)
 
 /* compatibiltiy defines. */
 #define S3C_PA_TIMER		S3C64XX_PA_TIMER
diff --git a/arch/arm/mach-s3c6400/include/mach/tick.h b/arch/arm/mach-s3c6400/include/mach/tick.h
index d9c0dc7..ebe18a9 100644
--- a/arch/arm/mach-s3c6400/include/mach/tick.h
+++ b/arch/arm/mach-s3c6400/include/mach/tick.h
@@ -20,7 +20,7 @@
  */
 static inline u32 s3c24xx_ostimer_pending(void)
 {
-	u32 pend = __raw_readl(S3C_VA_VIC0 + VIC_RAW_STATUS);
+	u32 pend = __raw_readl(VA_VIC0 + VIC_RAW_STATUS);
 	return pend & 1 << (IRQ_TIMER4_VIC - S3C64XX_IRQ_VIC0(0));
 }
 
diff --git a/arch/arm/plat-s3c64xx/cpu.c b/arch/arm/plat-s3c64xx/cpu.c
index 49796d2..c0e6f2a 100644
--- a/arch/arm/plat-s3c64xx/cpu.c
+++ b/arch/arm/plat-s3c64xx/cpu.c
@@ -78,12 +78,12 @@ static struct map_desc s3c_iodesc[] __initdata = {
 		.length		= SZ_4K,
 		.type		= MT_DEVICE,
 	}, {
-		.virtual	= (unsigned long)S3C_VA_VIC0,
+		.virtual	= (unsigned long)VA_VIC0,
 		.pfn		= __phys_to_pfn(S3C64XX_PA_VIC0),
 		.length		= SZ_16K,
 		.type		= MT_DEVICE,
 	}, {
-		.virtual	= (unsigned long)S3C_VA_VIC1,
+		.virtual	= (unsigned long)VA_VIC1,
 		.pfn		= __phys_to_pfn(S3C64XX_PA_VIC1),
 		.length		= SZ_16K,
 		.type		= MT_DEVICE,
diff --git a/arch/arm/plat-s3c64xx/include/plat/irqs.h b/arch/arm/plat-s3c64xx/include/plat/irqs.h
index 7956fd3..176fe15 100644
--- a/arch/arm/plat-s3c64xx/include/plat/irqs.h
+++ b/arch/arm/plat-s3c64xx/include/plat/irqs.h
@@ -24,8 +24,8 @@
 
 #define S3C_IRQ(x)	((x) + S3C_IRQ_OFFSET)
 
-#define S3C_VIC0_BASE	S3C_IRQ(0)
-#define S3C_VIC1_BASE	S3C_IRQ(32)
+#define IRQ_VIC0_BASE	S3C_IRQ(0)
+#define IRQ_VIC1_BASE	S3C_IRQ(32)
 
 /* UART interrupts, each UART has 4 intterupts per channel so
  * use the space between the ISA and S3C main interrupts. Note, these
@@ -59,8 +59,8 @@
 
 /* VIC based IRQs */
 
-#define S3C64XX_IRQ_VIC0(x)	(S3C_VIC0_BASE + (x))
-#define S3C64XX_IRQ_VIC1(x)	(S3C_VIC1_BASE + (x))
+#define S3C64XX_IRQ_VIC0(x)	(IRQ_VIC0_BASE + (x))
+#define S3C64XX_IRQ_VIC1(x)	(IRQ_VIC1_BASE + (x))
 
 /* VIC0 */
 
diff --git a/arch/arm/plat-s3c64xx/irq.c b/arch/arm/plat-s3c64xx/irq.c
index b98451e..67a145d 100644
--- a/arch/arm/plat-s3c64xx/irq.c
+++ b/arch/arm/plat-s3c64xx/irq.c
@@ -54,8 +54,8 @@ void __init s3c64xx_init_irq(u32 vic0_valid, u32 vic1_valid)
 	printk(KERN_DEBUG "%s: initialising interrupts\n", __func__);
 
 	/* initialise the pair of VICs */
-	vic_init(S3C_VA_VIC0, S3C_VIC0_BASE, vic0_valid, 0);
-	vic_init(S3C_VA_VIC1, S3C_VIC1_BASE, vic1_valid, 0);
+	vic_init(VA_VIC0, IRQ_VIC0_BASE, vic0_valid, 0);
+	vic_init(VA_VIC1, IRQ_VIC1_BASE, vic1_valid, 0);
 
 	/* add the timer sub-irqs */
 
-- 
1.6.0.4
