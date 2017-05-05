From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Fri, 5 May 2017 08:48:32 -0600
Subject: [PATCH v8 5/7] coresight: add support for CPU debug module
In-Reply-To: <4cd0e395-c177-0b72-9cab-7a95aac9cca4@arm.com>
References: <1493719717-27698-1-git-send-email-leo.yan@linaro.org>
 <1493719717-27698-6-git-send-email-leo.yan@linaro.org>
 <4cd0e395-c177-0b72-9cab-7a95aac9cca4@arm.com>
Message-ID: <20170505144832.GA4507@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 05, 2017 at 02:55:17PM +0100, Sudeep Holla wrote:
> 
> 
> On 02/05/17 11:08, Leo Yan wrote:
> > Coresight includes debug module and usually the module connects with CPU
> > debug logic. ARMv8 architecture reference manual (ARM DDI 0487A.k) has
> > description for related info in "Part H: External Debug".
> > 
> > Chapter H7 "The Sample-based Profiling Extension" introduces several
> > sampling registers, e.g. we can check program counter value with
> > combined CPU exception level, secure state, etc. So this is helpful for
> > analysis CPU lockup scenarios, e.g. if one CPU has run into infinite
> > loop with IRQ disabled. In this case the CPU cannot switch context and
> > handle any interrupt (including IPIs), as the result it cannot handle
> > SMP call for stack dump.
> > 
> > This patch is to enable coresight debug module, so firstly this driver
> > is to bind apb clock for debug module and this is to ensure the debug
> > module can be accessed from program or external debugger. And the driver
> > uses sample-based registers for debug purpose, e.g. when system triggers
> > panic, the driver will dump program counter and combined context
> > registers (EDCIDSR, EDVIDSR); by parsing context registers so can
> > quickly get to know CPU secure state, exception level, etc.
> > 
> > Some of the debug module registers are located in CPU power domain, so
> > this requires the CPU power domain stays on when access related debug
> > registers, but the power management for CPU power domain is quite
> > dependent on SoC integration for power management. For the platforms
> > which with sane power controller implementations, this driver follows
> > the method to set EDPRCR to try to pull the CPU out of low power state
> > and then set 'no power down request' bit so the CPU has no chance to
> > lose power.
> > 
> > If the SoC has not followed up this design well for power management
> > controller, the user should use the command line parameter or sysfs
> > to constrain all or partial idle states to ensure the CPU power
> > domain is enabled and access coresight CPU debug component safely.
> > 
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > ---
> >  drivers/hwtracing/coresight/Kconfig               |  14 +
> >  drivers/hwtracing/coresight/Makefile              |   1 +
> >  drivers/hwtracing/coresight/coresight-cpu-debug.c | 670 ++++++++++++++++++++++
> >  3 files changed, 685 insertions(+)
> >  create mode 100644 drivers/hwtracing/coresight/coresight-cpu-debug.c
> > 
> > diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
> > index 130cb21..8d55d6d 100644
> > --- a/drivers/hwtracing/coresight/Kconfig
> > +++ b/drivers/hwtracing/coresight/Kconfig
> > @@ -89,4 +89,18 @@ config CORESIGHT_STM
> >  	  logging useful software events or data coming from various entities
> >  	  in the system, possibly running different OSs
> >  
> > +config CORESIGHT_CPU_DEBUG
> > +	tristate "CoreSight CPU Debug driver"
> > +	depends on ARM || ARM64
> > +	depends on DEBUG_FS
> > +	help
> > +	  This driver provides support for coresight debugging module. This
> > +	  is primarily used to dump sample-based profiling registers when
> > +	  system triggers panic, the driver will parse context registers so
> > +	  can quickly get to know program counter (PC), secure state,
> > +	  exception level, etc. Before use debugging functionality, platform
> > +	  needs to ensure the clock domain and power domain are enabled
> > +	  properly, please refer Documentation/trace/coresight-cpu-debug.txt
> > +	  for detailed description and the example for usage.
> > +
> >  endif
> > diff --git a/drivers/hwtracing/coresight/Makefile b/drivers/hwtracing/coresight/Makefile
> > index af480d9..433d590 100644
> > --- a/drivers/hwtracing/coresight/Makefile
> > +++ b/drivers/hwtracing/coresight/Makefile
> > @@ -16,3 +16,4 @@ obj-$(CONFIG_CORESIGHT_SOURCE_ETM4X) += coresight-etm4x.o \
> >  					coresight-etm4x-sysfs.o
> >  obj-$(CONFIG_CORESIGHT_QCOM_REPLICATOR) += coresight-replicator-qcom.o
> >  obj-$(CONFIG_CORESIGHT_STM) += coresight-stm.o
> > +obj-$(CONFIG_CORESIGHT_CPU_DEBUG) += coresight-cpu-debug.o
> > diff --git a/drivers/hwtracing/coresight/coresight-cpu-debug.c b/drivers/hwtracing/coresight/coresight-cpu-debug.c
> > new file mode 100644
> > index 0000000..b77456d
> > --- /dev/null
> > +++ b/drivers/hwtracing/coresight/coresight-cpu-debug.c
> 
> [...]
> 
> > +static int debug_probe(struct amba_device *adev, const struct amba_id *id)
> > +{
> > +	void __iomem *base;
> > +	struct device *dev = &adev->dev;
> > +	struct debug_drvdata *drvdata;
> > +	struct resource *res = &adev->res;
> > +	struct device_node *np = adev->dev.of_node;
> > +	int ret;
> > +
> > +	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
> > +	if (!drvdata)
> > +		return -ENOMEM;
> > +
> > +	drvdata->cpu = np ? of_coresight_get_cpu(np) : 0;
> > +	if (per_cpu(debug_drvdata, drvdata->cpu)) {
> > +		dev_err(dev, "CPU%d drvdata has been initialized, "
> > +			"may be caused by binding wrong CPU node in the DT\n",
> > +			drvdata->cpu);
> > +		return -EBUSY;
> > +	}
> > +
> > +	drvdata->dev = &adev->dev;
> > +	amba_set_drvdata(adev, drvdata);
> > +
> > +	/* Validity for the resource is already checked by the AMBA core */
> > +	base = devm_ioremap_resource(dev, res);
> > +	if (IS_ERR(base))
> > +		return PTR_ERR(base);
> > +
> > +	drvdata->base = base;
> > +
> > +	get_online_cpus();
> > +	per_cpu(debug_drvdata, drvdata->cpu) = drvdata;
> > +	ret = smp_call_function_single(drvdata->cpu, debug_init_arch_data,
> > +				       drvdata, 1);
> > +	put_online_cpus();
> > +
> > +	if (ret) {
> > +		dev_err(dev, "CPU%d debug arch init failed\n", drvdata->cpu);
> > +		goto err;
> > +	}
> > +
> > +	if (!drvdata->edpcsr_present) {
> > +		dev_err(dev, "CPU%d sample-based profiling isn't implemented\n",
> > +			drvdata->cpu);
> > +		ret = -ENXIO;
> > +		goto err;
> > +	}
> > +
> > +	if (!debug_count++) {
> > +		ret = debug_func_init();
> > +		if (ret)
> > +			goto err_func_init;
> > +	}
> > +
> > +	mutex_lock(&debug_lock);
> > +	if (!debug_enable)
> > +		pm_runtime_put(dev);
> > +	mutex_unlock(&debug_lock);
> > +
> 
> Just curious as why this is not registered under coresight bus using
> coresight_register ? It would be good to group all the coresight devices
> under that bus if possible.

The only thing this driver has in common with the coresight framework is the
name, everything else is completely different.  Coupling them together (because
of the name) would introduce a lot of hacks and make the code unintelligible. 

Mathieu

> 
> --
> Regards,
> Sudeep
