From: ganguly.s@samsung.com (Sarbojit Ganguly)
Date: Tue, 19 May 2015 09:39:33 +0000 (GMT)
Subject: [RFC] arm: Add for atomic half word exchange
Message-ID: <1122007906.400701432028368414.JavaMail.weblogic@ep2mlwas07a>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since 16 bit half word exchange was not there and MCS based qspinlock by Waiman's xchg_tail() requires an atomic exchange on a half word,
here is a small modification to __xchg() code.

--- /linux.trees.git/tip/arch/arm/include/asm/cmpxchg.h      2015-05-11     23:36:06.942583615 +0530
+++ arch/arm/include/asm/cmpxchg.h      2015-04-08 18:40:43.276255712 +0530
@@ -2,9 +2,12 @@
 #define __ASM_ARM_CMPXCHG_H

 #include <linux/irqflags.h>
 #include <asm/barrier.h>

 #if defined(CONFIG_CPU_SA1100) || defined(CONFIG_CPU_SA110)
 /*
  * On the StrongARM, "swp" is terminally broken since it bypasses the
@@ -36,7 +39,6 @@
 #endif

        smp_mb();

        switch (size) {
 #if __LINUX_ARM_ARCH__ >= 6
@@ -50,6 +52,23 @@
                        : "r" (x), "r" (ptr)
                        : "memory", "cc");
                break;
+               /* 
+                * halfword exclusive exchange
+                * This is new implementation as qspinlock
+                * wants 16 bit atomic CAS.
+                */
+       case 2:
+               asm volatile("@ __xchg2\n"
+               "1:     ldrexh  %0, [%3]\n"
+               "       strexh  %1, %2, [%3]\n"
+               "       teq     %1, #0\n"
+               "       bne     1b"
+                       : "=&r" (ret), "=&r" (tmp)
+                       : "r" (x), "r" (ptr)
+                       : "memory", "cc");
+               break;
        case 4: 
                asm volatile("@ __xchg4\n"
                "1:     ldrex   %0, [%3]\n"
@@ -94,6 +113,10 @@ 
                break;
 #endif 
        default:
                __bad_xchg(ptr, size), ret = 0;
                break;
        }


Regards,
Sarbojit
