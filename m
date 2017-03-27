From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Mon, 27 Mar 2017 17:34:57 +0100
Subject: [PATCH v5 6/9] coresight: add support for CPU debug module
In-Reply-To: <1490466197-29163-7-git-send-email-leo.yan@linaro.org>
References: <1490466197-29163-1-git-send-email-leo.yan@linaro.org>
 <1490466197-29163-7-git-send-email-leo.yan@linaro.org>
Message-ID: <31be033f-514e-e48a-3ba2-a5c5cd477548@arm.com>
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

Leo,

Thanks a lot for the quick rework. I don't fully understand (yet!) why we need the
idle_constraint. I will leave it for Sudeep to comment on it, as he is the expert
in that area. Some minor comments below.

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

May be we should mention/warn the user about the possible caveats of using
this feature to help him make a better decision ? And / Or we should add a documentation
for it. We have collected some real good information over the discussions and
it is a good idea to capture it somewhere.

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

We don't need this to protect the defintions, see comments around adjust_pc method.

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

We don't need those two registers once we initialise the bool flags above.
So, we could as well drop them from here.

> +
> +	u32		edpcsr;
> +	u32		edpcsr_hi;

> +	u32		edprcr;

Unused member ?

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

Correct me if I am wrong,

All we want to do is disable the CPUIdle explicitly if the user knows that this
could be a problem to use CPU debug on his platform. So, in effect, we should
only be using idle_constraint = 0 or -1.

In which case, we could make it easier for the user to tell us, either

  0 - Don't do anything with CPUIdle (default)
  1 - Disable CPUIdle for me as I know the platform has issues with CPU debug and CPUidle.

than explaining the miscrosecond latency etc and make the appropriate calls underneath.
something like (not necessarily the same name) :

module_param(broken_with_cpuidle, bool, 0600);
MODULE_PARAM_DESC(broken_with_cpuidle, "Specifies whether the CPU debug has issues with CPUIdle on"
				       " the platform. Non-zero value implies CPUIdle has to be"
				       " explicitly disabled.",);

> +
> +static bool debug_enable;
> +module_param_named(enable, debug_enable, bool, 0600);
> +MODULE_PARM_DESC(enable, "Knob to enable debug functionality "
> +		 "(default is 0, which means is disabled by default)");

> +static void debug_force_cpu_powered_up(struct debug_drvdata *drvdata)
> +{
> +	int timeout = DEBUG_WAIT_TIMEOUT;
> +
> +	drvdata->edprsr = readl_relaxed(drvdata->base + EDPRSR);
> +
> +	CS_UNLOCK(drvdata->base);
> +
> +	/* Bail out if CPU is powered up yet */
> +	if (drvdata->edprsr & EDPRSR_PU)
> +		goto out_powered_up;
> +
> +	/*
> +	 * Send request to power management controller and assert
> +	 * DBGPWRUPREQ signal; if power management controller has
> +	 * sane implementation, it should enable CPU power domain
> +	 * in case CPU is in low power state.
> +	 */
> +	drvdata->edprsr = readl(drvdata->base + EDPRCR);
> +	drvdata->edprsr |= EDPRCR_COREPURQ;

You seem to be overloading the edprsr member here with EDPRCR by mistake.
Since we don't need a cached value of EDPRCR, you might as well use a local
variable here.

> +	writel(drvdata->edprsr, drvdata->base + EDPRCR);
> +
> +	/* Wait for CPU to be powered up (timeout~=32ms) */
> +	while (timeout--) {
> +		drvdata->edprsr = readl_relaxed(drvdata->base + EDPRSR);
> +		if (drvdata->edprsr & EDPRSR_PU)
> +			break;
> +
> +		usleep_range(1000, 2000);
> +	}

We have coresight_timeout() already, but not in a reusable shape (regarding
the timeout). We could possibly reuse it in the future.

> +
> +	/*
> +	 * Unfortunately the CPU cannot be powered up, so return
> +	 * back and later has no permission to access other
> +	 * registers. For this case, should set 'idle_constraint'
> +	 * to ensure CPU power domain is enabled!
> +	 */
> +	if (!(drvdata->edprsr & EDPRSR_PU)) {
> +		pr_err("%s: power up request for CPU%d failed\n",
> +			__func__, drvdata->cpu);
> +		goto out;
> +	}
> +
> +out_powered_up:
> +	debug_os_unlock(drvdata);

Question: Do we need a matching debug_os_lock() once we are done ?

> +
> +	/*
> +	 * At this point the CPU is powered up, so set the no powerdown
> +	 * request bit so we don't lose power and emulate power down.
> +	 */
> +	drvdata->edprsr = readl(drvdata->base + EDPRCR);
> +	drvdata->edprsr |= EDPRCR_COREPURQ | EDPRCR_CORENPDRQ;
> +	writel(drvdata->edprsr, drvdata->base + EDPRCR);
> +
> +out:
> +	CS_LOCK(drvdata->base);
> +}
> +
> +static void debug_read_regs(struct debug_drvdata *drvdata)
> +{
> +	/*
> +	 * Ensure CPU power domain is enabled to let registers
> +	 * are accessiable.
> +	 */
> +	debug_force_cpu_powered_up(drvdata);
> +
> +	if (!debug_access_permitted(drvdata))
> +		return;
> +
> +	CS_UNLOCK(drvdata->base);
> +
> +	debug_os_unlock(drvdata);
> +
> +	drvdata->edpcsr = readl_relaxed(drvdata->base + EDPCSR);
> +
> +	/*
> +	 * As described in ARM DDI 0487A.k, if the processing
> +	 * element (PE) is in debug state, or sample-based
> +	 * profiling is prohibited, EDPCSR reads as 0xFFFFFFFF;
> +	 * EDCIDSR, EDVIDSR and EDPCSR_HI registers also become
> +	 * UNKNOWN state. So directly bail out for this case.
> +	 */
> +	if (drvdata->edpcsr == EDPCSR_PROHIBITED)
> +		goto out;
> +
> +	/*
> +	 * A read of the EDPCSR normally has the side-effect of
> +	 * indirectly writing to EDCIDSR, EDVIDSR and EDPCSR_HI;
> +	 * at this point it's safe to read value from them.
> +	 */
> +	if (IS_ENABLED(CONFIG_64BIT))
> +		drvdata->edpcsr_hi = readl_relaxed(drvdata->base + EDPCSR_HI);
> +
> +	if (drvdata->edcidsr_present)
> +		drvdata->edcidsr = readl_relaxed(drvdata->base + EDCIDSR);
> +
> +	if (drvdata->edvidsr_present)
> +		drvdata->edvidsr = readl_relaxed(drvdata->base + EDVIDSR);
> +
> +out:
> +	CS_LOCK(drvdata->base);
> +}
> +

