From: brijeshkumar.singh@amd.com (Brijesh Singh)
Date: Thu, 22 Oct 2015 09:46:13 -0500
Subject: [PATCH v2] EDAC: Add ARM64 EDAC
In-Reply-To: <56282550.4000201@arm.com>
References: <1445460097-10260-1-git-send-email-brijeshkumar.singh@amd.com>
 <56282550.4000201@arm.com>
Message-ID: <5628F6B5.5080701@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andre,

On 10/21/2015 06:52 PM, Andre Przywara wrote:
> On 21/10/15 21:41, Brijesh Singh wrote:
>> Add support for Cortex A57 and A53 EDAC driver.
> 
> Hi Brijesh,
> 
> thanks for the quick update! Some comments below.
> 
>>
>> Signed-off-by: Brijesh Singh <brijeshkumar.singh@amd.com>
>> CC: robh+dt at kernel.org
>> CC: pawel.moll at arm.com
>> CC: mark.rutland at arm.com
>> CC: ijc+devicetree at hellion.org.uk
>> CC: galak at codeaurora.org
>> CC: dougthompson at xmission.com
>> CC: bp at alien8.de
>> CC: mchehab at osg.samsung.com
>> CC: devicetree at vger.kernel.org
>> CC: guohanjun at huawei.com
>> CC: andre.przywara at arm.com
>> CC: arnd at arndb.de
>> CC: linux-kernel at vger.kernel.org
>> CC: linux-edac at vger.kernel.org
>> ---
>>
>> v2:
>> * convert into generic arm64 edac driver
>> * remove AMD specific references from dt binding
>> * remove poll_msec property from dt binding
>> * add poll_msec as a module param, default is 100ms
>> * update copyright text
>> * define macro mnemonics for L1 and L2 RAMID
>> * check L2 error per-cluster instead of per core
>> * update function names
>> * use get_online_cpus() and put_online_cpus() to make L1 and L2 register 
>>   read hotplug-safe
>> * add error check in probe routine
>>
>>  .../devicetree/bindings/edac/armv8-edac.txt        |  15 +
>>  drivers/edac/Kconfig                               |   6 +
>>  drivers/edac/Makefile                              |   1 +
>>  drivers/edac/cortex_arm64_edac.c                   | 457 +++++++++++++++++++++
>>  4 files changed, 479 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/edac/armv8-edac.txt
>>  create mode 100644 drivers/edac/cortex_arm64_edac.c
>>
>> diff --git a/Documentation/devicetree/bindings/edac/armv8-edac.txt b/Documentation/devicetree/bindings/edac/armv8-edac.txt
>> new file mode 100644
>> index 0000000..dfd128f
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/edac/armv8-edac.txt
>> @@ -0,0 +1,15 @@
>> +* ARMv8 L1/L2 cache error reporting
>> +
>> +On ARMv8, CPU Memory Error Syndrome Register and L2 Memory Error Syndrome
>> +Register can be used for checking L1 and L2 memory errors.
>> +
>> +The following section describes the ARMv8 EDAC DT node binding.
>> +
>> +Required properties:
>> +- compatible: Should be "arm,armv8-edac"
>> +
>> +Example:
>> +	edac {
>> +		compatible = "arm,armv8-edac";
>> +	};
>> +
> 
> So if there is nothing in here, why do we need the DT binding at all (I
> think Mark hinted at that already)?
> Can't we just use the MIDR as already suggested by others?
> Secondly, armv8-edac is wrong here, as this feature is ARM-Cortex
> specific and not architectural.
> 
Yes, I was going with Mark suggestion to remove DT binding but then came across these cases which kind of hinted to keep DT binding:

* Without DT binding, the driver will always be loaded on arm64 unless its blacklisted.
* Its possible that other SoC's might handle single-bit and double-bit errors differently compare to 
  Seattle platform. In Seattle platform both errors are handled by firmware but if other SoC 
  wants OS to handle these errors then they might need DT binding to provide the irq numbers etc.

But if recommendation is to remove DT binding then I can remove it in next version. 

>> diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
>> index ef25000..dd7c195 100644
>> --- a/drivers/edac/Kconfig
>> +++ b/drivers/edac/Kconfig
>> @@ -390,4 +390,10 @@ config EDAC_XGENE
>>  	  Support for error detection and correction on the
>>  	  APM X-Gene family of SOCs.
>>  
>> +config EDAC_CORTEX_ARM64
>> +	tristate "ARM Cortex A57/A53"
>> +	depends on EDAC_MM_EDAC && ARM64
>> +	help
>> +	  Support for error detection and correction on the
>> +	  ARM Cortex A57 and A53.
>>  endif # EDAC
>> diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
>> index ae3c5f3..ac01660 100644
>> --- a/drivers/edac/Makefile
>> +++ b/drivers/edac/Makefile
>> @@ -68,3 +68,4 @@ obj-$(CONFIG_EDAC_OCTEON_PCI)		+= octeon_edac-pci.o
>>  obj-$(CONFIG_EDAC_ALTERA_MC)		+= altera_edac.o
>>  obj-$(CONFIG_EDAC_SYNOPSYS)		+= synopsys_edac.o
>>  obj-$(CONFIG_EDAC_XGENE)		+= xgene_edac.o
>> +obj-$(CONFIG_EDAC_CORTEX_ARM64)		+= cortex_arm64_edac.o
>> diff --git a/drivers/edac/cortex_arm64_edac.c b/drivers/edac/cortex_arm64_edac.c
>> new file mode 100644
>> index 0000000..c37bb94
>> --- /dev/null
>> +++ b/drivers/edac/cortex_arm64_edac.c
>> @@ -0,0 +1,457 @@
>> +/*
>> + * Cortex ARM64 EDAC
>> + *
>> + * Copyright (c) 2015, Advanced Micro Devices
>> + * Author: Brijesh Singh <brijeshkumar.singh@amd.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation; either version 2 of the License.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + */
>> +
>> +#include <linux/module.h>
>> +#include <linux/of_device.h>
>> +#include <linux/platform_device.h>
>> +
>> +#include "edac_core.h"
>> +
>> +#define EDAC_MOD_STR             "cortex_arm64_edac"
>> +
>> +#define A57_CPUMERRSR_EL1_INDEX(x)   ((x) & 0x1ffff)
>> +#define A57_CPUMERRSR_EL1_BANK(x)    (((x) >> 18) & 0x1f)
>> +#define A57_CPUMERRSR_EL1_RAMID(x)   (((x) >> 24) & 0x7f)
>> +#define A57_CPUMERRSR_EL1_VALID(x)   ((x) & (1 << 31))
>> +#define A57_CPUMERRSR_EL1_REPEAT(x)  (((x) >> 32) & 0x7f)
>> +#define A57_CPUMERRSR_EL1_OTHER(x)   (((x) >> 40) & 0xff)
>> +#define A57_CPUMERRSR_EL1_FATAL(x)   ((x) & (1UL << 63))
>> +#define A57_L1_I_TAG_RAM	     0x00
>> +#define A57_L1_I_DATA_RAM	     0x01
>> +#define A57_L1_D_TAG_RAM	     0x08
>> +#define A57_L1_D_DATA_RAM	     0x09
>> +#define A57_L1_TLB_RAM		     0x18
>> +
>> +#define A57_L2MERRSR_EL1_INDEX(x)    ((x) & 0x1ffff)
>> +#define A57_L2MERRSR_EL1_CPUID(x)    (((x) >> 18) & 0xf)
>> +#define A57_L2MERRSR_EL1_RAMID(x)    (((x) >> 24) & 0x7f)
>> +#define A57_L2MERRSR_EL1_VALID(x)    ((x) & (1 << 31))
>> +#define A57_L2MERRSR_EL1_REPEAT(x)   (((x) >> 32) & 0xff)
>> +#define A57_L2MERRSR_EL1_OTHER(x)    (((x) >> 40) & 0xff)
>> +#define A57_L2MERRSR_EL1_FATAL(x)    ((x) & (1UL << 63))
>> +#define A57_L2_TAG_RAM		     0x10
>> +#define A57_L2_DATA_RAM		     0x11
>> +#define A57_L2_SNOOP_TAG_RAM	     0x12
>> +#define A57_L2_DIRTY_RAM	     0x14
>> +#define A57_L2_INCLUSION_PF_RAM      0x18
>> +
>> +#define A53_CPUMERRSR_EL1_ADDR(x)    ((x) & 0xfff)
>> +#define A53_CPUMERRSR_EL1_CPUID(x)   (((x) >> 18) & 0x07)
>> +#define A53_CPUMERRSR_EL1_RAMID(x)   (((x) >> 24) & 0x7f)
>> +#define A53_CPUMERRSR_EL1_VALID(x)   ((x) & (1 << 31))
>> +#define A53_CPUMERRSR_EL1_REPEAT(x)  (((x) >> 32) & 0xff)
>> +#define A53_CPUMERRSR_EL1_OTHER(x)   (((x) >> 40) & 0xff)
>> +#define A53_CPUMERRSR_EL1_FATAL(x)   ((x) & (1UL << 63))
>> +#define A53_L1_I_TAG_RAM	     0x00
>> +#define A53_L1_I_DATA_RAM	     0x01
>> +#define A53_L1_D_TAG_RAM	     0x08
>> +#define A53_L1_D_DATA_RAM	     0x09
>> +#define A53_L1_D_DIRT_RAM	     0x0A
>> +#define A53_L1_TLB_RAM		     0x18
>> +
>> +#define A53_L2MERRSR_EL1_INDEX(x)    (((x) >> 3) & 0x3fff)
>> +#define A53_L2MERRSR_EL1_CPUID(x)    (((x) >> 18) & 0x0f)
>> +#define A53_L2MERRSR_EL1_RAMID(x)    (((x) >> 24) & 0x7f)
>> +#define A53_L2MERRSR_EL1_VALID(x)    ((x) & (1 << 31))
>> +#define A53_L2MERRSR_EL1_REPEAT(x)   (((x) >> 32) & 0xff)
>> +#define A53_L2MERRSR_EL1_OTHER(x)    (((x) >> 40) & 0xff)
>> +#define A53_L2MERRSR_EL1_FATAL(x)    ((x) & (1UL << 63))
>> +#define A53_L2_TAG_RAM		     0x10
>> +#define A53_L2_DATA_RAM		     0x11
>> +#define A53_L2_SNOOP_RAM	     0x12
> 
> I guess you can get rid of the A53/A57 prefix for most of the
> definitions - given they are identical.
> Just keep it around for the differing bits (but not as a prefix).
> 
Ok
>> +
>> +#define L1_CACHE		     0
>> +#define L2_CACHE		     1
>> +
>> +int poll_msec = 100;
>> +
>> +struct cortex_arm64_edac {
>> +	struct edac_device_ctl_info *edac_ctl;
>> +};
>> +
>> +static inline u64 read_cpumerrsr_el1(void)
>> +{
>> +	u64 val;
>> +
>> +	asm volatile("mrs %0, s3_1_c15_c2_2" : "=r" (val));
>> +	return val;
>> +}
>> +
>> +static inline void write_cpumerrsr_el1(u64 val)
>> +{
>> +	asm volatile("msr s3_1_c15_c2_2, %0" :: "r" (val));
>> +}
>> +
>> +static inline u64 read_l2merrsr_el1(void)
>> +{
>> +	u64 val;
>> +
>> +	asm volatile("mrs %0, s3_1_c15_c2_3" : "=r" (val));
>> +	return val;
>> +}
>> +
>> +static inline void write_l2merrsr_el1(u64 val)
>> +{
>> +	asm volatile("msr s3_1_c15_c2_3, %0" :: "r" (val));
>> +}
>> +
>> +static void a53_parse_l2merrsr(struct edac_device_ctl_info *edac_ctl)
>> +{
>> +	int fatal;
>> +	int repeat_err, other_err;
>> +	u64 val = read_l2merrsr_el1();
>> +
>> +	if (!A53_L2MERRSR_EL1_VALID(val))
>> +		return;
>> +
>> +	fatal = A53_L2MERRSR_EL1_FATAL(val);
>> +	repeat_err = A53_L2MERRSR_EL1_REPEAT(val);
>> +	other_err = A53_L2MERRSR_EL1_OTHER(val);
>> +
>> +	edac_printk(KERN_CRIT, EDAC_MOD_STR,
>> +		    "A53 CPU%d L2 %s error detected!\n", smp_processor_id(),
>> +		    fatal ? "fatal" : "non-fatal");
>> +	edac_printk(KERN_CRIT, EDAC_MOD_STR, "L2MERRSR_EL1=%#llx\n", val);
>> +
>> +	switch (A53_L2MERRSR_EL1_RAMID(val)) {
>> +	case A53_L2_TAG_RAM:
>> +		edac_printk(KERN_CRIT, EDAC_MOD_STR, "L2 Tag RAM\n");
>> +		break;
>> +	case A53_L2_DATA_RAM:
>> +		edac_printk(KERN_CRIT, EDAC_MOD_STR, "L2 Data RAM\n");
>> +		break;
>> +	case A53_L2_SNOOP_RAM:
>> +		edac_printk(KERN_CRIT, EDAC_MOD_STR, "L2 Snoop filter RAM\n");
>> +		break;
>> +	default:
>> +		edac_printk(KERN_CRIT, EDAC_MOD_STR, "unknown RAMID\n");
>> +		break;
>> +	}
>> +
>> +	edac_printk(KERN_CRIT, EDAC_MOD_STR, "Repeated error count=%d",
>> +		    repeat_err);
>> +	edac_printk(KERN_CRIT, EDAC_MOD_STR, "Other error count=%d\n",
>> +		    other_err);
>> +	if (fatal)
>> +		edac_device_handle_ue(edac_ctl, smp_processor_id(), L2_CACHE,
>> +				      edac_ctl->name);
>> +	else
>> +		edac_device_handle_ce(edac_ctl, smp_processor_id(), L2_CACHE,
>> +				      edac_ctl->name);
>> +	write_l2merrsr_el1(0);
>> +}
>> +
>> +static void a57_parse_l2merrsr(struct edac_device_ctl_info *edac_ctl)
>> +{
> 
> That looks like copied for most of the code, so it cries for unification.
> The semantics is almost identical, though the TRM describes it in a
> slighly different way sometimes (for CPUID/way for instance).

Yes RAMID description was different between A57 and A53. Will try to unify

>> +	int fatal;
>> +	int repeat_err, other_err;
>> +	u64 val = read_l2merrsr_el1();
>> +
>> +	if (!A57_L2MERRSR_EL1_VALID(val))
>> +		return;
>> +
>> +	fatal = A57_L2MERRSR_EL1_FATAL(val);
>> +	repeat_err = A57_L2MERRSR_EL1_REPEAT(val);
>> +	other_err = A57_L2MERRSR_EL1_OTHER(val);
>> +
>> +	edac_printk(KERN_CRIT, EDAC_MOD_STR,
>> +		    "A57 CPU%d L2 %s error detected!\n", smp_processor_id(),
>> +		    fatal ? "fatal" : "non-fatal");
>> +	edac_printk(KERN_CRIT, EDAC_MOD_STR, "L2MERRSR_EL1=%#llx\n", val);
>> +
>> +	switch (A57_L2MERRSR_EL1_RAMID(val)) {
>> +	case A57_L2_TAG_RAM:
>> +		edac_printk(KERN_CRIT, EDAC_MOD_STR, "L2 Tag RAM\n");
>> +		break;
>> +	case A57_L2_DATA_RAM:
>> +		edac_printk(KERN_CRIT, EDAC_MOD_STR, "L2 Data RAM\n");
>> +		break;
>> +	case A57_L2_SNOOP_TAG_RAM:
>> +		edac_printk(KERN_CRIT, EDAC_MOD_STR, "L2 Snoop tag RAM\n");
>> +		break;
>> +	case A57_L2_DIRTY_RAM:
>> +		edac_printk(KERN_CRIT, EDAC_MOD_STR, "L2 Dirty RAM\n");
>> +		break;
>> +	case A57_L2_INCLUSION_PF_RAM:
>> +		edac_printk(KERN_CRIT, EDAC_MOD_STR, "L2 inclusion PF RAM\n");
>> +		break;
>> +	default:
>> +		edac_printk(KERN_CRIT, EDAC_MOD_STR, "unknown RAMID\n");
>> +		break;
>> +	}
>> +
>> +	edac_printk(KERN_CRIT, EDAC_MOD_STR, "Repeated error count=%d",
>> +		    repeat_err);
>> +	edac_printk(KERN_CRIT, EDAC_MOD_STR, "Other error count=%d\n",
>> +		    other_err);
>> +	if (fatal)
>> +		edac_device_handle_ue(edac_ctl, smp_processor_id(), L2_CACHE,
>> +				      edac_ctl->name);
>> +	else
>> +		edac_device_handle_ce(edac_ctl, smp_processor_id(), L2_CACHE,
>> +				      edac_ctl->name);
>> +	write_l2merrsr_el1(0);
>> +}
>> +
>> +static void a57_parse_cpumerrsr(struct edac_device_ctl_info *edac_ctl)
>> +{
>> +	int fatal;
>> +	int repeat_err, other_err;
>> +	u64 val = read_cpumerrsr_el1();
>> +
>> +	if (!A57_CPUMERRSR_EL1_VALID(val))
>> +		return;
>> +
>> +	fatal = A57_CPUMERRSR_EL1_FATAL(val);
>> +	repeat_err = A57_CPUMERRSR_EL1_REPEAT(val);
>> +	other_err = A57_CPUMERRSR_EL1_OTHER(val);
>> +
>> +	edac_printk(KERN_CRIT, EDAC_MOD_STR,
>> +		    "CPU%d L1 %s error detected!\n", smp_processor_id(),
>> +		    fatal ? "fatal" : "non-fatal");
>> +	edac_printk(KERN_CRIT, EDAC_MOD_STR, "CPUMERRSR_EL1=%#llx\n", val);
>> +
>> +	switch (A57_CPUMERRSR_EL1_RAMID(val)) {
>> +	case A57_L1_I_TAG_RAM:
>> +		edac_printk(KERN_CRIT, EDAC_MOD_STR, "L1-I Tag RAM\n");
>> +		break;
>> +	case A57_L1_I_DATA_RAM:
>> +		edac_printk(KERN_CRIT, EDAC_MOD_STR, "L1-I Data RAM\n");
>> +		break;
>> +	case A57_L1_D_TAG_RAM:
>> +		edac_printk(KERN_CRIT, EDAC_MOD_STR, "L1-D Tag RAM\n");
>> +		break;
>> +	case A57_L1_D_DATA_RAM:
>> +		edac_printk(KERN_CRIT, EDAC_MOD_STR, "L1-D Data RAM\n");
>> +		break;
>> +	case A57_L1_TLB_RAM:
>> +		edac_printk(KERN_CRIT, EDAC_MOD_STR, "L2 TLB RAM\n");
>> +		break;
>> +	default:
>> +		edac_printk(KERN_CRIT, EDAC_MOD_STR, "unknown RAMID\n");
>> +		break;
>> +	}
>> +
>> +	edac_printk(KERN_CRIT, EDAC_MOD_STR, "Repeated error count=%d",
>> +		    repeat_err);
>> +	edac_printk(KERN_CRIT, EDAC_MOD_STR, "Other error count=%d\n",
>> +		    other_err);
>> +
>> +	if (fatal)
>> +		edac_device_handle_ue(edac_ctl, smp_processor_id(), L1_CACHE,
>> +				      edac_ctl->name);
>> +	else
>> +		edac_device_handle_ce(edac_ctl, smp_processor_id(), L1_CACHE,
>> +				      edac_ctl->name);
>> +	write_cpumerrsr_el1(0);
>> +}
>> +
>> +static void a53_parse_cpumerrsr(struct edac_device_ctl_info *edac_ctl)
>> +{
> 
> Same as above. Please unify to have one function.
> 
>> +	int fatal;
>> +	int repeat_err, other_err;
>> +	u64 val = read_cpumerrsr_el1();
>> +
>> +	if (!A53_CPUMERRSR_EL1_VALID(val))
>> +		return;
>> +
>> +	fatal = A53_CPUMERRSR_EL1_FATAL(val);
>> +	repeat_err = A53_CPUMERRSR_EL1_REPEAT(val);
>> +	other_err = A53_CPUMERRSR_EL1_OTHER(val);
>> +
>> +	edac_printk(KERN_CRIT, EDAC_MOD_STR,
>> +		    "A53 CPU%d L1 %s error detected!\n", smp_processor_id(),
>> +		    fatal ? "fatal" : "non-fatal");
>> +	edac_printk(KERN_CRIT, EDAC_MOD_STR, "CPUMERRSR_EL1=%#llx\n", val);
>> +
>> +	switch (A53_CPUMERRSR_EL1_RAMID(val)) {
>> +	case A53_L1_I_TAG_RAM:
>> +		edac_printk(KERN_CRIT, EDAC_MOD_STR, "L1-I Tag RAM\n");
>> +		break;
>> +	case A53_L1_I_DATA_RAM:
>> +		edac_printk(KERN_CRIT, EDAC_MOD_STR, "L1-I Data RAM\n");
>> +		break;
>> +	case A53_L1_D_TAG_RAM:
>> +		edac_printk(KERN_CRIT, EDAC_MOD_STR, "L1-D Tag RAM\n");
>> +		break;
>> +	case A53_L1_D_DATA_RAM:
>> +		edac_printk(KERN_CRIT, EDAC_MOD_STR, "L1-D Data RAM\n");
>> +		break;
>> +	case A53_L1_TLB_RAM:
>> +		edac_printk(KERN_CRIT, EDAC_MOD_STR, "L2 TLB RAM\n");
>> +		break;
>> +	default:
>> +		edac_printk(KERN_CRIT, EDAC_MOD_STR, "unknown RAMID\n");
>> +		break;
>> +	}
>> +
>> +	edac_printk(KERN_CRIT, EDAC_MOD_STR, "Repeated error count=%d",
>> +		    repeat_err);
>> +	edac_printk(KERN_CRIT, EDAC_MOD_STR, "Other error count=%d\n",
>> +		    other_err);
>> +
>> +	if (fatal)
>> +		edac_device_handle_ue(edac_ctl, smp_processor_id(), L1_CACHE,
>> +				      edac_ctl->name);
>> +	else
>> +		edac_device_handle_ce(edac_ctl, smp_processor_id(), L1_CACHE,
>> +				      edac_ctl->name);
>> +	write_cpumerrsr_el1(0);
>> +}
>> +
>> +static void parse_cpumerrsr(void *args)
>> +{
>> +	struct edac_device_ctl_info *edac_ctl = args;
>> +	int partnum = read_cpuid_part_number();
>> +
>> +	switch (partnum) {
>> +	case ARM_CPU_PART_CORTEX_A57:
> 
> You should have that distinction in the above (unified) function just
> for the differing bits. If that looks too ugly, hide it in a macro.
> 
>> +		a57_parse_cpumerrsr(edac_ctl);
>> +		break;
>> +	case ARM_CPU_PART_CORTEX_A53:
>> +		a53_parse_cpumerrsr(edac_ctl);
>> +		break;
>> +	}
>> +}
>> +
>> +static void parse_l2merrsr(void *args)
>> +{
>> +	struct edac_device_ctl_info *edac_ctl = args;
>> +	int partnum = read_cpuid_part_number();
>> +
>> +	switch (partnum) {
>> +	case ARM_CPU_PART_CORTEX_A57:
>> +		a57_parse_l2merrsr(edac_ctl);
>> +		break;
>> +	case ARM_CPU_PART_CORTEX_A53:
>> +		a53_parse_l2merrsr(edac_ctl);
>> +		break;
>> +	}
>> +}
>> +
>> +static void arm64_monitor_cache_errors(struct edac_device_ctl_info *edev_ctl)
>> +{
>> +	int cpu;
>> +	struct cpumask cluster_mask, old_mask;
>> +
>> +	cpumask_clear(&cluster_mask);
>> +	cpumask_clear(&old_mask);
>> +
>> +	get_online_cpus();
>> +	for_each_online_cpu(cpu) {
>> +		smp_call_function_single(cpu, parse_cpumerrsr, edev_ctl, 0);
>> +		cpumask_copy(&cluster_mask, topology_core_cpumask(cpu));
>> +		if (cpumask_equal(&cluster_mask, &old_mask))
>> +			continue;
>> +		cpumask_copy(&old_mask, &cluster_mask);
>> +		smp_call_function_any(&cluster_mask, parse_l2merrsr,
>> +				      edev_ctl, 0);
>> +	}
>> +	put_online_cpus();
>> +}
>> +
>> +static int cortex_arm64_edac_probe(struct platform_device *pdev)
>> +{
>> +	int rc;
>> +	struct cortex_arm64_edac *drv;
>> +	struct device *dev = &pdev->dev;
>> +
>> +	drv = devm_kzalloc(dev, sizeof(*drv), GFP_KERNEL);
>> +	if (!drv)
>> +		return -ENOMEM;
>> +
>> +	drv->edac_ctl = edac_device_alloc_ctl_info(0, "cpu",
>> +						   num_possible_cpus(), "L", 2,
>> +						   1, NULL, 0,
>> +						   edac_device_alloc_index());
>> +	if (IS_ERR(drv->edac_ctl))
>> +		return -ENOMEM;
>> +
>> +	drv->edac_ctl->poll_msec = poll_msec;
>> +	drv->edac_ctl->edac_check = arm64_monitor_cache_errors;
>> +	drv->edac_ctl->dev = dev;
>> +	drv->edac_ctl->mod_name = dev_name(dev);
>> +	drv->edac_ctl->dev_name = dev_name(dev);
>> +	drv->edac_ctl->ctl_name = "cpu_err";
>> +	drv->edac_ctl->panic_on_ue = 1;
>> +	platform_set_drvdata(pdev, drv);
>> +
>> +	rc = edac_device_add_device(drv->edac_ctl);
>> +	if (rc)
>> +		goto edac_alloc_failed;
>> +
>> +	return 0;
>> +
>> +edac_alloc_failed:
>> +	edac_device_free_ctl_info(drv->edac_ctl);
>> +	return rc;
>> +}
>> +
>> +static int cortex_arm64_edac_remove(struct platform_device *pdev)
>> +{
>> +	struct cortex_arm64_edac *drv = dev_get_drvdata(&pdev->dev);
>> +	struct edac_device_ctl_info *edac_ctl = drv->edac_ctl;
>> +
>> +	edac_device_del_device(edac_ctl->dev);
>> +	edac_device_free_ctl_info(edac_ctl);
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct of_device_id cortex_arm64_edac_of_match[] = {
>> +	{ .compatible = "arm,armv8-edac" },
>> +	{},
>> +};
>> +MODULE_DEVICE_TABLE(of, cortex_arm64_edac_of_match);
>> +
>> +static struct platform_driver cortex_arm64_edac_driver = {
>> +	.probe = cortex_arm64_edac_probe,
>> +	.remove = cortex_arm64_edac_remove,
>> +	.driver = {
>> +		.name = "arm64-edac",
>> +		.owner = THIS_MODULE,
>> +		.of_match_table = cortex_arm64_edac_of_match,
> 
> So you would need to get rid of that without a DT binding. Not sure if
> there is a precedence for a driver loaded by an MIDR match already (PMU
> comes to mind)?
> 
> Please note that would mean that the driver always loads on any Cortex
> CPU, I guess this is not always desirable (thinking about phones here).
> I am not sure if module blacklisting is a solution or we would need to
> come up with some clever way of potentially disabling some platforms -
> which admittedly cries for a DT binding again ;-)
> 
Yes, you read my mind :) See my comment above on DT binding.

> Cheers,
> Andre.
> 
>> +	},
>> +};
>> +
>> +static int __init cortex_arm64_edac_init(void)
>> +{
>> +	int rc;
>> +
>> +	/* Only POLL mode is supported so far */
>> +	edac_op_state = EDAC_OPSTATE_POLL;
>> +
>> +	rc = platform_driver_register(&cortex_arm64_edac_driver);
>> +	if (rc) {
>> +		edac_printk(KERN_ERR, EDAC_MOD_STR, "failed to register\n");
>> +		return rc;
>> +	}
>> +
>> +	return 0;
>> +}
>> +module_init(cortex_arm64_edac_init);
>> +
>> +static void __exit cortex_arm64_edac_exit(void)
>> +{
>> +	platform_driver_unregister(&cortex_arm64_edac_driver);
>> +}
>> +module_exit(cortex_arm64_edac_exit);
>> +
>> +MODULE_LICENSE("GPL");
>> +MODULE_AUTHOR("Brijesh Singh <brijeshkumar.singh@amd.com>");
>> +MODULE_DESCRIPTION("Cortex A57 and A53 EDAC driver");
>> +module_param(poll_msec, int, 0444);
>> +MODULE_PARM_DESC(poll_msec, "EDAC monitor poll interval in msec");
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
