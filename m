From: monstr@monstr.eu (Michal Simek)
Date: Wed, 27 Mar 2013 11:31:19 +0100
Subject: [PATCH v2 10/10] arm: zynq: Add cpuidle support
In-Reply-To: <5152C4D4.2020303@linaro.org>
References: <1364319822-5504-1-git-send-email-michal.simek@xilinx.com>
 <3395757de41837ecc1d84aac1a06ebcc23fe1367.1364319776.git.michal.simek@xilinx.com>
 <5152C4D4.2020303@linaro.org>
Message-ID: <CAHTX3dLg0tUPNaptyCDWL0j6ybASR7rQBK2CEEH3gb3GtXxSEQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

2013/3/27 Daniel Lezcano <daniel.lezcano@linaro.org>:
> On 03/26/2013 06:43 PM, Michal Simek wrote:
>> Add support for cpuidle.
>>
>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>
> Hi Michal,
>
> at the first glance, the driver won't enter in the self refresh state.
>
> If I am right, by checking:
>
> /sys/devices/system/cpu/cpu0/cpuidle/state1/usage, it should be always zero.

I have found this some mins ago.

I means that currently it is not zero.

zynq> cat /sys/devices/system/cpu/cpu0/cpuidle/state1/usage
96931
zynq> cat /sys/devices/system/cpu/cpu0/cpuidle/state0/usage
8396

> Also, I see there is self refresh but you save the cpu context, so it is
> cpu shutdown no ?
>
> In this case, 3 states would be needed, WFI, self-refresh, powerdown, no ?

Let me talk to Soren how this should be done on zynq.


> The comments below applies for this driver based on linux-pm-next.
>
> https://git.kernel.org/cgit/linux/kernel/git/rafael/linux-pm.git/

Appreciate that - the origin author of this code is not longer with Xilinx
that's why hard to tell why it was done in this way. This version
was done 2011-02. But that's not excuse just explanation.

It mean that this driver should also go through this tree, right?


>
>> ---
>> v2: Fix file header
>> ---
>>  arch/arm/mach-zynq/Makefile  |    1 +
>>  arch/arm/mach-zynq/cpuidle.c |  133 ++++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 134 insertions(+)
>>  create mode 100644 arch/arm/mach-zynq/cpuidle.c
>>
>> diff --git a/arch/arm/mach-zynq/Makefile b/arch/arm/mach-zynq/Makefile
>> index 1b25d92..238b8f9 100644
>> --- a/arch/arm/mach-zynq/Makefile
>> +++ b/arch/arm/mach-zynq/Makefile
>> @@ -7,4 +7,5 @@ obj-y                         := common.o slcr.o
>>  CFLAGS_REMOVE_hotplug.o              =-march=armv6k
>>  CFLAGS_hotplug.o             =-Wa,-march=armv7-a -mcpu=cortex-a9
>>  obj-$(CONFIG_HOTPLUG_CPU)    += hotplug.o
>> +obj-$(CONFIG_CPU_IDLE)               += cpuidle.o
>>  obj-$(CONFIG_SMP)            += headsmp.o platsmp.o
>> diff --git a/arch/arm/mach-zynq/cpuidle.c b/arch/arm/mach-zynq/cpuidle.c
>> new file mode 100644
>> index 0000000..4ed8855
>> --- /dev/null
>> +++ b/arch/arm/mach-zynq/cpuidle.c
>> @@ -0,0 +1,133 @@
>> +/*
>> + * Copyright (C) 2012-2013 Xilinx
>> + *
>> + * CPU idle support for Xilinx
>> + *
>> + * based on arch/arm/mach-at91/cpuidle.c
>> + *
>> + * This file is licensed under the terms of the GNU General Public
>> + * License version 2.  This program is licensed "as is" without any
>> + * warranty of any kind, whether express or implied.
>> + *
>> + * The cpu idle uses wait-for-interrupt and RAM self refresh in order
>> + * to implement two idle states -
>> + * #1 wait-for-interrupt
>> + * #2 wait-for-interrupt and RAM self refresh
>> + *
>> + * Note that this code is only intended as a prototype and is not tested
>> + * well yet, or tuned for the Xilinx Cortex A9. Also note that for a
>> + * tickless kernel, high res timers must not be turned on. The cpuidle
>> + * framework must also be turned on in the kernel.
>> + */
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/init.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/cpuidle.h>
>> +#include <linux/io.h>
>> +#include <linux/export.h>
>> +#include <linux/clockchips.h>
>> +#include <linux/cpu_pm.h>
>> +#include <linux/clk.h>
>> +#include <linux/err.h>
>> +#include <asm/proc-fns.h>
>> +
>> +#define XILINX_MAX_STATES    1
>
> You defined XILINX_MAX_STATES as 1, it should be 2.

yep. Done.

