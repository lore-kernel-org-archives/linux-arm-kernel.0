From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 10 Jan 2013 21:59:35 -0800
Subject: [PATCH] ARM: call disable_nonboot_cpus() from machine_shutdown()
In-Reply-To: <20130107144812.GD3222@n2100.arm.linux.org.uk> (Russell King's
 message of "Mon, 7 Jan 2013 14:48:13 +0000")
References: <1357160861-26282-1-git-send-email-swarren@wwwdotorg.org>
 <50E4C9C6.20609@codeaurora.org>
 <20130103120259.GB5193@mudshark.cambridge.arm.com>
 <20130103122100.GN2631@n2100.arm.linux.org.uk>
 <50E5E967.3020805@wwwdotorg.org>
 <20130106162200.GC11025@mudshark.cambridge.arm.com>
 <20130106164033.GA3222@n2100.arm.linux.org.uk>
 <87ehhxahd1.fsf@xmission.com>
 <20130107144812.GD3222@n2100.arm.linux.org.uk>
Message-ID: <87d2xcfeew.fsf@xmission.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:

> On Sun, Jan 06, 2013 at 05:53:30PM -0800, Eric W. Biederman wrote:
>> I have cleaned up the mess that is the reboot path once a bunch of years
>> ago, and apparently it is deteriorating again.
>
> Unfortunately, that's what happens when lots of cooks get their fingers
> in a pie with no coordination.  This is why having maintainers is soo
> important for code - a good maintainer ensures that the code remains
> high quality by whatever means.
>
> Code without maintainers is subject to modification in all kinds of
> random ways, including duplicating code amongst architectures which
> should be generic code - that happens because no one wants to understand
> what other architectures require.

I don't think you meant to but I have been rather strongly insulted.
With what time I can find I have been maintaining kexec.  Which I admit
has mostly been telling people don't do that silly stupid thing.

> Your original cleanups, afaik, are still all intact.  The problem is
> that since then, kexec has come along, and invented a new callback
> (machine_shutdown) which gets called while the system is still live
> in full SMP mode (and presumably all the devices are still running
> and potentially scribbling over memory with their DMA.)

The devices should not be running. The sequence of code is.
	kernel_restart_prepare();
	machine_shutdown();
	machine_kexec();

The reboot notifier and all of the device shutdown methods have been 
called in kernel_restart_prepare().  If drivers don't stop dma
in their shutdown method that is a driver bug.  I wish we could
use the remove method but I lost that fight a decade ago.

It is exactly the same sequence we use for a normal reboot
except for the the lack of disable_nonboot_cpus().

> Meanwhile
> kexec wants to pass control to the new kernel... that doesn't sound
> particularly clever to me.

Because I was annoyed I just stopped and between faded memories and
reading the kernel logs I think I can reconstruct how
disable_nonboot_cpus() got into the places it has gotten.

Ages and ages ago (the logs say Oct 2007) disable_nonboot_cpus() stopped
being a pure cpu-hotplug and power management thing and started being
called from kernel_power_off.  I objected to it's inclusion on the
reboot path but there was some deep magic ACPI ordering mess that
necessitated it be called in kernel_power_off.

In retrospect that disable_nonboot_cpus() call should have been x86
specific.

As I recall disable_nonboot_cpus() at the time was a cpu hotplug hack
and reading through the code again tonight it appears that
disable_noboot_cpus() continues to be a messed up cpu hotplug hack.

disable_nonboot_cpus() should really be called
sometimes_dangerously_hotunplug_all_but_one_cpu().

If that code is going to be something other than power management
specific it is not cool that disable_nonboot_cpus() is not always
enabled when SMP is enabled.  It means that architectures need to
implement two different ways of shutting down cpus.

One of the truly nasty things about cpu_hotplug is that it requires that
irqs be migrated away from a cpu with interrupts disabled, which at
least on x86 in some interrupt delivery modes is impossible to do
safely.  The only way to losslessly (and without wedging irq
controllers) in those interrupt delivery modes (needed for more than 8
cpus) is to migrate an irq in it's irq handler.  Which is fine for
setting /proc/irq/$N/smp_affinity but is useless for cpu hot-unplug,
where we need to guarantee that all irqs are going to stop hitting a
cpu.

Now sometimes_dangerously_hotunplug_all_but_one_cpu() on the reboot path 
was added just a few months ago in Oct 2012, and it appears to due to
weird ARM maintainership.  At least the x86 reboot_cpu_id option is
broken due to that addition.   The unlikely but very real ways to wedge
your cpu during a reboot still remain in those code paths and I expect
we simply have not seen regressions yet as there has not been enough
time for the regressions to be noticed and tracked down.

Now given that the inconsistences were caused by crazy ARM
maintainership and that disable_nonboot_cpus() is still crazy enough
to make me scared thinking about the code.

We should remove disable_nonboot_cpus() from the reboot path.   It is
still a crazy unmaintained cpu hotplug mess.

Move disable_nonboot_cpus() into machine_shutdown in the ARM reboot path
if you want to rely on that crazy piece of code.  Or possibly you can
write something ARM specific that requires less work and is safer.

Eric
