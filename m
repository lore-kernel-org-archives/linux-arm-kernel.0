From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 17 Oct 2013 18:04:13 +0200
Subject: [PATCH v2 3/4] ARM: EXYNOS: add Exynos Dual Cluster Support
In-Reply-To: <20131017143204.GE2442@localhost.localdomain>
References: <20131017143204.GE2442@localhost.localdomain>
Message-ID: <52600A7D.2000809@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/17/2013 04:32 PM, Dave Martin wrote:
> On Thu, Oct 17, 2013 at 12:45:29PM +0200, Daniel Lezcano wrote:
>> On 10/14/2013 05:08 PM, Vyacheslav Tyrtov wrote:
>>> From: Tarek Dakhran <t.dakhran@samsung.com>
>>>
>>> Add EDCS(Exynos Dual Cluster Support) for Samsung Exynos5410 SoC.
>>> This enables all 8 cores, 4 x A7 and 4 x A15 run at the same time.
>
> [...]
>
>>> +	__mcpm_cpu_down(cpu, cluster);
>>> +
>>> +	if (!skip_wfi) {
>>> +		exynos_core_power_down(cpu, cluster);
>>> +		wfi();
>>> +	}
>>> +}
>>
>> I did not looked line by line but these functions looks very similar
>> than the tc2_pm.c's function. no ?
>
> This is true.
>
>> May be some code consolidation could be considered here.
>>
>> Added Nico and Lorenzo in Cc.
>>
>> Thanks
>>    -- Daniel
>
> Nico can commnent further, but I think the main concern here was that
> this code shouldn't be factored prematurely.

I do not share this opinion.

> There are many low-level platform specifics involved here, so it's
> hard to be certain that all platforms could fit into a more abstracted
> framework until we have some evidence to look at.
>
> This could be revisited when we have a few diverse MCPM ports to
> compare.

I am worried about seeing more and more duplicated code around the ARM 
arch (eg. arm[64]/kernel/smp.c arm64/kernel/smp.c).

The cpuidle drivers have been duplicated and it took a while before 
refactoring them, and it is not finished. The hotplug code have been 
duplicated and now it is very difficult to factor it out.

A lot of work have been done to consolidate the code across the 
different SoC since the last 2 years.

If we let duplicate code populate the different files, they will belong 
to different maintainers, thus different trees. Each SoC contributors 
will tend to add their small changes making the code to diverge more and 
more and making difficult to re-factor it later.

I am in favor of preventing duplicate code entering in the kernel and 
force the contributors to improve the kernel in general, not just the 
small part they are supposed to work on. Otherwise, we are letting the 
kernel to fork itself, internally...

> The low-level A15/A7 cacheflush sequence is already being factored
> by Nico [1].

Hopefully he did it :)

Thanks
   -- Daniel

> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2013-October/205085.html
> [PATCH] ARM: cacheflush: consolidate single-CPU ARMv7 cache disabling code
>
> [...]
>


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
