From: guohanjun@huawei.com (Hanjun Guo)
Date: Wed, 12 Apr 2017 14:48:34 +0800
Subject: [PATCHv3 00/14] arm_pmu: ACPI support
In-Reply-To: <1491899997-32210-1-git-send-email-mark.rutland@arm.com>
References: <1491899997-32210-1-git-send-email-mark.rutland@arm.com>
Message-ID: <58EDCDC2.20706@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017/4/11 16:39, Mark Rutland wrote:
> Hi,
>
> This series implements ACPI support in the ARM PMU code. It borrows some code
> from Jeremy's series [1], but takes a different approach to probing and
> association, using the usual hotplug state machine, minimising external changes
> required, and simplifying the relationship with the common arm_pmu code.
>
> The first few patches are preparatory cleanup/refactoring, with the latter half
> of the series being specific to ACPI support.
>
> The series is based on Will's perf/updates branch [2]. I've pushed the whole
> series out to the arm/perf/acpi branch [3] of my kernel.org repo.
>
> Due to the innards of the hotplug callback framework, it's not entirely
> safe to register a PMU in a hotplug callback. Due to this, we can only
> associated hotplugged CPUs with a PMU if a matching CPU was around at
> probe time. A similar restriction already applies to DT systems. We may
> be able to relax this with some future work.
>
> I've given this some testing on a Juno platform (using SPIs). To see that IRQs
> are correctly associated, I've tested with the following:
>
>   $ taskset -c ${SOME_CPU_HERE} perf record \
>     -e armv8_pmuv3_0/cpu_cycles/ \
>     -e armv8_pmuv3_1/cpu_cycles/ \
>     cat /proc/interrupts
>  
> I've also booted with nr_cpus temporarily capped (passing maxcpus=) to test the
> association logic. This has also been tested in a VM using PPIs; I do not have
> access to a host machine which itself uses PPIs.

Hisilicon D03 using PPIs, I tested this patch set on D03 and basic perf events
work well.

Tested-by: Hanjun Guo <hanjun.guo@linaro.org>

Thanks
Hanjun
