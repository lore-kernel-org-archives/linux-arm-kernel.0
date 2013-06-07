From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 7 Jun 2013 23:55:12 +0100
Subject: [PATCH] ARM: tegra: disable nonboot CPUs when reboot
In-Reply-To: <51B26124.5060505@wwwdotorg.org>
References: <1370597810-1153-1-git-send-email-josephl@nvidia.com>
 <51B20DF1.3030207@wwwdotorg.org>
 <20130607181846.GL8111@mudshark.cambridge.arm.com>
 <51B22CDC.4080200@wwwdotorg.org> <51B25086.6020209@wwwdotorg.org>
 <20130607221526.GC18614@n2100.arm.linux.org.uk>
 <51B26124.5060505@wwwdotorg.org>
Message-ID: <20130607225512.GF18614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 07, 2013 at 04:39:32PM -0600, Stephen Warren wrote:
> On 06/07/2013 04:15 PM, Russell King - ARM Linux wrote:
> > For reboot, the real solution there is not to use software-based
> > reboot, but bring the other cores to a halt (which is what
> > ipi_send_stop is doing) and then issue a hardware reset to the whole
> > system, including the other CPUs.
> 
> Ignoring the issues with oops in reboot, I think there's a bug in that
> when hotplug is enabled, smp_kill_cpus() calls platform_cpu_kill(), but
> nothing causes the failing CPU to ever execute smp_ops.cpu_die(). Hence,
> if the implementation of smp_ops.cpu_kill() relies on the target CPU
> having run smp_ops.cpu_die(), then smp_ops.cpu_kill() may not operate
> correctly.

Well, smp_kill_cpus() was added to get around the kexec problem -
transitioning from one kernel to the next kernel without going through
a hardware reset.  Maybe if we take a step back...

1. remove smp_kill_cpus() from smp_send_stop().
2. remove machine_shutdown() from machine_halt(), machine_power_off()
   and machine_restart().
3. call smp_send_stop() only from machine_halt(), machine_power_off() and
   machine_restart()
4. require a hardware-based reboot method for all SMP implementations;
   using soft_reboot() is not an option.

This should get us into the situation where we have a reliable method of
halting and rebooting the kernel everywhere, leaving kexec as being the
remaining problem case.

Currently, for that we effectively do smp_send_stop() followed by
smp_kill_cpus().  The no-op change for kexec there is to allow
smp_kill_cpus() to be called directly from machine_shutdown() - but
I suspect there will still be stuff that's broken with that...

So the ongoing problem remains - how to deal with kexec in a SMP
environment where it's difficult to reliably take a secondary CPU
offline to a safe place and then be able to restart it into the
next kernel...
