From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 8 Aug 2011 21:02:56 +0100
Subject: [PATCH 4/6] ARM: smp: set thread_info->cpu to hardware CPU
	number for boot thread
In-Reply-To: <20110808181459.GB10072@e102144-lin.cambridge.arm.com>
References: <1312823424-9654-1-git-send-email-will.deacon@arm.com>
	<1312823424-9654-5-git-send-email-will.deacon@arm.com>
	<4E401DF2.10801@codeaurora.org>
	<20110808181459.GB10072@e102144-lin.cambridge.arm.com>
Message-ID: <20110808200256.GE19367@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 08, 2011 at 07:14:59PM +0100, Will Deacon wrote:
> On Mon, Aug 08, 2011 at 06:33:38PM +0100, Stephen Boyd wrote:
> > On 08/08/2011 10:10 AM, Will Deacon wrote:
> > >
> > >  
> > > +void __init smp_setup_processor_id(void)
> > > +{
> > > +	u32 mpidr;
> > > +
> > > +	/* Read the MPIDR to find the hardware ID of the current CPU. */
> > > +	asm("1:		mrc	p15, 0, %0, c0, c0, 5\n"
> > > +	    "		.pushsection \".alt.smp.init\", \"a\"\n"
> > > +	    "		.long	1b\n"
> > > +	    "		mov	%0, #0\n"
> > > +	    "		.popsection"
> > > +	    : "=r" (mpidr));
> > 
> > Would it be a good idea to put this into asm/cputype.h? I suppose the
> > smp alternatives part would need to be written in C.
> > 
> >     mpidr = is_smp() ? read_cpuid_mpidr() : 0;
> 
> Yes, that's much better. We used to have asm/smp_mpidr.h which did this, so I
> lifted the code from there but doing it in C is easier to read.
> 
> > >
> > > +
> > > +	current_thread_info()->cpu = mpidr & 0xff;
> > > +	printk("Booting Linux on CPU %d\n", current_thread_info()->cpu);
> > > +}
> > > +
> > 
> > Should there be a KERN_INFO there?
> 
> Can be. I just followed suit with secondary_start_kernel, but smp.c doesn't
> seem to be consistent anyway so I'll add the specifier.

Actually, it's probably much better to keep logical CPU0 as the boot CPU.
The hotplug code makes the assumption that the lowest online CPU number
is the boot CPU.

So unless we want even more pain, I suggest we just ensure logical CPU0
is the boot CPU.

We're already fairly clean on our interactions between CPU numbering and
the hardware CPU numbering - there's only a limited number of places where
the two interact.  Those are the GIC, IPI, secondary CPU bringup, and
hotplug code.  I suggest that we preserve the independence, and introduce
a mapping between logical CPU numbering and hardware CPU numbering.
