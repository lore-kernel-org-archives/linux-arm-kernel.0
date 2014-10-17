From: jingchang.lu@freescale.com (Jingchang Lu)
Date: Fri, 17 Oct 2014 10:10:38 +0000
Subject: [PATCHv5 6/6] ARM: imx: Add Freescale LS1021A SMP support
In-Reply-To: <993EF472-33A7-48BD-A4CD-15B361D53365@codeaurora.org>
References: <1413192963-11153-1-git-send-email-jingchang.lu@freescale.com>
 <1413192963-11153-7-git-send-email-jingchang.lu@freescale.com>
 <993EF472-33A7-48BD-A4CD-15B361D53365@codeaurora.org>
Message-ID: <1e98bf0f1f2347ed8f02138816061cdc@BL2PR03MB467.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



>-----Original Message-----
>From: Kumar Gala [mailto:galak at codeaurora.org]
>Sent: Thursday, October 16, 2014 10:31 PM
>To: Lu Jingchang-B35083
>Cc: shawn.guo at linaro.org; mark.rutland at arm.com; devicetree at vger.kernel.org;
>Lu Jingchang-B35083; linux-arm-kernel at lists.infradead.org; arnd at arndb.de
>Subject: Re: [PATCHv5 6/6] ARM: imx: Add Freescale LS1021A SMP support
>
>
>On Oct 13, 2014, at 11:36 AM, Jingchang Lu <jingchang.lu@freescale.com>
>wrote:
>
>> From: Jingchang Lu <b35083@freescale.com>
>>
>> Freescale LS1021A SoCs deploy two cortex-A7 processors, this adds
>> bring-up support for the secondary core.
>>
>> Signed-off-by: Jingchang Lu <b35083@freescale.com>
>> ---
>> arch/arm/mach-imx/Makefile       |  2 +-
>> arch/arm/mach-imx/common.h       |  1 +
>> arch/arm/mach-imx/mach-ls1021a.c |  1 +
>> arch/arm/mach-imx/platsmp.c      | 32 ++++++++++++++++++++++++++++++++
>> 4 files changed, 35 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
>> index ce137bc..38d75e2 100644
>> --- a/arch/arm/mach-imx/Makefile
>> +++ b/arch/arm/mach-imx/Makefile
>> @@ -89,7 +89,7 @@ obj-$(CONFIG_HAVE_IMX_ANATOP) += anatop.o
>> obj-$(CONFIG_HAVE_IMX_GPC) += gpc.o
>> obj-$(CONFIG_HAVE_IMX_MMDC) += mmdc.o
>> obj-$(CONFIG_HAVE_IMX_SRC) += src.o
>> -ifdef CONFIG_SOC_IMX6
>> +ifneq ($(CONFIG_SOC_IMX6)$(CONFIG_SOC_LS1021A),)
>> AFLAGS_headsmp.o :=-Wa,-march=armv7-a
>> obj-$(CONFIG_SMP) += headsmp.o platsmp.o
>> obj-$(CONFIG_HOTPLUG_CPU) += hotplug.o diff --git
>> a/arch/arm/mach-imx/common.h b/arch/arm/mach-imx/common.h index
>> 1dabf43..c473ca5 100644
>> --- a/arch/arm/mach-imx/common.h
>> +++ b/arch/arm/mach-imx/common.h
>> @@ -157,5 +157,6 @@ static inline void imx_init_l2cache(void) {}
>> #endif
>>
>> extern struct smp_operations imx_smp_ops;
>> +extern struct smp_operations ls1021a_smp_ops;
>>
>> #endif
>> diff --git a/arch/arm/mach-imx/mach-ls1021a.c
>> b/arch/arm/mach-imx/mach-ls1021a.c
>> index 9d2034b..b89c858 100644
>> --- a/arch/arm/mach-imx/mach-ls1021a.c
>> +++ b/arch/arm/mach-imx/mach-ls1021a.c
>> @@ -17,5 +17,6 @@ static const char * const ls1021a_dt_compat[]
>> __initconst = { };
>>
>> DT_MACHINE_START(LS1021A, "Freescale LS1021A")
>> +	.smp		= smp_ops(ls1021a_smp_ops),
>> 	.dt_compat	= ls1021a_dt_compat,
>> MACHINE_END
>> diff --git a/arch/arm/mach-imx/platsmp.c b/arch/arm/mach-imx/platsmp.c
>> index 771bd25..69b87ca 100644
>> --- a/arch/arm/mach-imx/platsmp.c
>> +++ b/arch/arm/mach-imx/platsmp.c
>> @@ -16,6 +16,8 @@
>> #include <asm/page.h>
>> #include <asm/smp_scu.h>
>> #include <asm/mach/map.h>
>> +#include <linux/of_address.h>
>> +#include <linux/of.h>
>>
>> #include "common.h"
>> #include "hardware.h"
>> @@ -94,3 +96,33 @@ struct smp_operations  imx_smp_ops __initdata = {
>> 	.cpu_kill		= imx_cpu_kill,
>> #endif
>> };
>> +
>> +#define DCFG_CCSR_SCRATCHRW1	0x200
>> +
>> +static int ls1021a_boot_secondary(unsigned int cpu, struct
>> +task_struct *idle) {
>> +	arch_send_wakeup_ipi_mask(cpumask_of(cpu));
>> +
>> +	return 0;
>> +}
>> +
>> +static void __init ls1021a_smp_prepare_cpus(unsigned int max_cpus) {
>> +	struct device_node *np;
>> +	void __iomem *dcfg_base;
>> +	unsigned long paddr;
>> +
>> +	np = of_find_compatible_node(NULL, NULL, "fsl,ls1021a-dcfg");
>> +	dcfg_base = of_iomap(np, 0);
>> +	BUG_ON(!dcfg_base);
>> +
>> +	paddr = virt_to_phys(secondary_startup);
>> +	writel_relaxed(cpu_to_be32(paddr), dcfg_base +
>> +DCFG_CCSR_SCRATCHRW1);
>> +
>
>This seems odd, why are we writing the startup address to
>DCFG_CCSR_SCRATCHRW1?
It is the secondary cpu's executing address for smp kernel image, 
the secondary cpu will jump to this address after wakeup during
the smp initialization. Thanks.

Best Regards,
Jingchang
