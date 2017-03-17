From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Fri, 17 Mar 2017 18:44:03 +0000
Subject: [PATCH v4 4/7] coresight: add support for CPU debug module
In-Reply-To: <1489762943-25849-5-git-send-email-leo.yan@linaro.org>
References: <1489762943-25849-1-git-send-email-leo.yan@linaro.org>
 <1489762943-25849-5-git-send-email-leo.yan@linaro.org>
Message-ID: <74d6fd19-89f0-7edf-ace3-8b07f13e9569@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/03/17 15:02, Leo Yan wrote:
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
> uses sample-based registers for debug purpose, e.g. when system detects
> the CPU lockup and trigger panic, the driver will dump program counter

Do we dump it when the CPU lockup is detected with this change ? If not,
we shouldn't claim that here.

> and combined context registers (EDCIDSR, EDVIDSR); by parsing context
> registers so can quickly get to know CPU secure state, exception level,
> etc.
>
> Some of the debug module registers are located in CPU power domain, so
> in the driver it has checked the power state for CPU before accessing
> registers within CPU power domain. For most safe way to use this driver,
> it's suggested to disable CPU low power states, this can simply set
> "nohlt" in kernel command line.
>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  drivers/hwtracing/coresight/Kconfig               |  10 +
>  drivers/hwtracing/coresight/Makefile              |   1 +
>  drivers/hwtracing/coresight/coresight-cpu-debug.c | 407 ++++++++++++++++++++++
>  3 files changed, 418 insertions(+)
>  create mode 100644 drivers/hwtracing/coresight/coresight-cpu-debug.c
>
> diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
> index 130cb21..daf80bc 100644
> --- a/drivers/hwtracing/coresight/Kconfig
> +++ b/drivers/hwtracing/coresight/Kconfig
> @@ -89,4 +89,14 @@ config CORESIGHT_STM
>  	  logging useful software events or data coming from various entities
>  	  in the system, possibly running different OSs
>
> +config CORESIGHT_CPU_DEBUG
> +	bool "CoreSight CPU Debug driver"
> +	depends on ARM || ARM64
> +	help
> +	  This driver provides support for coresight debugging module. This
> +	  is primarily used to dump sample-based profiling registers for
> +	  panic. To avoid lockups when accessing debug module registers,
> +	  it is safer to disable CPU low power states (like "nohlt" on the
> +	  kernel command line) when using this feature.
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

> +/*
> + * bits definition for EDDEVID1

Definition for EDDEVID1:PSCROffset

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

Thanks for adding the comment here.


> +#define EDDEVID1_PCSR_OFFSET_MASK	GENMASK(3, 0)
> +#define EDDEVID1_PCSR_OFFSET_INS_SET	(0x0)
> +#define EDDEVID1_PCSR_NO_OFFSET_DIS_AARCH32	(0x2)
> +
> +/* bits definition for EDDEVID */
> +#define EDDEVID_PCSAMPLE_MODE		GENMASK(3, 0)

Do we support an implementation where only EDPCSR is implemented (0x1) ?
That should be quite straight forward by adding edcidsr_present.

> +#define EDDEVID_IMPL_EDPCSR_EDCIDSR	(0x2)
> +#define EDDEVID_IMPL_FULL		(0x3)
> +
> +struct debug_drvdata {
> +	void __iomem	*base;
> +	struct device	*dev;
> +	int		cpu;
> +
> +	bool		edpcsr_present;
> +	bool		edvidsr_present;

> +	bool		pc_has_offset;

Unused member ? It would be good to populate these (and any other information)
rather than, caching devid/devid1 (below).

> +
> +	u32		eddevid;
> +	u32		eddevid1;
> +
> +	u32		edpcsr;
> +	u32		edpcsr_hi;
> +	u32		edprsr;
> +	u32		edvidsr;
> +	u32		edcidsr;
> +};

> +	/*
> +	 * A read of the EDPCSR normally has the side-effect of
> +	 * indirectly writing to EDCIDSR, EDVIDSR and EDPCSR_HI;
> +	 * at this point it's safe to read value from them.
> +	 */
> +	drvdata->edcidsr = readl_relaxed(drvdata->base + EDCIDSR);
> +#ifdef CONFIG_64BIT
> +	drvdata->edpcsr_hi = readl_relaxed(drvdata->base + EDPCSR_HI);
> +#endif

We could use IS_ENABLED() here.

> +#ifdef CONFIG_64BIT
> +	pc = (unsigned long)drvdata->edpcsr_hi << 32 |
> +	     (unsigned long)drvdata->edpcsr;
> +#else
> +	pc = debug_adjust_pc(drvdata, (unsigned long)drvdata->edpcsr);
> +#endif


> +
> +	pr_emerg("\tEDPCSR:  [<%p>] %pS\n", (void *)pc, (void *)pc);

Are we safe calling %pS on the PC, when the PC offset in implementation defined ?

