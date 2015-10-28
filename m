From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 28 Oct 2015 16:40:53 +0000
Subject: [PATCH v4] EDAC: Add ARM64 EDAC
In-Reply-To: <1446048829-3359-1-git-send-email-brijeshkumar.singh@amd.com>
References: <1446048829-3359-1-git-send-email-brijeshkumar.singh@amd.com>
Message-ID: <20151028164053.GG25451@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Oct 28, 2015 at 11:13:49AM -0500, Brijesh Singh wrote:
> Add support for Cortex A57 and A53 EDAC driver.
> 
> Signed-off-by: Brijesh Singh <brijeshkumar.singh@amd.com>
> CC: robh+dt at kernel.org
> CC: pawel.moll at arm.com
> CC: mark.rutland at arm.com
> CC: ijc+devicetree at hellion.org.uk
> CC: galak at codeaurora.org
> CC: dougthompson at xmission.com
> CC: bp at alien8.de
> CC: mchehab at osg.samsung.com
> CC: devicetree at vger.kernel.org
> CC: guohanjun at huawei.com
> CC: andre.przywara at arm.com
> CC: arnd at arndb.de
> CC: sboyd at codeaurora.org
> CC: linux-kernel at vger.kernel.org
> CC: linux-edac at vger.kernel.org
> ---
> Tested error reporting via rasdeamon on AMD seattle platform.
> 
> v4:
> * remove THIS_MODULE assignment from platform_driver
> * use module_platform_driver(), remove module_init() and module_exit()
> * remove default n from Kconfig
> 
> v3:
> * change DT binding compatibilty string to 'cortex-a57-edac'
> * remove A57/A53 prefix from register bit definition
> * unify A57 and A53 L1/L2 error parsing functions
> * use mc trace event function to report the error
> * update Kconfig default to 'n'
> 
> v2:
> * convert into generic arm64 edac driver
> * remove AMD specific references from dt binding
> * remove poll_msec property from dt binding
> * add poll_msec as a module param, default is 100ms
> * update copyright text
> * define macro mnemonics for L1 and L2 RAMID
> * check L2 error per-cluster instead of per core
> * update function names
> * use get_online_cpus() and put_online_cpus() to make L1 and L2 register 
>   read hotplug-safe
> * add error check in probe routine
> 
>  .../devicetree/bindings/edac/cortex-arm64-edac.txt |  15 +
>  drivers/edac/Kconfig                               |   7 +
>  drivers/edac/Makefile                              |   1 +
>  drivers/edac/cortex_arm64_edac.c                   | 336 +++++++++++++++++++++
>  4 files changed, 359 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/edac/cortex-arm64-edac.txt
>  create mode 100644 drivers/edac/cortex_arm64_edac.c
> 
> diff --git a/Documentation/devicetree/bindings/edac/cortex-arm64-edac.txt b/Documentation/devicetree/bindings/edac/cortex-arm64-edac.txt
> new file mode 100644
> index 0000000..552f0c7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/edac/cortex-arm64-edac.txt
> @@ -0,0 +1,15 @@
> +* ARM Cortex A57 and A53 L1/L2 cache error reporting
> +
> +CPU Memory Error Syndrome and L2 Memory Error Syndrome registers can be used
> +for checking L1 and L2 memory errors.
> +
> +The following section describes the Cortex A57/A53 EDAC DT node binding.
> +
> +Required properties:
> +- compatible: Should be "arm,cortex-a57-edac" or "arm,cortex-a53-edac"
> +
> +Example:
> +	edac {
> +		compatible = "arm,cortex-a57-edac";
> +	};
> +

This is insufficient for big.LITTLE, no interrupt is possible, and we
haven't defined the rules for accessing the registers (e.g. whether
write backs are permitted).

Please see my prior comments [1] on those points.

If we're going to use this feature directly within the kernel, we need
to consider the envelope of possible implementations rather than your
use-case alone.

