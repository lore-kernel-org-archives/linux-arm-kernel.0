From: dave.martin@linaro.org (Dave Martin)
Date: Tue, 25 Oct 2011 15:41:11 +0100
Subject: [PATCH] Shrink thread_info a bit
In-Reply-To: <20111024131853.GA4250@mudshark.cambridge.arm.com>
References: <20111024124818.GA17693@n2100.arm.linux.org.uk>
	<20111024131853.GA4250@mudshark.cambridge.arm.com>
Message-ID: <20111025144110.GA2043@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 24, 2011 at 02:18:53PM +0100, Will Deacon wrote:
> Hi Russell,
> 
> On Mon, Oct 24, 2011 at 01:48:18PM +0100, Russell King - ARM Linux wrote:
> > diff --git a/arch/arm/include/asm/thread_info.h b/arch/arm/include/asm/thread_info.h
> > index 7b5cc8d..a030be7 100644
> > --- a/arch/arm/include/asm/thread_info.h
> > +++ b/arch/arm/include/asm/thread_info.h
> > @@ -59,7 +59,9 @@ struct thread_info {
> >  	__u32			syscall;	/* syscall number */
> >  	__u8			used_cp[16];	/* thread used copro */
> >  	unsigned long		tp_value;
> > +#ifdef CONFIG_CRUNCH
> >  	struct crunch_state	crunchstate;
> > +#endif
> >  	union fp_state		fpstate __attribute__((aligned(8)));
> 
> Can we also shrink the contents of fp_state when AEABI && !OABI_COMPAT?

Is this the right config combination to indicate that the FPA ABI will
not be supported?  I'm assuming so, since that's the condition which
currently disallows CONFIG_NWFPE.

I'm not saying it's not ... I'm just unsure.

Note that the FPA state (35 words) is not that much smaller than the
iwmmxt state (38 words), so not much space would be saved by shrinking
that union.

I wonder whether fpstate can go away completely on platforms which have
neither fpa nor iwmmxt however.  That would be a more significant saving.
Is it used for anything else?

> It's slightly more involved as ptrace and core-dumping would need some
> similar treatment. We probably need to keep the union kicking around
> though, since the iwmmxt state is held in there.

We would need some sensible error return from the ptrace calls to access
the FPA registers.  PTRACE_GETREGSET (not currently working on ARM since
the relevant generic code is #ifdef'd on CONFIG_HAVE_ARCH_TRACEHOOK for
some reason) returns -EINVAL when requesting a regset that isn't there.

Fixing coredumps should be relatively easy -- I think we just need to
change arm_regsets[] in arch/arm/kernel/ptrace.c appropriately.

Cheers
---Dave
