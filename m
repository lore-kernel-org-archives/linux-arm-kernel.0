From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 17 Jun 2013 12:58:53 -0600
Subject: [PATCH V2 2/2] ARM: decouple CPU offlining from reboot/shutdown
In-Reply-To: <1371067281-655-2-git-send-email-swarren@wwwdotorg.org>
References: <1371067281-655-1-git-send-email-swarren@wwwdotorg.org>
 <1371067281-655-2-git-send-email-swarren@wwwdotorg.org>
Message-ID: <51BF5C6D.9050806@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/12/2013 02:01 PM, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> Add comments to machine_shutdown()/halt()/power_off()/restart() that
> describe their purpose and/or requirements re: CPUs being active/not.
> 
> In machine_shutdown(), replace the call to smp_send_stop() with a call to
> disable_nonboot_cpus(). This completely disables all but one CPU, thus
> satisfying the requirement that only a single CPU be active for kexec.
> Adjust Kconfig dependencies for this change.
> 
> In machine_halt()/power_off()/restart(), call smp_send_stop() directly,
> rather than via machine_shutdown(); these functions don't need to
> completely de-activate all CPUs using hotplug, but rather just quiesce
> them.
> 
> Remove smp_kill_cpus(), and its call from smp_send_stop().
> smp_kill_cpus() was indirectly calling smp_ops.cpu_kill() without calling
> smp_ops.cpu_die() on the target CPUs first. At least some implementations
> of smp_ops had issues with this; it caused cpu_kill() to hang on Tegra,
> for example. Since smp_send_stop() is only used for shutdown, halt, and
> power-off, there is no need to attempt any kind of CPU hotplug here.
> 
> Adjust Kconfig to reflect that machine_shutdown() (and hence kexec)
> relies upon disable_nonboot_cpus(). However, this alone doesn't guarantee
> that hotplug will work, or even that hotplug is implemented for a
> particular piece of HW that a multi-platform zImage runs on. Hence, add
> error-checking to machine_kexec() to determine whether it did work.

Russell,

The patch which initially triggered the problem [shutdown/reboot hangs
on Tegra] (cf7df37 "reboot: rigrate shutdown/reboot to boot cpu") ended
up going into v3.10; I assumed it was only going into v3.11.

Is it possible to take this patch for v3.10 rather than v3.11? (or is
your git-curr branch for 3.10; that's where your patchd told me this was
applied.)
