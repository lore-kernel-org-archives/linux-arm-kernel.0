From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 18 Aug 2014 15:22:49 +0100
Subject: VFP available on a single CPU in a dual-CPU complex
In-Reply-To: <yw1x4mxd30q0.fsf@unicorn.mansr.com>
References: <CAGVrzcaX4n2rJko_Kny81jkzQbV6z5TmcA2coGrj6BU-ahiOTA@mail.gmail.com>
 <201408151103.01349.arnd@arndb.de> <20140815091445.GC27466@arm.com>
 <8014330.Y4lYRxBeEx@wuerfel> <53EE58B7.6030207@gmail.com>
 <yw1x4mxd30q0.fsf@unicorn.mansr.com>
Message-ID: <20140818142249.GK20043@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 15, 2014 at 10:24:39PM +0100, M?ns Rullg?rd wrote:
> Florian Fainelli <f.fainelli@gmail.com> writes:
> 
> > On 08/15/2014 11:54 AM, Arnd Bergmann wrote:
> >> On Friday 15 August 2014 10:14:45 Will Deacon wrote:
> >>> On Fri, Aug 15, 2014 at 10:03:01AM +0100, Arnd Bergmann wrote:
> >>>> On Friday 15 August 2014, Florian Fainelli wrote:
> >>>>> Hello,
> >>>>>
> >>>>> On Broadcom's BCM63138 SoC, the second Cortex A9 CPU does not have
> >>>>> VFP, which is a problem as one might imagine because we currently
> >>>>> assume it is available for all CPUs within the complex.
> >>>>
> >>>> Wow, that is pretty crazy.
> >>>>
> >>>>> I started to patch vfp_support_entry to test for CPU1 and branch to a
> >>>>> different location, but that raises a bunch of question, in particular
> >>>>> what to do if NEON/VFP came from the kernel, how can we migrate that
> >>>>> execution to CPU0?
> >>>>>
> >>>>> If the answer is don't use VFP, I guess that's fine, and I can have a
> >>>>> runtime check in vfp_init() that checks for BCM63138 and set
> >>>>> vfp_vector to vfp_null_entry even though we are running on a multi-v7
> >>>>> kernel with VFP enabled.
> >>>>
> >>>> I think adding hooks to the scheduler for this case is problematic, so
> >>>> the easiest way would of course be to give the user a choice between
> >>>> VFP or SMP on this hardware. For anything beyond that, you could do
> >>>> a prototype patch (possibly for integration into OpenWRT) so we can
> >>>> see how ugly it gets to support this setup.
> >>>
> >>> I agree. We have something similar on the Realview-PBX (dual A9, only one
> >>> CPU with NEON) and the answer is not to enable NEON if you want SMP.
> >> 
> >> Does that work with a multiplatform kernel?
> >> 
> >> I have patches to enable realview for ARCH_MULTIPLATFORM, and I wonder
> >> if that gets in the way. Do we have code to detect this setup at runtime
> >> and disable NEON/VFP if only a subset of the enabled CPUs have it?
> >
> > I was wondering about that too, here are the two options I see for these
> > pathological cases:
> >
> > - if SMP is enabled, and CONFIG_VFP is also enabled, refuse bringing up
> > cores that do not support VFP/NEON, thus becoming a SMP on UP, and do
> > that for the platform/SoC-specific SMP support code
> >
> > - or, in the VFP initialization, completely disable VFP (overriding
> > VFP_arch in SoC specific code?) because at least one of CPU does not
> > support it
> >
> > I would favor enabling SMP over enabling VFP, because that's probably
> > what most people would expect.
> 
> The Realview system has VFP on both cores but NEON on only one IIRC.

That's the PBX-A9 IIRC.

> For pathological cases like these, and these are the only two I've heard
> of, disallowing VFP/NEON in kernel code is probably the sanest choice.

I agree.

> For userspace, it makes sense to enable it as usual and rely on CPU
> affinity to keep things working. 

If we rely on user-space to set affinity, we also need per-CPU hwcap or
some method to inform user which CPUs have VFP/Neon. But I really don't
like user space parsing /proc/cpuinfo, which leaves us with disabling
VFP altogether.

> If these systems were common,
> extending the per-task VFP enabling to also limit the CPU affinity would
> probably be something to consider.

We tried this before in ARM and it was kind of working. The only problem
was that because glibc was setting FPCSR, all processes ended up on the
same CPU. So we had to add a timer to clear the affinity for a task
after a while. But I would definitely not recommend such patches for
mainline.

I don't have any preference for SMP+!VFP vs UP+VFP in this case. I guess
Broadcom should know better what the target market is and what kind of
user space is supposed to run on such system.

-- 
Catalin
