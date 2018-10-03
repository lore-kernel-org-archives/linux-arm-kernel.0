From: robin.murphy@arm.com (Robin Murphy)
Date: Wed, 3 Oct 2018 11:37:07 +0100
Subject: [PATCH v3 2/3] perf: add arm64 smmuv3 pmu driver
In-Reply-To: <20180921150803.25444-3-shameerali.kolothum.thodi@huawei.com>
References: <20180921150803.25444-1-shameerali.kolothum.thodi@huawei.com>
 <20180921150803.25444-3-shameerali.kolothum.thodi@huawei.com>
Message-ID: <2b4a53bc-7839-6826-44ed-6099c732a31a@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/09/18 16:08, Shameer Kolothum wrote:
[...]
> +
> +	err = cpuhp_state_add_instance_nocalls(cpuhp_state_num,
> +					       &smmu_pmu->node);

In theory a hotplug event could happen as soon as the instance is 
registered...

> +	if (err) {
> +		dev_err(dev, "Error %d registering hotplug, PMU @%pa\n",
> +			err, &res_0->start);
> +		return err;
> +	}
> +
> +	/* Pick one CPU to be the preferred one to use */
> +	smmu_pmu->on_cpu = get_cpu();

...so this looks too late, i.e. a race here can result in a bogus call 
to perf_pmu_migrate_context() with an uninitialised pmu.

Robin.

> +	WARN_ON(irq_set_affinity(smmu_pmu->irq, cpumask_of(smmu_pmu->on_cpu)));
> +
> +	err = perf_pmu_register(&smmu_pmu->pmu, name, -1);
> +	if (err) {
> +		dev_err(dev, "Error %d registering PMU @%pa\n",
> +			err, &res_0->start);
> +		goto out_unregister;
> +	}
> +
> +	put_cpu();
