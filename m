From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 30 Mar 2017 16:56:52 +0100
Subject: [PATCH v5 6/9] coresight: add support for CPU debug module
In-Reply-To: <1490466197-29163-7-git-send-email-leo.yan@linaro.org>
References: <1490466197-29163-1-git-send-email-leo.yan@linaro.org>
 <1490466197-29163-7-git-send-email-leo.yan@linaro.org>
Message-ID: <f0c460e2-4e49-4f34-5288-f20a519dc182@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 25/03/17 18:23, Leo Yan wrote:
> Coresight includes debug module and usually the module connects with CPU
> debug logic. ARMv8 architecture reference manual (ARM DDI 0487A.k) has
> description for related info in "Part H: External Debug".
> 
> Chapter H7 "The Sample-based Profiling Extension" introduces several
> sampling registers, e.g. we can check program counter value with
> combined CPU exception level, secure state, etc. So this is helpful for
> analysis CPU lockup scenarios, e.g. if one CPU has run into infinite
> loop with IRQ disabled. In this case the CPU cannot switch context and
> handle any interrupt (including IPIs), as the result it cannot handle
> SMP call for stack dump.
> 
> This patch is to enable coresight debug module, so firstly this driver
> is to bind apb clock for debug module and this is to ensure the debug
> module can be accessed from program or external debugger. And the driver
> uses sample-based registers for debug purpose, e.g. when system triggers
> panic, the driver will dump program counter and combined context
> registers (EDCIDSR, EDVIDSR); by parsing context registers so can
> quickly get to know CPU secure state, exception level, etc.
> 
> Some of the debug module registers are located in CPU power domain, so
> this requires the CPU power domain stays on when access related debug
> registers, but the power management for CPU power domain is quite
> dependent on SoC integration for power management. For the platforms
> which with sane power controller implementations, this driver follows
> the method to set EDPRCR to try to pull the CPU out of low power state
> and then set 'no power down request' bit so the CPU has no chance to
> lose power.
> 
> If the SoC has not followed up this design well for power management
> controller, the driver introduces module parameter "idle_constraint".
> Setting this parameter for latency requirement in microseconds, finally
> we can constrain all or partial idle states to ensure the CPU power
> domain is enabled, this is a backup method to access coresight CPU
> debug component safely.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  drivers/hwtracing/coresight/Kconfig               |  11 +
>  drivers/hwtracing/coresight/Makefile              |   1 +
>  drivers/hwtracing/coresight/coresight-cpu-debug.c | 704 ++++++++++++++++++++++
>  3 files changed, 716 insertions(+)
>  create mode 100644 drivers/hwtracing/coresight/coresight-cpu-debug.c
> 
> diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
> index 130cb21..18d7931 100644
> --- a/drivers/hwtracing/coresight/Kconfig
> +++ b/drivers/hwtracing/coresight/Kconfig
> @@ -89,4 +89,15 @@ config CORESIGHT_STM
>  	  logging useful software events or data coming from various entities
>  	  in the system, possibly running different OSs
>  
> +config CORESIGHT_CPU_DEBUG
> +	tristate "CoreSight CPU Debug driver"
> +	depends on ARM || ARM64
> +	depends on DEBUG_FS
> +	help
> +	  This driver provides support for coresight debugging module. This
> +	  is primarily used to dump sample-based profiling registers when
> +	  system triggers panic, the driver will parse context registers so
> +	  can quickly get to know program counter (PC), secure state,
> +	  exception level, etc.
> +
>  endif
> diff --git a/drivers/hwtracing/coresight/Makefile b/drivers/hwtracing/coresight/Makefile
> index af480d9..433d590 100644
> --- a/drivers/hwtracing/coresight/Makefile
> +++ b/drivers/hwtracing/coresight/Makefile
> @@ -16,3 +16,4 @@ obj-$(CONFIG_CORESIGHT_SOURCE_ETM4X) += coresight-etm4x.o \
>  					coresight-etm4x-sysfs.o
>  obj-$(CONFIG_CORESIGHT_QCOM_REPLICATOR) += coresight-replicator-qcom.o
>  obj-$(CONFIG_CORESIGHT_STM) += coresight-stm.o
> +obj-$(CONFIG_CORESIGHT_CPU_DEBUG) += coresight-cpu-debug.o
> diff --git a/drivers/hwtracing/coresight/coresight-cpu-debug.c b/drivers/hwtracing/coresight/coresight-cpu-debug.c
> new file mode 100644
> index 0000000..fbec1d1
> --- /dev/null
> +++ b/drivers/hwtracing/coresight/coresight-cpu-debug.c
> @@ -0,0 +1,704 @@
> +/*
> + * Copyright (c) 2017 Linaro Limited. All rights reserved.
> + *
> + * Author: Leo Yan <leo.yan@linaro.org>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published by
> + * the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License along with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + *
> + */
> +#include <linux/amba/bus.h>
> +#include <linux/coresight.h>
> +#include <linux/cpu.h>
> +#include <linux/debugfs.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/moduleparam.h>
> +#include <linux/pm_qos.h>
> +#include <linux/slab.h>
> +#include <linux/smp.h>
> +#include <linux/types.h>
> +#include <linux/uaccess.h>
> +
> +#include "coresight-priv.h"
> +
> +#define EDPCSR				0x0A0
> +#define EDCIDSR				0x0A4
> +#define EDVIDSR				0x0A8
> +#define EDPCSR_HI			0x0AC
> +#define EDOSLAR				0x300
> +#define EDPRCR				0x310
> +#define EDPRSR				0x314
> +#define EDDEVID1			0xFC4
> +#define EDDEVID				0xFC8
> +
> +#define EDPCSR_PROHIBITED		0xFFFFFFFF
> +
> +/* bits definition for EDPCSR */
> +#ifndef CONFIG_64BIT
> +#define EDPCSR_THUMB			BIT(0)
> +#define EDPCSR_ARM_INST_MASK		GENMASK(31, 2)
> +#define EDPCSR_THUMB_INST_MASK		GENMASK(31, 1)
> +#endif
> +
> +/* bits definition for EDPRCR */
> +#define EDPRCR_COREPURQ			BIT(3)
> +#define EDPRCR_CORENPDRQ		BIT(0)
> +
> +/* bits definition for EDPRSR */
> +#define EDPRSR_DLK			BIT(6)
> +#define EDPRSR_PU			BIT(0)
> +
> +/* bits definition for EDVIDSR */
> +#define EDVIDSR_NS			BIT(31)
> +#define EDVIDSR_E2			BIT(30)
> +#define EDVIDSR_E3			BIT(29)
> +#define EDVIDSR_HV			BIT(28)
> +#define EDVIDSR_VMID			GENMASK(7, 0)
> +
> +/*
> + * bits definition for EDDEVID1:PSCROffset
> + *
> + * NOTE: armv8 and armv7 have different definition for the register,
> + * so consolidate the bits definition as below:
> + *
> + * 0b0000 - Sample offset applies based on the instruction state, we
> + *          rely on EDDEVID to check if EDPCSR is implemented or not
> + * 0b0001 - No offset applies.
> + * 0b0010 - No offset applies, but do not use in AArch32 mode
> + *
> + */
> +#define EDDEVID1_PCSR_OFFSET_MASK	GENMASK(3, 0)
> +#define EDDEVID1_PCSR_OFFSET_INS_SET	(0x0)
> +#define EDDEVID1_PCSR_NO_OFFSET_DIS_AARCH32	(0x2)
> +
> +/* bits definition for EDDEVID */
> +#define EDDEVID_PCSAMPLE_MODE		GENMASK(3, 0)
> +#define EDDEVID_IMPL_NONE		(0x0)
> +#define EDDEVID_IMPL_EDPCSR		(0x1)
> +#define EDDEVID_IMPL_EDPCSR_EDCIDSR	(0x2)
> +#define EDDEVID_IMPL_FULL		(0x3)
> +
> +#define DEBUG_WAIT_TIMEOUT		32
> +
> +struct debug_drvdata {
> +	void __iomem	*base;
> +	struct device	*dev;
> +	int		cpu;
> +
> +	bool		edpcsr_present;
> +	bool		edcidsr_present;
> +	bool		edvidsr_present;
> +	bool		pc_has_offset;
> +
> +	u32		eddevid;
> +	u32		eddevid1;
> +
> +	u32		edpcsr;
> +	u32		edpcsr_hi;
> +	u32		edprcr;
> +	u32		edprsr;
> +	u32		edvidsr;
> +	u32		edcidsr;
> +};
> +
> +static DEFINE_MUTEX(debug_lock);
> +static DEFINE_PER_CPU(struct debug_drvdata *, debug_drvdata);
> +static int debug_count;
> +static struct dentry *debug_debugfs_dir;
> +
> +static struct pm_qos_request debug_qos_req;
> +static int idle_constraint = PM_QOS_DEFAULT_VALUE;
> +module_param(idle_constraint, int, 0600);
> +MODULE_PARM_DESC(idle_constraint, "Latency requirement in microseconds for CPU "
> +		 "idle states (default is -1, which means have no limiation "
> +		 "to CPU idle states; 0 means disabling all idle states; user "
> +		 "can choose other platform dependent values so can disable "
> +		 "specific idle states for the platform)");
> +

NACK for this. Why you want the policy inside the driver. You can always
do that from the user-space. I have mentioned it several times now.
What can't you do these ?

1. echo "what_ever_latency_you_need_in_uS" > /dev/cpu_dma_latency
2. echo 1 > /sys/devices/system/cpu/cpu$cpu/cpuidle/state$state/disable
   (for all cpus and their states) (1) is definitely simpler way to
    disable deeper idle if latency = 0uS

You can always warn user about that when it's enabled via debugfs/sysfs

-- 
Regards,
Sudeep
