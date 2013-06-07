From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 07 Jun 2013 12:56:28 -0600
Subject: [PATCH] ARM: tegra: disable nonboot CPUs when reboot
In-Reply-To: <20130607181846.GL8111@mudshark.cambridge.arm.com>
References: <1370597810-1153-1-git-send-email-josephl@nvidia.com>
 <51B20DF1.3030207@wwwdotorg.org>
 <20130607181846.GL8111@mudshark.cambridge.arm.com>
Message-ID: <51B22CDC.4080200@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/07/2013 12:18 PM, Will Deacon wrote:
> On Fri, Jun 07, 2013 at 05:44:33PM +0100, Stephen Warren wrote:
>> On 06/07/2013 03:36 AM, Joseph Lo wrote:
>>> The normal CPU hotplug flow in kernel and the flow for Tegra we expected,
>>> is checking the CPU ID is OK for hotplug by "tegra_cpu_disable", the CPU
>>> that would be hotplugged runs into a power-gate state by "tegra_cpu_die",
>>> then the other CPU waits for the CPU that was hotplugged in reset and
>>> clock gate it by "tegra_cpu_kill". That means we don't support the CPU
>>> being stopped or put into offline by trigger "tegra_cpu_kill" directly.
>>> It may cause a busy loop for waiting CPU in reset.
>>>
>>> After the commit "62e930e reboot: rigrate shutdown/reboot to boot cpu",
>>> we remove "disable_nonboot_cpus" when kernel_{restart,halt,power_off}.
>>> But the ARM kernel trigger "send_smp_stop" when machine_shutdown, that
>>> would cause the "tegra_cpu_kill" directly without "tegra_cpu_die" first.
>>>
>>> We hook "disable_nonboot_cpus" in "reboot_notifier" to avoid that happens.
>>> And it can work for reboot, shutdown, halt and kexec.
>>
>> I don't believe this is the correct solution.
>>
>> If the semantics of cpu_kill/cpu_die are such that it's legal to call
>> only cpu_kill without having cause cpu_die to run on the killed CPU
>> first, then Tegra's implementation is buggy. We should simply fix that,
>> rather than avoiding this by forcing a different order for the calls to
>> cpu_kill/cpu_die.
>>
>> If the semantics of cpu_kill/cpu_die are such that one /must/ cause
>> cpu_die to run on the killed CPU before cpu_kill can be used on it, then
>> there's a bug in the code that isn't doing that.
>>
>> I'm CCing a few people in an attempt to find out exactly what the
>> expected semantics are for cpu_kill/cpu_die; is it legal to call
>> cpu_kill without having first caused cpu_die to execute?
> 
> By cpu_kill, do you mean platform_cpu_kill called from __cpu_die?

The struct smp_operations .cpu_kill/.cpu_die hooks. So, yes.

> If so,
> __cpu_die and cpu_die are definitely supposed to be treated as a pair, since
> they synchronise via the cpu_died completion.

So the analysis I did, cribbed from our internal bug report so hopefully
it makes sense without any context there, was:

==========
Before that patch (62e930e reboot: "rigrate shutdown/reboot to boot
cpu"), kernel/sys.c:kernel_restart() and kernel_power_off() used to use
CPU hotplug mechanisms to unplug every CPU other than one CPU, then do
the reboot or shutdown. The ARM implementation of machine_restart() and
machine_power_off() both call machine_shutdown() which calls
smp_send_stop(), which IPIs to every CPU to tell it to stop. However,
since all the CPUs were unplugged, this was a no-op.

With the patch, the kernel simply disables scheduling on all CPUs except
logical CPU 0 in kernel_restart() and kernel_power_off(). This
guarantees that the code is running on logical CPU 0, but leaves the
other CPUs still present. Hence, the call to smp_send_stop() from the
ARM code is no longer a no-op. This code hangs.

The implementation of smp_send_stop() raises IPI_CPU_STOP on each CPU
(other than logical CPU 0). This eventually calls down to
tegra_cpu_kill()[1], which calls tegra_wait_cpu_in_reset() which calls
tegra20_wait_cpu_in_reset(). That hangs, because nothing has ever told
the flow controller to put the CPU in reset, so logical CPU 0 waits
indefinitely for this to happen, which is the hang.
==========

[1] Perhaps the issue is why ipi_send_stop() calls down into
tegra_cpu_kill() rather than tegra_cpu_die(), since die() is what should
be run on the killed CPU, and kill() on the killing CPU?
