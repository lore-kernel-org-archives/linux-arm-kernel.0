From: leo.yan@linaro.org (Leo Yan)
Date: Fri, 10 Mar 2017 01:59:15 +0800
Subject: [v3 3/5] coresight: add support for debug module
In-Reply-To: <011fdac0-59bf-b539-2de3-0b59a41bc922@arm.com>
References: <1488520809-31670-4-git-send-email-leo.yan@linaro.org>
 <011fdac0-59bf-b539-2de3-0b59a41bc922@arm.com>
Message-ID: <20170309175915.GA964@leoy-linaro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Suziku,

Thanks for reviewing, please see some replying.

On Thu, Mar 09, 2017 at 04:53:05PM +0000, Suzuki K Poulose wrote:
> On 03/03/17 06:00, Leo Yan wrote:
> >Coresight includes debug module and usually the module connects with CPU
> >debug logic. ARMv8 architecture reference manual (ARM DDI 0487A.k) has
> >description for related info in "Part H: External Debug".
> >
> >Chapter H7 "The Sample-based Profiling Extension" introduces several
> >sampling registers, e.g. we can check program counter value with
> >combined CPU exception level, secure state, etc. So this is helpful for
> >analysis CPU lockup scenarios, e.g. if one CPU has run into infinite
> >loop with IRQ disabled. In this case the CPU cannot switch context and
> >handle any interrupt (including IPIs), as the result it cannot handle
> >SMP call for stack dump.
> >
> >This patch is to enable coresight debug module, so firstly this driver
> >is to bind apb clock for debug module and this is to ensure the debug
> >module can be accessed from program or external debugger. And the driver
> >uses sample-based registers for debug purpose, e.g. when system detects
> >the CPU lockup and trigger panic, the driver will dump program counter
> >and combined context registers (EDCIDSR, EDVIDSR); by parsing context
> >registers so can quickly get to know CPU secure state, exception level,
> >etc.
> 
> The problem is, it is not guaranteed that the EDPCSR_Hi, EDCIDSR & EDVIDSR are
> updated as a side effect of a memory mapped access (which is what we do here) to the
> EDPCSR_Lo.
> 
> Section H.7.1.2 : Reads of EDPCSRs (in ARM DDI 0487A.k) :
> 
> "The indirect writes to EDCIDSR, EDVIDSR, and EDPCSRhi might not occur for a memory-mapped access
> to the external debug interface. For more information, see Memory-mapped accesses to the external debug
> interface on page H8-4968."
> 
> So we cannot really rely on the values in EDVIDSR which we use to make further decisions. So I
> am wondering if this is really guranteed to be useful.

So this is caused by Software lock is locked?

Section H8.4.1: 

"Reads and writes have no side-effects. A side-effect is where a
direct read or a direct write of a register creates
an indirect write of the same or another register. When the Software
Lock is locked, the indirect write does
not occur."

> >Some of the debug module registers are located in CPU power domain, so
> >in the driver it has checked the power state for CPU before accessing
> >registers within CPU power domain. For most safe way to use this driver,
> >it's suggested to disable CPU low power states, this can simply set
> >"nohlt" in kernel command line.
> >
> >Signed-off-by: Leo Yan <leo.yan@linaro.org>
> >---
> > drivers/hwtracing/coresight/Kconfig           |  10 +
> > drivers/hwtracing/coresight/Makefile          |   1 +
> > drivers/hwtracing/coresight/coresight-debug.c | 377 ++++++++++++++++++++++++++
> > 3 files changed, 388 insertions(+)
> > create mode 100644 drivers/hwtracing/coresight/coresight-debug.c
> >
> >diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
> >index 130cb21..3ed651e 100644
> >--- a/drivers/hwtracing/coresight/Kconfig
> >+++ b/drivers/hwtracing/coresight/Kconfig
> >@@ -89,4 +89,14 @@ config CORESIGHT_STM
> > 	  logging useful software events or data coming from various entities
> > 	  in the system, possibly running different OSs
> >
> >+config CORESIGHT_DEBUG
> 
> To make it more specific, may be CORESIGHT_CPU_DEBUG ?

Will fix.

> >+	bool "CoreSight debug driver"
> 
> "Coresight CPU Debug driver"

Will fix.

> >+	depends on ARM || ARM64
> >+	help
> >+	  This driver provides support for coresight debugging module. This
> >+	  is primarily used to dump sample-based profiling registers for
> >+	  panic. To avoid lockups when accessing debug module registers,
> >+	  it is safer to disable CPU low power states (like "nohlt" on the
> >+	  kernel command line) when using this feature.
> >+
> 
> >+#define EDPCSR_THUMB			BIT(0)
> >+#define EDPCSR_ARM_INST_MASK		GENMASK(31, 2)
> >+#define EDPCSR_THUMB_INST_MASK		GENMASK(31, 1)
> 
> We don't need two different masks. {ED/DBG}PCSR has only bit 0 reserved
> for instruction set indication.

I think we need this two different masks. Please review below extra doc
for PC offset analysis in ARM ARM.

