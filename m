From: rickard.andersson@stericsson.com (Rickard Andersson)
Date: Mon, 23 Apr 2012 09:57:57 +0200
Subject: [PATCH] ARM: ux500: add the cpuidle driver for WFI and ARM
 retention
In-Reply-To: <1334839592-32251-1-git-send-email-daniel.lezcano@linaro.org>
References: <1334839592-32251-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <4F950B85.2010505@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Should not the driver be located in the 'drivers/cpuidle/' directory?

BR
Rickard
> This patch adds the cpuidle driver for the ux500 SoC.
> The boards saves 12mA with these states. It is based on the latest
> cpuidle consolidation from Robert Lee.
>
> The cpu can go to retention only if the other core is in WFI.
>
> If the other cpu is in WFI and we decoupled the gic from the cores,
> then we have the guarantee, it won't be wake up.
>
> It is up to the prcmu firmware to recouple the gic automatically
> after the power state mode is selected.
>
> Signed-off-by: Daniel Lezcano<daniel.lezcano@linaro.org>
> ---
>   arch/arm/mach-ux500/Makefile  |    1 +
>   arch/arm/mach-ux500/cpuidle.c |  171 +++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 172 insertions(+), 0 deletions(-)
>   create mode 100644 arch/arm/mach-ux500/cpuidle.c
>
> diff --git a/arch/arm/mach-ux500/Makefile b/arch/arm/mach-ux500/Makefile
> index fc7db5d..3b86b61 100644
> --- a/arch/arm/mach-ux500/Makefile
> +++ b/arch/arm/mach-ux500/Makefile
> @@ -4,6 +4,7 @@
>
>   obj-y				:= clock.o cpu.o devices.o devices-common.o \
>   				   id.o usb.o timer.o
> +obj-$(CONFIG_CPU_IDLE)          += cpuidle.o
>   obj-$(CONFIG_CACHE_L2X0)	+= cache-l2x0.o
>   obj-$(CONFIG_UX500_SOC_DB8500)	+= cpu-db8500.o devices-db8500.o
>   obj-$(CONFIG_MACH_MOP500)	+= board-mop500.o board-mop500-sdi.o \
> diff --git a/arch/arm/mach-ux500/cpuidle.c b/arch/arm/mach-ux500/cpuidle.c
> new file mode 100644
> index 0000000..b54884bd
> --- /dev/null
> +++ b/arch/arm/mach-ux500/cpuidle.c
> @@ -0,0 +1,171 @@
> +/*
> + * Copyright (c) 2012 Linaro : Daniel Lezcano<daniel.lezcano@linaro.org>  (IBM)
> + *
> + * Based on the work of Rickard Andersson<rickard.andersson@stericsson.com>
> + * and Jonas Aaberg<jonas.aberg@stericsson.com>.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include<linux/module.h>
> +#include<linux/cpuidle.h>
> +#include<linux/clockchips.h>
> +#include<linux/spinlock.h>
> +#include<linux/atomic.h>
> +#include<linux/smp.h>
> +#include<linux/mfd/dbx500-prcmu.h>
> +
> +#include<asm/cpuidle.h>
> +#include<asm/proc-fns.h>
> +
> +static atomic_t master = ATOMIC_INIT(0);
> +static DEFINE_SPINLOCK(master_lock);
> +static DEFINE_PER_CPU(struct cpuidle_device, ux500_cpuidle_device);
> +
> +static inline int ux500_enter_idle(struct cpuidle_device *dev,
> +				   struct cpuidle_driver *drv, int index)
> +{
> +	int this_cpu = smp_processor_id();
> +	bool recouple = false;
> +
> +	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ENTER,&this_cpu);
> +
> +	if (atomic_inc_return(&master) == num_online_cpus()) {
> +
> +		/* With this lock, we prevent the other cpu to exit and enter
> +		 * this function again and become the master */
> +		if (!spin_trylock(&master_lock))
> +			goto wfi;
> +
> +		/* decouple the gic from the A9 cores */
> +		if (prcmu_gic_decouple())
> +			goto out;
> +
> +		/* If an error occur, we will have to recouple the gic
> +		 * manually */
> +		recouple = true;
> +
> +		/* At this state, as the gic is decoupled, if the other
> +		 * cpu is in WFI, we have the guarantee it won't be wake
> +		 * up, so we can safely go to retention */
> +		if (!prcmu_is_cpu_in_wfi(this_cpu ? 0 : 1))
> +			goto out;
> +
> +		/* The prcmu will be in charge of watching the interrupts
> +		 * and wake up the cpus */
> +		if (prcmu_copy_gic_settings())
> +			goto out;
> +
> +		/* Check in the meantime an interrupt did
> +		 * not occur on the gic ... */
> +		if (prcmu_gic_pending_irq())
> +			goto out;
> +
> +		/* ... and the prcmu */
> +		if (prcmu_pending_irq())
> +			goto out;
> +
> +		/* Go to the retention state, the prcmu will wait for the
> +		 * cpu to go WFI and this is what happens after exiting this
> +		 * 'master' critical section */
> +		if (prcmu_set_power_state(PRCMU_AP_IDLE, true, true))
> +			goto out;
> +
> +		/* When we switch to retention, the prcmu is in charge
> +		 * of recoupling the gic automatically */
> +		recouple = false;
> +
> +		spin_unlock(&master_lock);
> +	}
> +wfi:
> +	cpu_do_idle();
> +out:
> +	atomic_dec(&master);
> +
> +	if (recouple) {
> +		prcmu_gic_recouple();
> +		spin_unlock(&master_lock);
> +	}
> +
> +	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_EXIT,&this_cpu);
> +
> +	return index;
> +}
> +
> +static struct cpuidle_driver ux500_idle_driver = {
> +	.name = "ux500_idle",
> +	.owner = THIS_MODULE,
> +	.en_core_tk_irqen = 1,
> +	.states = {
> +		ARM_CPUIDLE_WFI_STATE,
> +		{
> +			.enter		  = ux500_enter_idle,
> +			.exit_latency	  = 70,
> +			.target_residency = 260,
> +			.flags		  = CPUIDLE_FLAG_TIME_VALID,
> +			.name		  = "ApIdle",
> +			.desc		  = "ARM Retention",
> +		},
> +	},
> +	.safe_state_index = 0,
> +	.state_count = 2,
> +};
> +
> +/*
> + * For each cpu, setup the broadcast timer because we will
> + * need to migrate the timers for the states>= ApIdle.
> + */
> +static void ux500_setup_broadcast_timer(void *arg)
> +{
> +	int cpu = smp_processor_id();
> +	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ON,&cpu);
> +}
> +
> +int __init ux500_idle_init(void)
> +{
> +	int ret, cpu;
> +	struct cpuidle_device *device;
> +
> +        /* Configure wake up reasons */
> +	prcmu_enable_wakeups(PRCMU_WAKEUP(ARM) | PRCMU_WAKEUP(RTC) |
> +			     PRCMU_WAKEUP(ABB));
> +
> +	/*
> +	 * Configure the timer broadcast for each cpu, that must
> +	 * be done from the cpu context, so we use a smp cross
> +	 * call with 'on_each_cpu'.
> +	 */
> +	on_each_cpu(ux500_setup_broadcast_timer, NULL, 1);
> +
> +	ret = cpuidle_register_driver(&ux500_idle_driver);
> +	if (ret) {
> +		printk(KERN_ERR "failed to register ux500 idle driver\n");
> +		return ret;
> +	}
> +
> +	for_each_online_cpu(cpu) {
> +		device =&per_cpu(ux500_cpuidle_device, cpu);
> +		device->cpu = cpu;
> +		ret = cpuidle_register_device(device);
> +		if (ret) {
> +			printk(KERN_ERR "Failed to register cpuidle "
> +			       "device for cpu%d\n", cpu);
> +			goto out_unregister;
> +		}
> +	}
> +out:
> +	return ret;
> +
> +out_unregister:
> +	for_each_online_cpu(cpu) {
> +		device =&per_cpu(ux500_cpuidle_device, cpu);
> +		cpuidle_unregister_device(device);
> +	}
> +
> +	cpuidle_unregister_driver(&ux500_idle_driver);
> +	goto out;
> +}
> +
> +device_initcall(ux500_idle_init);
