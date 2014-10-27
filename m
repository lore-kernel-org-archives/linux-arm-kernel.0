From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 27 Oct 2014 16:32:33 +0100
Subject: [PATCHv2 1/3] ARM: mvebu: make the coherency_ll.S functions work with
 no coherency fabric
In-Reply-To: <1414423955-5933-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1414423955-5933-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1414423955-5933-2-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ll_add_cpu_to_smp_group(), ll_enable_coherency() and
ll_disable_coherency() are used on Armada XP to control the coherency
fabric. However, they make the assumption that the coherency fabric is
always available, which is currently a correct assumption but will no
longer be true with a followup commit that disables the usage of the
coherency fabric when the conditions are not met to use it.

Therefore, this commit modifies those functions so that they check the
return value of ll_get_coherency_base(), and if the return value is 0,
they simply return without configuring anything in the coherency
fabric.

The ll_get_coherency_base() function is also modified to properly
return 0 when the function is called with the MMU disabled. In this
case, it normally returns the physical address of the coherency
fabric, but we now check if the virtual address is 0, and if that's
case, return a physical address of 0 to indicate that the coherency
fabric is not enabled.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: <stable@vger.kernel.org> # v3.8+
---
 arch/arm/mach-mvebu/coherency_ll.S | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mvebu/coherency_ll.S b/arch/arm/mach-mvebu/coherency_ll.S
index f5d881b..0ed07c3 100644
--- a/arch/arm/mach-mvebu/coherency_ll.S
+++ b/arch/arm/mach-mvebu/coherency_ll.S
@@ -24,7 +24,10 @@
 #include <asm/cp15.h>
 
 	.text
-/* Returns the coherency base address in r1 (r0 is untouched) */
+/*
+ * Returns the coherency base address in r1 (r0 is untouched), or 0 if
+ * the coherency fabric is not enabled.
+ */
 ENTRY(ll_get_coherency_base)
 	mrc	p15, 0, r1, c1, c0, 0
 	tst	r1, #CR_M @ Check MMU bit enabled
@@ -32,8 +35,13 @@ ENTRY(ll_get_coherency_base)
 
 	/*
 	 * MMU is disabled, use the physical address of the coherency
-	 * base address.
+	 * base address. However, if the coherency fabric isn't mapped
+	 * (i.e its virtual address is zero), it means coherency is
+	 * not enabled, so we return 0.
 	 */
+	ldr	r1, =coherency_base
+	cmp	r1, #0
+	beq	2f
 	adr	r1, 3f
 	ldr	r3, [r1]
 	ldr	r1, [r1, r3]
@@ -85,6 +93,9 @@ ENTRY(ll_add_cpu_to_smp_group)
 	 */
 	mov 	r0, lr
 	bl	ll_get_coherency_base
+	/* Bail out if the coherency is not enabled */
+	cmp	r1, #0
+	moveq	pc, r0
 	bl	ll_get_coherency_cpumask
 	mov 	lr, r0
 	add	r0, r1, #ARMADA_XP_CFB_CFG_REG_OFFSET
@@ -107,6 +118,9 @@ ENTRY(ll_enable_coherency)
 	 */
 	mov r0, lr
 	bl	ll_get_coherency_base
+	/* Bail out if the coherency is not enabled */
+	cmp	r1, #0
+	moveq	pc, r0
 	bl	ll_get_coherency_cpumask
 	mov lr, r0
 	add	r0, r1, #ARMADA_XP_CFB_CTL_REG_OFFSET
@@ -131,6 +145,9 @@ ENTRY(ll_disable_coherency)
 	 */
 	mov 	r0, lr
 	bl	ll_get_coherency_base
+	/* Bail out if the coherency is not enabled */
+	cmp	r1, #0
+	moveq	pc, r0
 	bl	ll_get_coherency_cpumask
 	mov 	lr, r0
 	add	r0, r1, #ARMADA_XP_CFB_CTL_REG_OFFSET
-- 
2.0.0
