From: peter@hurleysoftware.com (Peter Hurley)
Date: Sat, 21 Mar 2015 13:25:53 -0400
Subject: [PATCH] ARM: io: Unpessimize relaxed io accessors
Message-ID: <1426958753-26903-1-git-send-email-peter@hurleysoftware.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

commit 195bbcac2e5c12f7fb ("ARM: 7500/1: io: avoid writeback addressing
modes for __raw_ accessors") disables writeback addressing modes for
raw i/o. However, the "+Q" assembler constraint forces the compiler to
invalidate and reload the 'addr' input.

The 'addr' parameter is an input, not an output, and the instructions do
not change the value of 'addr', so the '+' constraint modifier is
unnecessarily pessimistic and leads to poor code generation. This is
especially noticeable with complex address inputs in loops; the compiler
is forced to recompute 'addr' on each loop iteration.

For example, the following code:

    #include <linux/kernel.h>
    #include <linux/io.h>

    static const int *remap;

    void wr_loop(void __iomem *base, int c, int val)
    {
            int i;

            for (i = 0; i < c; i++)
                    writew_relaxed(val, base + remap[c >> 2]);
    }

generates

           current master             |             this patch
 0: e3510000    cmp     r1, #0        |  0: e3510000    cmp     r1, #0
 4: d12fff1e    bxle    lr            |  4: d12fff1e    bxle    lr
 8: e3003000    movw    r3, #0        |  8: e3c1c003    bic     ip, r1, #3
 c: e3403000    movt    r3, #0        |  c: e6ff2072    uxth    r2, r2
10: e92d4010    push    {r4, lr}      | 10: e3a03000    mov     r3, #0
14: e6ff2072    uxth    r2, r2        | 14: e59cc000    ldr     ip, [ip]
18: e3c14003    bic     r4, r1, #3    | 18: e080000c    add     r0, r0, ip
1c: e593e000    ldr     lr, [r3]      |
20: e3a03000    mov     r3, #0        | 1c: e1c020b0    strh    r2, [r0]
                                      | 20: e2833001    add     r3, r3, #1
24: e79ec004    ldr     ip, [lr, r4]  | 24: e1530001    cmp     r3, r1
28: e080c00c    add     ip, r0, ip    | 28: 1afffffb    bne     1c
2c: e1cc20b0    strh    r2, [ip]      | 2c: e12fff1e    bx      lr
30: e2833001    add     r3, r3, #1    |
34: e1530001    cmp     r3, r1        |
38: 1afffff9    bne     24            |
                                      |
3c: e8bd8010    pop     {r4, pc}      |

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 arch/arm/include/asm/io.h | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
index db58deb..7744e58 100644
--- a/arch/arm/include/asm/io.h
+++ b/arch/arm/include/asm/io.h
@@ -73,17 +73,16 @@ void __raw_readsl(const volatile void __iomem *addr, void *data, int longlen);
 static inline void __raw_writew(u16 val, volatile void __iomem *addr)
 {
 	asm volatile("strh %1, %0"
-		     : "+Q" (*(volatile u16 __force *)addr)
-		     : "r" (val));
+		     : : "Q" (*(volatile u16 __force *)addr), "r" (val));
 }
 
 #define __raw_readw __raw_readw
 static inline u16 __raw_readw(const volatile void __iomem *addr)
 {
 	u16 val;
-	asm volatile("ldrh %1, %0"
-		     : "+Q" (*(volatile u16 __force *)addr),
-		       "=r" (val));
+	asm volatile("ldrh %0, %1"
+		     : "=r" (val)
+		     : "Q" (*(volatile u16 __force *)addr));
 	return val;
 }
 #endif
@@ -92,25 +91,23 @@ static inline u16 __raw_readw(const volatile void __iomem *addr)
 static inline void __raw_writeb(u8 val, volatile void __iomem *addr)
 {
 	asm volatile("strb %1, %0"
-		     : "+Qo" (*(volatile u8 __force *)addr)
-		     : "r" (val));
+		     : : "Qo" (*(volatile u8 __force *)addr), "r" (val));
 }
 
 #define __raw_writel __raw_writel
 static inline void __raw_writel(u32 val, volatile void __iomem *addr)
 {
 	asm volatile("str %1, %0"
-		     : "+Qo" (*(volatile u32 __force *)addr)
-		     : "r" (val));
+		     : : "Qo" (*(volatile u32 __force *)addr), "r" (val));
 }
 
 #define __raw_readb __raw_readb
 static inline u8 __raw_readb(const volatile void __iomem *addr)
 {
 	u8 val;
-	asm volatile("ldrb %1, %0"
-		     : "+Qo" (*(volatile u8 __force *)addr),
-		       "=r" (val));
+	asm volatile("ldrb %0, %1"
+		     : "=r" (val)
+		     : "Qo" (*(volatile u8 __force *)addr));
 	return val;
 }
 
@@ -118,9 +115,9 @@ static inline u8 __raw_readb(const volatile void __iomem *addr)
 static inline u32 __raw_readl(const volatile void __iomem *addr)
 {
 	u32 val;
-	asm volatile("ldr %1, %0"
-		     : "+Qo" (*(volatile u32 __force *)addr),
-		       "=r" (val));
+	asm volatile("ldr %0, %1"
+		     : "=r" (val)
+		     : "Qo" (*(volatile u32 __force *)addr));
 	return val;
 }
 
-- 
2.3.3
