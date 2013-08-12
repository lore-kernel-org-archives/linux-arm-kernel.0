From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 12 Aug 2013 12:55:23 -0400 (EDT)
Subject: Build error: versatile express
In-Reply-To: <20130812124801.GB2823@localhost.localdomain>
References: <20130812124801.GB2823@localhost.localdomain>
Message-ID: <alpine.LFD.2.03.1308121125420.14472@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 12 Aug 2013, Dave Martin wrote:

> On Mon, Aug 12, 2013 at 11:28:04AM +0100, Russell King - ARM Linux wrote:
> > arch/arm/mach-vexpress/tc2_pm.c: In function 'tc2_pm_down.clone.0':
> > arch/arm/mach-vexpress/tc2_pm.c:200:1: error: fp cannot be used in asm here
> > 
> > This is caused by the assembly code in this file clobbering R11, which
> > is incompatible with having CONFIG_FRAME_POINTER=y.
> 
> Is there any reason not to fix this just by pushing/popping r11 inside
> the asm and removing it from the clobber list?

That's most likely the best fix.  What about this?

---- >8

From: Nicolas Pitre <nicolas.pitre@linaro.org>
Date: Mon, 12 Aug 2013 12:47:13 -0400
Subject: [PATCH] ARM: vexpress/MCPM: fix cache disable sequence when
 CONFIG_FRAME_POINTER=y

If CONFIG_FRAME_POINTER=y we hget the following error:

arch/arm/mach-vexpress/tc2_pm.c: In function 'tc2_pm_down':
arch/arm/mach-vexpress/tc2_pm.c:200:1: error: fp cannot be used in asm here

Let's fix that by explicitly preserving r11 on the stack and removing it
from the clobber list.

Reported-by: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Nicolas Pitre <nico@linaro.org>

diff --git a/arch/arm/mach-vexpress/dcscb.c b/arch/arm/mach-vexpress/dcscb.c
index 85fffa702f..3a6384c6c4 100644
--- a/arch/arm/mach-vexpress/dcscb.c
+++ b/arch/arm/mach-vexpress/dcscb.c
@@ -144,8 +144,13 @@ static void dcscb_power_down(void)
 		 * Let's do it in the safest possible way i.e. with
 		 * no memory access within the following sequence
 		 * including to the stack.
+		 *
+		 * Note: fp is preserved to the stack explicitly prior doing
+		 * this since adding it to the clobber list is incompatible
+		 * with having CONFIG_FRAME_POINTER=y.
 		 */
 		asm volatile(
+		"str	fp, [sp, #-4]! \n\t"
 		"mrc	p15, 0, r0, c1, c0, 0	@ get CR \n\t"
 		"bic	r0, r0, #"__stringify(CR_C)" \n\t"
 		"mcr	p15, 0, r0, c1, c0, 0	@ set CR \n\t"
@@ -156,9 +161,10 @@ static void dcscb_power_down(void)
 		"bic	r0, r0, #(1 << 6)	@ disable local coherency \n\t"
 		"mcr	p15, 0, r0, c1, c0, 1	@ set AUXCR \n\t"
 		"isb	\n\t"
-		"dsb	"
+		"dsb	\n\t"
+		"ldr	fp, [sp], #4"
 		: : : "r0","r1","r2","r3","r4","r5","r6","r7",
-		      "r9","r10","r11","lr","memory");
+		      "r9","r10","lr","memory");
 
 		/*
 		 * This is a harmless no-op.  On platforms with a real
@@ -182,6 +188,7 @@ static void dcscb_power_down(void)
 		 * Let's do it in the safest possible way as above.
 		 */
 		asm volatile(
+		"str	fp, [sp, #-4]! \n\t"
 		"mrc	p15, 0, r0, c1, c0, 0	@ get CR \n\t"
 		"bic	r0, r0, #"__stringify(CR_C)" \n\t"
 		"mcr	p15, 0, r0, c1, c0, 0	@ set CR \n\t"
@@ -192,9 +199,10 @@ static void dcscb_power_down(void)
 		"bic	r0, r0, #(1 << 6)	@ disable local coherency \n\t"
 		"mcr	p15, 0, r0, c1, c0, 1	@ set AUXCR \n\t"
 		"isb	\n\t"
-		"dsb	"
+		"dsb	\n\t"
+		"ldr	fp, [sp], #4"
 		: : : "r0","r1","r2","r3","r4","r5","r6","r7",
-		      "r9","r10","r11","lr","memory");
+		      "r9","r10","lr","memory");
 	}
 
 	__mcpm_cpu_down(cpu, cluster);
