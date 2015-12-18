From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 18 Dec 2015 10:54:05 +0000
Subject: [PATCH RFC] ARM64: Add cpu hotplug for device tree parking method
In-Reply-To: <20151218101550.GD29413@dhcppc13.redhat.com>
References: <49d1ca9f7ca09707cdefbebe6f0163c376b1eaea.1450358510.git.panand@redhat.com>
 <20151217142018.GE13389@leverpostej>
 <20151218101550.GD29413@dhcppc13.redhat.com>
Message-ID: <20151218105404.GA29219@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 18, 2015 at 03:45:51PM +0530, Pratyush Anand wrote:
> Hi Mark,
> 
> Thanks a lot for your review.
> 
> On 17/12/2015:02:20:19 PM, Mark Rutland wrote:
> > On Thu, Dec 17, 2015 at 07:09:29PM +0530, Pratyush Anand wrote:
> > > This patch has been implemented for CPU hotplug support for device tree
> > > spin-table based parking method.
> > > 
> > > While cpu is offlined, cpu_die is called and when it is brought online
> > > cpu_boot is called. So, cpu_boot must wake secondary and release pen,
> > > otherwise dynamic cpu offline/online will not work.
> > 
> > This has been discussed in the past, and using an in-kernel pen was
> > NAK'd. An in-purgatory pen has an almost identical set of problems.
> > 
> > At minimum, to make spin-table hotplug viable we need FW support, and a
> > well-defined protocol for handing CPUs back to FW.
> 
> OK.So is this being driven somewhere?

To the best of my knowledge, no-one is looking into support for
spin-table hotplug.

To be perfectly honest I'd rather not see that attempted. It's only
going to be a source of pain, and we have better options (e.g. PSCI).

We can still allow for a crash kernel on those systems without CPU
hotplug. Given the crash kernel has to preserve the original kernel text
anyway we can leave secondaries spinning in a WFI loop.

[...]

> > > cpu-park infrastructure of this patch can further be shared by ACPI parking
> > > protocol support for providing CPU hotplug support.
> > 
> > If the parking protocol is missing a provision to return CPUs to the FW,
> > then that should be addressed in the parking protocol spec rather than
> > hacking around it.
> 
> Well, IIUC then we should not need anything like cpu-park.S. When cpu is
> offlined then cpu_die() should pass control to the FW.

Yes.

> If that is correct then I think spec [1] should be improved for it.
> It talks about behavior in parked state, how to leave parked state.
> But it does not talk about how to enter parked state. Also "Figure 3.
> Mailbox Format" has fields for "Processor ID" and "Jump Address", the
> address where CPU should jump upon successful exit from parked state.
> I think, it should also have a field for "Jump IN Address", where OS
> should hand off the CPU upon cpu_die().

That could be one part of it, yes.

There are a number of other things that would need to be specified
(e.g. endianness, GIC state), which gets hairy very quickly.

[...]

> > > @@ -73,11 +76,16 @@ static int smp_spin_table_cpu_init(unsigned int cpu)
> > >  
> > >  static int smp_spin_table_cpu_prepare(unsigned int cpu)
> > >  {
> > > -	__le64 __iomem *release_addr;
> > > -
> > >  	if (!cpu_release_addr[cpu])
> > >  		return -ENODEV;
> > >  
> > > +	return 0;
> > > +}
> > > +
> > > +static int smp_spin_table_cpu_boot(unsigned int cpu)
> > > +{
> > > +	__le64 __iomem *release_addr;
> > > +
> > >  	/*
> > >  	 * The cpu-release-addr may or may not be inside the linear mapping.
> > >  	 * As ioremap_cache will either give us a new mapping or reuse the
> > > @@ -107,11 +115,6 @@ static int smp_spin_table_cpu_prepare(unsigned int cpu)
> > >  
> > >  	iounmap(release_addr);
> > >  
> > > -	return 0;
> > > -}
> > > -
> > > -static int smp_spin_table_cpu_boot(unsigned int cpu)
> > > -{
> > >  	/*
> > >  	 * Update the pen release flag.
> > >  	 */
> > > @@ -125,9 +128,32 @@ static int smp_spin_table_cpu_boot(unsigned int cpu)
> > >  	return 0;
> > >  }
> > 
> > Why have you changed the code for the boot path? No changes should be
> > necessary there.
> 
> This is the only point which I am still not able to understand. Current code
> structure of smp_spin_table_cpu_prepare() and smp_spin_table_cpu_boot() is fine
> when secondaries boot up during kernel initialization. But, will it work in case
> of a particular cpu is shutdown dynamically and brought up again?

Ah, I was being thick. Now I see.

> > > +#ifdef CONFIG_HOTPLUG_CPU
> > > +static int smp_spin_table_cpu_disable(unsigned int cpu)
> > > +{
> > > +	if (!cpu_release_addr[cpu])
> > > +		return -EOPNOTSUPP;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static void smp_spin_table_cpu_die(unsigned int cpu)
> > > +{
> > > +	setup_mm_for_reboot();
> > > +	cpu_park(in_crash_kexec ? 0 : is_hyp_mode_available(),
> > > +			cpu_release_addr[cpu]);
> > > +
> > 
> > For a crash it's _vastly_ simpler to put the secondary CPUs in a WFI
> > loop inside the crashed kernel and leave them there. You don't need them
> > to be able to dump the state of the system.
> > 
> > For a non-crash kernel you have no guarantee that the new kernel won't
> > clobber the old text. This won't work there.
> 
> Yes, agreed. I think we need to define something like cpu-park-addr in DT, where
> OS will handover control to FW and FW should have code something like following
> at that location:
> 1: 
>         wfe
>         check for valid address at cpu-release-addr
>         if valid switch to EL2 (if needed) and jump to that address
>         else goto 1:

I don't follow why/how the FW would switch EL. The OS would return it at
whatever EL it entered the kernel at (e.g. EL2), and the FW would have
no need to change EL.

My point was that we can support crash kernel without this, and I don't
think we need kexec for these platforms otherwise.

Thanks,
Mark.
