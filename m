From: eric.miao@canonical.com (Eric Miao)
Date: Tue, 13 Jul 2010 23:33:27 +0800
Subject: [PATCH 12/13] [ARM] Introduce ARCH_HAS_RET_TO_USER and remove most
	arch_ret_to_user
In-Reply-To: <1279035208-7249-1-git-send-email-eric.miao@canonical.com>
References: <1279035208-7249-1-git-send-email-eric.miao@canonical.com>
Message-ID: <1279035208-7249-13-git-send-email-eric.miao@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Eric Miao <eric.miao@canonical.com>
---
 arch/arm/Kconfig                                   |    6 ++++++
 arch/arm/include/asm/entry-macro-vic2.S            |    3 ---
 arch/arm/kernel/entry-common.S                     |    4 ++++
 arch/arm/mach-aaec2000/include/mach/entry-macro.S  |    3 ---
 arch/arm/mach-at91/include/mach/entry-macro.S      |    3 ---
 arch/arm/mach-bcmring/include/mach/entry-macro.S   |    3 ---
 arch/arm/mach-clps711x/include/mach/entry-macro.S  |    3 ---
 arch/arm/mach-cns3xxx/include/mach/entry-macro.S   |    3 ---
 arch/arm/mach-davinci/include/mach/entry-macro.S   |    3 ---
 arch/arm/mach-dove/include/mach/entry-macro.S      |    3 ---
 arch/arm/mach-ebsa110/include/mach/entry-macro.S   |    3 ---
 arch/arm/mach-ep93xx/include/mach/entry-macro.S    |    3 ---
 .../arm/mach-footbridge/include/mach/entry-macro.S |    3 ---
 arch/arm/mach-gemini/include/mach/entry-macro.S    |    3 ---
 arch/arm/mach-h720x/include/mach/entry-macro.S     |    3 ---
 .../arm/mach-integrator/include/mach/entry-macro.S |    3 ---
 arch/arm/mach-ixp2000/include/mach/entry-macro.S   |    3 ---
 arch/arm/mach-ixp23xx/include/mach/entry-macro.S   |    3 ---
 arch/arm/mach-ixp4xx/include/mach/entry-macro.S    |    3 ---
 arch/arm/mach-kirkwood/include/mach/entry-macro.S  |    3 ---
 arch/arm/mach-ks8695/include/mach/entry-macro.S    |    3 ---
 arch/arm/mach-l7200/include/mach/entry-macro.S     |    3 ---
 arch/arm/mach-lh7a40x/include/mach/entry-macro.S   |    9 ---------
 arch/arm/mach-loki/include/mach/entry-macro.S      |    3 ---
 arch/arm/mach-mmp/include/mach/entry-macro.S       |    3 ---
 arch/arm/mach-msm/include/mach/entry-macro.S       |    3 ---
 arch/arm/mach-mv78xx0/include/mach/entry-macro.S   |    3 ---
 arch/arm/mach-netx/include/mach/entry-macro.S      |    3 ---
 arch/arm/mach-nomadik/include/mach/entry-macro.S   |    3 ---
 arch/arm/mach-ns9xxx/include/mach/entry-macro.S    |    3 ---
 arch/arm/mach-nuc93x/include/mach/entry-macro.S    |    3 ---
 arch/arm/mach-omap1/include/mach/entry-macro.S     |    3 ---
 arch/arm/mach-omap2/include/mach/entry-macro.S     |    3 ---
 arch/arm/mach-orion5x/include/mach/entry-macro.S   |    3 ---
 arch/arm/mach-pnx4008/include/mach/entry-macro.S   |    3 ---
 arch/arm/mach-pxa/include/mach/entry-macro.S       |    3 ---
 arch/arm/mach-realview/include/mach/entry-macro.S  |    3 ---
 arch/arm/mach-rpc/include/mach/entry-macro.S       |    3 ---
 arch/arm/mach-s3c2410/include/mach/entry-macro.S   |    3 ---
 arch/arm/mach-s5p6442/include/mach/entry-macro.S   |    3 ---
 arch/arm/mach-s5pc100/include/mach/entry-macro.S   |    3 ---
 arch/arm/mach-s5pv210/include/mach/entry-macro.S   |    3 ---
 arch/arm/mach-sa1100/include/mach/entry-macro.S    |    3 ---
 arch/arm/mach-shark/include/mach/entry-macro.S     |    3 ---
 arch/arm/mach-shmobile/include/mach/entry-macro.S  |    3 ---
 arch/arm/mach-spear3xx/include/mach/entry-macro.S  |    3 ---
 arch/arm/mach-spear6xx/include/mach/entry-macro.S  |    3 ---
 arch/arm/mach-stmp378x/include/mach/entry-macro.S  |    2 --
 arch/arm/mach-stmp37xx/include/mach/entry-macro.S  |    2 --
 arch/arm/mach-u300/include/mach/entry-macro.S      |    3 ---
 arch/arm/mach-ux500/include/mach/entry-macro.S     |    3 ---
 arch/arm/mach-versatile/include/mach/entry-macro.S |    3 ---
 arch/arm/mach-vexpress/include/mach/entry-macro.S  |    3 ---
 arch/arm/mach-w90x900/include/mach/entry-macro.S   |    3 ---
 arch/arm/plat-mxc/include/mach/entry-macro.S       |    3 ---
 55 files changed, 10 insertions(+), 163 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 7da1979..708a1e1 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -59,6 +59,9 @@ config ARCH_USES_DEFAULT_GPIO_H
 config ARCH_USES_DEFAULT_TIMEX_H
 	def_bool n
 
