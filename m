From: venkappa.m@samsung.com (Venkappa Mala)
Date: Fri, 13 Feb 2015 14:56:41 +0000 (UTC)
Subject: [PATCH v10 4/6] ARM: add vdso user-space code
References: <1411413485-7675-1-git-send-email-nathan_lynch@mentor.com>
 <1411413485-7675-5-git-send-email-nathan_lynch@mentor.com>
 <loom.20150213T053547-381@post.gmane.org>
 <20150213105447.GB3508@e104818-lin.cambridge.arm.com>
 <loom.20150213T124417-857@post.gmane.org> <20150213141425.GA4713@localhost>
Message-ID: <loom.20150213T153239-809@post.gmane.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Catalin Marinas <catalin.marinas <at> arm.com> writes:

> 
> On Fri, Feb 13, 2015 at 12:01:40PM +0000, Venkappa Mala wrote:
> > Catalin Marinas <catalin.marinas <at> arm.com> writes:
> > > On Fri, Feb 13, 2015 at 04:36:25AM +0000, Venkappa Mala wrote:
> > > > Nathan Lynch <nathan_lynch <at> mentor.com> writes:
> > > > > +#ifdef CONFIG_ARM_ARCH_TIMER
> > > > > +
> > > > > +static notrace u64 get_ns(struct vdso_data *vdata)
> > > > > +{
> > > > > +	u64 cycle_delta;
> > > > > +	u64 cycle_now;
> > > > > +	u64 nsec;
> > > > > +
> > > > > +	cycle_now = arch_counter_get_cntvct();
> > > > 
> > > > Regarding ARM:vDSO, I have enabled your patch set on Cortex-
A7/ARMv7, 
> > > > the vDSO is up and running using generic arch timer using 
physical 
> > > > counter but not with VCT.
> > > > I anticipate, the issue could be due to VCT cycles.
> > > [...]
> > > > Perhaps, either we need to revise the vDSO frame work to choose 
VCT or 
> > > > PCT dynamically Otherwise CNTVOFF reset to be zero but CNTVOFF 
could not 
> > > > be accessed in SVC mode (PL1).
> > > 
> > > I assume on your platform, the DT also contains
> > > "arm,cpu-registers-not-fw-configured". In such case, the VDSO
> > > optimisation for gettimeofday should just be disabled (as it would 
be if
> > > the generic timers are not present). Really, just fix the 
firmware.
> > 
> > Thanks Catalin for your promote reply. Yes, DTS contained
> > arm,cpu-registers-not-fw-configured so that it uses generic physical
> > timer instead of virtual timer. Now, the vDSO gettimeofday
> > optimization is also possible since the generic timer is presented 
and
> > enabled. However, vDSO gettimeofday implementation has been using
> > virtual timer (VCT  user access) but the current implementation will
> > not be sufficient to handle when the firmware is not taken care 
about
> > reset CNTVOFF to zero. Let?s assume,neither firmware taken care nor
> > booted with HYP mode, then Can we use physical timer (PCT user 
access
> > needs to be enabled) for vDSO in the safe manner?
> 
> The short answer: no.
> 
> The problem is that user space is very "innovative" in making use of
> features in a different way than what the kernel people intended and
> it will be claimed "user ABI" afterwards. Take this glibc revert for
> example, luckily we noticed it early:
> 
> https://sourceware.org/git/?
p=glibc.git;a=commitdiff;h=33ef2f0c763b51e1df7896d7d39d585824558c75
> 
> CNTVCT is not intended to be used outside of the VDSO but, apparently,
> the VDSO->kernel interface is seen as user ABI by some.
> 
> CNTPCT cannot always be used in user space (VDSO and not even the
> kernel), especially when the kernel boots at EL1. Choosing CNTPCT vs
> CNTVCT in VDSO dynamically (or at boot time) is technically doable but
> there is a high risk that user space ends up using them directly when 
it
> detects a gettimeofday VDSO and such code will break when CNTPCT is no
> longer accessible.
> 

Ok Catalin, I have understood about your concern.
>From ARMv7 TRM,
An implementation of the Generic Timer always includes a virtual 
counter, that indicates virtual time:
[1]  In a processor implementation that does not include the 
Virtualization Extensions, virtual time is identical to physical time, 
and the virtual counter contains the same value as the physical counter.

[2]  If In a processor implementation that includes the Virtualization 
Extensions, then it is already taken care in the kernel with the 
following if boot loader boots with HYP mode,
       commit 0af0b189abf73d232af782df2f999235cd2fed7f 
	ARM: hyp: initialize CNTVOFF to zero
	
Currently, we have been noticing an issue with [1] with virtual offset 
when we enable VCT since it is not an initialize to zero.
Perhaps, the best way to handle this one in firmware itself rather than 
bringing too much complexity.
Are you recommending this one?

If that is true, then we are going to force everyone to take care 
CNTVOFF initialization in the firmware if they want to utilize vDSO on 
ARMv7 where HYP mode is disabled.

BR,
Venkappa