> >+#endif
> >+
> >+/* bits definition for EDPRSR */
> >+#define EDPRSR_DLK			BIT(6)
> >+#define EDPRSR_PU			BIT(0)
> >+
> >+
> >+static void debug_read_regs(struct debug_drvdata *drvdata)
> >+{
> >+	drvdata->edprsr = readl_relaxed(drvdata->base + EDPRSR);
> >+
> >+	if (!debug_access_permitted(drvdata))
> >+		return;
> >+
> >+	if (!drvdata->edpcsr_present)
> >+		return;
> >+
> >+	CS_UNLOCK(drvdata->base);
> >+
> >+	debug_os_unlock(drvdata);
> >+
> >+	drvdata->edpcsr = readl_relaxed(drvdata->base + EDPCSR);
> >+
> >+	/*
> >+	 * As described in ARM DDI 0487A.k, if the processing
> >+	 * element (PE) is in debug state, or sample-based
> >+	 * profiling is prohibited, EDPCSR reads as 0xFFFFFFFF;
> >+	 * EDCIDSR, EDVIDSR and EDPCSR_HI registers also become
> >+	 * UNKNOWN state. So directly bail out for this case.
> >+	 */
> >+	if (drvdata->edpcsr == EDPCSR_PROHIBITED) {
> >+		CS_LOCK(drvdata->base);
> >+		return;
> >+	}
> >+
> >+	/*
> >+	 * A read of the EDPCSR normally has the side-effect of
> >+	 * indirectly writing to EDCIDSR, EDVIDSR and EDPCSR_HI;
> >+	 * at this point it's safe to read value from them.
> >+	 */
> 
> See my comment above about the side effects of memory mapped access.

Yeah.

> >+	drvdata->edcidsr = readl_relaxed(drvdata->base + EDCIDSR);
> >+#ifdef CONFIG_64BIT
> >+	drvdata->edpcsr_hi = readl_relaxed(drvdata->base + EDPCSR_HI);
> >+#endif
> 
> >+
> >+	if (drvdata->edvidsr_present)
> >+		drvdata->edvidsr = readl_relaxed(drvdata->base + EDVIDSR);
> >+
> >+	CS_LOCK(drvdata->base);
> >+}
> >+
> 
> >+#ifndef CONFIG_64BIT
> 
> I guess this doesn't help for an ARMv8 32bit only core (e.g, Cortex-A32). And
> unfortunately, there are conflicting definitions for the values for PCSROffset w.r.t
> ARMv8 and ARMv7.
> 
> DBGDEVID1[3:0] For ARMv7 :
> 
> 0000 - Sample offset applies based on the instruction state.
> 0001 - No offset applies.
> 
> EDDEVID1[3:0] For ARMv8 :
> 0000 - EDPCSR not implemented
> 0010 - EDPCSR implemented without offsets, but do not use in AArch32 state!
> 
> So there is no easy way to make sense of the value, unless you know which version
> of the architecture is in use. Or may be we could co-relate it with the value from
> DEVID.
> 
> i.e, EDPCSR is not implemented do not register this device, see comments on debug_probe().
> ( And we should also include the following test for 32bit code to see if edpcsr is implemented.
> See comments on debug_init_arch_data() )
> 
> 
> That way, we could use the following inference from the PCSROffset value :
> 
> 0000 - Sample offset applies based on the instruction state (indicated by PCSR[0])
> 0001 - No offset applies.
> 0010 - No offset applies, but do not use in AArch32 mode

Just now I went through ARM ARM and ARMv8 ARM, this makes sense to me.
Thanks for good pointing for this.

