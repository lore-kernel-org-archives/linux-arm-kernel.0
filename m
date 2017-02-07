From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 7 Feb 2017 18:40:54 +0000
Subject: [PATCH v10] perf: add qcom l2 cache perf events driver
In-Reply-To: <1486491244-4143-1-git-send-email-nleeder@codeaurora.org>
References: <1486491244-4143-1-git-send-email-nleeder@codeaurora.org>
Message-ID: <20170207184054.GE26173@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Neil,

On Tue, Feb 07, 2017 at 01:14:04PM -0500, Neil Leeder wrote:
> Adds perf events support for L2 cache PMU.
> 
> The L2 cache PMU driver is named 'l2cache_0' and can be used
> with perf events to profile L2 events such as cache hits
> and misses on Qualcomm Technologies processors.
> 
> Signed-off-by: Neil Leeder <nleeder@codeaurora.org>

Thanks for respinning this. This looks good to me now:

Reviewed-by: Mark Rutland <mark.rutland@arm.com>

Will and I should be able to pick this up shortly.

There's one minor thing I'd like to clean up below, but we can sort that
out when applying -- there's no need to respin.

> +static struct cluster_pmu *l2_cache_associate_cpu_with_cluster(
> +	struct l2cache_pmu *l2cache_pmu, int cpu)
> +{
> +	u64 mpidr;
> +	int cpu_cluster_id;
> +	struct cluster_pmu *cluster;
> +
> +	/*
> +	 * This assumes that the cluster_id is in MPIDR[aff1] for
> +	 * single-threaded cores, and MPIDR[aff2] for multi-threaded
> +	 * cores. This logic will have to be updated if this changes.
> +	 */
> +	mpidr = read_cpuid_mpidr();
> +	if (mpidr & MPIDR_MT_BITMASK)
> +		cpu_cluster_id = MPIDR_AFFINITY_LEVEL(mpidr, 2);
> +	else
> +		cpu_cluster_id = MPIDR_AFFINITY_LEVEL(mpidr, 1);
> +
> +	list_for_each_entry(cluster, &l2cache_pmu->clusters, next) {
> +		if (cluster->cluster_id == cpu_cluster_id) {
> +			dev_info(&l2cache_pmu->pdev->dev,
> +				 "CPU%d associated with cluster %d\n", cpu,
> +				 cluster->cluster_id);
> +			cpumask_set_cpu(cpu, &cluster->cluster_cpus);
> +			*per_cpu_ptr(l2cache_pmu->pmu_cluster, cpu) = cluster;
> +			return cluster;
> +		}
> +	}

To minimise nesting, I'd like to fix this up as:

	list_for_each_entry(cluster, &l2cache_pmu->clusters, next) {
		if (cluster->cluster_id != cpu_cluster_id)
			continue;

		dev_info(&l2cache_pmu->pdev->dev,
			 "CPU%d associated with cluster %d\n", cpu,
			 cluster->cluster_id);
		cpumask_set_cpu(cpu, &cluster->cluster_cpus);
		*per_cpu_ptr(l2cache_pmu->pmu_cluster, cpu) = cluster;
		return cluster;
	}

Regardless, this is fine by me.

Thanks,
Mark.
