From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 07 Jun 2013 10:44:33 -0600
Subject: [PATCH] ARM: tegra: disable nonboot CPUs when reboot
In-Reply-To: <1370597810-1153-1-git-send-email-josephl@nvidia.com>
References: <1370597810-1153-1-git-send-email-josephl@nvidia.com>
Message-ID: <51B20DF1.3030207@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/07/2013 03:36 AM, Joseph Lo wrote:
> The normal CPU hotplug flow in kernel and the flow for Tegra we expected,
> is checking the CPU ID is OK for hotplug by "tegra_cpu_disable", the CPU
> that would be hotplugged runs into a power-gate state by "tegra_cpu_die",
> then the other CPU waits for the CPU that was hotplugged in reset and
> clock gate it by "tegra_cpu_kill". That means we don't support the CPU
> being stopped or put into offline by trigger "tegra_cpu_kill" directly.
> It may cause a busy loop for waiting CPU in reset.
> 
> After the commit "62e930e reboot: rigrate shutdown/reboot to boot cpu",
> we remove "disable_nonboot_cpus" when kernel_{restart,halt,power_off}.
> But the ARM kernel trigger "send_smp_stop" when machine_shutdown, that
> would cause the "tegra_cpu_kill" directly without "tegra_cpu_die" first.
> 
> We hook "disable_nonboot_cpus" in "reboot_notifier" to avoid that happens.
> And it can work for reboot, shutdown, halt and kexec.

I don't believe this is the correct solution.

If the semantics of cpu_kill/cpu_die are such that it's legal to call
only cpu_kill without having cause cpu_die to run on the killed CPU
first, then Tegra's implementation is buggy. We should simply fix that,
rather than avoiding this by forcing a different order for the calls to
cpu_kill/cpu_die.

If the semantics of cpu_kill/cpu_die are such that one /must/ cause
cpu_die to run on the killed CPU before cpu_kill can be used on it, then
there's a bug in the code that isn't doing that.

I'm CCing a few people in an attempt to find out exactly what the
expected semantics are for cpu_kill/cpu_die; is it legal to call
cpu_kill without having first caused cpu_die to execute?
