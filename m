From: tony@atomide.com (Tony Lindgren)
Date: Wed, 1 Sep 2010 20:40:47 -0700
Subject: [PATCH 4/6] ARM: Do not call test_for_ipi or test_for_ltrirq on UP systems
Message-ID: <mailman.223.1283444501.27306.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Do not call test_for_ipi or test_for_ltrirq on UP systems.

Note that we can't put test_for_ltriq into SMP statement as
it's inlined into the code and the remaining lines of the
macro would still run before UP macro line.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/kernel/entry-armv.S |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index bb2ef60..b8c1ec7 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -40,6 +40,11 @@
 	bne	asm_do_IRQ
 
 #ifdef CONFIG_SMP
+#ifdef CONFIG_SMP_ON_UP
+	adr	lr, BSYM(2f)	@ set lr to end of macro for early return
+	SMP(nop)		@ continue on SMP hardware
+	UP(mov	pc, lr)		@ return early on UP
+#endif
 	/*
 	 * XXX
 	 *
@@ -57,6 +62,7 @@
 	adrne	lr, BSYM(1b)
 	bne	do_local_timer
 #endif
+2:
 #endif
 
 	.endm
-- 
1.7.1
