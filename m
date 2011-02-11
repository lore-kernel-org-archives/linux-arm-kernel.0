From: vbarshak@mvista.com (Valentine Barshak)
Date: Sat, 12 Feb 2011 00:54:21 +0300
Subject: [PATCH RFC] ARM: MPCore v6_early_abort enhancement
Message-ID: <20110211215421.GA29361@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SWP instruction sets bit 11 in DFSR, in case of data fault on SMP MPCore.
So v6_early_abort doesn't need erratum 326103 workaround for MPCore.
    
Signed-off-by: Valentine Barshak <vbarshak@mvista.com>

diff --git a/arch/arm/mm/abort-ev6.S b/arch/arm/mm/abort-ev6.S
index f332df7..590d061 100644
--- a/arch/arm/mm/abort-ev6.S
+++ b/arch/arm/mm/abort-ev6.S
@@ -30,8 +30,10 @@ ENTRY(v6_early_abort)
 	mrc	p15, 0, r0, c6, c0, 0		@ get FAR
 /*
  * Faulty SWP instruction on 1136 doesn't set bit 11 in DFSR (erratum 326103).
- * The test below covers all the write situations, including Java bytecodes
+ * The test below covers all the write situations, including Java bytecodes.
+ * However SMP MPCore doesn't have this erratum.
  */
+#ifndef CONFIG_SMP
 	bic	r1, r1, #1 << 11		@ clear bit 11 of FSR
 	tst	r3, #PSR_J_BIT			@ Java?
 	movne	pc, lr
@@ -43,6 +45,7 @@ ENTRY(v6_early_abort)
 	do_ldrd_abort
 	tst	r3, #1 << 20			@ L = 0 -> write
 	orreq	r1, r1, #1 << 11		@ yes.
+#endif	/* !CONFIG_SMP */
 	mov	pc, lr
 
 
