From: lina.iyer@linaro.org (Lina Iyer)
Date: Wed, 18 Nov 2015 07:17:49 -0700
Subject: [PATCH RFC 13/27] ARM: cpuidle: Add runtime PM support for CPU
 idle
In-Reply-To: <CAN2waFuepGZW8DdA3HqkddCH4oBo1Lpoyn7kQXh0wiKTj3xTXg@mail.gmail.com>
References: <1447799871-56374-1-git-send-email-lina.iyer@linaro.org>
 <1447799871-56374-14-git-send-email-lina.iyer@linaro.org>
 <CAN2waFuepGZW8DdA3HqkddCH4oBo1Lpoyn7kQXh0wiKTj3xTXg@mail.gmail.com>
Message-ID: <20151118141749.GA893@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 18 2015 at 01:50 -0700, Zhaoyang Huang wrote:
>On 18 November 2015 at 06:37, Lina Iyer <lina.iyer@linaro.org> wrote:
>> Notify runtime PM when the CPU is going to be powered off in the idle
>> state. This allows for runtime PM suspend/resume of the CPU as well as
>> its PM domain.
>>
>> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
>> ---
>>  drivers/cpuidle/cpuidle-arm.c | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/drivers/cpuidle/cpuidle-arm.c b/drivers/cpuidle/cpuidle-arm.c
>> index 545069d..8e72a23 100644
>> --- a/drivers/cpuidle/cpuidle-arm.c
>> +++ b/drivers/cpuidle/cpuidle-arm.c
>> @@ -11,13 +11,16 @@
>>
>>  #define pr_fmt(fmt) "CPUidle arm: " fmt
>>
>> +#include <linux/cpu.h>
>>  #include <linux/cpuidle.h>
>>  #include <linux/cpumask.h>
>>  #include <linux/cpu_pm.h>
>>  #include <linux/kernel.h>
>>  #include <linux/module.h>
>>  #include <linux/of.h>
>> +#include <linux/pm_runtime.h>
>>  #include <linux/slab.h>
>> +#include <linux/rcupdate.h>
>>
>>  #include <asm/cpuidle.h>
>>
>> @@ -45,6 +48,10 @@ static int arm_enter_idle_state(struct cpuidle_device *dev,
>>
>>         ret = cpu_pm_enter();
>>         if (!ret) {
>> +               struct device *cpu_dev = get_cpu_device(dev->cpu);
>> +
>> +               RCU_NONIDLE(pm_runtime_put_sync_suspend(cpu_dev));
>By my test, it seems that the usage_count of cpu device will be
>decrease to -1 and the code never runs here. If it need a runtime_put
>somewhere?

You shouldn't have to. Pls make sure all the patches are pulled in and
compiles successfully.

Let me know if you still run into issues.

Thanks,
Lina

>> +
>>                 /*
>>                  * Pass idle state index to cpu_suspend which in turn will
>>                  * call the CPU ops suspend protocol with idle index as a
>> @@ -52,6 +59,7 @@ static int arm_enter_idle_state(struct cpuidle_device *dev,
>>                  */
>>                 arm_cpuidle_suspend(idx);
>>
>> +               RCU_NONIDLE(pm_runtime_get_sync(cpu_dev));
>>                 cpu_pm_exit();
>>         }
>>
>> --
>> 2.1.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
>> the body of a message to majordomo at vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
