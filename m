From: monstr@monstr.eu (Michal Simek)
Date: Tue, 04 Jun 2013 08:47:34 +0200
Subject: [PATCH v3] arm: zynq: Add cpuidle support
In-Reply-To: <51ACC20C.7000005@linaro.org>
References: <2ba502c172f5374ed2e424292fb50345c9dd007a.1370266815.git.michal.simek@xilinx.com>
 <51ACA237.8070004@linaro.org> <51ACB06A.2050206@monstr.eu>
 <51ACC20C.7000005@linaro.org>
Message-ID: <51AD8D86.8080906@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/03/2013 06:19 PM, Daniel Lezcano wrote:
> On 06/03/2013 05:04 PM, Michal Simek wrote:
>> On 06/03/2013 04:03 PM, Daniel Lezcano wrote:
>>> On 06/03/2013 03:40 PM, Michal Simek wrote:
>>>> Add support for cpuidle.
>>>>
>>>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>>>> ---
>>>> Changes in v3:
>>>> - Move driver to drivers/cpuidle/
>>>> - Check zynq compatible string suggested by Arnd
>>>> - Use zynq_ function prefix because of multiplatform kernel
>>>> - Incorporate comments from Daniel Lezcano
>>>> - Rebase on the top of git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
>>>>
>>>> Changes in v2:
>>>> - Fix file header
>>>>
>>>> Changes in v1:
>>>> - It was the part of Zynq core changes
>>>>   https://patchwork.kernel.org/patch/2342511/
>>>>
>>>>  drivers/cpuidle/Kconfig        |   6 +++
>>>>  drivers/cpuidle/Makefile       |   1 +
>>>>  drivers/cpuidle/cpuidle-zynq.c | 100 +++++++++++++++++++++++++++++++++++++++++
>>>>  3 files changed, 107 insertions(+)
>>>>  create mode 100644 drivers/cpuidle/cpuidle-zynq.c
>>>>
>>>> diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
>>>> index c4cc27e..8272a08 100644
>>>> --- a/drivers/cpuidle/Kconfig
>>>> +++ b/drivers/cpuidle/Kconfig
>>>> @@ -39,4 +39,10 @@ config CPU_IDLE_CALXEDA
>>>>  	help
>>>>  	  Select this to enable cpuidle on Calxeda processors.
>>>>
>>>> +config CPU_IDLE_ZYNQ
>>>> +	bool "CPU Idle Driver for Xilinx Zynq processors"
>>>> +	depends on ARCH_ZYNQ
>>>> +	help
>>>> +	  Select this to enable cpuidle on Xilinx Zynq processors.
>>>> +
>>>>  endif
>>>> diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
>>>> index 0d8bd55..8767a7b 100644
>>>> --- a/drivers/cpuidle/Makefile
>>>> +++ b/drivers/cpuidle/Makefile
>>>> @@ -7,3 +7,4 @@ obj-$(CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED) += coupled.o
>>>>
>>>>  obj-$(CONFIG_CPU_IDLE_CALXEDA) += cpuidle-calxeda.o
>>>>  obj-$(CONFIG_ARCH_KIRKWOOD) += cpuidle-kirkwood.o
>>>> +obj-$(CONFIG_CPU_IDLE_ZYNQ) += cpuidle-zynq.o
>>>> diff --git a/drivers/cpuidle/cpuidle-zynq.c b/drivers/cpuidle/cpuidle-zynq.c
>>>> new file mode 100644
>>>> index 0000000..afe6af3
>>>> --- /dev/null
>>>> +++ b/drivers/cpuidle/cpuidle-zynq.c
>>>> @@ -0,0 +1,100 @@
>>>> +/*
>>>> + * Copyright (C) 2012-2013 Xilinx
>>>> + *
>>>> + * CPU idle support for Xilinx Zynq
>>>> + *
>>>> + * based on arch/arm/mach-at91/cpuidle.c
>>>> + *
>>>> + * This file is licensed under the terms of the GNU General Public
>>>> + * License version 2.  This program is licensed "as is" without any
>>>> + * warranty of any kind, whether express or implied.
>>>> + *
>>>> + * The cpu idle uses wait-for-interrupt and RAM self refresh in order
>>>> + * to implement two idle states -
>>>> + * #1 wait-for-interrupt
>>>> + * #2 wait-for-interrupt and RAM self refresh
>>>> + */
>>>
>>> Please check you headers, it seems you are including unused headers.
>>>
>>>> +#include <linux/kernel.h>
>>>> +#include <linux/init.h>
>>>> +#include <linux/platform_device.h>
>>>> +#include <linux/cpuidle.h>
>>>> +#include <linux/io.h>
>>>
>>> ^^^^^
>>>
>>>> +#include <linux/export.h>
>>>
>>> ^^^^^
>>>
>>>> +#include <linux/clockchips.h>
>>>
>>> ^^^^^
>>>
>>>> +#include <linux/cpu_pm.h>
>>>> +#include <linux/clk.h>
>>>
>>> ^^^^
>>>
>>>> +#include <linux/err.h>
>>>> +#include <linux/of.h>
>>>> +#include <asm/proc-fns.h>
>>>> +#include <asm/cpuidle.h>
>>>> +
>>>> +#define ZYNQ_MAX_STATES		2
>>>> +
>>>> +static DEFINE_PER_CPU(struct cpuidle_device, zynq_cpuidle_device);
>>>
>>> see below.
>>>
>>>> +
>>>> +/* Actual code that puts the SoC in different idle states */
>>>> +static int zynq_enter_idle(struct cpuidle_device *dev,
>>>> +		struct cpuidle_driver *drv, int index)
>>>
>>> Indentation.
>>>
>>>> +{
>>>> +	/* Devices must be stopped here */
>>>> +	cpu_pm_enter();
>>>> +
>>>> +	/* Add code for DDR self refresh start */
>>>> +	cpu_do_idle();
>>>> +
>>>> +	/* Add code for DDR self refresh stop */
>>>> +	cpu_pm_exit();
>>>> +
>>>> +	return index;
>>>> +}
>>>> +
>>>> +static struct cpuidle_driver zynq_idle_driver = {
>>>> +	.name = "zynq_idle",
>>>> +	.owner = THIS_MODULE,
>>>> +	.states = {
>>>> +		ARM_CPUIDLE_WFI_STATE,
>>>> +		{
>>>> +			.enter            = zynq_enter_idle,
>>>> +			.exit_latency     = 10,
>>>> +			.target_residency = 10000,
>>>> +			.flags            = CPUIDLE_FLAG_TIME_VALID,
>>>> +					    CPUIDLE_FLAG_TIMER_STOP,
>>>> +			.name             = "RAM_SR",
>>>> +			.desc             = "WFI and RAM Self Refresh",
>>>> +		},
>>>> +	},
>>>> +	.safe_state_index = 0,
>>>> +	.state_count = ZYNQ_MAX_STATES,
>>>> +};
>>>> +
>>>> +/* Initialize CPU idle by registering the idle states */
>>>> +static int zynq_init_cpuidle(void)
>>>> +{
>>>> +	unsigned int cpu;
>>>> +	struct cpuidle_device *device;
>>>> +	int ret;
>>>> +
>>>> +	if (!of_machine_is_compatible("xlnx,zynq-7000"))
>>>> +		return -ENODEV;
>>>> +
>>>> +	ret = cpuidle_register_driver(&zynq_idle_driver);
>>>> +	if (ret) {
>>>> +		pr_err("%s: Driver registration failed\n", __func__);
>>>> +		return ret;
>>>> +	}
>>>> +
>>>> +	for_each_possible_cpu(cpu) {
>>>> +		device = &per_cpu(zynq_cpuidle_device, cpu);
>>>> +		device->cpu = cpu;
>>>> +		ret = cpuidle_register_device(device);
>>>> +		if (ret) {
>>>> +			pr_err("%s: Device registration failed\n", __func__);
>>>> +			return ret;
>>>> +		}
>>>> +	}
>>>> +
>>>> +	pr_info("Xilinx Zynq CpuIdle Driver started\n");
>>>
>>> Hi Michal,
>>>
>>> actually you can replace this code by
>>>
>>> cpuidle_register(&zynq_idle_driver, NULL);
>>>
>>> and remove the zynq_cpuidle_device.
>>>
>>> The framework will take care of registering the driver and the devices.
>>
>> Will change.
>>
>>
>>>> +	return 0;
>>>> +}
>>>> +module_init(zynq_init_cpuidle);
>>>
>>> Do you really want it as module ?
>>
>> kirkwood is a module
>> but in Makefile depends directly on ARCH
>> obj-$(CONFIG_ARCH_KIRKWOOD) += cpuidle-kirkwood.o
>>
>> Calxeda uses module_init() which is in this configuration device_initcall.
>>
>> Any advantage to write it as module?
>> Maybe for testing purpose will be helpful to have it as module too.
>> What do you think?
> 
> I don't see any reasons it couldn't be written as a module. It is up to
> you, if you think there could be any benefit on that, feel free to write
> it as a module. Otherwise it could be enabled in the kernel.
> 
> If it is only for testing purpose, that means a very specific use case
> where the module is loaded from NFS and a server doing cross compiling.
> Not sure it is worth to do finally.

