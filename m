From: bp@alien8.de (Borislav Petkov)
Date: Mon, 19 Oct 2015 22:14:57 +0200
Subject: [PATCH] EDAC: Add AMD Seattle SoC EDAC
In-Reply-To: <1445282597-18999-1-git-send-email-brijeshkumar.singh@amd.com>
References: <1445282597-18999-1-git-send-email-brijeshkumar.singh@amd.com>
Message-ID: <20151019201457.GA30135@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+ Arnd for the DT bindings.

On Mon, Oct 19, 2015 at 02:23:17PM -0500, Brijesh Singh wrote:
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
> diff --git a/Documentation/devicetree/bindings/edac/amd-seattle-edac.txt b/Documentation/devicetree/bindings/edac/amd-seattle-edac.txt
> new file mode 100644
> index 0000000..a0354e8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/edac/amd-seattle-edac.txt
> @@ -0,0 +1,15 @@
> +* AMD Seattle SoC EDAC node
> +
> +EDAC node is defined to describe on-chip error detection and reporting.
> +
> +Required properties:
> +- compatible: Should be "amd,arm-seattle-edac"
> +- poll-delay-msec: Indicates how often the edac check callback should be called.
> +  Time in msec.
> +
> +Example:
> +	edac {
> +		compatible = "amd,arm-seattle-edac";
> +		poll-delay-msec = <100>;
> +	};
> +
> diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
> index ef25000..d342335 100644
> --- a/drivers/edac/Kconfig
> +++ b/drivers/edac/Kconfig
> @@ -390,4 +390,10 @@ config EDAC_XGENE
>  	  Support for error detection and correction on the
>  	  APM X-Gene family of SOCs.
>  
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

								to log the ...

> + * non-fatal errors. Whereas the single bit and double bit ECC erros are 
> + * handled by firmware.

"Single and double bit ECC errors are handled by firmware." - no need
"for Whereas".

Please run this through a spell checker before your next submission.

Question about the content itself: non-fatal errors are polled but
single and double-bit errors are handled by fw. Single bit errors are
non-fatal, methinks. So what is this sentence actually saying?

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

Can you get rid of that copyright boilerplate and use a single sentence like:

"Licensed under GPL v2."

Ask your legal people and/or your manager - they should know.

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

All those function names are very cryptic. Can you make them more
human-readable and -understandable? Don't be afraid to use comments too.

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

		    "CPU%d detected %s L2 error ..."

> +		    smp_processor_id(), fatal ? "fatal" : "non-fatal", val);
> +
> +	switch (L2MERRSR_EL1_RAMID(val)) {
> +	case 0x10:
> +		edac_printk(KERN_CRIT, EDAC_MOD_STR,
> +			    "L2 Tag RAM cpu %d way %d\n", cpuid / 2, cpuid % 2);

What is a "L2 Tag RAM cpu <num> way <num>"? Can you make those more
humanly understandable please. Like

	" Error in the L2 Tag array.\n"

Also, you're dumping smp_processor_id() above and here you have cpuid
/ 2 (btw, I'm guessing you wanna do "cpuid >> 1" for the division and
"cpuid & 1" for the modulo for additional speed since division is
costly) and you're calling this "cpu" too. What is that "cpu" supposed
to mean?

Ditto for the remaining printk messages below.

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

Why the cast? You can simply print %lu.

> +	edac_printk(KERN_CRIT, EDAC_MOD_STR, "Other error count: %d\n",
> +		    (int)L2MERRSR_EL1_OTHER(val));

Ditto.

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

Also a cryptic name.

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

As above.

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

Are those to say *where* the errors were? If so, please say so in the
error message:

	"CPU%d: L1 %s error detected in the L1-I tag RAM bank"

you can use pr_cont() for the continuation messages.

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

No need to cast.

> +	if (fatal)
> +		edac_device_handle_ue(edac_ctl, smp_processor_id(), 1,
> +				      edac_ctl->name);
> +	else
> +		edac_device_handle_ce(edac_ctl, smp_processor_id(), 1,
> +				      edac_ctl->name);
> +	write_cpumerrsr_el1(0);
> +}
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

This is not cpu hotplug-safe. What if I offline a CPU while this loop
runs?

> +		smp_call_function_single(cpu, cpu_check_errors, edev_ctl, 0);

Hint:
	get_online_cpus();
	on_each_cpu();
	put_online_cpus();

> +}
> +
> +static int seattle_edac_probe(struct platform_device *pdev)
> +{
> +	int rc;
> +	u32 poll_msec;
> +	struct seattle_edac *drv;
> +	struct device *dev = &pdev->dev;
> +
> +	rc = of_property_read_u32(pdev->dev.of_node, "poll-delay-msec",
> +				  &poll_msec);
> +	if (rc < 0) {
> +		edac_printk(KERN_ERR, EDAC_MOD_STR,
> +			    "failed to get poll interval\n");
> +		return rc;
> +	}
> +
> +	drv = devm_kzalloc(dev, sizeof(*drv), GFP_KERNEL);
> +	if (!drv)
> +		return -ENOMEM;
> +
> +	drv->edac_ctl = edac_device_alloc_ctl_info(0, "cpu",
> +						   num_possible_cpus(), "L", 2,

Same problematic if someone offlines a core and then loads this module.

> +						   1, NULL, 0,
> +						   edac_device_alloc_index());

Why aren't you checking the return value of this function?

> +	drv->edac_ctl->poll_msec = poll_msec;
> +	drv->edac_ctl->edac_check = edac_check_errors;
> +	drv->edac_ctl->dev = dev;
> +	drv->edac_ctl->mod_name = dev_name(dev);
> +	drv->edac_ctl->dev_name = dev_name(dev);
> +	drv->edac_ctl->ctl_name = "cpu_err";
> +	drv->edac_ctl->panic_on_ue = 1;
> +	platform_set_drvdata(pdev, drv);
> +
> +	rc = edac_device_add_device(drv->edac_ctl);
> +	if (rc)
> +		goto edac_alloc_failed;
> +
> +	return 0;
> +
> +edac_alloc_failed:
> +	edac_device_free_ctl_info(drv->edac_ctl);
> +	return rc;
> +}
-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