+config ARCH_HAS_RET_TO_USER
+	def_bool n
+
 config GENERIC_CLOCKEVENTS
 	bool
 
@@ -399,6 +402,7 @@ config ARCH_IOP13XX
 	select PLAT_IOP
 	select PCI
 	select ARCH_SUPPORTS_MSI
+	select ARCH_HAS_RET_TO_USER
 	select VMSPLIT_1G
 	help
 	  Support for Intel's IOP13XX (XScale) family of processors.
@@ -410,6 +414,7 @@ config ARCH_IOP32X
 	select PLAT_IOP
 	select PCI
 	select ARCH_REQUIRE_GPIOLIB
+	select ARCH_HAS_RET_TO_USER
 	help
 	  Support for Intel's 80219 and IOP32X (XScale) family of
 	  processors.
@@ -421,6 +426,7 @@ config ARCH_IOP33X
 	select PLAT_IOP
 	select PCI
 	select ARCH_REQUIRE_GPIOLIB
+	select ARCH_HAS_RET_TO_USER
 	help
 	  Support for Intel's IOP33X (XScale) family of processors.
 
diff --git a/arch/arm/include/asm/entry-macro-vic2.S b/arch/arm/include/asm/entry-macro-vic2.S
index 2077314..2148196 100644
--- a/arch/arm/include/asm/entry-macro-vic2.S
+++ b/arch/arm/include/asm/entry-macro-vic2.S
@@ -33,9 +33,6 @@
 	ldr	\base, =VA_VIC0
 	.endm
 
-	.macro	arch_ret_to_user, tmp1, tmp2
-	.endm
-
 	.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
 
 	@ check the vic0
diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index 2c1db77..5fa7a4f 100644
--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -30,8 +30,10 @@ ret_fast_syscall:
 	tst	r1, #_TIF_WORK_MASK
 	bne	fast_work_pending
 
+#ifdef CONFIG_ARCH_HAS_RET_TO_USER
 	/* perform architecture specific actions before user return */
 	arch_ret_to_user r1, lr
+#endif
 
 	restore_user_regs fast = 1, offset = S_OFF
  UNWIND(.fnend		)
@@ -63,8 +65,10 @@ ret_slow_syscall:
 	tst	r1, #_TIF_WORK_MASK
 	bne	work_pending
 no_work_pending:
+#ifdef CONFIG_ARCH_HAS_RET_TO_USER
 	/* perform architecture specific actions before user return */
 	arch_ret_to_user r1, lr
+#endif
 
 	restore_user_regs fast = 0, offset = 0
 ENDPROC(ret_to_user)
diff --git a/arch/arm/mach-aaec2000/include/mach/entry-macro.S b/arch/arm/mach-aaec2000/include/mach/entry-macro.S
index 1cdbab4..9ffc1c4 100644
--- a/arch/arm/mach-aaec2000/include/mach/entry-macro.S
+++ b/arch/arm/mach-aaec2000/include/mach/entry-macro.S
@@ -15,9 +15,6 @@
 		.macro  get_irqnr_preamble, base, tmp
 		.endm
 
-		.macro  arch_ret_to_user, tmp1, tmp2
-		.endm
-
 		.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
 		mov	r4, #0xf8000000
 		add	r4, r4, #0x00000500
diff --git a/arch/arm/mach-at91/include/mach/entry-macro.S b/arch/arm/mach-at91/include/mach/entry-macro.S
index c39f889..85a84d4 100644
--- a/arch/arm/mach-at91/include/mach/entry-macro.S
+++ b/arch/arm/mach-at91/include/mach/entry-macro.S
@@ -17,9 +17,6 @@
 	ldr	\base, =(AT91_VA_BASE_SYS + AT91_AIC)		@ base virtual address of AIC peripheral
 	.endm
 
