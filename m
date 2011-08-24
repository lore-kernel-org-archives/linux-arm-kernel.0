From: dave.martin@linaro.org (Dave Martin)
Date: Wed, 24 Aug 2011 11:17:27 +0100
Subject: [PATCH v4 2/8] ARM: kexec: ensure new kernel is entered in ARM
	state
In-Reply-To: <alpine.LFD.2.00.1108232126550.20358@xanadu.home>
References: <1314136012-20533-1-git-send-email-will.deacon@arm.com>
	<1314136012-20533-3-git-send-email-will.deacon@arm.com>
	<alpine.LFD.2.00.1108232126550.20358@xanadu.home>
Message-ID: <20110824101727.GD2078@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 23, 2011 at 09:28:12PM -0400, Nicolas Pitre wrote:
> On Tue, 23 Aug 2011, Will Deacon wrote:
> 
> > Commit 540b5738 ("ARM: 6999/1: head, zImage: Always Enter the kernel in
> > ARM state") mandates that the kernel should be entered in ARM state.
> > 
> > If a Thumb-2 kernel kexecs a new kernel image, we need to ensure that
> > we change state when branching to the new code. This patch replaces a
> > mov pc, lr with a bx lr so that we transition to ARM state if need be.
> 
> This will break kexec support on ARMv4 targets.  No idea if any ARMv4 
> target uses kexec though.

Huh, good point -- I was too hasty.

We should use ARM() THUMB() here.

Cheers
---Dave

> 
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> > ---
> >  arch/arm/kernel/relocate_kernel.S |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> > 
> > diff --git a/arch/arm/kernel/relocate_kernel.S b/arch/arm/kernel/relocate_kernel.S
> > index 9cf4cbf..0908633 100644
> > --- a/arch/arm/kernel/relocate_kernel.S
> > +++ b/arch/arm/kernel/relocate_kernel.S
> > @@ -57,7 +57,7 @@ relocate_new_kernel:
> >  	mov r0,#0
> >  	ldr r1,kexec_mach_type
> >  	ldr r2,kexec_boot_atags
> > -	mov pc,lr
> > +	bx lr
> >  
> >  	.align
> >  
> > -- 
> > 1.7.0.4
> > 
> > 
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> > 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
