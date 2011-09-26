From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 26 Sep 2011 12:02:20 +0100
Subject: [PATCH v2 01/16] ARM: Make global handler and
	CONFIG_MULTI_IRQ_HANDLER mutually exclusive
In-Reply-To: <1317034955-1029-1-git-send-email-marc.zyngier@arm.com>
References: <1317034955-1029-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1317034955-1029-2-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Even when CONFIG_MULTI_IRQ_HANDLER is selected, the core code
requires the arch_irq_handler_default macro to be defined as
a fallback.

It turns out nobody is using that particular feature as both PXA
and shmobile have all their machine descriptors populated with
the interrupt handler, leaving unused code (or empty macros) in
their entry-macro.S file just to be able to compile entry-armv.S.

Make CONFIG_MULTI_IRQ_HANDLER exclusive wrt arch_irq_handler_default,
which allows to remove one test from the hot path. Also cleanup both
PXA and shmobile entry-macro.S.

Cc: Eric Miao <eric.y.miao@gmail.com>
Cc: Paul Mundt <lethal@linux-sh.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/kernel/entry-armv.S                      |    7 ++--
 arch/arm/mach-pxa/include/mach/entry-macro.S      |   36 ---------------------
 arch/arm/mach-shmobile/include/mach/entry-macro.S |    9 -----
 3 files changed, 3 insertions(+), 49 deletions(-)

diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index 9ad50c4..bd49a6a 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -36,12 +36,11 @@
 #ifdef CONFIG_MULTI_IRQ_HANDLER
 	ldr	r1, =handle_arch_irq
 	mov	r0, sp
-	ldr	r1, [r1]
 	adr	lr, BSYM(9997f)
-	teq	r1, #0
-	movne	pc, r1
-#endif
+	ldr	pc, [r1]
+#else
 	arch_irq_handler_default
+#endif
 9997:
 	.endm
 
diff --git a/arch/arm/mach-pxa/include/mach/entry-macro.S b/arch/arm/mach-pxa/include/mach/entry-macro.S
index a73bc86..260c0c1 100644
--- a/arch/arm/mach-pxa/include/mach/entry-macro.S
+++ b/arch/arm/mach-pxa/include/mach/entry-macro.S
@@ -7,45 +7,9 @@
  * License version 2. This program is licensed "as is" without any
  * warranty of any kind, whether express or implied.
  */
-#include <mach/hardware.h>
-#include <mach/irqs.h>
 
 		.macro	disable_fiq
 		.endm
 
-		.macro  get_irqnr_preamble, base, tmp
-		.endm
-
 		.macro  arch_ret_to_user, tmp1, tmp2
 		.endm
-
-		.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
-		mrc	p15, 0, \tmp, c0, c0, 0		@ CPUID
-		mov	\tmp, \tmp, lsr #13
-		and	\tmp, \tmp, #0x7		@ Core G
-		cmp	\tmp, #1
-		bhi	1002f
-
-		@ Core Generation 1 (PXA25x)
-		mov	\base, #io_p2v(0x40000000)	@ IIR Ctl = 0x40d00000
-		add	\base, \base, #0x00d00000
-		ldr	\irqstat, [\base, #0]		@ ICIP
-		ldr	\irqnr, [\base, #4]		@ ICMR
-
-		ands	\irqnr, \irqstat, \irqnr
-		beq	1001f
-		rsb	\irqstat, \irqnr, #0
-		and	\irqstat, \irqstat, \irqnr
-		clz	\irqnr, \irqstat
-		rsb	\irqnr, \irqnr, #(31 + PXA_IRQ(0))
-		b	1001f
-1002:
-		@ Core Generation 2 (PXA27x) or Core Generation 3 (PXA3xx)
-		mrc	p6, 0, \irqstat, c5, c0, 0	@ ICHP
-		tst	\irqstat, #0x80000000
-		beq	1001f
-		bic	\irqstat, \irqstat, #0x80000000
-		mov	\irqnr, \irqstat, lsr #16
-		add	\irqnr, \irqnr, #(PXA_IRQ(0))
-1001:
-		.endm
diff --git a/arch/arm/mach-shmobile/include/mach/entry-macro.S b/arch/arm/mach-shmobile/include/mach/entry-macro.S
index 8d4a416..2a57b29 100644
--- a/arch/arm/mach-shmobile/include/mach/entry-macro.S
+++ b/arch/arm/mach-shmobile/include/mach/entry-macro.S
@@ -18,14 +18,5 @@
 	.macro  disable_fiq
 	.endm
 
-	.macro  get_irqnr_preamble, base, tmp
-	.endm
-
-	.macro  get_irqnr_and_base, irqnr, irqstat, base, tmp
-	.endm
-
-	.macro  test_for_ipi, irqnr, irqstat, base, tmp
-	.endm
-
 	.macro  arch_ret_to_user, tmp1, tmp2
 	.endm
-- 
1.7.0.4
