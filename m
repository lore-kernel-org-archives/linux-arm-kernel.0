From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 20 Dec 2012 15:19:57 +0530
Subject: [PATCH V3 1/5] ARM: tegra: add pending SGI checking API
In-Reply-To: <20121220093412.GE19258@tbergstrom-lnx.Nvidia.com>
References: <1355797861-12759-1-git-send-email-josephl@nvidia.com>
 <1355797861-12759-2-git-send-email-josephl@nvidia.com>
 <CAMbhsRSorDf-BebFn+t39zOK4VX4N0Fu0iPrM7XpKZcssTgX9A@mail.gmail.com>
 <20121218101548.GO19258@tbergstrom-lnx.Nvidia.com>
 <CAMbhsRSDwSoHoEs93NZhDchCS28-vQCuW2p+kqfNKeqLygL2sQ@mail.gmail.com>
 <50D2BB51.9000109@ti.com> <20121220093412.GE19258@tbergstrom-lnx.Nvidia.com>
Message-ID: <50D2DF45.1000305@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 20 December 2012 03:04 PM, Peter De Schrijver wrote:
> On Thu, Dec 20, 2012 at 08:16:33AM +0100, Santosh Shilimkar wrote:
>> On Wednesday 19 December 2012 01:06 AM, Colin Cross wrote:
>>> On Tue, Dec 18, 2012 at 2:15 AM, Peter De Schrijver
>>> <pdeschrijver@nvidia.com> wrote:
>>>> On Tue, Dec 18, 2012 at 03:42:24AM +0100, Colin Cross wrote:
>>>>> On Mon, Dec 17, 2012 at 6:30 PM, Joseph Lo <josephl@nvidia.com> wrote:
>>>>>> The "powered-down" CPU idle mode of Tegra cut off the vdd_cpu rail, it
>>>>>> include the power of GIC. That caused the SGI (Software Generated
>>>>>> Interrupt) been lost. Because the SGI can't wake up the CPU that in
>>>>>> the "powered-down" CPU idle mode. We need to check if there is any
>>>>>> pending SGI when go into "powered-down" CPU idle mode. This is important
>>>>>> especially when applying the coupled cpuidle framework into "power-down"
>>>>>> cpuidle dirver. Because the coupled cpuidle framework may have the
>>>>>> chance that misses IPI_SINGLE_FUNC handling sometimes.
>>>>>
>>>>> This problem exists for any GIC-based SoC, and needs to be fixed in
>>>>> gic_cpu_save or gic_dist_save, whichever one loses the interrupt.
>>>>
>>>> Not necessarily. It depends on the SoC design. On Tegra20, the entire CPU
>>>> cluster is railgated, including the GIC. This causes a pending IPI to be lost.
>>>> But for example on OMAP4, only the actual CPU cores are powergated. The GIC
>>>> stays alive until also the core domain hits idle. By that time a potential
>>>> pending IPI has long woken up the target CPU again, so no additional
>>>> checks are needed for functional correct behavior.
>>>
>>> I'm not sure that is correct for OMAP4.  C2 and C3 will put the power
>>> rail for the GIC in retention, and I don't think an IPI will wake it
>>> up.  I believe the same problem also exists for Exynos5.  In any case,
>>> checking for an IPI early during idle and aborting won't hurt those
>>> platforms, so I still think it should be in the GIC driver and not by
>>> mapping the GIC registers into a separate driver.
>>>
>> I second Colin on the GIC power states on OMAP.
>
> But even then PRCM will only trigger the transition to retention voltage after
> both CPUs hit off mode. I guess a pending IPI will wakeup the core before the
> PRCM starts the transition.
>
No it won't. You are talking about the voltage domain retention while
the point is SGI becomes useless once CPU power domain transition to
low power state. And btw, voltage transition also can not happen just
with two CPU's in retention. It does have dependency like cluster power 
state to hit retention.

CPUs have their own power domain state and once they enter into any low
power state apart from ON power state, SGI doesn't work. hope this is
clear.

Regards
Santosh
