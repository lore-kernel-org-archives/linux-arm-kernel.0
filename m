From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 4 Aug 2015 12:12:59 +0100
Subject: [Query] ARM64: Softlockup when using PSCI for secondary CPU_ON
In-Reply-To: <BY1PR0301MB13035E3B09536F34F4C281CF82770@BY1PR0301MB1303.namprd03.prod.outlook.com>
References: <BY1PR0301MB1303EC5AAE8F0B4DAA70D15F82770@BY1PR0301MB1303.namprd03.prod.outlook.com>
 <20150803100248.GA25627@leverpostej>
 <BY1PR0301MB1303B775B1D5D318A64350C582770@BY1PR0301MB1303.namprd03.prod.outlook.com>
 <BY1PR0301MB13035E3B09536F34F4C281CF82770@BY1PR0301MB1303.namprd03.prod.outlook.com>
Message-ID: <20150804111258.GC7056@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> > > Is Linux itself booted at EL1 or EL2?
> > 
> > UEFI leaves the execution level of the primary core in EL2.
> > KVM is turned-off in my defconfig, so I am not loading any hypervisor at
> > EL2 as of now.

[...]

> > > > preempt self-detected stall on CPU { 3}  (t=17194 jiffies g=-267
> > > > c=-268 q=1)
> > >
> > > > INFO: rcu_preempt detected stalls on CPUs/tasks: { 1 2} (detected by
> > > > 0, t=287104493908 jiffies, g=-267, c=-268, q=2)
> > >
> > > It looks like your timekeeping has gone wrong. As mentioned above, I'd
> > > suspect that CNTVOFF_EL2 is not programmed consistently across all CPUs.
> > >
> > > Are you able to boot Linux at EL2 instead? Or can you verify that
> > > CNTVOFF_EL2 is initialised?
> > >
> > 
> > Ok, let me check the CNTVOFF_EL2 part then.
> > I will get back with details soon.
> > 
> 
> Indeed. Using the following code in the run-time EL3 firmware to correctly set the
> CNTVOFF_EL2 to zero for secondaries solves the soft-lockup. I took a reference from your u-boot
> patch (see [1]).
> 
> +	/* Initialize Generic Timers */
> +	msr	cntvoff_el2, xzr
> 
> [1] http://marc.info/?l=u-boot&m=140230240621878&w=2

That's good to hear!

However, this implies there are a couple of other issues. It sounds like
your UEFI Linux Loader doesn't correctly initialise EL2 state, and drops
EL1N before starting the kernel (or the kernel would have initialised
CNTVOFF itself).

PSCI should boot CPUs into the first available non-secure exception
level, which in this case is EL2, but it sounds like your implementation
boots them to EL1N instead, which is incorrect and prevents Linux from
being able to initialise EL2 correctly.

In the absence of a hypervisor, you should enter the kernel on all CPUs
at EL2. That means we can configure more EL2 state in the kernel and
your bootlaoder/firmware needs to do less.

I would also strongly recommend booting Linux as an EFI application
rather than using the Linux Loader, as the loader isn't even compliant
with the Linux boot protocol and hampers Linux booting correctly.

Thanks,
Mark.
