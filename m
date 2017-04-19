From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Wed, 19 Apr 2017 08:52:12 -0600
Subject: [PATCH v6 6/8] coresight: add support for CPU debug module
In-Reply-To: <20170419001807.GB8524@leoy-linaro>
References: <1491485461-22800-1-git-send-email-leo.yan@linaro.org>
 <1491485461-22800-7-git-send-email-leo.yan@linaro.org>
 <20170418174050.GC22806@linaro.org>
 <20170419001807.GB8524@leoy-linaro>
Message-ID: <CANLsYkyheVJkEjpcWAd5HHFCimfTPhgihioE7bYo1RAL=8Shdw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18 April 2017 at 18:18, Leo Yan <leo.yan@linaro.org> wrote:
> On Tue, Apr 18, 2017 at 11:40:50AM -0600, Mathieu Poirier wrote:
>> On Thu, Apr 06, 2017 at 09:30:59PM +0800, Leo Yan wrote:
>> > Coresight includes debug module and usually the module connects with CPU
>> > debug logic. ARMv8 architecture reference manual (ARM DDI 0487A.k) has
>> > description for related info in "Part H: External Debug".
>> >
>> > Chapter H7 "The Sample-based Profiling Extension" introduces several
>> > sampling registers, e.g. we can check program counter value with
>> > combined CPU exception level, secure state, etc. So this is helpful for
>> > analysis CPU lockup scenarios, e.g. if one CPU has run into infinite
>> > loop with IRQ disabled. In this case the CPU cannot switch context and
>> > handle any interrupt (including IPIs), as the result it cannot handle
>> > SMP call for stack dump.
>> >
>> > This patch is to enable coresight debug module, so firstly this driver
>> > is to bind apb clock for debug module and this is to ensure the debug
>> > module can be accessed from program or external debugger. And the driver
>> > uses sample-based registers for debug purpose, e.g. when system triggers
>> > panic, the driver will dump program counter and combined context
>> > registers (EDCIDSR, EDVIDSR); by parsing context registers so can
>> > quickly get to know CPU secure state, exception level, etc.
>> >
>> > Some of the debug module registers are located in CPU power domain, so
>> > this requires the CPU power domain stays on when access related debug
>> > registers, but the power management for CPU power domain is quite
>> > dependent on SoC integration for power management. For the platforms
>> > which with sane power controller implementations, this driver follows
>> > the method to set EDPRCR to try to pull the CPU out of low power state
>> > and then set 'no power down request' bit so the CPU has no chance to
>> > lose power.
>> >
>> > If the SoC has not followed up this design well for power management
>> > controller, the user should use the command line parameter or sysfs
>> > to constrain all or partial idle states to ensure the CPU power
>> > domain is enabled and access coresight CPU debug component safely.
>> >
>> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
>>
>> This is coming along well - a few comment below.  In your next revision please
>> add GKH to the 'To' list.
>
> Sure. Will send out in this week and add Greg in 'To' list.
>
>> > ---
>> >  drivers/hwtracing/coresight/Kconfig               |  14 +
>> >  drivers/hwtracing/coresight/Makefile              |   1 +
>> >  drivers/hwtracing/coresight/coresight-cpu-debug.c | 667 ++++++++++++++++++++++
>> >  3 files changed, 682 insertions(+)
>> >  create mode 100644 drivers/hwtracing/coresight/coresight-cpu-debug.c
>> >
>> > diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
>> > index 130cb21..8d55d6d 100644
>> > --- a/drivers/hwtracing/coresight/Kconfig
>> > +++ b/drivers/hwtracing/coresight/Kconfig
>> > @@ -89,4 +89,18 @@ config CORESIGHT_STM
>> >       logging useful software events or data coming from various entities
>> >       in the system, possibly running different OSs
>> >
>> > +config CORESIGHT_CPU_DEBUG
>> > +   tristate "CoreSight CPU Debug driver"
>> > +   depends on ARM || ARM64
>> > +   depends on DEBUG_FS
>> > +   help
>> > +     This driver provides support for coresight debugging module. This
>> > +     is primarily used to dump sample-based profiling registers when
>> > +     system triggers panic, the driver will parse context registers so
>> > +     can quickly get to know program counter (PC), secure state,
>> > +     exception level, etc. Before use debugging functionality, platform
>> > +     needs to ensure the clock domain and power domain are enabled
>> > +     properly, please refer Documentation/trace/coresight-cpu-debug.txt
>> > +     for detailed description and the example for usage.
>> > +
>> >  endif
>> > diff --git a/drivers/hwtracing/coresight/Makefile b/drivers/hwtracing/coresight/Makefile
>> > index af480d9..433d590 100644
>> > --- a/drivers/hwtracing/coresight/Makefile
>> > +++ b/drivers/hwtracing/coresight/Makefile
>> > @@ -16,3 +16,4 @@ obj-$(CONFIG_CORESIGHT_SOURCE_ETM4X) += coresight-etm4x.o \
>> >                                     coresight-etm4x-sysfs.o
>> >  obj-$(CONFIG_CORESIGHT_QCOM_REPLICATOR) += coresight-replicator-qcom.o
>> >  obj-$(CONFIG_CORESIGHT_STM) += coresight-stm.o
>> > +obj-$(CONFIG_CORESIGHT_CPU_DEBUG) += coresight-cpu-debug.o
>> > diff --git a/drivers/hwtracing/coresight/coresight-cpu-debug.c b/drivers/hwtracing/coresight/coresight-cpu-debug.c
>> > new file mode 100644
>> > index 0000000..8470e31
>> > --- /dev/null
>> > +++ b/drivers/hwtracing/coresight/coresight-cpu-debug.c
>> > @@ -0,0 +1,667 @@
>> > +/*
>> > + * Copyright (c) 2017 Linaro Limited. All rights reserved.
>> > + *
>> > + * Author: Leo Yan <leo.yan@linaro.org>
>> > + *
>> > + * This program is free software; you can redistribute it and/or modify it
>> > + * under the terms of the GNU General Public License version 2 as published by
>> > + * the Free Software Foundation.
>> > + *
>> > + * This program is distributed in the hope that it will be useful, but WITHOUT
>> > + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
>> > + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
>> > + * more details.
>> > + *
>> > + * You should have received a copy of the GNU General Public License along with
>> > + * this program.  If not, see <http://www.gnu.org/licenses/>.
>> > + *
>> > + */
>> > +#include <linux/amba/bus.h>
>> > +#include <linux/coresight.h>
>> > +#include <linux/cpu.h>
>> > +#include <linux/debugfs.h>
>> > +#include <linux/delay.h>
>> > +#include <linux/device.h>
>> > +#include <linux/err.h>
>> > +#include <linux/init.h>
>> > +#include <linux/io.h>
>> > +#include <linux/iopoll.h>
>> > +#include <linux/kernel.h>
>> > +#include <linux/module.h>
>> > +#include <linux/moduleparam.h>
>> > +#include <linux/pm_qos.h>
>> > +#include <linux/slab.h>
>> > +#include <linux/smp.h>
>> > +#include <linux/types.h>
>> > +#include <linux/uaccess.h>
>> > +
>> > +#include "coresight-priv.h"
>> > +
>> > +#define EDPCSR                             0x0A0
>> > +#define EDCIDSR                            0x0A4
>> > +#define EDVIDSR                            0x0A8
>> > +#define EDPCSR_HI                  0x0AC
>> > +#define EDOSLAR                            0x300
>> > +#define EDPRCR                             0x310
>> > +#define EDPRSR                             0x314
>> > +#define EDDEVID1                   0xFC4
>> > +#define EDDEVID                            0xFC8
>> > +
>> > +#define EDPCSR_PROHIBITED          0xFFFFFFFF
>> > +
>> > +/* bits definition for EDPCSR */
>> > +#define EDPCSR_THUMB                       BIT(0)
>> > +#define EDPCSR_ARM_INST_MASK               GENMASK(31, 2)
>> > +#define EDPCSR_THUMB_INST_MASK             GENMASK(31, 1)
>> > +
>> > +/* bits definition for EDPRCR */
>> > +#define EDPRCR_COREPURQ                    BIT(3)
>> > +#define EDPRCR_CORENPDRQ           BIT(0)
>> > +
>> > +/* bits definition for EDPRSR */
>> > +#define EDPRSR_DLK                 BIT(6)
>> > +#define EDPRSR_PU                  BIT(0)
>> > +
>> > +/* bits definition for EDVIDSR */
>> > +#define EDVIDSR_NS                 BIT(31)
>> > +#define EDVIDSR_E2                 BIT(30)
>> > +#define EDVIDSR_E3                 BIT(29)
>> > +#define EDVIDSR_HV                 BIT(28)
>> > +#define EDVIDSR_VMID                       GENMASK(7, 0)
>> > +
>> > +/*
>> > + * bits definition for EDDEVID1:PSCROffset
>> > + *
>> > + * NOTE: armv8 and armv7 have different definition for the register,
>> > + * so consolidate the bits definition as below:
>> > + *
>> > + * 0b0000 - Sample offset applies based on the instruction state, we
>> > + *          rely on EDDEVID to check if EDPCSR is implemented or not
>> > + * 0b0001 - No offset applies.
>> > + * 0b0010 - No offset applies, but do not use in AArch32 mode
>> > + *
>> > + */
>> > +#define EDDEVID1_PCSR_OFFSET_MASK  GENMASK(3, 0)
>> > +#define EDDEVID1_PCSR_OFFSET_INS_SET       (0x0)
>> > +#define EDDEVID1_PCSR_NO_OFFSET_DIS_AARCH32        (0x2)
>> > +
>> > +/* bits definition for EDDEVID */
>> > +#define EDDEVID_PCSAMPLE_MODE              GENMASK(3, 0)
>> > +#define EDDEVID_IMPL_EDPCSR                (0x1)
>> > +#define EDDEVID_IMPL_EDPCSR_EDCIDSR        (0x2)
>> > +#define EDDEVID_IMPL_FULL          (0x3)
>> > +
>> > +#define DEBUG_WAIT_SLEEP           1000
>> > +#define DEBUG_WAIT_TIMEOUT         32000
>> > +
>> > +struct debug_drvdata {
>> > +   void __iomem    *base;
>> > e   struct device   *dev;
>> > +   int             cpu;
>> > +
>> > +   bool            edpcsr_present;
>> > +   bool            edcidsr_present;
>> > +   bool            edvidsr_present;
>> > +   bool            pc_has_offset;
>> > +
>> > +   u32             edpcsr;
>> > +   u32             edpcsr_hi;
>> > +   u32             edprsr;
>> > +   u32             edvidsr;
>> > +   u32             edcidsr;
>> > +};
>> > +
>> > +static DEFINE_MUTEX(debug_lock);
>> > +static DEFINE_PER_CPU(struct debug_drvdata *, debug_drvdata);
>> > +static int debug_count;
>> > +static struct dentry *debug_debugfs_dir;
>> > +
>> > +static bool debug_enable;
>> > +module_param_named(enable, debug_enable, bool, 0600);
>> > +MODULE_PARM_DESC(enable, "Knob to enable debug functionality "
>> > +            "(default is 0, which means is disabled by default)");
>>
>> For this driver we have a debugFS interface so I question the validity of a
>> kernel module parameter.  Other than adding complexity to the code it offers no
>> real added value.  If a user is to insmod a module, it is just as easy to switch
>> on the functionality using debugFS in a second step.
>
> This module parameter can be used for kernel command line, so
> it's useful when user wants to dynamically turn on/off the
> functionality at boot up time.
>
> Does this make sense for you? Removing this parameter is okay for
> me, but this means users need to decide if use it by Kernel config
> with static building in. This is a bit contradictory with before's
> discussion.

