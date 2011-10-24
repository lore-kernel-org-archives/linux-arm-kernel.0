From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 24 Oct 2011 14:20:44 +0100
Subject: [PATCH] Shrink thread_info a bit
In-Reply-To: <20111024131853.GA4250@mudshark.cambridge.arm.com>
References: <20111024124818.GA17693@n2100.arm.linux.org.uk>
	<20111024131853.GA4250@mudshark.cambridge.arm.com>
Message-ID: <20111024132044.GB18426@n2100.arm.linux.org.uk>
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
> It's slightly more involved as ptrace and core-dumping would need some
> similar treatment. We probably need to keep the union kicking around
> though, since the iwmmxt state is held in there.

This patch is the nice easy bit - doing the same with the fpstate would
be much more involved because thre's also bits of assembly which would
be impacted as well.
