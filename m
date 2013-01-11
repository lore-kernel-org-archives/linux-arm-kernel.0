From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 10 Jan 2013 22:28:42 -0800
Subject: [PATCH] ARM: call disable_nonboot_cpus() from machine_shutdown()
In-Reply-To: <50ECB49C.7010609@wwwdotorg.org> (Stephen Warren's message of
 "Tue, 08 Jan 2013 17:06:52 -0700")
References: <1357160861-26282-1-git-send-email-swarren@wwwdotorg.org>
 <50E4C9C6.20609@codeaurora.org>
 <20130103120259.GB5193@mudshark.cambridge.arm.com>
 <20130103122100.GN2631@n2100.arm.linux.org.uk>
 <50E5E967.3020805@wwwdotorg.org>
 <20130106162200.GC11025@mudshark.cambridge.arm.com>
 <20130106164033.GA3222@n2100.arm.linux.org.uk>
 <87ehhxahd1.fsf@xmission.com> <50ECB49C.7010609@wwwdotorg.org>
Message-ID: <87obgwb5d1.fsf@xmission.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Thanks for the cross architecture survey.

Stephen Warren <swarren@wwwdotorg.org> writes:

> On 01/06/2013 06:53 PM, Eric W. Biederman wrote:
> ...
>> Yes.  On x86 we have had the generic equivalent of disable_nonboot_cpus
>> in the machine_shutdown for a long time.
>
> It looks like the x86 implementation does a bit more than
> disable_nonboot_cpus():
>
> disable_nonboot_cpus():
> 	find first cpu in online cpu mask
> 	disable everything else
>
> x86's machine_shutdown():
> 	default to rebooting on cpu 0
> 	if user specified a different cpu, override default
> 	bring that cpu online
> 	disable everything else

That you can no longer specify a reboot_cpu_id on x86 is a regression
since Oct caused by people fixing another piece of the ARM SMP reboot.

Not that I know it is knew I wonder what other x86 regressions it
causes.  The migrating of irqs to different cpus with interrupts
disabled on interrupt the architectural x86 interrupt controllers that
don't support that and that I have experimentally verified can be locked
on with no recovery short of power cycling gives me the willies.

The actual reboot_cpu_id option was someones first hack at getting
the reboot to happen on the boot cpu so it may not matter much as
long as we reboot on the boot cpu.

reboot_cpu_id really wasn't a kexec thing in this case.

> So, x86 always kexec's on a specific CPU, whereas if we use
> disable_nonboot_cpus() on ARM, we'll end up kexec'ing on whichever is
> the first online CPU, which might not be the actual boot CPU, and can
> vary.

> On Tegra this doesn't (currently?) matter since CPU 0 can't be taken
> offline due to our CPU hotplug driver disallowing it. But, perhaps other
> SoCs or future Tegra versions don't/won't have this restriction, so the
> difference will be material.

> Should the x86 code be lifted into the implementation of
> disable_nonboot_cpus()?

disable_nonboot_cpus() roughly as it exists today is needed for
hibernation and some silliness like that.

I don't have any problem with generic code in the reboot path
doing:
if (cpu_online(0))
	set_cpus_allowed_ptr(current, cpumask_of(0));

All of the code in native_stop_other_cpus() on x86 is both simple and
pretty architecture specific so I don't see much if any point in making
a generic version.  At most there is an argument for an arch specific
stop_other_cpus() call.

I have a real hard time believe that power management and cpu hot-unplug
need to be as complex as disable_nonboot_cpus() suggest.

For justifying disable_nonboot_cpus() there is the question of how many
architectures is it safe to migrate irqs from one cpu to another with
irqs disabled.

> For the record, here's what I can tell about what the various
> arch-specific machine_shutdown() do:
>
> ARM, ARM64: calls smp_send_stop()
>   -> disable_nonboot_cpus() would be correct
>
> IA64: shuts down all CPUs except the current one
>   -> disable_nonboot_cpus() would be correct
>
> Microblaze: nothing (but no SMP support?)
>   -> disable_nonboot_cpus() would be irrelevant, but fine
>
> MIPS: machine-specific:
>   Cavium Octeon: Shuts down CPUs, waits until num_online_cpus()==1
>     Not sure which CPU isn't shut down though; the current one?
>   Others: Nothing (but at least some have SMP support)
>   -> disable_nonboot_cpus() would be a behaviour change
>
> PPC: machine-specific
>   Only implementations either aren't for SMP, or do nothing (but
> presumably many have SMP support)
>   -> disable_nonboot_cpus() would be a behaviour change
>
> SH: smp_send_stop()
>   -> disable_nonboot_cpus() would be correct
>
> S390: nothing (but appears to have SMP support)
>   -> disable_nonboot_cpus() would be a behaviour change
>
> Tile: nothing (but bans kexec unless no SMP or only 1 CPU online)
>   -> disable_nonboot_cpus() would be irrelevant, but fine, and perhaps
> even allow removal of the kexec ban for SMP?
>
> So at least I don't see anything that would particularly indicate that
> having the kexec generic/core code call disable_nonboot_cpus() would
> cause problems; many architectures have done something like that
> themselves. That said, it certainly would cause some behavioural
> differences on some big platforms like PPC...

Behavior differences someone introduced just a kernel ago in the PPC
reboot code to deal with ARMs lack of code in machine_shutdown to handle
this at all.

Eric