diff --git a/arch/arm/mach-vexpress/tc2_pm.c b/arch/arm/mach-vexpress/tc2_pm.c
index dfb55d45b6..9419b1550a 100644
--- a/arch/arm/mach-vexpress/tc2_pm.c
+++ b/arch/arm/mach-vexpress/tc2_pm.c
@@ -139,8 +139,13 @@ static void tc2_pm_down(u64 residency)
 		 * Let's do it in the safest possible way i.e. with
 		 * no memory access within the following sequence
 		 * including the stack.
+		 *
+		 * Note: fp is preserved to the stack explicitly prior doing
+		 * this since adding it to the clobber list is incompatible
+		 * with having CONFIG_FRAME_POINTER=y.
 		 */
 		asm volatile(
+		"str	fp, [sp, #-4]! \n\t"
 		"mrc	p15, 0, r0, c1, c0, 0	@ get CR \n\t"
 		"bic	r0, r0, #"__stringify(CR_C)" \n\t"
 		"mcr	p15, 0, r0, c1, c0, 0	@ set CR \n\t"
@@ -151,9 +156,10 @@ static void tc2_pm_down(u64 residency)
 		"bic	r0, r0, #(1 << 6)	@ disable local coherency \n\t"
 		"mcr	p15, 0, r0, c1, c0, 1	@ set AUXCR \n\t"
 		"isb	\n\t"
-		"dsb	"
+		"dsb	\n\t"
+		"ldr	fp, [sp], #4"
 		: : : "r0","r1","r2","r3","r4","r5","r6","r7",
-		      "r9","r10","r11","lr","memory");
+		      "r9","r10","lr","memory");
 
 		cci_disable_port_by_cpu(mpidr);
 
@@ -174,6 +180,7 @@ static void tc2_pm_down(u64 residency)
 		 * Let's do it in the safest possible way as above.
 		 */
 		asm volatile(
+		"str	fp, [sp, #-4]! \n\t"
 		"mrc	p15, 0, r0, c1, c0, 0	@ get CR \n\t"
 		"bic	r0, r0, #"__stringify(CR_C)" \n\t"
 		"mcr	p15, 0, r0, c1, c0, 0	@ set CR \n\t"
@@ -184,9 +191,10 @@ static void tc2_pm_down(u64 residency)
 		"bic	r0, r0, #(1 << 6)	@ disable local coherency \n\t"
 		"mcr	p15, 0, r0, c1, c0, 1	@ set AUXCR \n\t"
 		"isb	\n\t"
-		"dsb	"
+		"dsb	\n\t"
+		"ldr	fp, [sp], #4"
 		: : : "r0","r1","r2","r3","r4","r5","r6","r7",
-		      "r9","r10","r11","lr","memory");
+		      "r9","r10","lr","memory");
 	}
 
 	__mcpm_cpu_down(cpu, cluster);


> 
> Since there are no "m" constraints or similar, there should be no
> implicit references to fp or sp inside the asm which would be disrupted
> by that.
> 
> We could #ifdef it on CONFIG_FRAME_POINTER, but that probably just
> uglifies the code for no real benefit.
> 
> 
> FRAME_POINTER depends on !THUMB2_KERNEL, so we shouldn't hit the same
> issue with r7 in Thumb-2.
> 
> Cheers
> ---Dave
> 
