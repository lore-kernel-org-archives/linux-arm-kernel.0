From: dave.martin@linaro.org (Dave Martin)
Date: Tue, 31 May 2011 17:27:32 +0100
Subject: [RFC PATCH REPOST] ARM: kuser helpers: comment cleanup
Message-ID: <1306859252-21254-1-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The comments accompanying the kuser helpers contain assembler code
which is no longer really needed, since the compiler will do a
decent job of calling the helpers if the suggested C declarations
are used.

Also, the existing code uses old?style calling techniquies which do
not interwork properly if used in Thumb code, and which are likely
to be suboptimally branch?predicted on recent CPUs.  Letting the
compiler generate the appropriate function call boilerplate avoids
these problems without needing to write multiple versions of the
code.

For these reasons, this patch removes those example assembler code
snippets.

Similarly, there?s no real reason why the example of how to
implement atomic add needs to be assembler, so I have replaced it
with a simpler C version.

Comments have also been added clarifying how and when
__kernel_helper_version should be checked.

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---

[Reposting this for feedback, since I've not had any comments on it
yet.]

Note that this is just an RFC: In particular, I haven't tested
the C atomic_add example yet -- it just shows the kind of thing
we _could_ document.

Instead of (or in addition to) this patch, we could also:

 * Put the kuser helper C declarations in an actual header file:
   this would mean that people writing userspace code could just
   use the helpers directly via C instead of having to write their
   own assembler wrappers.

 * Move the explanatory test into Documentation/arm/

The proposed comments on checking __kernel_helper_version may be
overkill, particularly for the helpers which have always been
there.  On the other hand, encouraging people into good habits of
always checking seems harmless at worst, and beneficial at best,
particularly if we add more helpers over time, such as the 64-bit
cpmxchg helper which has been mooted.

Any views on this?

Cheers
---Dave

 arch/arm/kernel/entry-armv.S |   55 ++++++++++++++++++++---------------------
 1 files changed, 27 insertions(+), 28 deletions(-)

diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index e8d8856..5d444b5 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -779,6 +779,11 @@ ENDPROC(__switch_to)
  * earlier processors just for the sake of not using these kernel helpers
  * if your compiled code is not going to use the new instructions for other
  * purpose.
+ *
+ * New helpers may be added over time, so an older kernel may be missing
+ * some helpers present in a newer kernel.  For this reason, programs
+ * must check the value of __kernel_helper_version (see below) before
+ * assuming that it is safe to call any particular helper.
  */
  THUMB(	.arm	)
 
@@ -819,11 +824,7 @@ __kuser_helper_start:
  * Apply any needed memory barrier to preserve consistency with data modified
  * manually and __kuser_cmpxchg usage.
  *
- * This could be used as follows:
- *
- * #define __kernel_dmb() \
- *         asm volatile ( "mov r0, #0xffff0fff; mov lr, pc; sub pc, r0, #95" \
- *	        : : : "r0", "lr","cc" )
+ * Do not attempt to call this function unless __kernel_helper_version >= 3.
  */
 
 __kuser_memory_barrier:				@ 0xffff0fa0
@@ -855,7 +856,8 @@ __kuser_memory_barrier:				@ 0xffff0fa0
  *
  * Definition and user space usage example:
  *
- *	typedef int (__kernel_cmpxchg_t)(int oldval, int newval, int *ptr);
+ *	typedef int (__kernel_cmpxchg_t)(int oldval, int newval,
+ *					 int volatile *ptr);
  *	#define __kernel_cmpxchg (*(__kernel_cmpxchg_t *)0xffff0fc0)
  *
  * Atomically store newval in *ptr if *ptr is equal to oldval for user space.
@@ -863,27 +865,25 @@ __kuser_memory_barrier:				@ 0xffff0fa0
  * The C flag is also set if *ptr was changed to allow for assembly
  * optimization in the calling code.
  *
+ * Do not attempt to call this function unless __kernel_helper_version >= 2.
+ *
  * Notes:
  *
  *    - This routine already includes memory barriers as needed.
  *
  * For example, a user space atomic_add implementation could look like this:
  *
- * #define atomic_add(ptr, val) \
- *	({ register unsigned int *__ptr asm("r2") = (ptr); \
- *	   register unsigned int __result asm("r1"); \
- *	   asm volatile ( \
- *	       "1: @ atomic_add\n\t" \
- *	       "ldr	r0, [r2]\n\t" \
- *	       "mov	r3, #0xffff0fff\n\t" \
- *	       "add	lr, pc, #4\n\t" \
- *	       "add	r1, r0, %2\n\t" \
- *	       "add	pc, r3, #(0xffff0fc0 - 0xffff0fff)\n\t" \
- *	       "bcc	1b" \
- *	       : "=&r" (__result) \
- *	       : "r" (__ptr), "rIL" (val) \
- *	       : "r0","r3","ip","lr","cc","memory" ); \
- *	   __result; })
+ * int atomic_add(int volatile *ptr, int val)
+ * {
+ *	int newval;
+ *	do {
+ *		int oldval = *ptr;
+ *
+ *		newval = oldval + val;
+ *	while(__kernel_cmpxchg(oldval, newval, ptr));
+ *
+ *	return newval;
+ * }
  */
 
 __kuser_cmpxchg:				@ 0xffff0fc0
@@ -983,13 +983,7 @@ kuser_cmpxchg_fixup:
  *
  * Get the TLS value as previously set via the __ARM_NR_set_tls syscall.
  *
- * This could be used as follows:
- *
- * #define __kernel_get_tls() \
- *	({ register unsigned int __val asm("r0"); \
- *         asm( "mov r0, #0xffff0fff; mov lr, pc; sub pc, r0, #31" \
- *	        : "=r" (__val) : : "lr","cc" ); \
- *	   __val; })
+ * Do not attempt to call this function unless __kernel_helper_version >= 1.
  */
 
 __kuser_get_tls:				@ 0xffff0fe0
@@ -1011,6 +1005,11 @@ __kuser_get_tls:				@ 0xffff0fe0
  *
  * User space may read this to determine the curent number of helpers
  * available.
+ *
+ * User space may assume that the value of this field never changes
+ * during the lifetime of any single process.  This means that this
+ * field can be read once during the initialisation of a library or
+ * startup phase of a program.
  */
 
 __kuser_helper_version:				@ 0xffff0ffc
-- 
1.7.4.1
