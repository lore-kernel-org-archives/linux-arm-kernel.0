From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 17 Jan 2013 09:48:34 -0700
Subject: [PATCH V4 5/5] ARM: tegra20: cpuidle: apply coupled cpuidle for
 powered-down mode
In-Reply-To: <1358389815.1667.32.camel@jlo-ubuntu-64.nvidia.com>
References: <1358323873-30525-1-git-send-email-josephl@nvidia.com>
 <CAMbhsRTmGVrjnKa_z+zonGypU+U4r2iE=D-Zfvyoq8chY68QKQ@mail.gmail.com>
 <50F71C21.20904@wwwdotorg.org>
 <1358389815.1667.32.camel@jlo-ubuntu-64.nvidia.com>
Message-ID: <50F82B62.2090903@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/16/2013 07:30 PM, Joseph Lo wrote:
> On Thu, 2013-01-17 at 05:31 +0800, Stephen Warren wrote:
>> On 01/16/2013 11:55 AM, Colin Cross wrote:
>>> On Wed, Jan 16, 2013 at 12:11 AM, Joseph Lo <josephl@nvidia.com> wrote:
>>>> The "powered-down" cpuidle mode of Tegra20 needs the CPU0 be the last one
>>>> core to go into this mode before other core. The coupled cpuidle framework
>>>> can help to sync the MPCore to coupled state then go into "powered-down"
>>>> idle mode together. The driver can just assume the MPCore come into
>>>> "powered-down" mode at the same time. No need to take care if the CPU_0
>>>> goes into this mode along and only can put it into safe idle mode (WFI).
>>>>
>>>> The powered-down state of Tegra20 requires power gating both CPU cores.
>>>> When the secondary CPU requests to enter powered-down state, it saves
>>>> its own contexts and then enters WFI for waiting CPU0 in the same state.
>>>> When the CPU0 requests powered-down state, it attempts to put the secondary
>>>> CPU into reset to prevent it from waking up. Then power down both CPUs
>>>> together and power off the cpu rail.
>>>>
>>>> Be aware of that, you may see the legacy power state "LP2" in the code
>>
>> Colin, since you only raised a few small issues on this series, does
>> that mean you're OK with it once those issues are fixed?
>>
>> Joseph, we'll be merging Tegra114 in the near future. How will this
>> patch series affect Tegra114? Will the cpuidle driver simply fail to
>> register on Tegra114 (which would be fine until we explicitly add
>> support), or would we need to disable cpuidle in Kconfig to get a
>> working Tegra114 kernel. Does this patch series affect the answer to the
>> previous question? Thanks.
>>
> Stephen,
> 
> This patch series won't affect Tegra114. I think I need to add a simple
> cpuidle driver for Tegra114 to support just WFI state first.

Ah right, I see that tegra_cpuidle_init() already switches on the SoC
version and doesn't do anything for unknown SoCs.

> And I am going do some re-works about CPUs and cluster power status sync
> functions that be introduced recently[1] for CPU hotplug, idle and
> secondary booting in Tegra tree. I hope I can hide all the power related
> function behind that and make the CPU idle driver be more generic for
> all Tegra series.
> 
> Before that re-works, I will still keep upstream the platform suspend
> function for Tegra.
> (If I am not in the right direction, please pull me back.)

That's all fine; I just wanted to make sure that applying these patches
wouldn't break anything in the new Tegra114 support.
