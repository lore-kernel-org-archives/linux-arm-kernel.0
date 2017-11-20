From: hejianet@gmail.com (Jia He)
Date: Mon, 20 Nov 2017 22:15:58 +0800
Subject: [PATCH] drivers/perf: arm_pmu: save/restore cpu cycle counter in
 cpu_pm_pmu_notify
In-Reply-To: <20171120140451.ztr2i24v2vspu364@lakrids.cambridge.arm.com>
References: <1510813648-45090-1-git-send-email-hejianet@gmail.com>
 <20171120123240.ohcdgv2nnoyrc7ov@lakrids.cambridge.arm.com>
 <a3c87ec9-e670-d867-3446-7963339067d1@gmail.com>
 <20171120140451.ztr2i24v2vspu364@lakrids.cambridge.arm.com>
Message-ID: <bbc23c99-6821-66ec-f2a1-c5dfdec97d60@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks, got it

Cheers,

Jia


On 11/20/2017 10:04 PM, Mark Rutland Wrote:
> On Mon, Nov 20, 2017 at 09:50:15PM +0800, Jia He wrote:
>> On 11/20/2017 8:32 PM, Mark Rutland Wrote:
>>> On Thu, Nov 16, 2017 at 06:27:28AM +0000, Jia He wrote:
>>>> Sometimes userspace need a high resolution cycle counter by reading
>>>> pmccntr_el0.
>>>>
>>>> In commit da4e4f18afe0 ("drivers/perf: arm_pmu: implement CPU_PM
>>>> notifier"), it resets all the counters even when the pmcr_el0.E and
>>>> pmcntenset_el0.C are both 1 . That is incorrect.
>>> I appreciate that you may wish to make use of the cycle counter from
>>> userspace, but this is the intended behaviour kernel-side. Direct
>>> userspace counter acceess is not supported.
>> Sorry for my previous description. Not only user space, but also any
>> pmccntr_el0 reading
>> in kernel space is 0 except perf infrastructure.
> The only user of PMCCNTR in the kernel is the perf infrastructure.
>
> If you want to perform in-kernel counts, please use
> perf_event_create_kernel_counter() and related functions.
>
>>> In power states where context is lost, any perf events are
>>> saved/restored by cpu_pm_pmu_setup(). So we certainly shouldn't be
>>> modifying the counter registers in any other PM code.
>>>
>>> We *could* expose counters to userspace on homogeneous systems, so long
>>> as users stuck to the usual perf data page interface. However, this
>>> comes with a number of subtle problems, and no-one's done the work to
>>> enable this.
>>>
>>> Even then, perf may modify counters at any point in time, and
>>> monotonicity (and/or presence) of counters is not guaranteed.
>> Yes, the cycle counter register pmccntr_el0 will be impacted by perf
>> usage.But do you think pmccntr_el0 is intented for perf only?
> We only intend for the in-kernel perf infrastructure to access
> pmccntr_el0; nothing else should touch it.
>
>> Currently, many user space/kernel space programs will use pmccntr_el0
>> as a timestamp( just likethe rdtsc() on X86).
> This is not supported, and will return completely unusable numbers if
> it were. This will be randomly reset/modified, CPUs aren't in lock-step,
> so this isn't monotonic, etc.
>
> If you want a timestamp, the architecture provides an counter that is
> monotonic and uniform across all CPUs. We expose that to userspace via
> the VDSO (e.g. clock_gettime with CLOCK_MONOTONIC_RAW) and it can be
> read in-kernel through the usual clocksource APIs.
>
> PMCCNTR is *not* usable in this manner.
>
>> After commit da4e4f18afe0, all the cycle counter readingis 0 because
>> of CPU PM enter/exit state changes in armv8pmu_reset.
> Previously, had a CPU been reset, the counter would hold an UNKNOWN
> value (i.e. it would be reset to junk), and may or may not have been
> accessible depending on what CNTKCTL reset to.
>
> So if you tried to read PMCCNTR in userspace, and happened to have been
> granted access, the values would have been bogus and unusable.
>
> Commit da4e4f18afe0 fixed things and made the behaviour consistent, as
> intended.
>
> Thanks,
> Mark.
>
