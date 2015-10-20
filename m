From: guohanjun@huawei.com (Hanjun Guo)
Date: Tue, 20 Oct 2015 10:21:28 +0800
Subject: [PATCH] EDAC: Add AMD Seattle SoC EDAC
In-Reply-To: <1445282597-18999-1-git-send-email-brijeshkumar.singh@amd.com>
References: <1445282597-18999-1-git-send-email-brijeshkumar.singh@amd.com>
Message-ID: <5625A528.1040803@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Brijesh,

On 2015/10/20 3:23, Brijesh Singh wrote:
> Add support for the AMD Seattle SoC EDAC driver.
>
> Signed-off-by: Brijesh Singh <brijeshkumar.singh@amd.com>
> ---
>  .../devicetree/bindings/edac/amd-seattle-edac.txt  |  15 +
>  drivers/edac/Kconfig                               |   6 +
>  drivers/edac/Makefile                              |   1 +
>  drivers/edac/seattle_edac.c                        | 306 +++++++++++++++++++++
>  4 files changed, 328 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/edac/amd-seattle-edac.txt
>  create mode 100644 drivers/edac/seattle_edac.c
>
>
[...]
> +config EDAC_SEATTLE
> +	tristate "AMD Seattle EDAC"
> +	depends on EDAC_MM_EDAC && ARCH_SEATTLE
> +	help
> +	  Support for error detection and correction on the
> +	  AMD Seattle SOC.
>  endif # EDAC
> diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
> index ae3c5f3..9e4f3ef 100644
> --- a/drivers/edac/Makefile
> +++ b/drivers/edac/Makefile
> @@ -68,3 +68,4 @@ obj-$(CONFIG_EDAC_OCTEON_PCI)		+= octeon_edac-pci.o
>  obj-$(CONFIG_EDAC_ALTERA_MC)		+= altera_edac.o
>  obj-$(CONFIG_EDAC_SYNOPSYS)		+= synopsys_edac.o
>  obj-$(CONFIG_EDAC_XGENE)		+= xgene_edac.o
> +obj-$(CONFIG_EDAC_SEATTLE)		+= seattle_edac.o
> diff --git a/drivers/edac/seattle_edac.c b/drivers/edac/seattle_edac.c
> new file mode 100644
> index 0000000..78101aa
> --- /dev/null
> +++ b/drivers/edac/seattle_edac.c
> @@ -0,0 +1,306 @@
> +/*
> + * AMD Seattle EDAC
> + *
> + * Copyright (c) 2015, Advanced Micro Devices
> + * Author: Brijesh Singh <brijeshkumar.singh@amd.com>
> + *
> + * The driver polls CPUMERRSR_EL1 and L2MERRSR_EL1 registers to logs the 
> + * non-fatal errors. Whereas the single bit and double bit ECC erros are 
> + * handled by firmware.
> + *
> + * This program is free software; you can redistribute  it and/or modify it
> + * under  the terms of  the GNU General  Public License as published by the
> + * Free Software Foundation;  either version 2 of the  License, or (at your
> + * option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +
> +#include "edac_core.h"
> +
> +#define EDAC_MOD_STR             "seattle_edac"
> +
> +#define CPUMERRSR_EL1_INDEX(x)   ((x) & 0x1ffff)
> +#define CPUMERRSR_EL1_BANK(x)    (((x) >> 18) & 0x1f)
> +#define CPUMERRSR_EL1_RAMID(x)   (((x) >> 24) & 0x7f)
> +#define CPUMERRSR_EL1_VALID(x)   ((x) & (1 << 31))
> +#define CPUMERRSR_EL1_REPEAT(x)  (((x) >> 32) & 0x7f)
> +#define CPUMERRSR_EL1_OTHER(x)   (((x) >> 40) & 0xff)
> +#define CPUMERRSR_EL1_FATAL(x)   ((x) & (1UL << 63))
> +
> +#define L2MERRSR_EL1_INDEX(x)    ((x) & 0x1ffff)
> +#define L2MERRSR_EL1_CPUID(x)    (((x) >> 18) & 0xf)
> +#define L2MERRSR_EL1_RAMID(x)    (((x) >> 24) & 0x7f)
> +#define L2MERRSR_EL1_VALID(x)    ((x) & (1 << 31))
> +#define L2MERRSR_EL1_REPEAT(x)   (((x) >> 32) & 0xff)
> +#define L2MERRSR_EL1_OTHER(x)    (((x) >> 40) & 0xff)
> +#define L2MERRSR_EL1_FATAL(x)    ((x) & (1UL << 63))
> +
> +struct seattle_edac {
> +	struct edac_device_ctl_info *edac_ctl;
> +};
> +
> +static inline u64 read_cpumerrsr_el1(void)
> +{
> +	u64 val;
> +
> +	asm volatile("mrs %0, s3_1_c15_c2_2" : "=r" (val));
> +	return val;
> +}
> +
> +static inline void write_cpumerrsr_el1(u64 val)
> +{
> +	asm volatile("msr s3_1_c15_c2_2, %0" :: "r" (val));
> +}
> +
> +static inline u64 read_l2merrsr_el1(void)
> +{
> +	u64 val;
> +
> +	asm volatile("mrs %0, s3_1_c15_c2_3" : "=r" (val));
> +	return val;
> +}
> +
> +static inline void write_l2merrsr_el1(u64 val)
> +{
> +	asm volatile("msr s3_1_c15_c2_3, %0" :: "r" (val));
> +}
> +
> +static void check_l2merrsr_el1_error(struct edac_device_ctl_info *edac_ctl)
> +{
> +	int fatal;
> +	int cpuid;
> +	u64 val = read_l2merrsr_el1();
> +
> +	if (!L2MERRSR_EL1_VALID(val))
> +		return;
> +
> +	fatal = L2MERRSR_EL1_FATAL(val);
> +	cpuid = L2MERRSR_EL1_CPUID(val);
> +	edac_printk(KERN_CRIT, EDAC_MOD_STR,
> +		    "CPU%d detected %s error on L2 (L2MERRSR=%#llx)!\n",
> +		    smp_processor_id(), fatal ? "fatal" : "non-fatal", val);
> +
> +	switch (L2MERRSR_EL1_RAMID(val)) {
> +	case 0x10:
> +		edac_printk(KERN_CRIT, EDAC_MOD_STR,
> +			    "L2 Tag RAM cpu %d way %d\n", cpuid / 2, cpuid % 2);
> +		break;
> +	case 0x11:
> +		edac_printk(KERN_CRIT, EDAC_MOD_STR,
> +			    "L2 Data RAM cpu %d way %d\n", cpuid / 2, cpuid % 2);
> +		break;
> +	case 0x12:
> +		edac_printk(KERN_CRIT, EDAC_MOD_STR,
> +			    "L2 Snoop tag RAM cpu %d way %d\n",
> +			    cpuid / 2, cpuid % 2);
> +		break;
> +	case 0x14:
> +		edac_printk(KERN_CRIT, EDAC_MOD_STR,
> +			    "L2 Dirty RAM cpu %d way %d\n",
> +			    cpuid / 2, cpuid % 2);
> +		break;
> +	case 0x18:
> +		edac_printk(KERN_CRIT, EDAC_MOD_STR,
> +			    "L2 inclusion RAM cpu %d way %d\n",
> +			    cpuid / 2, cpuid % 2);
> +		break;
> +	default:
> +		edac_printk(KERN_CRIT, EDAC_MOD_STR,
> +			    "unknown RAMID cpuid %d\n", cpuid);
> +		break;
> +	}
> +
> +	edac_printk(KERN_CRIT, EDAC_MOD_STR, "Repeated error count: %d\n",
> +		    (int)L2MERRSR_EL1_REPEAT(val));
> +	edac_printk(KERN_CRIT, EDAC_MOD_STR, "Other error count: %d\n",
> +		    (int)L2MERRSR_EL1_OTHER(val));
> +	if (fatal)
> +		edac_device_handle_ue(edac_ctl, smp_processor_id(), 1,
> +				      edac_ctl->name);
> +	else
> +		edac_device_handle_ce(edac_ctl, smp_processor_id(), 1,
> +				      edac_ctl->name);
> +	write_l2merrsr_el1(0);
> +}
> +
> +static void check_cpumerrsr_el1_error(struct edac_device_ctl_info *edac_ctl)
> +{
> +	int fatal;
> +	int bank;
> +	u64 val = read_cpumerrsr_el1();
> +
> +	if (!CPUMERRSR_EL1_VALID(val))
> +		return;
> +
> +	bank = CPUMERRSR_EL1_BANK(val);
> +	fatal = CPUMERRSR_EL1_FATAL(val);
> +	edac_printk(KERN_CRIT, EDAC_MOD_STR,
> +		    "CPU%d detected %s error on L1 (CPUMERRSR=%#llx)!\n",
> +		    smp_processor_id(), fatal ? "fatal" : "non-fatal", val);
> +
> +	switch (CPUMERRSR_EL1_RAMID(val)) {
> +	case 0x0:
> +		edac_printk(KERN_CRIT, EDAC_MOD_STR,
> +			    "L1-I Tag RAM bank %d\n", bank);
> +		break;
> +	case 0x1:
> +		edac_printk(KERN_CRIT, EDAC_MOD_STR,
> +			    "L1-I Data RAM bank %d\n", bank);
> +		break;
> +	case 0x8:
> +		edac_printk(KERN_CRIT, EDAC_MOD_STR,
> +			    "L1-D Tag RAM bank %d\n", bank);
> +		break;
> +	case 0x9:
> +		edac_printk(KERN_CRIT, EDAC_MOD_STR,
> +			    "L1-D Data RAM bank %d\n", bank);
> +		break;
> +	case 0x18:
> +		edac_printk(KERN_CRIT, EDAC_MOD_STR,
> +			    "L2 TLB RAM bank %d\n", bank);
> +		break;
> +	default:
> +		edac_printk(KERN_CRIT, EDAC_MOD_STR,
> +			    "unknown ramid %d bank %d\n",
> +			    (int)CPUMERRSR_EL1_RAMID(val), bank);
> +		break;
> +	}
> +
> +	edac_printk(KERN_CRIT, EDAC_MOD_STR, "Repeated error count: %d\n",
> +		    (int)CPUMERRSR_EL1_REPEAT(val));
> +	edac_printk(KERN_CRIT, EDAC_MOD_STR, "Other error count: %d\n",
> +		    (int)CPUMERRSR_EL1_OTHER(val));
> +	if (fatal)
> +		edac_device_handle_ue(edac_ctl, smp_processor_id(), 1,
> +				      edac_ctl->name);
> +	else
> +		edac_device_handle_ce(edac_ctl, smp_processor_id(), 1,
> +				      edac_ctl->name);
> +	write_cpumerrsr_el1(0);
> +}

The codes above are common for all A57 architectures, other A57 SoCs will use the same
code for L1/L2 caches error report, can we put those codes in common place and reused
for all A57 architectures?

> +
> +static void cpu_check_errors(void *args)
> +{
> +	struct edac_device_ctl_info *edev_ctl = args;
> +
> +	check_cpumerrsr_el1_error(edev_ctl);
> +	check_l2merrsr_el1_error(edev_ctl);
> +}
> +
> +static void edac_check_errors(struct edac_device_ctl_info *edev_ctl)
> +{
> +	int cpu;
> +
> +	/* read L1 and L2 memory error syndrome register on possible CPU's */
> +	for_each_possible_cpu(cpu)
> +		smp_call_function_single(cpu, cpu_check_errors, edev_ctl, 0);

Seems that error syndrome registers for L2 cache are cluster lever (each cluster share the
L2 cache, you can refer to ARM doc: DDI0488D, Cortex-A57 Technical Reference Manual),
so for L2 cache, we need to check the error at cluster lever not the cpu core lever.

Thanks
Hanjun
