From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 14 Aug 2013 10:25:14 -0400 (EDT)
Subject: [Git pull request] fix to the vexpress/mcpm branch
In-Reply-To: <20130814055800.GG16635@quad.lixom.net>
References: <alpine.LFD.2.03.1308121428080.14472@syhkavp.arg>
 <20130814055800.GG16635@quad.lixom.net>
Message-ID: <alpine.LFD.2.03.1308141018140.14472@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 13 Aug 2013, Olof Johansson wrote:

> Hi Nico,
> 
> On Mon, Aug 12, 2013 at 02:37:54PM -0400, Nicolas Pitre wrote:
> > 
> > Please pull the following:
> > 
> > 	git://git.linaro.org/people/nico/linux mcpm+tc2
> > 
> > which will update your vexpress/mcpm branch with one additional commit 
> > fixing the build issue with CONFIG_FRAME_POINTER reported by RMK.  This 
> > commit's SHA1 is 95fbdc9cf542.
> 
> So, I just replaced my branch with the one from Pawel, and the topmost patch
> in your branch seems to no longer apply.

Weird.  It still applies perfectly here.

Here's the patch nevertheless.  Please apply ASAP as Lorenzo wishes to 
base his next pull request on top of this.

----- >8

From: Nicolas Pitre <nicolas.pitre@linaro.org>
Date: Mon, 12 Aug 2013 12:47:13 -0400
Subject: [PATCH] ARM: vexpress/MCPM: fix cache disable sequence when CONFIG_FRAME_POINTER=y

If CONFIG_FRAME_POINTER=y we hget the following error:

arch/arm/mach-vexpress/tc2_pm.c: In function 'tc2_pm_down':
arch/arm/mach-vexpress/tc2_pm.c:200:1: error: fp cannot be used in asm here

Let's fix that by explicitly preserving r11 on the stack and removing it
from the clobber list.

Reported-by: Russell King <rmk+kernel@arm.linux.org.uk>
Reviewed-by: Dave Martin <Dave.Martin@arm.com>
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
index ddd97dd4e9..2b7c93a724 100644
--- a/arch/arm/mach-vexpress/tc2_pm.c
+++ b/arch/arm/mach-vexpress/tc2_pm.c
@@ -150,8 +150,13 @@ static void tc2_pm_down(u64 residency)
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
@@ -162,9 +167,10 @@ static void tc2_pm_down(u64 residency)
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
 
@@ -185,6 +191,7 @@ static void tc2_pm_down(u64 residency)
 		 * Let's do it in the safest possible way as above.
 		 */
 		asm volatile(
+		"str	fp, [sp, #-4]! \n\t"
 		"mrc	p15, 0, r0, c1, c0, 0	@ get CR \n\t"
 		"bic	r0, r0, #"__stringify(CR_C)" \n\t"
 		"mcr	p15, 0, r0, c1, c0, 0	@ set CR \n\t"
@@ -195,9 +202,10 @@ static void tc2_pm_down(u64 residency)
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