> +static void parse_cpumerrsr(void *arg)
> +{
> +	int cpu, partnum, way;
> +	unsigned int index = 0;
> +	u64 val = read_cpumerrsr_el1();
> +	int repeat_err, other_err;
> +
> +	/* we do not support fatal error handling so far */
> +	if (CPUMERRSR_EL1_FATAL(val))
> +		return;

Silently ignoring fatal errors doesn't seem good.

Shouldn't this be checked after the valid bit?

> +	/* check if we have valid error before continuing */
> +	if (!CPUMERRSR_EL1_VALID(val))
> +		return;
> +
> +	cpu = smp_processor_id();
> +	partnum = read_cpuid_part_number();
> +	repeat_err = CPUMERRSR_EL1_REPEAT(val);
> +	other_err = CPUMERRSR_EL1_OTHER(val);
> +
> +	/* way/bank and index address bit ranges are different between
> +	 * A57 and A53 */
> +	if (partnum == ARM_CPU_PART_CORTEX_A57) {
> +		index = CPUMERRSR_EL1_INDEX(val, 0x1ffff);
> +		way = CPUMERRSR_EL1_BANK_WAY(val, 0x1f);
> +	} else {
> +		index = CPUMERRSR_EL1_INDEX(val, 0xfff);
> +		way = CPUMERRSR_EL1_BANK_WAY(val, 0x7);
> +	}

Can the bit ranges not be determined at probe time rather than reading
the MIDR repeatedly?

> +	edac_printk(KERN_CRIT, EDAC_MOD_STR, "CPU%d L1 error detected!\n", cpu);
> +	edac_printk(KERN_CRIT, EDAC_MOD_STR, "index=%#x, RAMID=", index);
> +
> +	switch (CPUMERRSR_EL1_RAMID(val)) {
> +	case L1_I_TAG_RAM:
> +		pr_cont("'L1-I Tag RAM' (way %d)", way);
> +		break;
> +	case L1_I_DATA_RAM:
> +		pr_cont("'L1-I Data RAM' (bank %d)", way);
> +		break;
> +	case L1_D_TAG_RAM:
> +		pr_cont("'L1-D Tag RAM' (way %d)", way);
> +		break;
> +	case L1_D_DATA_RAM:
> +		pr_cont("'L1-D Data RAM' (bank %d)", way);
> +		break;
> +	case L1_D_DIRTY_RAM:
> +		pr_cont("'L1 Dirty RAM'");
> +		break;
> +	case TLB_RAM:
> +		pr_cont("'TLB RAM'");
> +		break;
> +	default:
> +		pr_cont("'unknown'");
> +		break;
> +	}
> +
> +	pr_cont(", repeat=%d, other=%d (CPUMERRSR_EL1=%#llx)\n", repeat_err,
> +		other_err, val);
> +
> +	trace_mc_event(HW_EVENT_ERR_CORRECTED, "L1 non-fatal error",
> +		       "", repeat_err, 0, 0, 0, -1, index, 0, 0, DRV_NAME);
> +	write_cpumerrsr_el1(0);
> +}

The comments above also apply to parse_l2merrsr.

> +static void cortex_arm64_edac_check(struct edac_device_ctl_info *edac_ctl)
> +{
> +	int cpu;
> +	struct cpumask cluster_mask, old_mask;
> +
> +	cpumask_clear(&cluster_mask);
> +	cpumask_clear(&old_mask);
> +
> +	get_online_cpus();
> +	for_each_online_cpu(cpu) {
> +		/* Check CPU L1 error */
> +		smp_call_function_single(cpu, parse_cpumerrsr, NULL, 0);
> +		cpumask_copy(&cluster_mask, topology_core_cpumask(cpu));
> +		if (cpumask_equal(&cluster_mask, &old_mask))
> +			continue;
> +		cpumask_copy(&old_mask, &cluster_mask);
> +		/* Check CPU L2 error */
> +		smp_call_function_any(&cluster_mask, parse_l2merrsr, NULL, 0);
> +	}

I don't think the use of old_mask is sufficient here, given the mapping
of logical to physical ID is arbitrary. For example, we could have CPUs
0,5,6,7 in one cluster, and CPUs 1,2,3,4 in another, and in that case
we'd check the first cluster twice.

This also is wrong for big.LITTLE; we can't necessarily check on every
CPU.

Thanks,
Mark.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-October/380942.html
