From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 22 May 2014 14:48:01 +0200
Subject: [PATCH 3/4] ARM: mvebu: improve comments in coherency_ll.S
In-Reply-To: <1400762882-10116-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1400762882-10116-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1400762882-10116-4-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit makes no functional change, it only improves a bit the
various code comments in mach-mvebu/coherency_ll.S, by fixing a few
typos and adding a few more details.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-mvebu/coherency_ll.S | 50 ++++++++++++++++++++++++--------------
 1 file changed, 32 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-mvebu/coherency_ll.S b/arch/arm/mach-mvebu/coherency_ll.S
index 7d1b5a5..311442a 100644
--- a/arch/arm/mach-mvebu/coherency_ll.S
+++ b/arch/arm/mach-mvebu/coherency_ll.S
@@ -24,26 +24,32 @@
 #include <asm/cp15.h>
 
 	.text
-/* Returns with the coherency address in r1 (r0 is untouched)*/
+/* Returns the coherency base address in r1 (r0 is untouched) */
 ENTRY(ll_get_coherency_base)
 	mrc	p15, 0, r1, c1, c0, 0
 	tst	r1, #CR_M @ Check MMU bit enabled
 	bne	1f
 
-	/* use physical address of the coherency register */
+	/*
+	 * MMU is disabled, use the physical address of the coherency
+	 * base address.
+	 */
 	adr	r1, 3f
 	ldr	r3, [r1]
 	ldr	r1, [r1, r3]
 	b	2f
 1:
-	/* use virtual address of the coherency register */
+	/*
+	 * MMU is enabled, use the virtual address of the coherency
+	 * base address.
+	 */
 	ldr	r1, =coherency_base
 	ldr	r1, [r1]
 2:
 	mov	pc, lr
 ENDPROC(ll_get_coherency_base)
 
-/* Returns with the CPU ID in r3 (r0 is untouched)*/
+/* Returns the CPU ID in r3 (r0 is untouched) */
 ENTRY(ll_get_cpuid)
 	mrc	15, 0, r3, cr0, cr0, 5
 	and	r3, r3, #15
@@ -53,18 +59,22 @@ ARM_BE8(rev	r3, r3)
 	mov	pc, lr
 ENDPROC(ll_get_cpuid)
 
-/* ll_add_cpu_to_smp_group, ll_enable_coherency and
- * ll_disable_coherency use strex/ldrex whereas MMU can be off. The
- * Armada XP SoC has an exclusive monitor that can track transactions
- * to Device and/or SO and as such also when MMU is disabled the
- * exclusive transactions will be functional
+/*
+ * ll_add_cpu_to_smp_group(), ll_enable_coherency() and
+ * ll_disable_coherency() use the strex/ldrex instructions while the
+ * MMU can be disabled. The Armada XP SoC has an exclusive monitor
+ * that tracks transactions to Device and/or SO memory and thanks to
+ * that, exclusive transactions are functional even when the MMU is
+ * disabled.
  */
 
 ENTRY(ll_add_cpu_to_smp_group)
 	/*
-	 * r0 being untouched in ll_get_coherency_base and
-	 * ll_get_cpuid, we can use it to save lr modifing it with the
-	 * following bl
+	 * As r0 is not modified by ll_get_coherency_base() and
+	 * ll_get_cpuid(), we use it to temporarly save lr and avoid
+	 * it being modified by the branch and link calls. This
+	 * function is used very early in the secondary CPU boot, and
+	 * no stack is available at this point.
 	 */
 	mov 	r0, lr
 	bl	ll_get_coherency_base
@@ -82,9 +92,11 @@ ENDPROC(ll_add_cpu_to_smp_group)
 
 ENTRY(ll_enable_coherency)
 	/*
-	 * r0 being untouched in ll_get_coherency_base and
-	 * ll_get_cpuid, we can use it to save lr modifing it with the
-	 * following bl
+	 * As r0 is not modified by ll_get_coherency_base() and
+	 * ll_get_cpuid(), we use it to temporarly save lr and avoid
+	 * it being modified by the branch and link calls. This
+	 * function is used very early in the secondary CPU boot, and
+	 * no stack is available at this point.
 	 */
 	mov r0, lr
 	bl	ll_get_coherency_base
@@ -104,9 +116,11 @@ ENDPROC(ll_enable_coherency)
 
 ENTRY(ll_disable_coherency)
 	/*
-	 * r0 being untouched in ll_get_coherency_base and
-	 * ll_get_cpuid, we can use it to save lr modifing it with the
-	 * following bl
+	 * As r0 is not modified by ll_get_coherency_base() and
+	 * ll_get_cpuid(), we use it to temporarly save lr and avoid
+	 * it being modified by the branch and link calls. This
+	 * function is used very early in the secondary CPU boot, and
+	 * no stack is available at this point.
 	 */
 	mov 	r0, lr
 	bl	ll_get_coherency_base
-- 
1.9.3
