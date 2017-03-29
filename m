From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Wed, 29 Mar 2017 09:41:15 -0600
Subject: [PATCH v5 6/9] coresight: add support for CPU debug module
In-Reply-To: <20170329030735.GA23889@leoy-linaro>
References: <1490466197-29163-1-git-send-email-leo.yan@linaro.org>
 <1490466197-29163-7-git-send-email-leo.yan@linaro.org>
 <31be033f-514e-e48a-3ba2-a5c5cd477548@arm.com>
 <20170329030735.GA23889@leoy-linaro>
Message-ID: <20170329154115.GA24889@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 29, 2017 at 11:07:35AM +0800, Leo Yan wrote:
> Hi Suzuki,
> 
> On Mon, Mar 27, 2017 at 05:34:57PM +0100, Suzuki K Poulose wrote:
> > On 25/03/17 18:23, Leo Yan wrote:
> 
> [...]
> 
> > Leo,
> > 
> > Thanks a lot for the quick rework. I don't fully understand (yet!) why we need the
> > idle_constraint. I will leave it for Sudeep to comment on it, as he is the expert
> > in that area. Some minor comments below.
> 
> Thanks a lot for quick reviewing :)
> 
> > >Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > >---
> > > drivers/hwtracing/coresight/Kconfig               |  11 +
> > > drivers/hwtracing/coresight/Makefile              |   1 +
> > > drivers/hwtracing/coresight/coresight-cpu-debug.c | 704 ++++++++++++++++++++++
> > > 3 files changed, 716 insertions(+)
> > > create mode 100644 drivers/hwtracing/coresight/coresight-cpu-debug.c
> > >
> > >diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
> > >index 130cb21..18d7931 100644
> > >--- a/drivers/hwtracing/coresight/Kconfig
> > >+++ b/drivers/hwtracing/coresight/Kconfig
> > >@@ -89,4 +89,15 @@ config CORESIGHT_STM
> > > 	  logging useful software events or data coming from various entities
> > > 	  in the system, possibly running different OSs
> > >
> > >+config CORESIGHT_CPU_DEBUG
> > >+	tristate "CoreSight CPU Debug driver"
> > >+	depends on ARM || ARM64
> > >+	depends on DEBUG_FS
> > >+	help
> > >+	  This driver provides support for coresight debugging module. This
> > >+	  is primarily used to dump sample-based profiling registers when
> > >+	  system triggers panic, the driver will parse context registers so
> > >+	  can quickly get to know program counter (PC), secure state,
> > >+	  exception level, etc.
> > 
> > May be we should mention/warn the user about the possible caveats of using
> > this feature to help him make a better decision ? And / Or we should add a documentation
> > for it. We have collected some real good information over the discussions and
> > it is a good idea to capture it somewhere.
> 
> Sure, I will add a documentation for this.
> 
> [...]
> 
> > >+static struct pm_qos_request debug_qos_req;
> > >+static int idle_constraint = PM_QOS_DEFAULT_VALUE;
> > >+module_param(idle_constraint, int, 0600);
> > >+MODULE_PARM_DESC(idle_constraint, "Latency requirement in microseconds for CPU "
> > >+		 "idle states (default is -1, which means have no limiation "
> > >+		 "to CPU idle states; 0 means disabling all idle states; user "
> > >+		 "can choose other platform dependent values so can disable "
> > >+		 "specific idle states for the platform)");
> > 
> > Correct me if I am wrong,
> > 
> > All we want to do is disable the CPUIdle explicitly if the user knows that this
> > could be a problem to use CPU debug on his platform. So, in effect, we should
> > only be using idle_constraint = 0 or -1.
> > 
> > In which case, we could make it easier for the user to tell us, either
> > 
> >  0 - Don't do anything with CPUIdle (default)
> >  1 - Disable CPUIdle for me as I know the platform has issues with CPU debug and CPUidle.
> 
> The reason for not using bool flag is: usually SoC may have many idle
> states, so if user wants to partially enable some states then can set
> the latency to constraint.
> 
> But of course, we can change this to binary value as you suggested,
> this means turn on of turn off all states. The only one reason to use
> latency value is it is more friendly for hardware design, e.g. some
> platforms can enable partial states to save power and avoid overheat
> after using this driver.
> 
> If you guys think this is a bit over design, I will follow up your
> suggestion. I also have some replying in Mathieu's reviewing, please
> help review as well.
> 
> > than explaining the miscrosecond latency etc and make the appropriate calls underneath.
> > something like (not necessarily the same name) :
> > 
> > module_param(broken_with_cpuidle, bool, 0600);
> > MODULE_PARAM_DESC(broken_with_cpuidle, "Specifies whether the CPU debug has issues with CPUIdle on"
> > 				       " the platform. Non-zero value implies CPUIdle has to be"
> > 				       " explicitly disabled.",);
> 
> [...]
> 
> > >+	/*
> > >+	 * Unfortunately the CPU cannot be powered up, so return
> > >+	 * back and later has no permission to access other
> > >+	 * registers. For this case, should set 'idle_constraint'
> > >+	 * to ensure CPU power domain is enabled!
> > >+	 */
> > >+	if (!(drvdata->edprsr & EDPRSR_PU)) {
> > >+		pr_err("%s: power up request for CPU%d failed\n",
> > >+			__func__, drvdata->cpu);
> > >+		goto out;
> > >+	}
> > >+
> > >+out_powered_up:
> > >+	debug_os_unlock(drvdata);
> > 
> > Question: Do we need a matching debug_os_lock() once we are done ?
> 
> I have checked ARM ARMv8, but there have no detailed description for
> this. I refered coresight-etmv4 code and Mike's pseudo code, ther have
> no debug_os_lock() related operations.
> 
> Mike, Mathieu, could you also help confirm this?

