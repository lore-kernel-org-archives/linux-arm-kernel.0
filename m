From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 29 Jan 2013 15:10:42 -0700
Subject: [PATCH] ARM: call disable_nonboot_cpus() from machine_shutdown()
In-Reply-To: <87obgwb5d1.fsf@xmission.com>
References: <1357160861-26282-1-git-send-email-swarren@wwwdotorg.org>
 <50E4C9C6.20609@codeaurora.org>
 <20130103120259.GB5193@mudshark.cambridge.arm.com>
 <20130103122100.GN2631@n2100.arm.linux.org.uk>
 <50E5E967.3020805@wwwdotorg.org>
 <20130106162200.GC11025@mudshark.cambridge.arm.com>
 <20130106164033.GA3222@n2100.arm.linux.org.uk> <87ehhxahd1.fsf@xmission.com>
 <50ECB49C.7010609@wwwdotorg.org> <87obgwb5d1.fsf@xmission.com>
Message-ID: <510848E2.50203@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/10/2013 11:28 PM, Eric W. Biederman wrote:
...
> I don't have any problem with generic code in the reboot path
> doing:
> if (cpu_online(0))
> 	set_cpus_allowed_ptr(current, cpumask_of(0));

It looks like that API just affects the scheduler, and not whether the
other CPUs are actually active/hot-plugged-in. At least for my use-case,
I need something that really disables the other CPUs so they aren't
executing code, hence my tendency to hot-un-plug them using
disable_nonboot_cpus(), rather than just shift task execution off them
using the code above.

I wonder if all architectures shouldn't always do the following in all
reboot/shutdown/kexec cases:

* set_cpus_allowed_ptr() to limit code execution to a single CPU.
* disable_nonboot_cpus() (or equivalent) if it's available to turn off
all the other CPUs.

The issue here would be that disable_nonboot_cpus() isn't always
available; I assume that's part of the reason that there are
arch-specific machine_xxx() hooks, so that architectures can
power-off/reset their CPUs even when hotplug isn't enabled? I wonder if
that can be refactored so that reboot/poweroff/kexec can share some
CPU-disable code with CPU hotplug?
