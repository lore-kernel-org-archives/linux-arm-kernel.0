From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 22 May 2014 14:48:02 +0200
Subject: [PATCH 4/4] ARM: mvebu: returns ll_get_cpuid() to
 ll_get_coherency_cpumask()
In-Reply-To: <1400762882-10116-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1400762882-10116-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1400762882-10116-5-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the refactoring of the coherency fabric assembly code, a function
called ll_get_cpuid() was created to factorize common logic between
functions adding CPU to the SMP coherency group, enabling and
disabling the coherency.

However, the name of the function is highly misleading: ll_get_cpuid()
makes one think tat it returns the ID of the CPU, i.e 0 for CPU0, 1
for CPU1, etc. In fact, this is not at all what this function returns:
it returns a CPU mask for the current CPU, usable for the coherency
fabric configuration and control registers.

Therefore this commit renames this function to
ll_get_coherency_cpumask(), and adds additional comments on top of the
function to explain in more details what it does, and also how the
endianess issue is handled.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-mvebu/coherency_ll.S | 43 ++++++++++++++++++++++----------------
 1 file changed, 25 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-mvebu/coherency_ll.S b/arch/arm/mach-mvebu/coherency_ll.S
index 311442a..510c29e 100644
--- a/arch/arm/mach-mvebu/coherency_ll.S
+++ b/arch/arm/mach-mvebu/coherency_ll.S
@@ -49,15 +49,22 @@ ENTRY(ll_get_coherency_base)
 	mov	pc, lr
 ENDPROC(ll_get_coherency_base)
 
-/* Returns the CPU ID in r3 (r0 is untouched) */
-ENTRY(ll_get_cpuid)
+/*
+ * Returns the coherency CPU mask in r3 (r0 is untouched). This
+ * coherency CPU mask can be used with the coherency fabric
+ * configuration and control registers. Note that the mask is already
+ * endian-swapped as appropriate so that the calling functions do not
+ * have to care about endianness issues while accessing the coherency
+ * fabric registers
+ */
+ENTRY(ll_get_coherency_cpumask)
 	mrc	15, 0, r3, cr0, cr0, 5
 	and	r3, r3, #15
 	mov	r2, #(1 << 24)
 	lsl	r3, r2, r3
 ARM_BE8(rev	r3, r3)
 	mov	pc, lr
-ENDPROC(ll_get_cpuid)
+ENDPROC(ll_get_coherency_cpumask)
 
 /*
  * ll_add_cpu_to_smp_group(), ll_enable_coherency() and
@@ -71,14 +78,14 @@ ENDPROC(ll_get_cpuid)
 ENTRY(ll_add_cpu_to_smp_group)
 	/*
 	 * As r0 is not modified by ll_get_coherency_base() and
-	 * ll_get_cpuid(), we use it to temporarly save lr and avoid
-	 * it being modified by the branch and link calls. This
-	 * function is used very early in the secondary CPU boot, and
-	 * no stack is available at this point.
+	 * ll_get_coherency_cpumask(), we use it to temporarly save lr
+	 * and avoid it being modified by the branch and link
+	 * calls. This function is used very early in the secondary
+	 * CPU boot, and no stack is available at this point.
 	 */
 	mov 	r0, lr
 	bl	ll_get_coherency_base
-	bl	ll_get_cpuid
+	bl	ll_get_coherency_cpumask
 	mov 	lr, r0
 	add	r0, r1, #ARMADA_XP_CFB_CFG_REG_OFFSET
 1:
@@ -93,14 +100,14 @@ ENDPROC(ll_add_cpu_to_smp_group)
 ENTRY(ll_enable_coherency)
 	/*
 	 * As r0 is not modified by ll_get_coherency_base() and
-	 * ll_get_cpuid(), we use it to temporarly save lr and avoid
-	 * it being modified by the branch and link calls. This
-	 * function is used very early in the secondary CPU boot, and
-	 * no stack is available at this point.
+	 * ll_get_coherency_cpumask(), we use it to temporarly save lr
+	 * and avoid it being modified by the branch and link
+	 * calls. This function is used very early in the secondary
+	 * CPU boot, and no stack is available at this point.
 	 */
 	mov r0, lr
 	bl	ll_get_coherency_base
-	bl	ll_get_cpuid
+	bl	ll_get_coherency_cpumask
 	mov lr, r0
 	add	r0, r1, #ARMADA_XP_CFB_CTL_REG_OFFSET
 1:
@@ -117,14 +124,14 @@ ENDPROC(ll_enable_coherency)
 ENTRY(ll_disable_coherency)
 	/*
 	 * As r0 is not modified by ll_get_coherency_base() and
-	 * ll_get_cpuid(), we use it to temporarly save lr and avoid
-	 * it being modified by the branch and link calls. This
-	 * function is used very early in the secondary CPU boot, and
-	 * no stack is available at this point.
+	 * ll_get_coherency_cpumask(), we use it to temporarly save lr
+	 * and avoid it being modified by the branch and link
+	 * calls. This function is used very early in the secondary
+	 * CPU boot, and no stack is available@this point.
 	 */
 	mov 	r0, lr
 	bl	ll_get_coherency_base
-	bl	ll_get_cpuid
+	bl	ll_get_coherency_cpumask
 	mov 	lr, r0
 	add	r0, r1, #ARMADA_XP_CFB_CTL_REG_OFFSET
 1:
-- 
1.9.3
