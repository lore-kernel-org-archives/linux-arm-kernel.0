From: hejianet@gmail.com (Jia He)
Date: Mon, 20 Nov 2017 21:50:15 +0800
Subject: [PATCH] drivers/perf: arm_pmu: save/restore cpu cycle counter in
 cpu_pm_pmu_notify
In-Reply-To: <20171120123240.ohcdgv2nnoyrc7ov@lakrids.cambridge.arm.com>
References: <1510813648-45090-1-git-send-email-hejianet@gmail.com>
 <20171120123240.ohcdgv2nnoyrc7ov@lakrids.cambridge.arm.com>
Message-ID: <a3c87ec9-e670-d867-3446-7963339067d1@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark

Thanks for your review.


On 11/20/2017 8:32 PM, Mark Rutland Wrote:
> Hi,
>
> On Thu, Nov 16, 2017 at 06:27:28AM +0000, Jia He wrote:
>> Sometimes userspace need a high resolution cycle counter by reading
>> pmccntr_el0.
>>
>> In commit da4e4f18afe0 ("drivers/perf: arm_pmu: implement CPU_PM
>> notifier"), it resets all the counters even when the pmcr_el0.E and
>> pmcntenset_el0.C are both 1 . That is incorrect.
> I appreciate that you may wish to make use of the cycle counter from
> userspace, but this is the intended behaviour kernel-side. Direct
> userspace counter acceess is not supported.
Sorry for my previous description. Not only user space, but also any 
pmccntr_el0 reading
in kernel space is 0 except perf infrastructure.

>
> In power states where context is lost, any perf events are
> saved/restored by cpu_pm_pmu_setup(). So we certainly shouldn't be
> modifying the counter registers in any other PM code.
>
> We *could* expose counters to userspace on homogeneous systems, so long
> as users stuck to the usual perf data page interface. However, this
> comes with a number of subtle problems, and no-one's done the work to
> enable this.
>
> Even then, perf may modify counters at any point in time, and
> monotonicity (and/or presence) of counters is not guaranteed.

Yes, the cycle counter register pmccntr_el0 will be impacted by perf 
usage.But do you think
pmccntr_el0 is intented for perf only? Currently, many user space/kernel 
space programs will use
pmccntr_el0 as a timestamp( just likethe rdtsc() on X86). After commit 
da4e4f18afe0, all the cycle counter readingis 0 because of CPU PM 
enter/exit state changes in armv8pmu_reset.

-- 
Cheers,
Jia
