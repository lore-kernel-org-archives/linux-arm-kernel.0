From: will.deacon@arm.com (Will Deacon)
Date: Fri, 9 Sep 2016 11:24:43 +0100
Subject: [RFCv4 5/7] drivers/perf: arm_pmu: expose a cpumask in sysfs
In-Reply-To: <1473330112-28528-6-git-send-email-mark.rutland@arm.com>
References: <1473330112-28528-1-git-send-email-mark.rutland@arm.com>
 <1473330112-28528-6-git-send-email-mark.rutland@arm.com>
Message-ID: <20160909102443.GE20192@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 08, 2016 at 11:21:50AM +0100, Mark Rutland wrote:
> In systems with heterogeneous CPUs, there are multiple logical CPU PMUs,
> each of which covers a subset of CPUs in the system. In some cases
> userspace needs to know which CPUs a given logical PMU covers, so we'd
> like to expose a cpumask under sysfs, similar to what is done for uncore
> PMUs.
> 
> Unfortunately, prior to commit 00e727bb389359c8 ("perf stat: Balance
> opening and reading events"), perf stat only correctly handled a cpumask
> holding a single CPU, and only when profiling in system-wide mode. In
> other cases, the presence of a cpumask file could cause perf stat to
> behave erratically.
> 
> Thus, exposing a cpumask file would break older perf binaries in cases
> where they would otherwise work.
> 
> To avoid this issue while still providing userspace with the information
> it needs, this patch exposes a differently-named file (cpus) under
> sysfs. New tools can look for this and operate correctly, while older
> tools will not be adversely affected by its presence.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>  drivers/perf/arm_pmu.c       | 21 +++++++++++++++++++++
>  include/linux/perf/arm_pmu.h |  1 +
>  2 files changed, 22 insertions(+)
> 
> diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
> index ac83e1e..09e9944 100644
> --- a/drivers/perf/arm_pmu.c
> +++ b/drivers/perf/arm_pmu.c
> @@ -534,6 +534,25 @@ static int armpmu_filter_match(struct perf_event *event)
>  	return cpumask_test_cpu(cpu, &armpmu->supported_cpus);
>  }
>  
> +static ssize_t armpmu_cpumask_show(struct device *dev,
> +				   struct device_attribute *attr, char *buf)
> +{
> +	struct arm_pmu *armpmu = to_arm_pmu(dev_get_drvdata(dev));
> +	return cpumap_print_to_pagebuf(true, buf, &armpmu->supported_cpus);
> +}
> +
> +static struct device_attribute armpmu_cpumask_attr =
> +		__ATTR(cpus, S_IRUGO, armpmu_cpumask_show, NULL);

You can use the DEVICE_ATTR macro for this.

Will