>
>> +static DEFINE_PER_CPU(struct cpuidle_device, xilinx_cpuidle_device);
>> +
>> +/* Actual code that puts the SoC in different idle states */
>> +static int xilinx_enter_idle(struct cpuidle_device *dev,
>> +             struct cpuidle_driver *drv, int index)
>> +{
>> +     struct timeval before, after;
>> +     int idle_time;
>> +
>> +     local_irq_disable();
>
> Remove this line, it is done by the caller.

Where is that caller function? I can trace it but this maybe faster way. :-)

>
>> +     do_gettimeofday(&before);
>
> Remove this line, that will be taken into account by the driver's
> en_core_tk_irqen flag.

ok

>
>> +
>> +     if (index == 0)
>> +             /* Wait for interrupt state */
>> +             cpu_do_idle();
>
> Don't check the index, see in the driver initialization comment below
> the defaul wfi state. You will have one state entering WFI and the
> xilinx_enter_idle function entering with always index 1.

ok

>
>> +     else if (index == 1) {
>> +             unsigned int cpu_id = smp_processor_id();
>> +
>> +             clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ENTER, &cpu_id);
>
> Remove this line, CPUIDLE_FLAG_TIMER_STOP will tell the cpuidle
> framework to handle that.

ok

>
>> +             /* Devices must be stopped here */
>> +             cpu_pm_enter();
>> +
>> +             /* Add code for DDR self refresh start */
>> +
>> +             cpu_do_idle();
>> +             /*cpu_suspend(foo, bar);*/
>> +
>> +             /* Add code for DDR self refresh stop */
>> +
>> +             cpu_pm_exit();
>> +
>> +             clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_EXIT, &cpu_id);
>
> Remove this line, CPUIDLE_FLAG_TIMER_STOP will tell the cpuidle
> framework to handle that.

ok

>
>> +     }
>> +
>> +     do_gettimeofday(&after);
>> +     local_irq_enable();
>> +     idle_time = (after.tv_sec - before.tv_sec) * USEC_PER_SEC +
>> +                     (after.tv_usec - before.tv_usec);
>> +
>> +     dev->last_residency = idle_time;
>
> Remove these lines about time computation, that is handled by the caller.

ok

>
>> +     return index;
>> +}
>> +
>> +static struct cpuidle_driver xilinx_idle_driver = {
>> +     .name = "xilinx_idle",
>> +     .owner = THIS_MODULE,
>> +     .state_count = XILINX_MAX_STATES,
>> +     /* Wait for interrupt state */
>> +     .states[0] = {
>> +             .enter = xilinx_enter_idle,
>> +             .exit_latency = 1,
>> +             .target_residency = 10000,
>> +             .flags = CPUIDLE_FLAG_TIME_VALID,
>> +             .name = "WFI",
>> +             .desc = "Wait for interrupt",
>> +     },
>> +     /* Wait for interrupt and RAM self refresh state */
>> +     .states[1] = {
>> +             .enter = xilinx_enter_idle,
>> +             .exit_latency = 10,
>> +             .target_residency = 10000,
>> +             .flags = CPUIDLE_FLAG_TIME_VALID,
>> +             .name = "RAM_SR",
>> +             .desc = "WFI and RAM Self Refresh",
>> +     },
>> +};
>
> static struct cpuidle_driver xilinx_idle_driver = {
>         .name = "xilinx_idle",
>         .owner = THIS_MODULE,
>         .states = {
>                 ARM_CPUIDLE_WFI_STATE,
>                 {
>                         .enter            = xilinx_enter_idle,
>                         .exit_latency     = 10,
>                         .target_residency = 10000,
>                         .flags            = CPUIDLE_FLAG_TIME_VALID,
>                                             CPUIDLE_FLAG_TIMER_STOP,
>                         .name             = "RAM_SR",
>                         .desc             = "WFI and RAM Self Refresh",
>                 },
>         },
>         .safe_state_index = 0,
>         .state_count = XILINX_MAX_STATES,
> };
>

ok

>
>> +/* Initialize CPU idle by registering the idle states */
>> +static int xilinx_init_cpuidle(void)
>> +{
>> +     unsigned int cpu;
>> +     struct cpuidle_device *device;
>> +     int ret;
>> +
>> +     ret = cpuidle_register_driver(&xilinx_idle_driver);
>> +     if (ret) {
>> +             pr_err("Registering Xilinx CpuIdle Driver failed.\n");
>> +             return ret;
>> +     }
>> +
>> +     for_each_possible_cpu(cpu) {
>> +             device = &per_cpu(xilinx_cpuidle_device, cpu);
>> +             device->state_count = XILINX_MAX_STATES;
>
> This is initialization is done from the cpuidle_register_device. As
> drv->state_count == device->state_count.

ok. Thanks you very much for your comments.
Michal

-- 
Michal Simek, Ing. (M.Eng)
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform
