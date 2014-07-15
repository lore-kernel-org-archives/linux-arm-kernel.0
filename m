From: jaswinder.singh@linaro.org (Jassi Brar)
Date: Tue, 15 Jul 2014 23:46:38 +0530
Subject: [PATCH 1/8] ARM: Add platform support for Fujitsu MB86S7X SoCs
In-Reply-To: <alpine.LFD.2.11.1407151214070.3647@knanqh.ubzr>
References: <message-id-of-cover-letter@videotron.ca>
 <1405232911-4569-1-git-send-email-mollie.wu@linaro.org>
 <alpine.LFD.2.11.1407151214070.3647@knanqh.ubzr>
Message-ID: <CAJe_Zhd5SN-G9NURfpujYdBBpEtq5sPAQJJG0f-T4X+fXX-HqA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15 July 2014 22:35, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> On Sun, 13 Jul 2014, Mollie Wu wrote:
>
>> diff --git a/arch/arm/mach-mb86s7x/board.c b/arch/arm/mach-mb86s7x/board.c
>> new file mode 100644
>> index 0000000..d6e76ec
>> --- /dev/null
>> +++ b/arch/arm/mach-mb86s7x/board.c
>> @@ -0,0 +1,65 @@
>> +/*
>> + * Support for the Fujitsu's MB86S7x based devices.
>> + *
>> + * Copyright (C) 2014 Linaro, LTD
>> + *
>> + * This program is free software: you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation, version 2 of the License.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + */
>> +
>> +#include <linux/of.h>
>> +
>> +#include <asm/mcpm.h>
>> +#include <asm/mach/map.h>
>> +#include <asm/mach/arch.h>
>> +
>> +#include "iomap.h"
>> +
>> +bool __init mb86s7x_smp_init_ops(void)
>> +{
>> +     struct device_node *node;
>> +
>> +     node = of_find_compatible_node(NULL, NULL, "arm,cci-400");
>> +     if (node && of_device_is_available(node)) {
>> +             mcpm_smp_set_ops();
>> +             return true;
>> +     }
>> +
>> +     return false;
>> +}
>
> You should be able to call mcpm_smp_set_ops() directly from
> mb86s7x_mcpm_init() and dispense with this function entirely.
>
Yup, thanks.

> [...]
>
>> diff --git a/arch/arm/mach-mb86s7x/mcpm.c b/arch/arm/mach-mb86s7x/mcpm.c
>> new file mode 100644
>> index 0000000..86d223f
>> --- /dev/null
>> +++ b/arch/arm/mach-mb86s7x/mcpm.c
>> @@ -0,0 +1,293 @@
>> +/*
>> + * arch/arm/mach-mb86s7x/mcpm.c
>> + *
>> + * "Inspired" by tc_pm.c
>> + * Copyright:        (C) 2013-2014  Fujitsu Semiconductor Limited
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + */
>> +
>> +#include <linux/io.h>
>> +#include <linux/pm.h>
>> +#include <linux/delay.h>
>> +#include <linux/kernel.h>
>> +#include <linux/reboot.h>
>> +#include <linux/arm-cci.h>
>> +#include <linux/spinlock.h>
>> +#include <linux/irqchip/arm-gic.h>
>> +#include <linux/platform_data/mb86s7x_mbox.h>
>> +
>> +#include <asm/mcpm.h>
>> +#include <asm/cp15.h>
>> +#include <asm/cputype.h>
>> +#include <asm/system_misc.h>
>> +
>> +#include "iomap.h"
>> +
>> +static arch_spinlock_t mb86s7x_pm_lock = __ARCH_SPIN_LOCK_UNLOCKED;
>> +static int mb86s7x_pm_use_count[2][2];
>> +
>> +#define MB86S7X_WFICOLOR_VIRT (MB86S7X_ISRAM_VIRT + WFI_COLOR_REG_OFFSET)
>> +
>> +static void mb86s7x_set_wficolor(unsigned clstr, unsigned cpu, unsigned clr)
>> +{
>> +     u8 val;
>> +
>> +     if (clr & ~AT_WFI_COLOR_MASK)
>> +             return;
>> +
>> +     val = readb_relaxed(MB86S7X_WFICOLOR_VIRT + clstr * 2 + cpu);
>> +     val &= ~AT_WFI_COLOR_MASK;
>> +     val |= clr;
>> +     writeb_relaxed(val, MB86S7X_WFICOLOR_VIRT + clstr * 2 + cpu);
>> +}
>> +
>> +static int mb86s7x_pm_power_up(unsigned int cpu, unsigned int cluster)
>> +{
>> +     struct completion got_rsp;
>> +     int ret = 0;
>> +
>> +     pr_debug("%s: cpu %u cluster %u\n", __func__, cpu, cluster);
>
> You should ensure cpu and cluster are within the allowed range here.
>
OK, I didn't realize mcpm core could call with invalid cpu/cluster ids.


>> +
>> +     arch_spin_lock(&mb86s7x_pm_lock);
>
> As mentioned in my previous email there has to be a local_irq_disable()
> here before locking.
>
OK

>> +
>> +     mb86s7x_pm_use_count[cpu][cluster]++;
>> +
>> +     if (mb86s7x_pm_use_count[cpu][cluster] == 1) {
>> +             struct mb86s7x_cpu_gate cmd;
>> +
>> +             arch_spin_unlock(&mb86s7x_pm_lock);
>
> Hmmm.... I was about to say that you cannot drop the lock here, however
> if the count is now 1, that means the target CPU is either down or
> already prepared to get there, and it cannot race with the code here. So
> far so good.
>
>> +             cmd.payload_size = sizeof(cmd);
>> +             cmd.cluster_class = 0;
>> +             cmd.cluster_id = cluster;
>> +             cmd.cpu_id = cpu;
>> +             cmd.cpu_state = SCB_CPU_STATE_ON;
>> +
>> +             pr_debug("%s:%d CMD Cl_Class-%u CL_ID-%u CPU_ID-%u STATE-%u}\n",
>> +                      __func__, __LINE__, cmd.cluster_class,
>> +                      cmd.cluster_id, cmd.cpu_id, cmd.cpu_state);
>> +
>> +             init_completion(&got_rsp);
>> +             mb86s7x_set_wficolor(cluster, cpu, AT_WFI_DO_NOTHING);
>> +             ret = mhu_send_packet(CMD_CPU_CLOCK_GATE_SET_REQ,
>> +                                   &cmd, sizeof(cmd), &got_rsp);
>> +             if (ret < 0) {
>> +                     pr_err("%s:%d failed!\n", __func__, __LINE__);
>> +                     return ret;
>> +             }
>> +             if (ret)
>> +                     wait_for_completion(&got_rsp);
>> +
>> +             pr_debug("%s:%d REP Cl_Class-%u CL_ID-%u CPU_ID-%u STATE-%u}\n",
>> +                      __func__, __LINE__, cmd.cluster_class,
>> +                      cmd.cluster_id, cmd.cpu_id, cmd.cpu_state);
>> +
>> +             if (cmd.cpu_state != SCB_CPU_STATE_ON)
>> +                     return -ENODEV;
>> +
>> +     } else if (mb86s7x_pm_use_count[cpu][cluster] != 2) {
>> +             /*
>> +              * The only possible values are:
>> +              * 0 = CPU down
>> +              * 1 = CPU (still) up
>> +              * 2 = CPU requested to be up before it had a chance
>> +              *     to actually make itself down.
>> +              * Any other value is a bug.
>> +              */
>> +             BUG();
>> +     }
>> +
>> +     arch_spin_unlock(&mb86s7x_pm_lock);
>
> If the count became 1, the lock was already unlocked above.
>
Ah, yes. thanks.

>> +
>> +     return 0;
>> +}
>> +
>> +static void mb86s7x_pm_suspend(u64 ignored)
>> +{
>> +     unsigned int mpidr, cpu, cluster;
>> +     bool last_man = false, skip_wfi = false;
>> +
>> +     mpidr = read_cpuid_mpidr();
>> +     cpu = MPIDR_AFFINITY_LEVEL(mpidr, 0);
>> +     cluster = MPIDR_AFFINITY_LEVEL(mpidr, 1);
>> +
>> +     pr_debug("%s: cpu %u cluster %u\n", __func__, cpu, cluster);
>> +     __mcpm_cpu_going_down(cpu, cluster);
>> +
>> +     arch_spin_lock(&mb86s7x_pm_lock);
>> +     BUG_ON(__mcpm_cluster_state(cluster) != CLUSTER_UP);
>> +
>> +     mb86s7x_pm_use_count[cpu][cluster]--;
>> +
>> +     if (mb86s7x_pm_use_count[cpu][cluster] == 0) {
>> +             if (!mb86s7x_pm_use_count[0][cluster] &&
>> +                 !mb86s7x_pm_use_count[1][cluster])
>> +                     last_man = true;
>> +             mb86s7x_set_wficolor(cluster, cpu, AT_WFI_DO_POWEROFF);
>> +     } else if (mb86s7x_pm_use_count[cpu][cluster] == 1) {
>> +             skip_wfi = true; /* Overtaken by a power up */
>> +     } else {
>> +             BUG();
>> +     }
>> +
>> +     if (!skip_wfi)
>> +             gic_cpu_if_down();
>> +
>> +     if (last_man && __mcpm_outbound_enter_critical(cpu, cluster)) {
>> +             arch_spin_unlock(&mb86s7x_pm_lock);
>> +
>> +             if (read_cpuid_part_number() == ARM_CPU_PART_CORTEX_A15) {
>> +                     /*
>> +                      * On the Cortex-A15 we need to disable
>> +                      * L2 prefetching before flushing the cache.
>> +                      */
>> +                     asm volatile(
>> +                     "mcr p15, 1, %0, c15, c0, 3\n\t"
>> +                     "isb\n\t"
>> +                     "dsb"
>> +                     : : "r" (0x400));
>> +             }
>> +
>> +             v7_exit_coherency_flush(all);
>> +
>> +             cci_disable_port_by_cpu(mpidr);
>> +
>> +             __mcpm_outbound_leave_critical(cluster, CLUSTER_DOWN);
>> +     } else {
>> +             arch_spin_unlock(&mb86s7x_pm_lock);
>> +             v7_exit_coherency_flush(louis);
>> +     }
>> +
>> +     __mcpm_cpu_down(cpu, cluster);
>> +
>> +     /* Now we are prepared for power-down, do it: */
>> +     if (!skip_wfi)
>> +             wfi();
>> +
>> +     /* Not dead at this point?  Let our caller cope. */
>> +}
>> +
>> +static void mb86s7x_pm_power_down(void)
>> +{
>> +     mb86s7x_pm_suspend(0);
>> +}
>> +
>> +static int mb86s7x_wait_for_powerdown(unsigned int cpu, unsigned int cluster)
>> +{
>> +     struct mb86s7x_cpu_gate cmd;
>> +     struct completion got_rsp;
>> +     int i, ret;
>> +
>> +     cmd.payload_size = sizeof(cmd);
>> +     cmd.cluster_class = 0;
>> +     cmd.cluster_id = cluster;
>> +     cmd.cpu_id = cpu;
>> +     cmd.cpu_state = SCB_CPU_STATE_ON;
>> +
>> +     for (i = 0; i < 50; i++) {
>> +             init_completion(&got_rsp);
>> +             ret = mhu_send_packet(CMD_CPU_CLOCK_GATE_GET_REQ,
>> +                                   &cmd, sizeof(cmd), &got_rsp);
>> +             if (ret < 0) {
>> +                     pr_err("%s:%d failed to get CPU status\n",
>> +                            __func__, __LINE__);
>> +                     return -ETIMEDOUT;
>
> You should probably return the actual error from mhu_send_packet() here
> as this is probably not going to be a time-out error ?
>
OK.

>> +             }
>> +             if (ret)
>> +                     wait_for_completion(&got_rsp);
>
> Maybe wait_for_completion_timeout() so execution doesn't get stuck if
> the answer never comes back.  That is valid for the other call sites as
> well.
>
OK, though we are dead if communication with remote fails because
something real bad has to have happened to remote whose job is mainly
to serve our requests.

>> +             pr_debug("%s:%d Cl_Class-%u CL_ID-%u CPU_ID-%u STATE-%u\n",
>> +                      __func__, __LINE__,
>> +                      cmd.cluster_class, cmd.cluster_id,
>> +                      cmd.cpu_id, cmd.cpu_state);
>> +
>> +             if (cmd.cpu_state == SCB_CPU_STATE_OFF)
>> +                     return 0;
>> +
>> +             msleep(20);
>> +     }
>> +
>> +     return -ETIMEDOUT;
>> +}
>> +
>> +static const struct mcpm_platform_ops mb86s7x_pm_power_ops = {
>> +     .power_up               = mb86s7x_pm_power_up,
>> +     .power_down             = mb86s7x_pm_power_down,
>> +     .wait_for_powerdown     = mb86s7x_wait_for_powerdown,
>> +     .suspend                = mb86s7x_pm_suspend,
>> +};
>
> For proper behavior with cpuidle you'll need to provide a powered_up
> method as well.
>
OK.

>> +
>> +static void mb86s7x_restart(enum reboot_mode reboot_mode, const char *unused)
>> +{
>> +     /* Reboot immediately */
>> +     mb86s7x_reboot(50);
>> +}
>> +
>> +static void mb86s7x_poweroff(void)
>> +{
>> +     /* Reboot never, remain dead */
>> +     mb86s7x_reboot(~0);
>> +}
>> +
>> +/*
>> + * Enable cluster-level coherency, in preparation for turning on the MMU.
>> + */
>> +static void __naked mb86s7x_pm_power_up_setup(unsigned int affinity_level)
>> +{
>> +     asm volatile ("\n"
>> +"    cmp     r0, #1\n"
>> +"    bxne    lr\n"
>> +"    b       cci_enable_port_for_self");
>> +}
>> +
>> +static int __init mb86s7x_mcpm_init(void)
>> +{
>> +     unsigned int mpidr, cpu, cluster;
>> +     struct mb86s7x_scb_version cmd;
>> +     struct completion got_rsp;
>> +     int ret;
>> +
>> +     arm_pm_restart = mb86s7x_restart;
>> +     pm_power_off = mb86s7x_poweroff;
>> +
>> +     if (!cci_probed())
>> +             return -ENODEV;
>> +
>> +     mpidr = read_cpuid_mpidr();
>> +     cpu = MPIDR_AFFINITY_LEVEL(mpidr, 0);
>> +     cluster = MPIDR_AFFINITY_LEVEL(mpidr, 1);
>> +
>> +     pr_info("Booting on cpu_%u cluster_%u\n", cpu, cluster);
>> +     mb86s7x_pm_use_count[cpu][cluster] = 1;
>> +
>> +     /* reset the wfi 'color' for primary cpu */
>> +     mb86s7x_set_wficolor(cluster, cpu, AT_WFI_DO_NOTHING);
>> +
>> +     /* Set entry point for any CPU nowonwards */
>> +     writel_relaxed(virt_to_phys(mcpm_entry_point),
>> +                  MB86S7X_TRAMPOLINE_VIRT + SEC_RSTADDR_OFF);
>> +
>> +     cmd.payload_size = sizeof(cmd);
>> +     cmd.version = 0;
>> +     cmd.config_version = 0;
>> +     init_completion(&got_rsp);
>> +     ret = mhu_send_packet(CMD_SCB_CAPABILITY_GET_REQ,
>> +                           &cmd, sizeof(cmd), &got_rsp);
>> +     if (ret < 0)
>> +             pr_err("%s:%d failed to get SCB version\n",
>> +                    __func__, __LINE__);
>> +     if (ret)
>> +             wait_for_completion(&got_rsp);
>
> There appears to be a recurring pattern here:
>
>   - fill up mb86s7x_scb_version structure
>   - init_completion()
>   - mhu_send_packet()
>   - complain if error
>   - otherwise possibly wait_for_completion()
>
> All this could be abstracted in a common function to reduce code
> duplication.
>
OK.

Thank you.
-Jassi
