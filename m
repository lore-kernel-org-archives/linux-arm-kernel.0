From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 08 Jan 2013 17:06:52 -0700
Subject: [PATCH] ARM: call disable_nonboot_cpus() from machine_shutdown()
In-Reply-To: <87ehhxahd1.fsf@xmission.com>
References: <1357160861-26282-1-git-send-email-swarren@wwwdotorg.org>
 <50E4C9C6.20609@codeaurora.org>
 <20130103120259.GB5193@mudshark.cambridge.arm.com>
 <20130103122100.GN2631@n2100.arm.linux.org.uk>
 <50E5E967.3020805@wwwdotorg.org>
 <20130106162200.GC11025@mudshark.cambridge.arm.com>
 <20130106164033.GA3222@n2100.arm.linux.org.uk> <87ehhxahd1.fsf@xmission.com>
Message-ID: <50ECB49C.7010609@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/06/2013 06:53 PM, Eric W. Biederman wrote:
...
> Yes.  On x86 we have had the generic equivalent of disable_nonboot_cpus
> in the machine_shutdown for a long time.

It looks like the x86 implementation does a bit more than
disable_nonboot_cpus():

disable_nonboot_cpus():
	find first cpu in online cpu mask
	disable everything else

x86's machine_shutdown():
	default to rebooting on cpu 0
	if user specified a different cpu, override default
	bring that cpu online
	disable everything else

So, x86 always kexec's on a specific CPU, whereas if we use
disable_nonboot_cpus() on ARM, we'll end up kexec'ing on whichever is
the first online CPU, which might not be the actual boot CPU, and can vary.

On Tegra this doesn't (currently?) matter since CPU 0 can't be taken
offline due to our CPU hotplug driver disallowing it. But, perhaps other
SoCs or future Tegra versions don't/won't have this restriction, so the
difference will be material.

Should the x86 code be lifted into the implementation of
disable_nonboot_cpus()?

For the record, here's what I can tell about what the various
arch-specific machine_shutdown() do:

ARM, ARM64: calls smp_send_stop()
  -> disable_nonboot_cpus() would be correct

IA64: shuts down all CPUs except the current one
  -> disable_nonboot_cpus() would be correct

Microblaze: nothing (but no SMP support?)
  -> disable_nonboot_cpus() would be irrelevant, but fine

MIPS: machine-specific:
  Cavium Octeon: Shuts down CPUs, waits until num_online_cpus()==1
    Not sure which CPU isn't shut down though; the current one?
  Others: Nothing (but at least some have SMP support)
  -> disable_nonboot_cpus() would be a behaviour change

PPC: machine-specific
  Only implementations either aren't for SMP, or do nothing (but
presumably many have SMP support)
  -> disable_nonboot_cpus() would be a behaviour change

SH: smp_send_stop()
  -> disable_nonboot_cpus() would be correct

S390: nothing (but appears to have SMP support)
  -> disable_nonboot_cpus() would be a behaviour change

Tile: nothing (but bans kexec unless no SMP or only 1 CPU online)
  -> disable_nonboot_cpus() would be irrelevant, but fine, and perhaps
even allow removal of the kexec ban for SMP?

So at least I don't see anything that would particularly indicate that
having the kexec generic/core code call disable_nonboot_cpus() would
cause problems; many architectures have done something like that
themselves. That said, it certainly would cause some behavioural
differences on some big platforms like PPC...