> +	pr_emerg("\tEDCIDSR: %08x\n", drvdata->edcidsr);
> +
> +	if (!drvdata->edvidsr_present)
> +		return;
> +
> +	pr_emerg("\tEDVIDSR: %08x (State:%s Mode:%s Width:%s VMID:%x)\n",
> +		 drvdata->edvidsr,
> +		 drvdata->edvidsr & EDVIDSR_NS ? "Non-secure" : "Secure",
> +		 drvdata->edvidsr & EDVIDSR_E3 ? "EL3" :
> +			(drvdata->edvidsr & EDVIDSR_E2 ? "EL2" : "EL1/0"),
> +		 drvdata->edvidsr & EDVIDSR_HV ? "64bits" : "32bits",

ultra minor nit: this could be also done as : "Width:%dbits" and drvdata->edvidsr & EDVISR_HW ? 64 : 32.
Avoids string literal.

> +		 drvdata->edvidsr & (u32)EDVIDSR_VMID);
> +}
> +
> +/*
> + * Dump out information on panic.
> + */
> +static int debug_notifier_call(struct notifier_block *self,
> +			       unsigned long v, void *p)
> +{
> +	int cpu;
> +
> +	pr_emerg("ARM external debug module:\n");
> +
> +	for_each_possible_cpu(cpu) {
> +		if (!per_cpu(debug_drvdata, cpu))
> +			continue;
> +
> +		pr_emerg("CPU[%d]:\n", per_cpu(debug_drvdata, cpu)->cpu);
> +
> +		debug_read_regs(per_cpu(debug_drvdata, cpu));
> +		debug_dump_regs(per_cpu(debug_drvdata, cpu));

nit: It would look nicer if you could use a variable for the per_cpu(debug_drvdata, cpu),
rather than repeating it every single line.


> +	}
> +
> +	return 0;
> +}
> +
> +static struct notifier_block debug_notifier = {
> +	.notifier_call = debug_notifier_call,
> +};
> +
> +static void debug_init_arch_data(void *info)
> +{
> +	struct debug_drvdata *drvdata = info;
> +	u32 mode, pcsr_offset;
> +
> +	CS_UNLOCK(drvdata->base);
> +
> +	debug_os_unlock(drvdata);
> +
> +	/* Read device info */
> +	drvdata->eddevid  = readl_relaxed(drvdata->base + EDDEVID);
> +	drvdata->eddevid1 = readl_relaxed(drvdata->base + EDDEVID1);
> +
> +	/* Parse implementation feature */
> +	mode = drvdata->eddevid & EDDEVID_PCSAMPLE_MODE;
> +	if (mode == EDDEVID_IMPL_FULL) {
> +		drvdata->edpcsr_present  = true;
> +		drvdata->edvidsr_present = true;
> +	} else if (mode == EDDEVID_IMPL_EDPCSR_EDCIDSR) {
> +
> +		pcsr_offset = drvdata->eddevid1 & EDDEVID1_PCSR_OFFSET_MASK;
> +
> +		/*
> +		 * In ARM DDI 0487A.k, the EDDEVID1.PCSROffset is used to
> +		 * define if has the offset for PC sampling value; if read
> +		 * back EDDEVID1.PCSROffset == 0x2, then this means the debug
> +		 * module does not sample the instruction set state when
> +		 * armv8 CPU in AArch32 state.
> +		 */
> +		if (!IS_ENABLED(CONFIG_64BIT) &&
> +			(pcsr_offset == EDDEVID1_PCSR_NO_OFFSET_DIS_AARCH32))
> +			drvdata->edpcsr_present = false;
> +		else
> +			drvdata->edpcsr_present = true;
> +
> +		drvdata->edvidsr_present = false;
> +	} else {

Actually, if mode == 0x01, pcsr is present, which we don't handle here.

> +		drvdata->edpcsr_present  = false;
> +		drvdata->edvidsr_present = false;
> +	}
> +
> +	CS_LOCK(drvdata->base);
> +}
> +
> +static int debug_probe(struct amba_device *adev, const struct amba_id *id)
> +{
> +	void __iomem *base;
> +	struct device *dev = &adev->dev;
> +	struct debug_drvdata *drvdata;
> +	struct resource *res = &adev->res;
> +	struct device_node *np = adev->dev.of_node;
> +	static int debug_count;
> +	int ret;
> +
> +	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
> +	if (!drvdata)
> +		return -ENOMEM;
> +
> +	drvdata->cpu = np ? of_coresight_get_cpu(np) : 0;
> +	drvdata->dev = &adev->dev;
> +
> +	dev_set_drvdata(dev, drvdata);
> +
> +	/* Validity for the resource is already checked by the AMBA core */
> +	base = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	drvdata->base = base;
> +
> +	get_online_cpus();
> +	per_cpu(debug_drvdata, drvdata->cpu) = drvdata;

We should make sure that there is no debug_drvdata already set for the CPU.
(e.g, if the cpu node is missing for two CPUs, we could end up in two drvdata
for CPU0 and thus leaking the memory allocated for the first one).


Suzuki
