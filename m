From: ganguly.s@samsung.com (Sarbojit Ganguly)
Date: Mon, 05 Oct 2015 03:07:57 +0000 (GMT)
Subject: [PATCH v2] arm: Adding support for atomic half word exchange
Message-ID: <1394429506.566981444014475210.JavaMail.weblogic@epmlwas08c>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hello Will,

This is my second version of the patch which covers the byte exclusive case as pointed out by you.
Please share your opinion on this.


v1-->v2 : Extended the guard code to cover the byte exchange case as 
well following opinion of Will Deacon.
Checkpatch has been run and issues were taken care of.

Since support for half-word atomic exchange was not there and Qspinlock
on ARM requires it, modified __xchg() to add support for that as well.
ARMv6 and lower does not support ldrex{b,h} so, added a guard code
to prevent build breaks.

Signed-off-by: Sarbojit Ganguly <ganguly.s@samsung.com>
---
 arch/arm/include/asm/cmpxchg.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/include/asm/cmpxchg.h b/arch/arm/include/asm/cmpxchg.h index 916a274..a53cbeb 100644
--- a/arch/arm/include/asm/cmpxchg.h
+++ b/arch/arm/include/asm/cmpxchg.h
@@ -39,6 +39,7 @@ static inline unsigned long __xchg(unsigned long x, volatile void *ptr, int size
 
  switch (size) {
 #if __LINUX_ARM_ARCH__ >= 6
+#if !defined(CONFIG_CPU_V6)
  case 1:
   asm volatile("@ __xchg1\n"
   "1: ldrexb %0, [%3]\n"
@@ -49,6 +50,22 @@ static inline unsigned long __xchg(unsigned long x, volatile void *ptr, int size
    : "r" (x), "r" (ptr)
    : "memory", "cc");
   break;
+
+  /*
+   * Half-word atomic exchange, required
+   * for Qspinlock support on ARM.
+   */
+ case 2:
+  asm volatile("@ __xchg2\n"
+  "1: ldrexh %0, [%3]\n"
+  " strexh %1, %2, [%3]\n"
+  " teq %1, #0\n"
+  " bne 1b"
+   : "=&r" (ret), "=&r" (tmp)
+   : "r" (x), "r" (ptr)
+   : "memory", "cc");
+  break;
+#endif
  case 4:
   asm volatile("@ __xchg4\n"
   "1: ldrex %0, [%3]\n"
-- 
