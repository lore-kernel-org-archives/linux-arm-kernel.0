From: dave.martin@linaro.org (Dave Martin)
Date: Thu, 25 Aug 2011 12:19:03 +0100
Subject: [PATCH v4 1/8] ARM: proc-v7: disable SCTLR.TE when disabling MMU
In-Reply-To: <20110824110149.GF32688@e102144-lin.cambridge.arm.com>
References: <1314136012-20533-1-git-send-email-will.deacon@arm.com>
	<1314136012-20533-2-git-send-email-will.deacon@arm.com>
	<20110824101507.GB2078@arm.com>
	<20110824110149.GF32688@e102144-lin.cambridge.arm.com>
Message-ID: <20110825111902.GA12556@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 24, 2011 at 12:01:50PM +0100, Will Deacon wrote:
> On Wed, Aug 24, 2011 at 11:15:07AM +0100, Dave Martin wrote:
> > On Tue, Aug 23, 2011 at 10:46:45PM +0100, Will Deacon wrote:
> > > cpu_v7_reset disables the MMU and then branches to the provided address.
> > > On Thumb-2 kernels, we should take care to clear the Thumb Exception
> > > enable bit in the System Control Register, otherwise this may wreak
> > > havok in the code to which we are branching (for example, an ARM kernel
> > > image via kexec).
> > > 
> > > Signed-off-by: Will Deacon <will.deacon@arm.com>
> > > ---
> > >  arch/arm/mm/proc-v7.S |    1 +
> > >  1 files changed, 1 insertions(+), 0 deletions(-)
> > > 
> > > diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
> > > index a30e785..96b872c 100644
> > > --- a/arch/arm/mm/proc-v7.S
> > > +++ b/arch/arm/mm/proc-v7.S
> > > @@ -66,6 +66,7 @@ ENDPROC(cpu_v7_proc_fin)
> > >  ENTRY(cpu_v7_reset)
> > >  	mrc	p15, 0, r1, c1, c0, 0		@ ctrl register
> > >  	bic	r1, r1, #0x1			@ ...............m
> > > + THUMB(	bic	r1, r1, #1 << 30 )		@ Thumb exceptions
> > 
> > Can we give the architectural name for the bit here?
> 
> Ok. It's SCTLR.TE so representing it as we do for SCTLR.M looks a bit odd
> unless you use two lines. Perhaps if I just add @ SCTLR.TE (Thumb
> exceptions) ?

That seems fine -- exactly how it looks is not so important as the
information itself IMHO.

It's a pretty minor nit in any case.

Cheers
---Dave