> +#ifndef CONFIG_64BIT

Instead of using this #ifndef/ifdef check twice (here and in the caller), we could :

> +static unsigned long debug_adjust_pc(struct debug_drvdata *drvdata,
> +				     unsigned long pc)
> +{
> +	unsigned long arm_inst_offset = 0, thumb_inst_offset = 0;
> +
	if (IS_ENABLED(CONFIG_64BIT))
		return drvdata->edpcsr_hi << 32 | drvdata->edpcsr;

> +	if (drvdata->pc_has_offset) {
> +		arm_inst_offset = 8;
> +		thumb_inst_offset = 4;
> +	}
> +
> +	/* Handle thumb instruction */
> +	if (pc & EDPCSR_THUMB) {
> +		pc = (pc & EDPCSR_THUMB_INST_MASK) - thumb_inst_offset;
> +		return pc;
> +	}
> +
> +	/*
> +	 * Handle arm instruction offset, if the arm instruction
> +	 * is not 4 byte alignment then it's possible the case
> +	 * for implementation defined; keep original value for this
> +	 * case and print info for notice.
> +	 */
> +	if (pc & BIT(1))
> +		pr_emerg("Instruction offset is implementation defined\n");
> +	else
> +		pc = (pc & EDPCSR_ARM_INST_MASK) - arm_inst_offset;
> +
> +	return pc;
> +}

> +#endif
> +
> +static void debug_dump_regs(struct debug_drvdata *drvdata)
> +{
> +	unsigned long pc;
> +
> +	pr_emerg("\tEDPRSR:  %08x (Power:%s DLK:%s)\n", drvdata->edprsr,
> +		 drvdata->edprsr & EDPRSR_PU ? "On" : "Off",
> +		 drvdata->edprsr & EDPRSR_DLK ? "Lock" : "Unlock");
> +
> +	if (!debug_access_permitted(drvdata)) {
> +		pr_emerg("No permission to access debug registers!\n");
> +		return;
> +	}
> +
> +	if (drvdata->edpcsr == EDPCSR_PROHIBITED) {
> +		pr_emerg("CPU is in Debug state or profiling is prohibited!\n");
> +		return;
> +	}
> +

> +#ifdef CONFIG_64BIT
> +	pc = (unsigned long)drvdata->edpcsr_hi << 32 |
> +	     (unsigned long)drvdata->edpcsr;
> +#else
> +	pc = debug_adjust_pc(drvdata, (unsigned long)drvdata->edpcsr);
> +#endif

nit: see above, comment for debug_adjust_pc().


> +
> +	pr_emerg("\tEDPCSR:  [<%p>] %pS\n", (void *)pc, (void *)pc);
> +
> +	if (drvdata->edcidsr_present)
> +		pr_emerg("\tEDCIDSR: %08x\n", drvdata->edcidsr);
> +
> +	if (drvdata->edvidsr_present)
> +		pr_emerg("\tEDVIDSR: %08x (State:%s Mode:%s Width:%dbits VMID:%x)\n",
> +			 drvdata->edvidsr,
> +			 drvdata->edvidsr & EDVIDSR_NS ? "Non-secure" : "Secure",
> +			 drvdata->edvidsr & EDVIDSR_E3 ? "EL3" :
> +				(drvdata->edvidsr & EDVIDSR_E2 ? "EL2" : "EL1/0"),
> +			 drvdata->edvidsr & EDVIDSR_HV ? 64 : 32,
> +			 drvdata->edvidsr & (u32)EDVIDSR_VMID);
> +}
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