-	.macro  arch_ret_to_user, tmp1, tmp2
-	.endm
-
 	.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
 	ldr	\irqnr, [\base, #(AT91_AIC_IVR - AT91_AIC)]	@ read IRQ vector register: de-asserts nIRQ to processor (and clears interrupt)
 	ldr	\irqstat, [\base, #(AT91_AIC_ISR - AT91_AIC)]	@ read interrupt source number
diff --git a/arch/arm/mach-bcmring/include/mach/entry-macro.S b/arch/arm/mach-bcmring/include/mach/entry-macro.S
index 7dac106..af0d3cc 100644
--- a/arch/arm/mach-bcmring/include/mach/entry-macro.S
+++ b/arch/arm/mach-bcmring/include/mach/entry-macro.S
@@ -75,9 +75,6 @@
 		.macro  get_irqnr_preamble, base, tmp
 		.endm
 
-		.macro  arch_ret_to_user, tmp1, tmp2
-		.endm
-
 		.macro	irq_prio_table
 		.endm
 
diff --git a/arch/arm/mach-clps711x/include/mach/entry-macro.S b/arch/arm/mach-clps711x/include/mach/entry-macro.S
index a04c12e..125af59 100644
--- a/arch/arm/mach-clps711x/include/mach/entry-macro.S
+++ b/arch/arm/mach-clps711x/include/mach/entry-macro.S
@@ -13,9 +13,6 @@
 		.macro	get_irqnr_preamble, base, tmp
 		.endm
 
-		.macro	arch_ret_to_user, tmp1, tmp2
-		.endm
-
 #if (INTSR2 - INTSR1) != (INTMR2 - INTMR1)
 #error INTSR stride != INTMR stride
 #endif
diff --git a/arch/arm/mach-cns3xxx/include/mach/entry-macro.S b/arch/arm/mach-cns3xxx/include/mach/entry-macro.S
index a7601d0..25c1de8 100644
--- a/arch/arm/mach-cns3xxx/include/mach/entry-macro.S
+++ b/arch/arm/mach-cns3xxx/include/mach/entry-macro.S
@@ -16,9 +16,6 @@
 		ldr	\base, [\base]
 		.endm
 
-		.macro  arch_ret_to_user, tmp1, tmp2
-		.endm
-
 		/*
 		 * The interrupt numbering scheme is defined in the
 		 * interrupt controller spec.  To wit:
diff --git a/arch/arm/mach-davinci/include/mach/entry-macro.S b/arch/arm/mach-davinci/include/mach/entry-macro.S
index 9119790..694c18f 100644
--- a/arch/arm/mach-davinci/include/mach/entry-macro.S
+++ b/arch/arm/mach-davinci/include/mach/entry-macro.S
@@ -16,9 +16,6 @@
 		ldr \base, [\base]
 		.endm
 
-		.macro  arch_ret_to_user, tmp1, tmp2
-		.endm
-
 		.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
 #if defined(CONFIG_AINTC) && defined(CONFIG_CP_INTC)
 		ldr \tmp, =davinci_intc_type
diff --git a/arch/arm/mach-dove/include/mach/entry-macro.S b/arch/arm/mach-dove/include/mach/entry-macro.S
index ec55a83..72d622b 100644
--- a/arch/arm/mach-dove/include/mach/entry-macro.S
+++ b/arch/arm/mach-dove/include/mach/entry-macro.S
@@ -10,9 +10,6 @@
 
 #include <mach/bridge-regs.h>
 
-	.macro  arch_ret_to_user, tmp1, tmp2
-	.endm
-
 	.macro  get_irqnr_preamble, base, tmp
 	ldr	\base, =IRQ_VIRT_BASE
 	.endm
diff --git a/arch/arm/mach-ebsa110/include/mach/entry-macro.S b/arch/arm/mach-ebsa110/include/mach/entry-macro.S
index 6d32f8b..14b110d 100644
--- a/arch/arm/mach-ebsa110/include/mach/entry-macro.S
+++ b/arch/arm/mach-ebsa110/include/mach/entry-macro.S
@@ -16,9 +16,6 @@
 	mov	\base, #IRQ_STAT
 	.endm
 
-	.macro  arch_ret_to_user, tmp1, tmp2
-	.endm
-
 	.macro	get_irqnr_and_base, irqnr, stat, base, tmp
 	ldrb	\stat, [\base]			@ get interrupts
 	mov	\irqnr, #0
diff --git a/arch/arm/mach-ep93xx/include/mach/entry-macro.S b/arch/arm/mach-ep93xx/include/mach/entry-macro.S
index 1b535d6..4891ad7 100644
--- a/arch/arm/mach-ep93xx/include/mach/entry-macro.S
+++ b/arch/arm/mach-ep93xx/include/mach/entry-macro.S
@@ -14,9 +14,6 @@
 		.macro  get_irqnr_preamble, base, tmp
 		.endm
 
-		.macro  arch_ret_to_user, tmp1, tmp2
-		.endm
-
 		.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
 		ldr	\base, =(EP93XX_AHB_VIRT_BASE)
 		orr	\base, \base, #0x000b0000
diff --git a/arch/arm/mach-footbridge/include/mach/entry-macro.S b/arch/arm/mach-footbridge/include/mach/entry-macro.S
index 77c709e..dabbd5c 100644
--- a/arch/arm/mach-footbridge/include/mach/entry-macro.S
+++ b/arch/arm/mach-footbridge/include/mach/entry-macro.S
@@ -21,9 +21,6 @@
 		.endif
 		.endm
 
-		.macro  arch_ret_to_user, tmp1, tmp2
-		.endm
-
 		.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
 		ldr	\irqstat, [\base, #0x180]	@ get interrupts
 
diff --git a/arch/arm/mach-gemini/include/mach/entry-macro.S b/arch/arm/mach-gemini/include/mach/entry-macro.S
index b24bde7..f044e43 100644
--- a/arch/arm/mach-gemini/include/mach/entry-macro.S
+++ b/arch/arm/mach-gemini/include/mach/entry-macro.S
@@ -15,9 +15,6 @@
 	.macro  get_irqnr_preamble, base, tmp
 	.endm
 
-	.macro  arch_ret_to_user, tmp1, tmp2
-	.endm
-
 	.macro  get_irqnr_and_base, irqnr, irqstat, base, tmp
 	ldr     \irqstat, =IO_ADDRESS(GEMINI_INTERRUPT_BASE + IRQ_STATUS)
 	ldr     \irqnr, [\irqstat]
diff --git a/arch/arm/mach-h720x/include/mach/entry-macro.S b/arch/arm/mach-h720x/include/mach/entry-macro.S
index d928619..96f2e11 100644
--- a/arch/arm/mach-h720x/include/mach/entry-macro.S
+++ b/arch/arm/mach-h720x/include/mach/entry-macro.S
@@ -11,9 +11,6 @@
 		.macro  get_irqnr_preamble, base, tmp
 		.endm
 
-		.macro  arch_ret_to_user, tmp1, tmp2
-		.endm
-
 		.macro  get_irqnr_and_base, irqnr, irqstat, base, tmp
 #if defined (CONFIG_CPU_H7201) || defined (CONFIG_CPU_H7202)
 		@ we could use the id register on H7202, but this is not
diff --git a/arch/arm/mach-integrator/include/mach/entry-macro.S b/arch/arm/mach-integrator/include/mach/entry-macro.S
index f0c4de4..5cc7b85 100644
--- a/arch/arm/mach-integrator/include/mach/entry-macro.S
+++ b/arch/arm/mach-integrator/include/mach/entry-macro.S
@@ -14,9 +14,6 @@
 		.macro  get_irqnr_preamble, base, tmp
 		.endm
 
-		.macro  arch_ret_to_user, tmp1, tmp2
-		.endm
-
 		.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
 /* FIXME: should not be using soo many LDRs here */
 		ldr	\base, =IO_ADDRESS(INTEGRATOR_IC_BASE)
diff --git a/arch/arm/mach-ixp2000/include/mach/entry-macro.S b/arch/arm/mach-ixp2000/include/mach/entry-macro.S
index 6d27838..c4444df 100644
--- a/arch/arm/mach-ixp2000/include/mach/entry-macro.S
+++ b/arch/arm/mach-ixp2000/include/mach/entry-macro.S
@@ -12,9 +12,6 @@
 		.macro  get_irqnr_preamble, base, tmp
 		.endm
 
-		.macro  arch_ret_to_user, tmp1, tmp2
-		.endm
-
 		.macro  get_irqnr_and_base, irqnr, irqstat, base, tmp
 
 		mov	\irqnr, #0x0              @clear out irqnr as default
diff --git a/arch/arm/mach-ixp23xx/include/mach/entry-macro.S b/arch/arm/mach-ixp23xx/include/mach/entry-macro.S
index c22f772..3fd2cb9 100644
--- a/arch/arm/mach-ixp23xx/include/mach/entry-macro.S
+++ b/arch/arm/mach-ixp23xx/include/mach/entry-macro.S
@@ -5,9 +5,6 @@
 		.macro  get_irqnr_preamble, base, tmp
 		.endm
 
-		.macro  arch_ret_to_user, tmp1, tmp2
-		.endm
-
 		.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
 		ldr	\irqnr, =(IXP23XX_INTC_VIRT + IXP23XX_INTR_IRQ_ENC_ST_OFFSET)
 		ldr	\irqnr, [\irqnr]	@ get interrupt number
diff --git a/arch/arm/mach-ixp4xx/include/mach/entry-macro.S b/arch/arm/mach-ixp4xx/include/mach/entry-macro.S
index c53de19..79adf83 100644
--- a/arch/arm/mach-ixp4xx/include/mach/entry-macro.S
+++ b/arch/arm/mach-ixp4xx/include/mach/entry-macro.S
@@ -12,9 +12,6 @@
 		.macro  get_irqnr_preamble, base, tmp
 		.endm
 
-		.macro  arch_ret_to_user, tmp1, tmp2
-		.endm
-
 		.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
 		ldr	\irqstat, =(IXP4XX_INTC_BASE_VIRT+IXP4XX_ICIP_OFFSET)
 		ldr	\irqstat, [\irqstat]		@ get interrupts
diff --git a/arch/arm/mach-kirkwood/include/mach/entry-macro.S b/arch/arm/mach-kirkwood/include/mach/entry-macro.S
index 5d072cb..82db29f 100644
--- a/arch/arm/mach-kirkwood/include/mach/entry-macro.S
+++ b/arch/arm/mach-kirkwood/include/mach/entry-macro.S
@@ -10,9 +10,6 @@
 
 #include <mach/bridge-regs.h>
 
-	.macro  arch_ret_to_user, tmp1, tmp2
-	.endm
-
 	.macro  get_irqnr_preamble, base, tmp
 	ldr	\base, =IRQ_VIRT_BASE
 	.endm
diff --git a/arch/arm/mach-ks8695/include/mach/entry-macro.S b/arch/arm/mach-ks8695/include/mach/entry-macro.S
index 1bc1c4c..8315b34 100644
--- a/arch/arm/mach-ks8695/include/mach/entry-macro.S
+++ b/arch/arm/mach-ks8695/include/mach/entry-macro.S
@@ -18,9 +18,6 @@
 		ldr	\base, =KS8695_IRQ_VA			@ Base address of interrupt controller
 	.endm
 
-	.macro  arch_ret_to_user, tmp1, tmp2
-	.endm
-
 	.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
 		ldr	\irqstat, [\base, #KS8695_INTMS]	@ Mask Status register
 
diff --git a/arch/arm/mach-l7200/include/mach/entry-macro.S b/arch/arm/mach-l7200/include/mach/entry-macro.S
index 570e71a..1564b9e 100644
--- a/arch/arm/mach-l7200/include/mach/entry-macro.S
+++ b/arch/arm/mach-l7200/include/mach/entry-macro.S
@@ -14,9 +14,6 @@
 		.macro  get_irqnr_preamble, base, tmp
 		.endm
 
-		.macro  arch_ret_to_user, tmp1, tmp2
-		.endm
-
 		.macro  get_irqnr_and_base, irqnr, irqstat, base, tmp
 		mov     \irqstat, #irq_base_addr		@ Virt addr IRQ regs
 		add	\irqstat, \irqstat, #0x00001000		@ Status reg
diff --git a/arch/arm/mach-lh7a40x/include/mach/entry-macro.S b/arch/arm/mach-lh7a40x/include/mach/entry-macro.S
index 8e99a99..e74ba53 100644
--- a/arch/arm/mach-lh7a40x/include/mach/entry-macro.S
+++ b/arch/arm/mach-lh7a40x/include/mach/entry-macro.S
@@ -26,9 +26,6 @@
 		.macro  get_irqnr_preamble, base, tmp
 		.endm
 
-		.macro  arch_ret_to_user, tmp1, tmp2
-		.endm
-
 		.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
 
 branch_irq_lh7a400: b 1000f
@@ -83,9 +80,6 @@ branch_irq_lh7a400: b 1000f
 		.macro  get_irqnr_preamble, base, tmp
 		.endm
 
-		.macro  arch_ret_to_user, tmp1, tmp2
-		.endm
-
 		.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
 		mov	\irqnr, #0
 		mov	\base, #io_p2v(0x80000000)	@ APB registers
@@ -105,9 +99,6 @@ branch_irq_lh7a400: b 1000f
 		.macro  get_irqnr_preamble, base, tmp
 		.endm
 
-		.macro  arch_ret_to_user, tmp1, tmp2
-		.endm
-
 		.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
 		mov	\irqnr, #0			@ VIC1 irq base
 		mov	\base, #io_p2v(0x80000000)	@ APB registers
diff --git a/arch/arm/mach-loki/include/mach/entry-macro.S b/arch/arm/mach-loki/include/mach/entry-macro.S
index a569fcb..fb5b942 100644
--- a/arch/arm/mach-loki/include/mach/entry-macro.S
+++ b/arch/arm/mach-loki/include/mach/entry-macro.S
@@ -10,9 +10,6 @@
 
 #include <mach/bridge-regs.h>
 
-	.macro  arch_ret_to_user, tmp1, tmp2
-	.endm
-
 	.macro  get_irqnr_preamble, base, tmp
 	ldr	\base, =IRQ_VIRT_BASE
 	.endm
diff --git a/arch/arm/mach-mmp/include/mach/entry-macro.S b/arch/arm/mach-mmp/include/mach/entry-macro.S
index 9e93544..9cff9e7 100644
--- a/arch/arm/mach-mmp/include/mach/entry-macro.S
+++ b/arch/arm/mach-mmp/include/mach/entry-macro.S
@@ -8,9 +8,6 @@
 
 #include <mach/regs-icu.h>
 
-	.macro	arch_ret_to_user, tmp1, tmp2
-	.endm
-
 	.macro	get_irqnr_preamble, base, tmp
 	mrc	p15, 0, \tmp, c0, c0, 0		@ CPUID
 	and	\tmp, \tmp, #0xff00
diff --git a/arch/arm/mach-msm/include/mach/entry-macro.S b/arch/arm/mach-msm/include/mach/entry-macro.S
index d4a5503..3381956 100644
--- a/arch/arm/mach-msm/include/mach/entry-macro.S
+++ b/arch/arm/mach-msm/include/mach/entry-macro.S
@@ -22,9 +22,6 @@
 	mov	\base, #MSM_VIC_BASE
 	.endm
 
-	.macro	arch_ret_to_user, tmp1, tmp2
-	.endm
-
 	.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
 	@ 0xD0 has irq# or old irq# if the irq has been handled
 	@ 0xD4 has irq# or -1 if none pending *but* if you just
diff --git a/arch/arm/mach-mv78xx0/include/mach/entry-macro.S b/arch/arm/mach-mv78xx0/include/mach/entry-macro.S
index ad7fd77..6b1f088 100644
--- a/arch/arm/mach-mv78xx0/include/mach/entry-macro.S
+++ b/arch/arm/mach-mv78xx0/include/mach/entry-macro.S
@@ -10,9 +10,6 @@
 
 #include <mach/bridge-regs.h>
 
-	.macro  arch_ret_to_user, tmp1, tmp2
-	.endm
-
 	.macro  get_irqnr_preamble, base, tmp
 	ldr	\base, =IRQ_VIRT_BASE
 	.endm
diff --git a/arch/arm/mach-netx/include/mach/entry-macro.S b/arch/arm/mach-netx/include/mach/entry-macro.S
index 3eea16a..d198559 100644
--- a/arch/arm/mach-netx/include/mach/entry-macro.S
+++ b/arch/arm/mach-netx/include/mach/entry-macro.S
@@ -24,9 +24,6 @@
 		ldr	\base, =io_p2v(0x001ff000)
 		.endm
 
-		.macro  arch_ret_to_user, tmp1, tmp2
-		.endm
-
 		.macro  get_irqnr_and_base, irqnr, irqstat, base, tmp
 		ldr	\irqstat, [\base, #0]
 		clz	\irqnr, \irqstat
diff --git a/arch/arm/mach-nomadik/include/mach/entry-macro.S b/arch/arm/mach-nomadik/include/mach/entry-macro.S
index 6028da6..5c72dba 100644
--- a/arch/arm/mach-nomadik/include/mach/entry-macro.S
+++ b/arch/arm/mach-nomadik/include/mach/entry-macro.S
@@ -13,9 +13,6 @@
 	ldr	\base, =IO_ADDRESS(NOMADIK_IC_BASE)
 	.endm
 
-	.macro	arch_ret_to_user, tmp1, tmp2
-	.endm
-
 	.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
 
 	/* This stanza gets the irq mask from one of two status registers */
diff --git a/arch/arm/mach-ns9xxx/include/mach/entry-macro.S b/arch/arm/mach-ns9xxx/include/mach/entry-macro.S
index 5e49cd4..cbdbdc3 100644
--- a/arch/arm/mach-ns9xxx/include/mach/entry-macro.S
+++ b/arch/arm/mach-ns9xxx/include/mach/entry-macro.S
@@ -15,9 +15,6 @@
 		ldr	\base, =SYS_ISRADDR
 		.endm
 
-		.macro	arch_ret_to_user, tmp1, tmp2
-		.endm
-
 		.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
 		ldr	\irqstat, [\base, #(SYS_ISA - SYS_ISRADDR)]
 		cmp	\irqstat, #0
diff --git a/arch/arm/mach-nuc93x/include/mach/entry-macro.S b/arch/arm/mach-nuc93x/include/mach/entry-macro.S
index e3cd5df..3ed2c17 100644
--- a/arch/arm/mach-nuc93x/include/mach/entry-macro.S
+++ b/arch/arm/mach-nuc93x/include/mach/entry-macro.S
@@ -13,9 +13,6 @@
 	.macro  get_irqnr_preamble, base, tmp
 	.endm
 
-	.macro  arch_ret_to_user, tmp1, tmp2
-	.endm
-
 	.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
 
 		mov	\base, #AIC_BA
diff --git a/arch/arm/mach-omap1/include/mach/entry-macro.S b/arch/arm/mach-omap1/include/mach/entry-macro.S
index 1751955..a620265 100644
--- a/arch/arm/mach-omap1/include/mach/entry-macro.S
+++ b/arch/arm/mach-omap1/include/mach/entry-macro.S
@@ -31,9 +31,6 @@
 		.macro  get_irqnr_preamble, base, tmp
 		.endm
 
-		.macro  arch_ret_to_user, tmp1, tmp2
-		.endm
-
 		.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
 		ldr	\base, =OMAP1_IO_ADDRESS(OMAP_IH1_BASE)
 		ldr	\irqnr, [\base, #IRQ_ITR_REG_OFFSET]
diff --git a/arch/arm/mach-omap2/include/mach/entry-macro.S b/arch/arm/mach-omap2/include/mach/entry-macro.S
index e28b256..0b271f7 100644
--- a/arch/arm/mach-omap2/include/mach/entry-macro.S
+++ b/arch/arm/mach-omap2/include/mach/entry-macro.S
@@ -27,9 +27,6 @@
 #define INTCPS_SIR_IRQ_OFFSET	0x0040	/* omap2/3 active interrupt offset */
 #define	ACTIVEIRQ_MASK		0x7f	/* omap2/3 active interrupt bits */
 
-		.macro  arch_ret_to_user, tmp1, tmp2
-		.endm
-
 /*
  * Unoptimized irq functions for multi-omap2, 3 and 4
  */
diff --git a/arch/arm/mach-orion5x/include/mach/entry-macro.S b/arch/arm/mach-orion5x/include/mach/entry-macro.S
index 92409c3..79eb502 100644
--- a/arch/arm/mach-orion5x/include/mach/entry-macro.S
+++ b/arch/arm/mach-orion5x/include/mach/entry-macro.S
@@ -10,9 +10,6 @@
 
 #include <mach/bridge-regs.h>
 
-	.macro  arch_ret_to_user, tmp1, tmp2
-	.endm
-
 	.macro  get_irqnr_preamble, base, tmp
 	ldr	\base, =MAIN_IRQ_CAUSE
 	.endm
diff --git a/arch/arm/mach-pnx4008/include/mach/entry-macro.S b/arch/arm/mach-pnx4008/include/mach/entry-macro.S
index 908c3d6..4ccd4c5 100644
--- a/arch/arm/mach-pnx4008/include/mach/entry-macro.S
+++ b/arch/arm/mach-pnx4008/include/mach/entry-macro.S
@@ -28,9 +28,6 @@
 		.macro  get_irqnr_preamble, base, tmp
 		.endm
 
-		.macro  arch_ret_to_user, tmp1, tmp2
-		.endm
-
 		.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
 /* decode the MIC interrupt numbers */
 		ldr	\base, =IO_ADDRESS(PNX4008_INTCTRLMIC_BASE)
diff --git a/arch/arm/mach-pxa/include/mach/entry-macro.S b/arch/arm/mach-pxa/include/mach/entry-macro.S
index 5f646d6..8c64ce9 100644
--- a/arch/arm/mach-pxa/include/mach/entry-macro.S
+++ b/arch/arm/mach-pxa/include/mach/entry-macro.S
@@ -13,9 +13,6 @@
 		.macro  get_irqnr_preamble, base, tmp
 		.endm
 
-		.macro  arch_ret_to_user, tmp1, tmp2
-		.endm
-
 		.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
 		mrc	p15, 0, \tmp, c0, c0, 0		@ CPUID
 		mov	\tmp, \tmp, lsr #13
diff --git a/arch/arm/mach-realview/include/mach/entry-macro.S b/arch/arm/mach-realview/include/mach/entry-macro.S
index f3ec9d4..5621337 100644
--- a/arch/arm/mach-realview/include/mach/entry-macro.S
+++ b/arch/arm/mach-realview/include/mach/entry-macro.S
@@ -15,9 +15,6 @@
 		ldr	\base, [\base]
 		.endm
 
-		.macro  arch_ret_to_user, tmp1, tmp2
-		.endm
-
 		/*
 		 * The interrupt numbering scheme is defined in the
 		 * interrupt controller spec.  To wit:
diff --git a/arch/arm/mach-rpc/include/mach/entry-macro.S b/arch/arm/mach-rpc/include/mach/entry-macro.S
index 4e7e541..02c246d 100644
--- a/arch/arm/mach-rpc/include/mach/entry-macro.S
+++ b/arch/arm/mach-rpc/include/mach/entry-macro.S
@@ -11,6 +11,3 @@
 	.endif
 	.endm
 
-	.macro  arch_ret_to_user, tmp1, tmp2
-	.endm
-
diff --git a/arch/arm/mach-s3c2410/include/mach/entry-macro.S b/arch/arm/mach-s3c2410/include/mach/entry-macro.S
index 04791d2..7615a14 100644
--- a/arch/arm/mach-s3c2410/include/mach/entry-macro.S
+++ b/arch/arm/mach-s3c2410/include/mach/entry-macro.S
@@ -25,9 +25,6 @@
 	.macro  get_irqnr_preamble, base, tmp
 	.endm
 
-	.macro  arch_ret_to_user, tmp1, tmp2
-	.endm
-
 	.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
 
 		mov	\base, #S3C24XX_VA_IRQ
diff --git a/arch/arm/mach-s5p6442/include/mach/entry-macro.S b/arch/arm/mach-s5p6442/include/mach/entry-macro.S
index c56a1d6..fad4037 100644
--- a/arch/arm/mach-s5p6442/include/mach/entry-macro.S
+++ b/arch/arm/mach-s5p6442/include/mach/entry-macro.S
@@ -18,9 +18,6 @@
 	ldr	\base, =VA_VIC0
 	.endm
 
-	.macro	arch_ret_to_user, tmp1, tmp2
-	.endm
-
 	.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
 
 	@ check the vic0
diff --git a/arch/arm/mach-s5pc100/include/mach/entry-macro.S b/arch/arm/mach-s5pc100/include/mach/entry-macro.S
index ffb41e9..ac55802 100644
--- a/arch/arm/mach-s5pc100/include/mach/entry-macro.S
+++ b/arch/arm/mach-s5pc100/include/mach/entry-macro.S
@@ -20,9 +20,6 @@
 	ldr	\base, =S3C_VA_VIC0
 	.endm
 
-	.macro	arch_ret_to_user, tmp1, tmp2
-	.endm
-
 	.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
 
 	@ check the vic0
diff --git a/arch/arm/mach-s5pv210/include/mach/entry-macro.S b/arch/arm/mach-s5pv210/include/mach/entry-macro.S
index 35c7a7c..42ab65e 100644
--- a/arch/arm/mach-s5pv210/include/mach/entry-macro.S
+++ b/arch/arm/mach-s5pv210/include/mach/entry-macro.S
@@ -18,9 +18,6 @@
 	ldr	\base, =VA_VIC0
 	.endm
 
-	.macro	arch_ret_to_user, tmp1, tmp2
-	.endm
-
 	.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
 
 	@ check the vic0
diff --git a/arch/arm/mach-sa1100/include/mach/entry-macro.S b/arch/arm/mach-sa1100/include/mach/entry-macro.S
index 4151c7f..8cf7630 100644
--- a/arch/arm/mach-sa1100/include/mach/entry-macro.S
+++ b/arch/arm/mach-sa1100/include/mach/entry-macro.S
@@ -13,9 +13,6 @@
 		add	\base, \base, #0x00050000
 		.endm
 
-		.macro  arch_ret_to_user, tmp1, tmp2
-		.endm
-
 		.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
 		ldr	\irqstat, [\base]		@ get irqs
 		ldr	\irqnr, [\base, #4]		@ ICMR = 0xfa050004
diff --git a/arch/arm/mach-shark/include/mach/entry-macro.S b/arch/arm/mach-shark/include/mach/entry-macro.S
index c7bfeaa..84f6fa4 100644
--- a/arch/arm/mach-shark/include/mach/entry-macro.S
+++ b/arch/arm/mach-shark/include/mach/entry-macro.S
@@ -10,9 +10,6 @@
 		.macro  get_irqnr_preamble, base, tmp
 		.endm
 
-		.macro  arch_ret_to_user, tmp1, tmp2
-		.endm
-
 		.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
 		mov	r4, #0xe0000000
 
diff --git a/arch/arm/mach-shmobile/include/mach/entry-macro.S b/arch/arm/mach-shmobile/include/mach/entry-macro.S
index dbc6545..ac5310e 100644
--- a/arch/arm/mach-shmobile/include/mach/entry-macro.S
+++ b/arch/arm/mach-shmobile/include/mach/entry-macro.S
@@ -21,9 +21,6 @@
 	ldr     \base, =INTFLGA
 	.endm
 
-	.macro  arch_ret_to_user, tmp1, tmp2
-	.endm
-
 	.macro  get_irqnr_and_base, irqnr, irqstat, base, tmp
 	ldr     \irqnr, [\base]
 	cmp	\irqnr, #0
diff --git a/arch/arm/mach-spear3xx/include/mach/entry-macro.S b/arch/arm/mach-spear3xx/include/mach/entry-macro.S
index dfef683..589b441 100644
--- a/arch/arm/mach-spear3xx/include/mach/entry-macro.S
+++ b/arch/arm/mach-spear3xx/include/mach/entry-macro.S
@@ -18,9 +18,6 @@
 		.macro	get_irqnr_preamble, base, tmp
 		.endm
 
-		.macro	arch_ret_to_user, tmp1, tmp2
-		.endm
-
 		.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
 		ldr	\base, =VA_SPEAR3XX_ML1_VIC_BASE
 		ldr	\irqstat, [\base, #VIC_IRQ_STATUS]	@ get status
diff --git a/arch/arm/mach-spear6xx/include/mach/entry-macro.S b/arch/arm/mach-spear6xx/include/mach/entry-macro.S
index 76a6ace..accef45 100644
--- a/arch/arm/mach-spear6xx/include/mach/entry-macro.S
+++ b/arch/arm/mach-spear6xx/include/mach/entry-macro.S
@@ -18,9 +18,6 @@
 		.macro	get_irqnr_preamble, base, tmp
 		.endm
 
-		.macro	arch_ret_to_user, tmp1, tmp2
-		.endm
-
 		.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
 		ldr	\base, =VA_SPEAR6XX_CPU_VIC_PRI_BASE
 		ldr	\irqstat, [\base, #VIC_IRQ_STATUS]	@ get status
diff --git a/arch/arm/mach-stmp378x/include/mach/entry-macro.S b/arch/arm/mach-stmp378x/include/mach/entry-macro.S
index 9be8e1f..4169390 100644
--- a/arch/arm/mach-stmp378x/include/mach/entry-macro.S
+++ b/arch/arm/mach-stmp378x/include/mach/entry-macro.S
@@ -28,5 +28,3 @@
                 .macro  get_irqnr_preamble, base, tmp
                 .endm
 
-                .macro  arch_ret_to_user, tmp1, tmp2
-                .endm
diff --git a/arch/arm/mach-stmp37xx/include/mach/entry-macro.S b/arch/arm/mach-stmp37xx/include/mach/entry-macro.S
index 04d9c76..dc017c9 100644
--- a/arch/arm/mach-stmp37xx/include/mach/entry-macro.S
+++ b/arch/arm/mach-stmp37xx/include/mach/entry-macro.S
@@ -30,5 +30,3 @@
                 .macro  get_irqnr_preamble, base, tmp
                 .endm
 
-                .macro  arch_ret_to_user, tmp1, tmp2
-                .endm
diff --git a/arch/arm/mach-u300/include/mach/entry-macro.S b/arch/arm/mach-u300/include/mach/entry-macro.S
index 171f2e1..3647a9a 100644
--- a/arch/arm/mach-u300/include/mach/entry-macro.S
+++ b/arch/arm/mach-u300/include/mach/entry-macro.S
@@ -14,9 +14,6 @@
 	.macro  get_irqnr_preamble, base, tmp
 	.endm
 
-	.macro  arch_ret_to_user, tmp1, tmp2
-	.endm
-
 	.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
 	ldr	\base, = U300_AHB_PER_VIRT_BASE-U300_AHB_PER_PHYS_BASE+U300_INTCON0_BASE
 	ldr	\irqstat, [\base, #VIC_IRQ_STATUS] @ get masked status
diff --git a/arch/arm/mach-ux500/include/mach/entry-macro.S b/arch/arm/mach-ux500/include/mach/entry-macro.S
index 1f5bb0b..88f115e 100644
--- a/arch/arm/mach-ux500/include/mach/entry-macro.S
+++ b/arch/arm/mach-ux500/include/mach/entry-macro.S
@@ -17,9 +17,6 @@
 		ldr     \base, =IO_ADDRESS(UX500_GIC_CPU_BASE)
 		.endm
 
-		.macro  arch_ret_to_user, tmp1, tmp2
-		.endm
-
 		/*
 		 * The interrupt numbering scheme is defined in the
 		 * interrupt controller spec.  To wit:
diff --git a/arch/arm/mach-versatile/include/mach/entry-macro.S b/arch/arm/mach-versatile/include/mach/entry-macro.S
index ea5e33d..b7ce3c2 100644
--- a/arch/arm/mach-versatile/include/mach/entry-macro.S
+++ b/arch/arm/mach-versatile/include/mach/entry-macro.S
@@ -15,9 +15,6 @@
 		ldr	\base, =IO_ADDRESS(VERSATILE_VIC_BASE)
 		.endm
 
-		.macro  arch_ret_to_user, tmp1, tmp2
-		.endm
-
 		.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
 		ldr	\irqstat, [\base, #VIC_IRQ_STATUS]	@ get masked status
 		mov	\irqnr, #0
diff --git a/arch/arm/mach-vexpress/include/mach/entry-macro.S b/arch/arm/mach-vexpress/include/mach/entry-macro.S
index 15c70e8..7362d7f 100644
--- a/arch/arm/mach-vexpress/include/mach/entry-macro.S
+++ b/arch/arm/mach-vexpress/include/mach/entry-macro.S
@@ -5,9 +5,6 @@
 	ldr	\base, [\base]
 	.endm
 
-	.macro	arch_ret_to_user, tmp1, tmp2
-	.endm
-
 	/*
 	 * The interrupt numbering scheme is defined in the
 	 * interrupt controller spec.  To wit:
diff --git a/arch/arm/mach-w90x900/include/mach/entry-macro.S b/arch/arm/mach-w90x900/include/mach/entry-macro.S
index b747c2b..e286dac 100644
--- a/arch/arm/mach-w90x900/include/mach/entry-macro.S
+++ b/arch/arm/mach-w90x900/include/mach/entry-macro.S
@@ -15,9 +15,6 @@
 	.macro  get_irqnr_preamble, base, tmp
 	.endm
 
-	.macro  arch_ret_to_user, tmp1, tmp2
-	.endm
-
 	.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
 
 		mov	\base, #AIC_BA
diff --git a/arch/arm/plat-mxc/include/mach/entry-macro.S b/arch/arm/plat-mxc/include/mach/entry-macro.S
index 4afbf58..f233072 100644
--- a/arch/arm/plat-mxc/include/mach/entry-macro.S
+++ b/arch/arm/plat-mxc/include/mach/entry-macro.S
@@ -27,9 +27,6 @@
 #endif /* CONFIG_MXC_TZIC */
 	.endm
 
-	.macro  arch_ret_to_user, tmp1, tmp2
-	.endm
-
 	@ this macro checks which interrupt occured
 	@ and returns its number in irqnr
 	@ and returns if an interrupt occured in irqstat
-- 
1.7.1