My hope was to use the kernel command line and the debugFS interface,
avoiding the module parameter.  Look at what the baycom_par and
blacklist drivers are doing with the "__setup()" function and see if
we can void a module parameter.  If not then let it be, unless someone
else has a better idea.

[1]. drivers/net/hamradio/baycom_par.c
[2]. drivers/se90/cio/blacklist.c

>
>> > +static void debug_os_unlock(struct debug_drvdata *drvdata)
>> > +{
>> > +   /* Unlocks the debug registers */
>> > +   writel_relaxed(0x0, drvdata->base + EDOSLAR);
>>
>> Here the wmb is to make sure reordering (either at compile time or in the CPU)
>> doesn't happend.  You need a comment here otherwise checkpatch will complain.
>> Speaking of which, did you run this through checkpatch?
>
> Right. Everytime I run checkpatch before sending patch and it has
> complain for this. Will add comment. Sorry for imprecise working.
>
>> > +   wmb();
>> > +}
>> > +
>> > +/*
>> > + * According to ARM DDI 0487A.k, before access external debug
>> > + * registers should firstly check the access permission; if any
>> > + * below condition has been met then cannot access debug
>> > + * registers to avoid lockup issue:
>> > + *
>> > + * - CPU power domain is powered off;
>> > + * - The OS Double Lock is locked;
>> > + *
>> > + * By checking EDPRSR can get to know if meet these conditions.
>> > + */
>> > +static bool debug_access_permitted(struct debug_drvdata *drvdata)
>> > +{
>> > +   /* CPU is powered off */
>> > +   if (!(drvdata->edprsr & EDPRSR_PU))
>> > +           return false;
>> > +
>> > +   /* The OS Double Lock is locked */
>> > +   if (drvdata->edprsr & EDPRSR_DLK)
>> > +           return false;
>> > +
>> > +   return true;
>> > +}
>> > +
>> > +static void debug_force_cpu_powered_up(struct debug_drvdata *drvdata)
>> > +{
>> > +   bool retried = false;
>> > +   u32 edprcr;
>> > +
>> > +try_again:
>> > +
>> > +   /*
>> > +    * Send request to power management controller and assert
>> > +    * DBGPWRUPREQ signal; if power management controller has
>> > +    * sane implementation, it should enable CPU power domain
>> > +    * in case CPU is in low power state.
>> > +    */
>> > +   edprcr = readl_relaxed(drvdata->base + EDPRCR);
>> > +   edprcr |= EDPRCR_COREPURQ;
>> > +   writel_relaxed(edprcr, drvdata->base + EDPRCR);
>> > +
>> > +   /* Wait for CPU to be powered up (timeout~=32ms) */
>> > +   if (readx_poll_timeout_atomic(readl_relaxed, drvdata->base + EDPRSR,
>> > +                   drvdata->edprsr, (drvdata->edprsr & EDPRSR_PU),
>> > +                   DEBUG_WAIT_SLEEP, DEBUG_WAIT_TIMEOUT)) {
>> > +           /*
>> > +            * Unfortunately the CPU cannot be powered up, so return
>> > +            * back and later has no permission to access other
>> > +            * registers. For this case, should disable CPU low power
>> > +            * states to ensure CPU power domain is enabled!
>> > +            */
>> > +           pr_err("%s: power up request for CPU%d failed\n",
>> > +                   __func__, drvdata->cpu);
>> > +           return;
>> > +   }
>> > +
>> > +   /*
>> > +    * At this point the CPU is powered up, so set the no powerdown
>> > +    * request bit so we don't lose power and emulate power down.
>> > +    */
>> > +   edprcr = readl_relaxed(drvdata->base + EDPRCR);
>> > +   edprcr |= EDPRCR_COREPURQ | EDPRCR_CORENPDRQ;
>> > +   writel_relaxed(edprcr, drvdata->base + EDPRCR);
>> > +
>> > +   drvdata->edprsr = readl_relaxed(drvdata->base + EDPRSR);
>> > +
>> > +   /* Bail out if CPU is powered up */
>> > +   if (likely(drvdata->edprsr & EDPRSR_PU))
>> > +           return;
>>
>>         /* The core power domain got switched off on use, try again */
>>         if (unlikely(!drvdata->edprsr & EDPRSR_PU))
>>                 goto try_again;
>>
>> I understand you don't want to introduce a infinite loop but if that happens
>> here, something else has gone very wrong.  The above readx_poll_timeout_atomic
>> loop should take care of bailing out in case of problems.  That way you also get
>> to rid of the retried variable and the code is more simple.
>
> Okay. I will follow your method. Thinking the duration of CPU power
> on/off is not same magnitude with this piece code, the infinite loop
> will not happen.
>
>> > +
>> > +   /*
>> > +    * Handle race condition if CPU has been waken up but it sleeps
>> > +    * again if EDPRCR_CORENPDRQ has been flipped, so try to run
>> > +    * waken flow one more time.
>> > +    */
>> > +   if (!retried) {
>> > +           retried = true;
>> > +           goto try_again;
>> > +   }
>> > +}
>> > +
>> > +static void debug_read_regs(struct debug_drvdata *drvdata)
>> > +{
>> > +   u32 save_edprcr;
>> > +
>> > +   CS_UNLOCK(drvdata->base);
>> > +
>> > +   /* Unlock os lock */
>> > +   debug_os_unlock(drvdata);
>> > +
>> > +   /* Save EDPRCR register */
>> > +   save_edprcr = readl_relaxed(drvdata->base + EDPRCR);
>> > +
>> > +   /*
>> > +    * Ensure CPU power domain is enabled to let registers
>> > +    * are accessiable.
>> > +    */
>> > +   debug_force_cpu_powered_up(drvdata);
>> > +
>> > +   if (!debug_access_permitted(drvdata))
>> > +           goto out;
>> > +
>> > +   drvdata->edpcsr = readl_relaxed(drvdata->base + EDPCSR);
>> > +
>> > +   /*
>> > +    * As described in ARM DDI 0487A.k, if the processing
>> > +    * element (PE) is in debug state, or sample-based
>> > +    * profiling is prohibited, EDPCSR reads as 0xFFFFFFFF;
>> > +    * EDCIDSR, EDVIDSR and EDPCSR_HI registers also become
>> > +    * UNKNOWN state. So directly bail out for this case.
>> > +    */
>> > +   if (drvdata->edpcsr == EDPCSR_PROHIBITED)
>> > +           goto out;
>> > +
>> > +   /*
>> > +    * A read of the EDPCSR normally has the side-effect of
>> > +    * indirectly writing to EDCIDSR, EDVIDSR and EDPCSR_HI;
>> > +    * at this point it's safe to read value from them.
>> > +    */
>> > +   if (IS_ENABLED(CONFIG_64BIT))
>> > +           drvdata->edpcsr_hi = readl_relaxed(drvdata->base + EDPCSR_HI);
>> > +
>> > +   if (drvdata->edcidsr_present)
>> > +           drvdata->edcidsr = readl_relaxed(drvdata->base + EDCIDSR);
>> > +
>> > +   if (drvdata->edvidsr_present)
>> > +           drvdata->edvidsr = readl_relaxed(drvdata->base + EDVIDSR);
>> > +
>> > +out:
>> > +   /* Restore EDPRCR register */
>> > +   writel_relaxed(save_edprcr, drvdata->base + EDPRCR);
>> > +
>> > +   CS_LOCK(drvdata->base);
>> > +}
>> > +
>> > +static unsigned long debug_adjust_pc(struct debug_drvdata *drvdata)
>> > +{
>> > +   unsigned long arm_inst_offset = 0, thumb_inst_offset = 0;
>> > +   unsigned long pc;
>> > +
>> > +   if (IS_ENABLED(CONFIG_64BIT))
>> > +           return (unsigned long)drvdata->edpcsr_hi << 32 |
>> > +                  (unsigned long)drvdata->edpcsr;
>> > +
>> > +   pc = (unsigned long)drvdata->edpcsr;
>> > +
>> > +   if (drvdata->pc_has_offset) {
>> > +           arm_inst_offset = 8;
>> > +           thumb_inst_offset = 4;
>> > +   }
>> > +
>> > +   /* Handle thumb instruction */
>> > +   if (pc & EDPCSR_THUMB) {
>> > +           pc = (pc & EDPCSR_THUMB_INST_MASK) - thumb_inst_offset;
>> > +           return pc;
>> > +   }
>> > +
>> > +   /*
>> > +    * Handle arm instruction offset, if the arm instruction
>> > +    * is not 4 byte alignment then it's possible the case
>> > +    * for implementation defined; keep original value for this
>> > +    * case and print info for notice.
>> > +    */
>> > +   if (pc & BIT(1))
>> > +           pr_emerg("Instruction offset is implementation defined\n");
>> > +   else
>> > +           pc = (pc & EDPCSR_ARM_INST_MASK) - arm_inst_offset;
>> > +
>> > +   return pc;
>> > +}
>> > +
>> > +static void debug_dump_regs(struct debug_drvdata *drvdata)
>> > +{
>> > +   unsigned long pc;
>> > +
>> > +   pr_emerg("\tEDPRSR:  %08x (Power:%s DLK:%s)\n", drvdata->edprsr,
>> > +            drvdata->edprsr & EDPRSR_PU ? "On" : "Off",
>> > +            drvdata->edprsr & EDPRSR_DLK ? "Lock" : "Unlock");
>> > +
>> > +   if (!debug_access_permitted(drvdata)) {
>> > +           pr_emerg("No permission to access debug registers!\n");
>> > +           return;
>> > +   }
>> > +
>> > +   if (drvdata->edpcsr == EDPCSR_PROHIBITED) {
>> > +           pr_emerg("CPU is in Debug state or profiling is prohibited!\n");
>> > +           return;
>> > +   }
>> > +
>> > +   pc = debug_adjust_pc(drvdata);
>> > +   pr_emerg("\tEDPCSR:  [<%p>] %pS\n", (void *)pc, (void *)pc);
>> > +
>> > +   if (drvdata->edcidsr_present)
>> > +           pr_emerg("\tEDCIDSR: %08x\n", drvdata->edcidsr);
>> > +
>> > +   if (drvdata->edvidsr_present)
>> > +           pr_emerg("\tEDVIDSR: %08x (State:%s Mode:%s Width:%dbits VMID:%x)\n",
>> > +                    drvdata->edvidsr,
>> > +                    drvdata->edvidsr & EDVIDSR_NS ? "Non-secure" : "Secure",
>> > +                    drvdata->edvidsr & EDVIDSR_E3 ? "EL3" :
>> > +                           (drvdata->edvidsr & EDVIDSR_E2 ? "EL2" : "EL1/0"),
>> > +                    drvdata->edvidsr & EDVIDSR_HV ? 64 : 32,
>> > +                    drvdata->edvidsr & (u32)EDVIDSR_VMID);
>> > +}
>> > +
>> > +static void debug_init_arch_data(void *info)
>> > +{
>> > +   struct debug_drvdata *drvdata = info;
>> > +   u32 mode, pcsr_offset;
>> > +   u32 eddevid, eddevid1;
>> > +
>> > +   CS_UNLOCK(drvdata->base);
>> > +
>> > +   /* Read device info */
>> > +   eddevid  = readl_relaxed(drvdata->base + EDDEVID);
>> > +   eddevid1 = readl_relaxed(drvdata->base + EDDEVID1);
>> > +
>> > +   CS_LOCK(drvdata->base);
>> > +
>> > +   /* Parse implementation feature */
>> > +   mode = eddevid & EDDEVID_PCSAMPLE_MODE;
>> > +   pcsr_offset = eddevid1 & EDDEVID1_PCSR_OFFSET_MASK;
>> > +
>> > +   drvdata->edpcsr_present  = false;
>> > +   drvdata->edcidsr_present = false;
>> > +   drvdata->edvidsr_present = false;
>> > +   drvdata->pc_has_offset   = false;
>> > +
>> > +   switch (mode) {
>> > +   case EDDEVID_IMPL_FULL:
>> > +           drvdata->edvidsr_present = true;
>> > +           /* Fall through */
>> > +   case EDDEVID_IMPL_EDPCSR_EDCIDSR:
>> > +           drvdata->edcidsr_present = true;
>> > +           /* Fall through */
>> > +   case EDDEVID_IMPL_EDPCSR:
>> > +           /*
>> > +            * In ARM DDI 0487A.k, the EDDEVID1.PCSROffset is used to
>> > +            * define if has the offset for PC sampling value; if read
>> > +            * back EDDEVID1.PCSROffset == 0x2, then this means the debug
>> > +            * module does not sample the instruction set state when
>> > +            * armv8 CPU in AArch32 state.
>> > +            */
>> > +           drvdata->edpcsr_present = (IS_ENABLED(CONFIG_64BIT) ||
>> > +                   (pcsr_offset != EDDEVID1_PCSR_NO_OFFSET_DIS_AARCH32));
>> > +
>> > +           drvdata->pc_has_offset =
>> > +                   (pcsr_offset == EDDEVID1_PCSR_OFFSET_INS_SET);
>> > +           break;
>> > +   default:
>> > +           break;
>> > +   }
>> > +}
>> > +
>> > +/*
>> > + * Dump out information on panic.
>> > + */
>> > +static int debug_notifier_call(struct notifier_block *self,
>> > +                          unsigned long v, void *p)
>> > +{
>> > +   int cpu;
>> > +   struct debug_drvdata *drvdata;
>> > +
>> > +   pr_emerg("ARM external debug module:\n");
>> > +
>> > +   for_each_possible_cpu(cpu) {
>> > +           drvdata = per_cpu(debug_drvdata, cpu);
>> > +           if (!drvdata)
>> > +                   continue;
>> > +
>> > +           pr_emerg("CPU[%d]:\n", drvdata->cpu);
>> > +
>> > +           debug_read_regs(drvdata);
>> > +           debug_dump_regs(drvdata);
>> > +   }
>> > +
>> > +   return 0;
>> > +}
>> > +
>> > +static struct notifier_block debug_notifier = {
>> > +   .notifier_call = debug_notifier_call,
>> > +};
>> > +
>> > +static int debug_enable_func(void)
>> > +{
>> > +   struct debug_drvdata *drvdata;
>> > +   int cpu;
>> > +
>> > +   for_each_possible_cpu(cpu) {
>> > +           drvdata = per_cpu(debug_drvdata, cpu);
>> > +           if (!drvdata)
>> > +                   continue;
>> > +
>> > +           pm_runtime_get_sync(drvdata->dev);
>> > +   }
>> > +
>> > +   return atomic_notifier_chain_register(&panic_notifier_list,
>> > +                                         &debug_notifier);
>> > +}
>> > +
>> > +static int debug_disable_func(void)
>> > +{
>> > +   struct debug_drvdata *drvdata;
>> > +   int cpu;
>> > +
>> > +   for_each_possible_cpu(cpu) {
>> > +           drvdata = per_cpu(debug_drvdata, cpu);
>> > +           if (!drvdata)
>> > +                   continue;
>> > +
>> > +           pm_runtime_put(drvdata->dev);
>> > +   }
>> > +
>> > +   return atomic_notifier_chain_unregister(&panic_notifier_list,
>> > +                                           &debug_notifier);
>> > +}
>> > +
>> > +static ssize_t debug_func_knob_write(struct file *f,
>> > +           const char __user *buf, size_t count, loff_t *ppos)
>> > +{
>> > +   u8 val;
>> > +   int ret;
>> > +
>> > +   ret = kstrtou8_from_user(buf, count, 2, &val);
>> > +   if (ret)
>> > +           return ret;
>> > +
>> > +   mutex_lock(&debug_lock);
>> > +
>> > +   if (val == debug_enable)
>> > +           goto out;
>> > +
>> > +   if (val)
>> > +           ret = debug_enable_func();
>> > +   else
>> > +           ret = debug_disable_func();
>>
>> I don't think you need to install the handler every time the functionality is
>> switched on/off.  I suggest to install the handler at boot time (or module
>> insertion time) and in the notifier handler, check the debug_enable flag before
>> moving on with the output.
>
> Will do.
>
>> > +
>> > +   if (ret) {
>> > +           pr_err("%s: unable to %s debug function: %d\n",
>> > +                  __func__, val ? "enable" : "disable", ret);
>> > +           goto err;
>> > +   }
>> > +
>> > +   debug_enable = val;
>>
>> Using a true/false value is probably better here.  That way you don't end up
>> with miscellaneous values in debugFS.
>
> From my testing here will not assign other values rather than 0 or 1.
> This is controlled by function kstrtou8_from_user(), the 3rd parameter
> '2' is to define the value range [0..1], so other values will report
> error after return back from kstrtou8_from_user().

Ok that works.

>
>> > +out:
>> > +   ret = count;
>> > +err:
>> > +   mutex_unlock(&debug_lock);
>> > +   return ret;
>> > +}
>> > +
>> > +static ssize_t debug_func_knob_read(struct file *f,
>> > +           char __user *ubuf, size_t count, loff_t *ppos)
>> > +{
>> > +   ssize_t ret;
>> > +   char buf[2];
>> > +
>> > +   mutex_lock(&debug_lock);
>> > +
>> > +   buf[0] = '0' + debug_enable;
>> > +   buf[1] = '\n';
>>
>>         snprintf()
>
> Will fix.
>
>> > +   ret = simple_read_from_buffer(ubuf, count, ppos, buf, sizeof(buf));
>> > +
>> > +   mutex_unlock(&debug_lock);
>> > +   return ret;
>> > +}
>> > +
>> > +static const struct file_operations debug_func_knob_fops = {
>> > +   .open   = simple_open,
>> > +   .read   = debug_func_knob_read,
>> > +   .write  = debug_func_knob_write,
>> > +};
>> > +
>> > +static int debug_func_init(void)
>> > +{
>> > +   struct dentry *file;
>> > +   int ret;
>> > +
>> > +   /* Create debugfs node */
>> > +   debug_debugfs_dir = debugfs_create_dir("coresight_cpu_debug", NULL);
>> > +   if (!debug_debugfs_dir) {
>> > +           pr_err("%s: unable to create debugfs directory\n", __func__);
>> > +           return -ENOMEM;
>> > +   }
>> > +
>> > +   file = debugfs_create_file("enable", S_IRUGO | S_IWUSR,
>> > +                   debug_debugfs_dir, NULL, &debug_func_knob_fops);
>>
>> Please align this properly.
>
> Will fix. Thanks a lot for detailed reviewing.
>
> [...]
>
> Thanks,
> Leo Yan
