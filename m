From: dan.j.williams@intel.com (Dan Williams)
Date: Tue, 27 Oct 2009 16:43:18 -0700
Subject: [PATCH v3 4/4] iop: implement sched_clock()
In-Reply-To: <19174.53502.967101.548629@pilspetsen.it.uu.se>
References: <19160.60691.72229.932486@pilspetsen.it.uu.se>
	<e9c3a7c20910221449i6a9f8bc6y6b3af1f2f7fe1c44@mail.gmail.com>
	<19168.55801.851167.570526@pilspetsen.it.uu.se>
	<19169.39885.258937.672777@pilspetsen.it.uu.se>
	<1256582040.11080.14.camel@dwillia2-linux.ch.intel.com>
	<19174.53502.967101.548629@pilspetsen.it.uu.se>
Message-ID: <1256686998.26589.6.camel@dwillia2-linux.ch.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2009-10-27 at 03:52 -0700, Mikael Pettersson wrote:
> Thanks. Looks sane to me, although the extra load in sched_clock() does
> bother me.

I looked into it a bit more.  The following patch also works for me and
matches iop3xx.

diff --git a/arch/arm/mm/proc-xsc3.S b/arch/arm/mm/proc-xsc3.S
index 2028f37..fab134e 100644
--- a/arch/arm/mm/proc-xsc3.S
+++ b/arch/arm/mm/proc-xsc3.S
@@ -396,7 +396,7 @@ __xsc3_setup:
 	orr	r4, r4, #0x18			@ cache the page table in L2
 	mcr	p15, 0, r4, c2, c0, 0		@ load page table pointer
 
-	mov	r0, #0				@ don't allow CP access
+	mov	r0, #1 << 6			@ cp6 access for early sched_clock
 	mcr	p15, 0, r0, c15, c1, 0		@ write CP access register
 
 	mrc	p15, 0, r0, c1, c0, 1		@ get auxiliary control reg

I'll fold this into your patch.

> I wonder if the exception could be handled by an exception handler
> that just forces the return value to zero, similar to how the x86
> kernel handles bad get_user/put_user calls or accesses to potentially
> invalid (x86) MSRs?

This is what arch/arm/plat-iop/cp6.c does, it is just registered too
late to cover the early calls to sched_clock(), so we need to turn on
cp6 access early.

> Why whould anyone want to prevent the kernel from accessing cp6?

Kernel accesses are fine the trick is turning off access when returning
to userspace, and automatically turning access on when the kernel needs
it (via undefined instruction trap).  Doing it dynamically eliminates
cp6 enable/disable code sprinkled throughout the kernel (commit
4434c5c7)

--
Dan
