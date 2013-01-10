From: daniel.lezcano@free.fr (Daniel Lezcano)
Date: Thu, 10 Jan 2013 22:32:25 +0100
Subject: [PATCH 5/5] ARM: exynos: enable/disable cpuidle when cpu1 is
 down/up
In-Reply-To: <CADGdYn7y_SSmLoEpeRjL8PDSZS-YJwC1QpRcUocSSnDyM8BRhQ@mail.gmail.com>
References: <1357318799-24378-1-git-send-email-daniel.lezcano@linaro.org>
 <1357318799-24378-5-git-send-email-daniel.lezcano@linaro.org>
 <CADGdYn7y_SSmLoEpeRjL8PDSZS-YJwC1QpRcUocSSnDyM8BRhQ@mail.gmail.com>
Message-ID: <50EF3369.2060902@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/10/2013 09:07 PM, amit daniel kachhap wrote:
> Hi Daniel,

Hi Amit Daniel,

> This hotplug noifiers looks fine. I suppose it should add extra state
> C1 in cpu0. If it is done like below than for normal cases(when all
> cpu's are online) there wont be any statistics for C0 state 

I guess you meant state 0 which is WFI, right ?
C0 state is the intel semantic for cpu fully turned on.

> also which
> is required. Other patches look good.

Ok, that makes sense to have statistics even if they are only doing WFI.

Then the patch 4/5 is not ok, no ?

Thanks for review
  -- Daniel

>
> Thanks,
> Amit
>
> On Fri, Jan 4, 2013 at 8:59 AM, Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>> What we have now is (1) cpu0 going always to WFI when cpu1 is up,
>> (2) cpu0 going to all states when cpu1 is down.
>>
>> In other words, cpuidle is disabled when cpu1 is up and enabled
>> when cpu1 is down.
>>
>> This patch use the cpu hotplug notifier to enable/disable cpuidle,
>> when the cpu1 is plugged or unplugged. That clarifies the code and
>> make it simpler.
>>
>> Signed-off: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
>>  arch/arm/mach-exynos/cpuidle.c |  117 +++++++++++++++++++++++-----------------
>>  1 file changed, 69 insertions(+), 48 deletions(-)
>>
>> diff --git a/arch/arm/mach-exynos/cpuidle.c b/arch/arm/mach-exynos/cpuidle.c
>> index e6f006b..d8f6f33 100644
>> --- a/arch/arm/mach-exynos/cpuidle.c
>> +++ b/arch/arm/mach-exynos/cpuidle.c
>> @@ -12,6 +12,8 @@
>>  #include <linux/init.h>
>>  #include <linux/cpuidle.h>
>>  #include <linux/cpu_pm.h>
>> +#include <linux/notifier.h>
>> +#include <linux/cpu.h>
>>  #include <linux/io.h>
>>  #include <linux/export.h>
>>  #include <linux/time.h>
>> @@ -36,31 +38,8 @@
>>
>>  #define S5P_CHECK_AFTR         0xFCBA0D10
>>
>> -static int exynos4_enter_lowpower(struct cpuidle_device *dev,
>> -                               struct cpuidle_driver *drv,
>> -                               int index);
>> -
>>  static struct cpuidle_device exynos4_cpuidle_device;
>>
>> -static struct cpuidle_driver exynos4_idle_driver = {
>> -       .name                   = "exynos4_idle",
>> -       .owner                  = THIS_MODULE,
>> -       .en_core_tk_irqen       = 1,
>> -       .states = {
>> -               [0] = ARM_CPUIDLE_WFI_STATE,
>> -               [1] = {
>> -                       .enter            = exynos4_enter_lowpower,
>> -                       .exit_latency     = 300,
>> -                       .target_residency = 100000,
>> -                       .flags            = CPUIDLE_FLAG_TIME_VALID,
>> -                       .name             = "C1",
>> -                       .desc             = "ARM power down",
>> -               },
>> -       },
>> -       .state_count = 2,
>> -       .safe_state_index = 0,
>> -};
>> -
>>  /* Ext-GIC nIRQ/nFIQ is the only wakeup source in AFTR */
>>  static void exynos4_set_wakeupmask(void)
>>  {
>> @@ -93,9 +72,9 @@ static int idle_finisher(unsigned long flags)
>>         return 1;
>>  }
>>
>> -static int exynos4_enter_core0_aftr(struct cpuidle_device *dev,
>> -                               struct cpuidle_driver *drv,
>> -                               int index)
>> +static int exynos4_enter_lowpower(struct cpuidle_device *dev,
>> +                                 struct cpuidle_driver *drv,
>> +                                 int index)
>>  {
>>         unsigned long tmp;
>>
>> @@ -143,22 +122,6 @@ static int exynos4_enter_core0_aftr(struct cpuidle_device *dev,
>>         return index;
>>  }
>>
>> -static int exynos4_enter_lowpower(struct cpuidle_device *dev,
>> -                               struct cpuidle_driver *drv,
>> -                               int index)
>> -{
>> -       int new_index = index;
>> -
>> -       /* This mode only can be entered when other core's are offline */
>> -       if (num_online_cpus() > 1)
>> -               new_index = drv->safe_state_index;
>> -
>> -       if (new_index == 0)
>> -               return arm_cpuidle_simple_enter(dev, drv, new_index);
>> -       else
>> -               return exynos4_enter_core0_aftr(dev, drv, new_index);
>> -}
>> -
>>  static void __init exynos5_core_down_clk(void)
>>  {
>>         unsigned int tmp;
>> @@ -191,6 +154,62 @@ static void __init exynos5_core_down_clk(void)
>>         __raw_writel(tmp, EXYNOS5_PWR_CTRL2);
>>  }
>>
>> +static int cpu_hotplug_notify(struct notifier_block *n,
>> +                             unsigned long action, void *hcpu)
>> +{
>> +       int ret;
>> +
>> +       /*
>> +        * cpu0 can't be shutdown on Origen, so this routine is
>> +        * called only for cpu1.
>> +        */
>> +
>> +       switch (action & 0xf) {
>> +
>> +       case CPU_ONLINE:
>> +               cpuidle_pause_and_lock();
>> +               cpuidle_disable_device(&exynos4_cpuidle_device);
>> +               cpuidle_resume_and_unlock();
>> +               break;
>> +
>> +       case CPU_DEAD:
>> +               if (!exynos4_cpuidle_device.registered) {
>> +                       ret = cpuidle_register_device(&exynos4_cpuidle_device);
>> +                       WARN_ONCE(ret, "Failed to register cpuidle device");
>> +               } else {
>> +                       cpuidle_pause_and_lock();
>> +                       cpuidle_enable_device(&exynos4_cpuidle_device);
>> +                       cpuidle_resume_and_unlock();
>> +               }
>> +               break;
>> +       }
>> +
>> +       return NOTIFY_OK;
>> +}
>> +
>> +static struct notifier_block cpu_hotplug_notifier = {
>> +       .notifier_call = cpu_hotplug_notify,
>> +};
>> +
>> +static struct cpuidle_driver exynos4_idle_driver = {
>> +       .name                   = "exynos4_idle",
>> +       .owner                  = THIS_MODULE,
>> +       .en_core_tk_irqen       = 1,
>> +       .states = {
>> +               [0] = ARM_CPUIDLE_WFI_STATE,
>> +               [1] = {
>> +                       .enter            = exynos4_enter_lowpower,
>> +                       .exit_latency     = 300,
>> +                       .target_residency = 100000,
>> +                       .flags            = CPUIDLE_FLAG_TIME_VALID,
>> +                       .name             = "C1",
>> +                       .desc             = "ARM power down",
>> +               },
>> +       },
>> +       .state_count = 2,
>> +       .safe_state_index = 0,
>> +};
>> +
>>  static int __init exynos4_init_cpuidle(void)
>>  {
>>         int ret;
>> @@ -204,12 +223,14 @@ static int __init exynos4_init_cpuidle(void)
>>                 return ret;
>>         }
>>
>> -       ret = cpuidle_register_device(&exynos4_cpuidle_device);
>> -       if (ret) {
>> -               printk(KERN_ERR "CPUidle register device failed\n");
>> -               return ret;
>> -       }
>> +       ret = register_cpu_notifier(&cpu_hotplug_notifier);
>> +       if (ret)
>> +               goto out_unregister_driver;
>> +out:
>> +       return ret;
>>
>> -       return 0;
>> +out_unregister_driver:
>> +       cpuidle_unregister_driver(&exynos4_idle_driver);
>> +       goto out;
>>  }
>>  device_initcall(exynos4_init_cpuidle);
>> --
>> 1.7.9.5
>>
>>
>> _______________________________________________
>> linaro-dev mailing list
>> linaro-dev at lists.linaro.org
>> http://lists.linaro.org/mailman/listinfo/linaro-dev
> _______________________________________________
> linaro-dev mailing list
> linaro-dev at lists.linaro.org
> http://lists.linaro.org/mailman/listinfo/linaro-dev
>