I'm not strongly opiniated on the usage of the OS lock, hence being a little
nonchalent in the coresight-etmv4 driver.   

> 
> [...]
> 
> > >+static void debug_init_arch_data(void *info)
> > >+{
> > >+	struct debug_drvdata *drvdata = info;
> > >+	u32 mode, pcsr_offset;
> > >+
> > >+	CS_UNLOCK(drvdata->base);
> > >+
> > >+	debug_os_unlock(drvdata);
> > >+
> > >+	/* Read device info */
> > >+	drvdata->eddevid  = readl_relaxed(drvdata->base + EDDEVID);
> > >+	drvdata->eddevid1 = readl_relaxed(drvdata->base + EDDEVID1);
> > 
> > As mentioned above, both of these registers are only need at init time to
> > figure out the flags we set here. So we could remove them.
> > 
> > >+
> > >+	CS_LOCK(drvdata->base);
> > >+
> > >+	/* Parse implementation feature */
> > >+	mode = drvdata->eddevid & EDDEVID_PCSAMPLE_MODE;
> > >+	pcsr_offset = drvdata->eddevid1 & EDDEVID1_PCSR_OFFSET_MASK;
> > 
> > 
> > >+
> > >+	if (mode == EDDEVID_IMPL_NONE) {
> > >+		drvdata->edpcsr_present  = false;
> > >+		drvdata->edcidsr_present = false;
> > >+		drvdata->edvidsr_present = false;
> > >+	} else if (mode == EDDEVID_IMPL_EDPCSR) {
> > >+		drvdata->edpcsr_present  = true;
> > >+		drvdata->edcidsr_present = false;
> > >+		drvdata->edvidsr_present = false;
> > >+	} else if (mode == EDDEVID_IMPL_EDPCSR_EDCIDSR) {
> > >+		if (!IS_ENABLED(CONFIG_64BIT) &&
> > >+			(pcsr_offset == EDDEVID1_PCSR_NO_OFFSET_DIS_AARCH32))
> > >+			drvdata->edpcsr_present = false;
> > >+		else
> > >+			drvdata->edpcsr_present = true;
> > 
> > Sorry, I forgot why we do this check only in this mode. Shouldn't this be
> > common to all modes (of course which implies PCSR is present) ?
> 
> No. PCSROffset is defined differently in ARMv7 and ARMv8; So finally we
> simplize PCSROffset value :
> 0000 - Sample offset applies based on the instruction state (indicated by PCSR[0])
> 0001 - No offset applies.
> 0010 - No offset applies, but do not use in AArch32 mode!
> 
> So we need handle the corner case is when CPU runs AArch32 mode and
> PCSRoffset = 'b0010. Other cases the pcsr should be present.
> 
> [...]
> 
> Other suggestions are good for me, will take them in next version.
> 
> Thanks,
> Leo Yan