As mentioned above, both of these registers are only need at init time to
figure out the flags we set here. So we could remove them.

> +
> +	CS_LOCK(drvdata->base);
> +
> +	/* Parse implementation feature */
> +	mode = drvdata->eddevid & EDDEVID_PCSAMPLE_MODE;
> +	pcsr_offset = drvdata->eddevid1 & EDDEVID1_PCSR_OFFSET_MASK;


> +
> +	if (mode == EDDEVID_IMPL_NONE) {
> +		drvdata->edpcsr_present  = false;
> +		drvdata->edcidsr_present = false;
> +		drvdata->edvidsr_present = false;
> +	} else if (mode == EDDEVID_IMPL_EDPCSR) {
> +		drvdata->edpcsr_present  = true;
> +		drvdata->edcidsr_present = false;
> +		drvdata->edvidsr_present = false;
> +	} else if (mode == EDDEVID_IMPL_EDPCSR_EDCIDSR) {
> +		if (!IS_ENABLED(CONFIG_64BIT) &&
> +			(pcsr_offset == EDDEVID1_PCSR_NO_OFFSET_DIS_AARCH32))
> +			drvdata->edpcsr_present = false;
> +		else
> +			drvdata->edpcsr_present = true;

Sorry, I forgot why we do this check only in this mode. Shouldn't this be
common to all modes (of course which implies PCSR is present) ?

> +
> +		drvdata->edcidsr_present = true;
> +		drvdata->edvidsr_present = false;
> +	} else if (mode == EDDEVID_IMPL_FULL) {
> +		drvdata->edpcsr_present  = true;
> +		drvdata->edcidsr_present = true;
> +		drvdata->edvidsr_present = true;
> +	}
> +
> +	if (IS_ENABLED(CONFIG_64BIT))
> +		drvdata->pc_has_offset = false;
> +	else
> +		drvdata->pc_has_offset =
> +			(pcsr_offset == EDDEVID1_PCSR_OFFSET_INS_SET);
> +

nit: This if-else chain could be replaced by :

	
	drvdata->edpcsr_present = false;
	drvdata->edcidsr_present = false;
	drvdata->edvidsr_present = false;

	switch(mode) {
	case EDDEVID_IMPL_FULL:
		drvdata->edvidsr_present = true;
		/* Fall through */
	case EDDEVID_IMPL_EDPCSR_EDCIDSR:
		drvdata->edcidsr_present = true;
		/* Fall through */
	case EDDEVID_IMPL_EDPCSR:
		/*
		 * In ARM DDI 0487A.k, the EDDEVID1.PCSROffset is used to
		 * define if has the offset for PC sampling value; if read
		 * back EDDEVID1.PCSROffset == 0x2, then this means the debug
		 * module does not sample the instruction set state when
		 * armv8 CPU in AArch32 state.
		 */
		drvdata->edpcsr_present = (IS_ENABLED(CONFIG_64BIT) ||
					   (pcsr_offset != EDDEVID1_PCSR_NO_OFFSET_DIS_AARCH32));
		drvdata->pc_has_offset = (pcsr_offset == EDDEVID1_PCSR_OFFSET_INS_SET);
	default:
		break;
	}