Let me try to create module from it and also enable this option in Kconfig
and test it and I will see if there is any problem or not.
If not, I will do it as module because as I said I see only one
reason why this could be helpful which is testing.
Because you can run set of testcases with this module and without
but on the same kernel configuration. And you don't need to recompile
the kernel and reload it.

> In the future, I hope we can do a single entry for an ARM driver based
> on the device tree choosing the right back end driver in the case of the
> single kernel image. In this case, it won't be consistent to have some
> of the drivers being modules and others not. But the future does not
> exist (yet) ... :)

There shouldn't be a problem to use this as module too.

> I am a bit worried about the moment the driver is initialized because if
> we try to make all the drivers to converge to a single one, that means
> it will be initialized at a moment compatible with all the drivers.
> 
> Just to summarize:
> 
> cpuidle framework: core_initcall
> 
> calxeda:     module_platform_driver => module_init

Based on Kconfig(bool) this is also device_initcall

> kirkwood:    module_init

But based on Makefile(depends on ARCH_KIRKWOOD) as I wrote this is device_initcall

> davinci      device_initcall
> omap3/omap4: device_initcall
> at91:        device_initcall
> shmobile:    init_late
> imx5/6:      init_late
> s3c64:       device_initcall
> ux500:       device_initcall
> tegra1/2/3:  device_initcall

Thanks,
Michal


-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 263 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130604/7a7e3c86/attachment-0001.sig>
