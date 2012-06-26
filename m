From: will.deacon@arm.com (Will Deacon)
Date: Tue, 26 Jun 2012 16:54:48 +0100
Subject: [PATCH 2/2] ARM: delay: allow timer-based delay implementation
 to be selected
In-Reply-To: <20120626104944.GE27996@mudshark.cambridge.arm.com>
References: <1340377774-17173-1-git-send-email-will.deacon@arm.com>
 <1340377774-17173-3-git-send-email-will.deacon@arm.com>
 <4FE8DA7E.5040105@codeaurora.org>
 <20120626104944.GE27996@mudshark.cambridge.arm.com>
Message-ID: <20120626155448.GQ27996@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 26, 2012 at 11:49:44AM +0100, Will Deacon wrote:
> On Mon, Jun 25, 2012 at 10:39:10PM +0100, Stephen Boyd wrote:
> > 
> > It's unfortunate that we have to duplicate the same code and constants
> > in both C and assembly. With my approach we convert delay.S into C and
> > avoid the duplication.
> 
> It's probably easy enough to have a #define for the multiplier, I can do
> that for v2.

Looks like I spoke too soon :)

The reason this is slightly problematic is due to gas's inability to
represent unsigned constants -- namely that the 'U' suffix causes it to
barf. I can fix it with the diff below, but please let me know what you
think.

Cheers,

Will


diff --git a/arch/arm/include/asm/delay.h b/arch/arm/include/asm/delay.h
index c6ab91a..ce9f564 100644
--- a/arch/arm/include/asm/delay.h
+++ b/arch/arm/include/asm/delay.h
@@ -8,6 +8,12 @@
 
 #include <asm/param.h>	/* HZ */
 
+#define MAX_UDELAY_MS	2
+#define UDELAY_MULT	((UDELAY_MULT_HZ * HZ) >> 11)
+#define UDELAY_SHIFT	30
+
+#ifndef __ASSEMBLY__
+
 extern struct arm_delay_ops {
 	void (*delay)(unsigned long);
 	void (*const_udelay)(unsigned long);
@@ -38,12 +44,10 @@ extern void __bad_udelay(void);
 #define __udelay(n)		arm_delay_ops.udelay(n)
 #define __const_udelay(n)	arm_delay_ops.const_udelay(n)
 
-#define MAX_UDELAY_MS 2
-
 #define udelay(n)							\
 	(__builtin_constant_p(n) ?					\
 	  ((n) > (MAX_UDELAY_MS * 1000) ? __bad_udelay() :		\
-			__const_udelay((n) * ((2199023U*HZ)>>11))) :	\
+			__const_udelay((n) * UDELAY_MULT)) :		\
 	  __udelay(n))
 
 /* Loop-based definitions for assembly code. */
@@ -51,5 +55,10 @@ extern void __loop_delay(unsigned long loops);
 extern void __loop_udelay(unsigned long usecs);
 extern void __loop_const_udelay(unsigned long);
 
+#define UDELAY_MULT_HZ	2199023U
+#else
+#define UDELAY_MULT_HZ	2199023
+#endif /* __ASSEMBLY__ */
+
 #endif /* defined(_ARM_DELAY_H) */
 
diff --git a/arch/arm/lib/delay-loop.S b/arch/arm/lib/delay-loop.S
index 1428a8f..36b668d 100644
--- a/arch/arm/lib/delay-loop.S
+++ b/arch/arm/lib/delay-loop.S
@@ -9,11 +9,11 @@
  */
 #include <linux/linkage.h>
 #include <asm/assembler.h>
-#include <asm/param.h>
+#include <asm/delay.h>
 		.text
 
 .LC0:		.word	loops_per_jiffy
-.LC1:		.word	(2199023*HZ)>>11
+.LC1:		.word	UDELAY_MULT
 
 /*
  * r0  <= 2000
diff --git a/arch/arm/lib/delay.c b/arch/arm/lib/delay.c
index 2b590c3..e1030e1 100644
--- a/arch/arm/lib/delay.c
+++ b/arch/arm/lib/delay.c
@@ -47,12 +47,12 @@ static void __timer_const_udelay(unsigned long xloops)
 {
 	unsigned long long loops = xloops;
 	loops *= loops_per_jiffy;
-	__timer_delay(loops >> 30);
+	__timer_delay(loops >> UDELAY_SHIFT);
 }
 
 static void __timer_udelay(unsigned long usecs)
 {
-	__timer_const_udelay(usecs * ((2199023U * HZ) >> 11));
+	__timer_const_udelay(usecs * UDELAY_MULT);
 }
 
 void __init init_current_timer_delay(unsigned long freq)
