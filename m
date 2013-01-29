From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 29 Jan 2013 15:01:34 -0700
Subject: [PATCH] ARM: call disable_nonboot_cpus() from machine_shutdown()
In-Reply-To: <87d2xcfeew.fsf@xmission.com>
References: <1357160861-26282-1-git-send-email-swarren@wwwdotorg.org>
 <50E4C9C6.20609@codeaurora.org>
 <20130103120259.GB5193@mudshark.cambridge.arm.com>
 <20130103122100.GN2631@n2100.arm.linux.org.uk>
 <50E5E967.3020805@wwwdotorg.org>
 <20130106162200.GC11025@mudshark.cambridge.arm.com>
 <20130106164033.GA3222@n2100.arm.linux.org.uk> <87ehhxahd1.fsf@xmission.com>
 <20130107144812.GD3222@n2100.arm.linux.org.uk> <87d2xcfeew.fsf@xmission.com>
Message-ID: <510846BE.5090704@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/10/2013 10:59 PM, Eric W. Biederman wrote:
...
> disable_nonboot_cpus() should really be called
> sometimes_dangerously_hotunplug_all_but_one_cpu().
> 
> If that code is going to be something other than power management
> specific it is not cool that disable_nonboot_cpus() is not always
> enabled when SMP is enabled.  It means that architectures need to
> implement two different ways of shutting down cpus.
> 
> One of the truly nasty things about cpu_hotplug is that it requires that
> irqs be migrated away from a cpu with interrupts disabled, which at
> least on x86 in some interrupt delivery modes is impossible to do
> safely.  The only way to losslessly (and without wedging irq
> controllers) in those interrupt delivery modes (needed for more than 8
> cpus) is to migrate an irq in it's irq handler.  Which is fine for
> setting /proc/irq/$N/smp_affinity but is useless for cpu hot-unplug,
> where we need to guarantee that all irqs are going to stop hitting a
> cpu.

I'm a little confused about this; disable_nonboot_cpus() calls
_cpu_down() to hot-unplug the CPU, and the regular CPU hotplug path is
drivers/base/cpu.c:store_online() -> cpu_down() -> _cpu_down(), i.e. the
same basic code.

Given that, why is CPU hot unplug safe on x86 via sysfs (well, I'm just
assuming it must be, since it's enabled in my regular distro kernel and
appears to work fine), but not safe when it's done from
disable_nonboot_cpus()?

> Now sometimes_dangerously_hotunplug_all_but_one_cpu() on the reboot path 
> was added just a few months ago in Oct 2012, and it appears to due to
> weird ARM maintainership.  At least the x86 reboot_cpu_id option is
> broken due to that addition.

I guess this is true because reboot_cpu_id() isn't honored unless that
CPU is already offline, and disable_nonboot_cpus() probably took it
offline on average.

Perhaps x86's native_machine_shutdown() should explicitly bring that CPU
online if it's in cpu_possible_mask? Or perhaps disable_nonboot_cpus()
should be enhanced with x86's reboot_cpu_id logic, so it simply works
the same way across all architectures; that way some chunk of x86's
native_machine_shutdown() could be made common.

...
> We should remove disable_nonboot_cpus() from the reboot path.   It is
> still a crazy unmaintained cpu hotplug mess.

Even if we updated it to standardize the reboot_cpu_id logic across all
architectures, and hence made it still suitable for x86?