> >+static bool debug_pc_has_offset(struct debug_drvdata *drvdata)
> >+{
> >+	u32 pcsr_offset;
> >+
> >+	pcsr_offset = drvdata->eddevid1 & EDDEVID1_PCSR_OFFSET_MASK;
> >+
> >+	return (pcsr_offset == EDDEVID1_PCSR_OFFSET_INS_SET);
> >+}
> >+
> >+static unsigned long debug_adjust_pc(struct debug_drvdata *drvdata,
> >+				     unsigned long pc)
> >+{
> >+	unsigned long arm_inst_offset = 0, thumb_inst_offset = 0;
> >+
> >+	if (debug_pc_has_offset(drvdata)) {
> >+		arm_inst_offset = 8;
> >+		thumb_inst_offset = 4;
> >+	}
> >+
> >+	/* Handle thumb instruction */
> >+	if (pc & EDPCSR_THUMB) {
> >+		pc = (pc & EDPCSR_THUMB_INST_MASK) - thumb_inst_offset;
> >+		return pc;
> >+	}
> >+
> >+	/*
> >+	 * Handle arm instruction offset, if the arm instruction
> >+	 * is not 4 byte alignment then it's possible the case
> >+	 * for implementation defined; keep original value for this
> >+	 * case and print info for notice.
> >+	 */
> >+	if (pc & BIT(1))
> >+		pr_emerg("Instruction offset is implementation defined\n");
> 
> I am struggling to find the any mention about this in the ARM ARM. Please could
> you point me to it.

Sure, please see ARM DDI 0406C.b, chapter C11.11.34 "
DBGPCSR, Program Counter Sampling Register":

A profiling tool can use the value of the T bit to calculate the
instruction address as follows:

When an offset is applied to the sampled address
- if T is 0 and DBGPCSR[1] is 0, ((DBGPCSR[31:2] << 2) - 8) is the
address of the sampled ARM instruction
- if T is 0 and DBGPCSR[1] is 1, the instruction address is
IMPLEMENTATION DEFINED
- if T is 1, ((DBGPCSR[31:1] << 1) - 4) is the address of the sampled
Thumb or ThumbEE instruction.

When no offset is applied to the sampled address
-  if T is 0 and DBGPCSR[1] is 0, (DBGPCSR[31:2] << 2) is the address
of the sampled ARM instruction
-  if T is 0 and DBGPCSR[1] is 1, the instruction address is
IMPLEMENTATION DEFINED
- if T is 1, (DBGPCSR[31:1] << 1) is the address of the sampled Thumb
or ThumbEE instruction.

> >+static void debug_init_arch_data(void *info)
> >+{
> >+	struct debug_drvdata *drvdata = info;
> >+	u32 mode;
> >+
> >+	CS_UNLOCK(drvdata->base);
> >+
> >+	debug_os_unlock(drvdata);
> >+
> >+	/* Read device info */
> >+	drvdata->eddevid  = readl_relaxed(drvdata->base + EDDEVID);
> >+	drvdata->eddevid1 = readl_relaxed(drvdata->base + EDDEVID1);
> >+
> >+	/* Parse implementation feature */
> >+	mode = drvdata->eddevid & EDDEVID_PCSAMPLE_MODE;
> >+	if (mode == EDDEVID_IMPL_FULL) {
> >+		drvdata->edpcsr_present  = true;
> >+		drvdata->edvidsr_present = true;
> >+	} else if (mode == EDDEVID_IMPL_EDPCSR_EDCIDSR) {
> >+		drvdata->edpcsr_present  = true;
> >+		drvdata->edvidsr_present = false;
> 
> As discussed above, we need to consult the DEVID1:PCSROffset for AArch32 to decide
> if we have the edpcsr implemented on ARMv8.

Yeah.

> >+	} else {
> >+		drvdata->edpcsr_present  = false;
> >+		drvdata->edvidsr_present = false;
> >+	}
> >+
> >+	CS_LOCK(drvdata->base);
> >+}
> >+
> >+static int debug_probe(struct amba_device *adev, const struct amba_id *id)
> >+{
> >+	void __iomem *base;
> >+	struct device *dev = &adev->dev;
> >+	struct debug_drvdata *drvdata;
> >+	struct resource *res = &adev->res;
> >+	struct device_node *np = adev->dev.of_node;
> >+	char buf[32];
> >+	static int debug_count;
> >+
> >+	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
> >+	if (!drvdata)
> >+		return -ENOMEM;
> >+
> >+	drvdata->cpu = np ? of_coresight_get_cpu(np) : 0;
> >+	drvdata->dev = &adev->dev;
> >+
> >+	dev_set_drvdata(dev, drvdata);
> >+
> >+	/* Validity for the resource is already checked by the AMBA core */
> >+	base = devm_ioremap_resource(dev, res);
> >+	if (IS_ERR(base))
> >+		return PTR_ERR(base);
> >+
> >+	drvdata->base = base;
> >+
> >+	get_online_cpus();
> >+	per_cpu(debug_drvdata, drvdata->cpu) = drvdata;
> >+
> >+	if (smp_call_function_single(drvdata->cpu,
> >+				debug_init_arch_data, drvdata, 1))
> >+		dev_err(dev, "Debug arch init failed\n");
> 
> If this fails (say the CPU was offline), should we still return success ?
> And may be we should check if the drvdata->edpcsr_present to detect if the CPU
> implements the PC Sampling and return failure here if it doesn't.

Will fix.

> >+
> >+	put_online_cpus();
> >+
> >+	if (!debug_count++)
> >+		atomic_notifier_chain_register(&panic_notifier_list,
> >+					       &debug_notifier);
> >+
> 
> >+	sprintf(buf, (char *)id->data, drvdata->cpu);
> >+	dev_info(dev, "%s initialized\n", buf);
> 
> This could simply be :
> 	dev_info(dev, "Coresight debug-CPU%d initialized\n", drvdata->cpu);
> 
> and get rid of the static string and the buffer, see below.
> 
> >+	return 0;
> >+}
> >+
> >+static struct amba_id debug_ids[] = {
> >+	{       /* Debug for Cortex-A53 */
> >+		.id	= 0x000bbd03,
> >+		.mask	= 0x000fffff,
> 
> ...
> 
> >+		.data   = "Coresight debug-CPU%d",
> 
> I think this is pointless, as the debug area we are interested in is always associated
> with a CPU, we could as well figure out what to print from the drvdata->cpu above.

I prefer to follow your suggestion for upper two comments; but I'd like
check with Mathieu, due I followed up Mathieu's suggestion to write
current code.

Thanks,
Leo Yan
