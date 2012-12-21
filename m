From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 21 Dec 2012 14:12:51 -0700
Subject: [PATCH] ARM: tegra30: fix power up sequence for boot_secondary
In-Reply-To: <1356077271.26029.81.camel@jlo-ubuntu-64.nvidia.com>
References: <1355970603-28531-1-git-send-email-josephl@nvidia.com>
 <50D3430A.4020901@wwwdotorg.org>
 <1356077271.26029.81.camel@jlo-ubuntu-64.nvidia.com>
Message-ID: <50D4D0D3.5090106@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/21/2012 01:07 AM, Joseph Lo wrote:
> On Fri, 2012-12-21 at 00:55 +0800, Stephen Warren wrote:
>> On 12/19/2012 07:30 PM, Joseph Lo wrote:
>>> The power up sequence is different on the cold boot CPU and the CPU
>>> that resumed from the hotplug. For the cold boot CPU, it was been power
>>> gated as default. To power up the cold boot CPU, the power should be
>>> un-gated by un toggling the power gate register manually.
>>>
>>> For the CPU that resumed from the hotplug, after un-halted the CPU. The
>>> flow controller will un-gate the power of the CPU. No need to manually
>>> control, just wait the power be resumed and continue the power up
>>> sequence after the CPU power is ready.
...
>> Also, it'd be good to explain (or at least briefly reference) the boot
>> path for a cold-boot CPU and a warm boot CPU; I assume that somehow a
>> cold boot CPU doesn't execute tegra_secondary_init(), but a warm boot
>> CPU does?
>>
> The boot path was the same. Both of the conditions were booted from
> tegra_boot_secondary. Just the power sequence has been different. We add
> the code to recover the power up sequence of warm boot CPU.

Ah, I see - tegra20_power_up_cpu() runs first to boot the secondary CPU,
and tegra_secondary_init() runs on the secondary CPU during the boot
process, which then sets tegra_cpu_init_mask which influences what
tegra20_power_up_cpu() does next time around. It'd be useful to say that
in the patch description.
