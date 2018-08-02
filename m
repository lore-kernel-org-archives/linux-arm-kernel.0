From: robin.murphy@arm.com (Robin Murphy)
Date: Thu, 2 Aug 2018 11:55:29 +0100
Subject: [PATCH] arm_pmu: fix compiler warning in arm_pmu_device_probe
In-Reply-To: <20180801214526.24599-1-chris.packham@alliedtelesis.co.nz>
References: <20180801214526.24599-1-chris.packham@alliedtelesis.co.nz>
Message-ID: <449c26bb-9d31-984e-da74-73ef1bd9a674@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chris,

On 01/08/18 22:45, Chris Packham wrote:
> GCC warns
> 
>    arm_pmu_platform.c:234:5: error: 'err' may be used uninitialized in this function [-Werror=maybe-uninitialized]
> 
> This is because we rely on the for_each_cpu loop in armpmu_request_irqs
> to initialise err. The warning is a little bogus because we know if
> there were 0 CPUs this code would not be running.
> 
> Initialise err to 0 to avoid the warning.

Maybe initialising to something like -EINVAL would be more appropriate, 
just in case we did ever manage to get here with armpmu->supported_cpus 
unset?

Robin.

> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
> This has been reported before in https://lkml.org/lkml/2018/3/5/508 I'm not
> sure if it was dismmissed as "meh, gcc is wrong" or if it was just wainting for
> someone with some round tuits.
> 
> 
>   drivers/perf/arm_pmu_platform.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/perf/arm_pmu_platform.c b/drivers/perf/arm_pmu_platform.c
> index 971ff336494a..96075cecb0ae 100644
> --- a/drivers/perf/arm_pmu_platform.c
> +++ b/drivers/perf/arm_pmu_platform.c
> @@ -160,7 +160,7 @@ static int pmu_parse_irqs(struct arm_pmu *pmu)
>   static int armpmu_request_irqs(struct arm_pmu *armpmu)
>   {
>   	struct pmu_hw_events __percpu *hw_events = armpmu->hw_events;
> -	int cpu, err;
> +	int cpu, err = 0;
>   
>   	for_each_cpu(cpu, &armpmu->supported_cpus) {
>   		int irq = per_cpu(hw_events->irq, cpu);
> 
