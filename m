From: will.deacon@arm.com (Will Deacon)
Date: Mon, 14 May 2012 18:37:57 +0100
Subject: [PATCH v4 2/2] ARM: vfp: clear fpscr length and stride bits on
 entry to sig handler
In-Reply-To: <1337011379.16954.40.camel@linaro1.home>
References: <1330009632-1235-1-git-send-email-will.deacon@arm.com>
 <1330009632-1235-2-git-send-email-will.deacon@arm.com>
 <1337006035.16954.21.camel@linaro1.home>
 <20120514145931.GF11088@mudshark.cambridge.arm.com>
 <1337011379.16954.40.camel@linaro1.home>
Message-ID: <20120514173757.GJ11088@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 14, 2012 at 05:02:59PM +0100, Jon Medhurst (Tixy) wrote:
> On Mon, 2012-05-14 at 15:59 +0100, Will Deacon wrote:
> > The idea is that we disable VFP in hardware (via vfp_flush_hwstate) prior to
> > entering the signal handler. Then we clear hwstate->fpexc.FPEXC_EN so that
> > we can detect if VFP gets used during the handler, since the exception
> > handling code will set that back up if we trapon a VFP operation (see
> > vfp_support_entry in vfphw.S).
> 
> I had a look at vfp_support_entry. I can see it loading the hardware
> registers from the saved vfp state, but can't see where it updates the
> fpexc value in the saved vfp state. (I also can't think of why it would
> need to, but this is the first time I've looked Linux vfp code so there
> could be lots I've missed.)

You're right, in the lazy case (i.e. SMP) we update the hwstate on
context-switch rather than on the fault. Your quick fix looks good to me
(that is, unconditionally flushing the state after handling a signal). I was
initially worried that the added flushing would cause a performance hit on
the usual path, where VFP is not used in the handler, however since we flush
before the signal handler, it really won't make a lot of difference.

I took the liberty of writing a commit message, so can I add your S-o-B to
this please (I wasn't sure which email address to use)?

Thanks,

Will

Subject: [PATCH] ARM: vfp: fix VFP flushing regression on sigreturn path

Commit ff9a184c ("ARM: 7400/1: vfp: clear fpscr length and stride bits
on entry to sig handler") flushes the VFP state prior to entering a
signal handler so that a VFP operation inside the handler will trap and
force a restore of ABI-compliant registers. Restoring the registers on
the sigreturn path is predicated on the saved thread state indicating
that VFP was used by the handler -- however for SMP platforms this is
only set on context-switch, making the check unreliable and causing VFP
register corruption in userspace.

This patch unconditionally flushes the VFP state after a signal handler.
Since we already perform the flush before the handler and the flushing
itself happens lazily, the effect on performance is negligible.

Reported-by: Jon Medhurst <tixy@yxit.co.uk>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/vfp/vfpmodule.c |   14 ++------------
 1 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
index c5767b5..b0197b2 100644
--- a/arch/arm/vfp/vfpmodule.c
+++ b/arch/arm/vfp/vfpmodule.c
@@ -577,12 +577,6 @@ int vfp_preserve_user_clear_hwstate(struct user_vfp __user *ufp,
 	 * entry.
 	 */
 	hwstate->fpscr &= ~(FPSCR_LENGTH_MASK | FPSCR_STRIDE_MASK);
-
-	/*
-	 * Disable VFP in the hwstate so that we can detect if it gets
-	 * used.
-	 */
-	hwstate->fpexc &= ~FPEXC_EN;
 	return 0;
 }
 
@@ -595,12 +589,8 @@ int vfp_restore_user_hwstate(struct user_vfp __user *ufp,
 	unsigned long fpexc;
 	int err = 0;
 
-	/*
-	 * If VFP has been used, then disable it to avoid corrupting
-	 * the new thread state.
-	 */
-	if (hwstate->fpexc & FPEXC_EN)
-		vfp_flush_hwstate(thread);
+	/* Disable VFP to avoid corrupting the new thread state. */
+	vfp_flush_hwstate(thread);
 
 	/*
 	 * Copy the floating point registers. There can be unused
-- 
1.7.4.1
