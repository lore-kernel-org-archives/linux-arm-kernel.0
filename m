From: will.deacon@arm.com (Will Deacon)
Date: Mon, 22 May 2017 12:05:22 +0100
Subject: [PATCH v3 4/5] drivers/perf: Add support for ARMv8.2 Statistical
 Profiling Extension
In-Reply-To: <alpine.DEB.2.20.1705212207020.3023@nanos>
References: <1495128273-13941-1-git-send-email-will.deacon@arm.com>
 <1495128273-13941-5-git-send-email-will.deacon@arm.com>
 <alpine.DEB.2.20.1705212207020.3023@nanos>
Message-ID: <20170522110521.GB1107@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

Thanks for having a look at the patch. Responses inline.

On Sun, May 21, 2017 at 10:36:19PM +0200, Thomas Gleixner wrote:
> On Thu, 18 May 2017, Will Deacon wrote:
> > +static void __arm_spe_pmu_dev_probe(void *info)
> > +{
> > +	dev_info(dev,
> > +		 "probed for CPUs %*pbl [max_record_sz %u, align %u, features 0x%llx]\n",
> > +		 cpumask_pr_args(&spe_pmu->supported_cpus),
> > +		 spe_pmu->max_record_sz, spe_pmu->align, spe_pmu->features);
> 
> I have a hard time to spot the place which actually sets a CPU in the
> supported_cpus mask. I must be missing something, but that's what grep
> gives me:
> 
> +	cpumask_t				supported_cpus;
> +	return cpumap_print_to_pagebuf(true, buf, &spe_pmu->supported_cpus);
> +	    !cpumask_test_cpu(event->cpu, &spe_pmu->supported_cpus))
> +	if (!cpumask_test_cpu(cpu, &spe_pmu->supported_cpus))
> +		 cpumask_pr_args(&spe_pmu->supported_cpus),
> +	if (!cpumask_test_cpu(cpu, &spe_pmu->supported_cpus))
> +	if (!cpumask_test_cpu(cpu, &spe_pmu->supported_cpus))
> +	cpumask_t *mask = &spe_pmu->supported_cpus;
> +	if (irq_get_percpu_devid_partition(irq, &spe_pmu->supported_cpus)) {

That's the one ^^^. The mask is determined by the affinity of the
interrupt partition.

> +	cpumask_t *mask = &spe_pmu->supported_cpus;
> 
> > +static int arm_spe_pmu_dev_init(struct arm_spe_pmu *spe_pmu)
> > +{
> > +	int ret;
> > +	cpumask_t *mask = &spe_pmu->supported_cpus;
> > +
> > +	/* Keep the hotplug state steady whilst we probe */
> > +	get_online_cpus();
> > +
> > +	/* Make sure we probe the hardware on a relevant CPU */
> > +	ret = smp_call_function_any(mask,  __arm_spe_pmu_dev_probe, spe_pmu, 1);
> 
> You can release the hotplug lock here again and spare all the goto magic.

Actually, if I rework this to use cpuhp_state_add_instance instead, then
I might be able to do without the hotplug lock altogether. I'll have a
play.

> > +	if (ret || !(spe_pmu->features & SPE_PMU_FEAT_DEV_PROBED)) {
> > +		ret = -ENXIO;
> > +		goto out_put_cpus;
> > +	}
> > +
> > +	/* Request our PPIs (note that the IRQ is still disabled) */
> > +	ret = request_percpu_irq(spe_pmu->irq, arm_spe_pmu_irq_handler, DRVNAME,
> > +				 spe_pmu->handle);
> > +	if (ret)
> > +		goto out_put_cpus;
> > +
> > +	/* Setup the CPUs in our mask -- this enables the IRQ */
> > +	on_each_cpu_mask(mask, __arm_spe_pmu_setup_one, spe_pmu, 1);
> > +
> > +	/* Register our hotplug notifier now so we don't miss any events */
> > +	ret = cpuhp_state_add_instance_nocalls(arm_spe_pmu_online,
> > +					       &spe_pmu->hotplug_node);
> 
> If you use cpuhp_state_add_instance() then you can spare the
> on_each_cpu_mask(). The downside is that it will invoke the callback on the
> non-supported CPUs as well, but you have protection in the callbacks anyway.

Yes, I think that will work and I can get rid of get_online_cpus around
the probing too.

> > +static int arm_spe_pmu_device_dt_probe(struct platform_device *pdev)
> > +{
> > +	int ret;
> > +	struct arm_spe_pmu *spe_pmu;
> > +	struct device *dev = &pdev->dev;
> > +
> > +	spe_pmu = devm_kzalloc(dev, sizeof(*spe_pmu), GFP_KERNEL);
> > +	if (!spe_pmu) {
> > +		dev_err(dev, "failed to allocate spe_pmu\n");
> > +		return -ENOMEM;
> > +	}
> > +
> > +	spe_pmu->handle = alloc_percpu(typeof(*spe_pmu->handle));
> > +	if (!spe_pmu->handle)
> > +		return -ENOMEM;
> > +
> > +	spe_pmu->pdev = pdev;
> > +	platform_set_drvdata(pdev, spe_pmu);
> > +
> > +	ret = arm_spe_pmu_irq_probe(spe_pmu);
> > +	if (ret)
> > +		goto out_free_handle;
> > +
> > +	ret = arm_spe_pmu_dev_init(spe_pmu);
> > +	if (ret)
> > +		goto out_free_handle;
> > +
> > +	ret = arm_spe_pmu_perf_init(spe_pmu);
> > +	if (ret)
> > +		goto out_free_handle;
> 
> If that fails you leak the cpu hotplug instance. It's still enqueued.

Yikes, well spotted. That will then get called with the freed spe_pmu,
which will probably end badly.

> > +static int arm_spe_pmu_device_remove(struct platform_device *pdev)
> > +{
> > +	struct arm_spe_pmu *spe_pmu = platform_get_drvdata(pdev);
> > +	cpumask_t *mask = &spe_pmu->supported_cpus;
> > +
> > +	arm_spe_pmu_perf_destroy(spe_pmu);
> > +
> > +	get_online_cpus();
> > +	cpuhp_state_remove_instance_nocalls(arm_spe_pmu_online,
> > +					    &spe_pmu->hotplug_node);
> > +	on_each_cpu_mask(mask, __arm_spe_pmu_stop_one, spe_pmu, 1);
> 
> 
> You can spare that dance and just use cpuhp_state_remove_instance().

Thanks, I'll fix this too.

Will