> +	return;
> +}
> +
> +/*
> + * Dump out information on panic.
> + */
> +static int debug_notifier_call(struct notifier_block *self,
> +			       unsigned long v, void *p)
> +{
> +	int cpu;
> +	struct debug_drvdata *drvdata;
> +
> +	pr_emerg("ARM external debug module:\n");
> +
> +	for_each_possible_cpu(cpu) {

Shouldn't this be for_each_online_cpu() ? If the user has turned off a CPU,
we shouldn't try to dump its registers.

> +		drvdata = per_cpu(debug_drvdata, cpu);
> +		if (!drvdata)
> +			continue;
> +
> +		pr_emerg("CPU[%d]:\n", drvdata->cpu);
> +
> +		debug_read_regs(drvdata);
> +		debug_dump_regs(drvdata);
> +	}
> +
> +	return 0;
> +}
> +
> +static struct notifier_block debug_notifier = {
> +	.notifier_call = debug_notifier_call,
> +};
> +
> +static int debug_enable_func(void)
> +{
> +	int ret;
> +

I think we should request the power domain here, now that the user
has explicitly requested the feature to be turned on and released
in debug_disable_func().

> +	pm_qos_add_request(&debug_qos_req,
> +		PM_QOS_CPU_DMA_LATENCY, idle_constraint);
> +
> +	ret = atomic_notifier_chain_register(&panic_notifier_list,
> +					     &debug_notifier);

...

> +	if (ret)
> +		goto err;
> +
> +	return 0;
> +
> +err:
> +	pm_qos_remove_request(&debug_qos_req);
> +	return ret;

nit : this could be :

	if (ret)
		pm_qos_remove_request(&debug_qos_req);
	return ret;

> +}
> +
> +static void debug_disable_func(void)
> +{

As noted above, we could drop the power domain here.

> +	atomic_notifier_chain_unregister(&panic_notifier_list,
> +					 &debug_notifier);
> +	pm_qos_remove_request(&debug_qos_req);
> +}
> +
> +static ssize_t debug_func_knob_write(struct file *f,
> +		const char __user *buf, size_t count, loff_t *ppos)
> +{

> +	if (on) {
> +		ret = debug_enable_func();
> +		if (ret) {
> +			pr_err("%s: unable to disable debug function: %d\n",
> +			       __func__, ret);
> +			goto err;
> +		}
> +	} else
> +		debug_disable_func();

As per Linux codingstyle rules, you should use {} for the else section.
See Documentation/process/coding-style.rst: Section 3.


> +static ssize_t debug_idle_constraint_write(struct file *f,
> +		const char __user *buf, size_t count, loff_t *ppos)
> +{
> +	int val;
> +	ssize_t ret;
> +
> +	ret = kstrtoint_from_user(buf, count, 10, &val);
> +	if (ret)
> +		return ret;
> +
> +	mutex_lock(&debug_lock);
> +	idle_constraint = val;
> +
> +	if (debug_enable)
> +		pm_qos_update_request(&debug_qos_req, idle_constraint);
> +
> +	mutex_unlock(&debug_lock);
> +	return count;
> +}
> +
> +static ssize_t debug_idle_constraint_read(struct file *f,
> +		char __user *ubuf, size_t count, loff_t *ppos)
> +{
> +	char buf[32];
> +	int len;
> +
> +	if (*ppos)
> +		return 0;

It would be better if we do :

> +
> +	len = sprintf(buf, "%d\n", idle_constraint);

	if (*ppos > len)
		return 0;

> +	return simple_read_from_buffer(ubuf, count, ppos, buf, len);

	return simple_read_from_buffer(ubuf, count, ppos, buf + *ppos, len - *ppos);

> +
> +static int debug_func_init(void)
> +{
> +	struct dentry *file;
> +	int ret;

...

> +	/* Enable debug module at boot time */
> +	ret = debug_enable_func();
> +	if (ret) {
> +		pr_err("%s: unable to disable debug function: %d\n",

s/disable/enable ?

> +		       __func__, ret);
> +		goto err;
> +	}
> +
> +	return 0;
> +
> +err:
> +	debugfs_remove_recursive(debug_debugfs_dir);
> +	return ret;
> +}
> +
> +static void debug_func_exit(void)
> +{
> +	debugfs_remove_recursive(debug_debugfs_dir);
> +
> +	/* Disable functionality if has enabled */
> +	if (debug_enable)
> +		debug_disable_func();
> +}
> +
> +static int debug_probe(struct amba_device *adev, const struct amba_id *id)
> +{
> +	void __iomem *base;
> +	struct device *dev = &adev->dev;
> +	struct debug_drvdata *drvdata;
> +	struct resource *res = &adev->res;
> +	struct device_node *np = adev->dev.of_node;
> +	int ret;
> +
> +	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
> +	if (!drvdata)
> +		return -ENOMEM;
> +
> +	drvdata->cpu = np ? of_coresight_get_cpu(np) : 0;
> +	if (per_cpu(debug_drvdata, drvdata->cpu)) {
> +		dev_err(dev, "CPU's drvdata has been initialized\n");
> +		return -EBUSY;
> +	}
> +
> +	drvdata->dev = &adev->dev;
> +	amba_set_drvdata(adev, drvdata);
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
> +	ret = smp_call_function_single(drvdata->cpu,
> +				debug_init_arch_data, drvdata, 1);
> +	put_online_cpus();

Now that we have dynamic enable/disable of the feature, we should do a pm_runtime_put()
as expected and try to get_ the power domain when we enable the debug.


Suzuki
