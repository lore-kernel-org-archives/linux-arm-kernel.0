From: will.deacon@arm.com (Will Deacon)
Date: Fri, 5 Aug 2016 09:32:39 +0100
Subject: [PATCH] arm64: Support hard limit of cpu count by nr_cpus
In-Reply-To: <1470377035-1591-1-git-send-email-wangkefeng.wang@huawei.com>
References: <1470377035-1591-1-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <20160805083238.GA13272@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 05, 2016 at 02:03:55PM +0800, Kefeng Wang wrote:
> Enable the hard limit of cpu count by nr_cpus on arm64.
> The code is borrowed from MIPS.
> 
> Reported-by: Shiyuan Hu <hushiyuan@huawei.com>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  arch/arm64/kernel/setup.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> index 536dce2..597b777 100644
> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c
> @@ -224,6 +224,21 @@ static void __init request_standard_resources(void)
>  
>  u64 __cpu_logical_map[NR_CPUS] = { [0 ... NR_CPUS-1] = INVALID_HWID };
>  
> +static void __init prefill_possible_map(void)
> +{
> +	int i, possible = num_possible_cpus();
> +
> +	if (possible > nr_cpu_ids)
> +		possible = nr_cpu_ids;
> +
> +	for (i = 0; i < possible; i++)
> +		set_cpu_possible(i, true);
> +	for (; i < NR_CPUS; i++)
> +		set_cpu_possible(i, false);
> +
> +	nr_cpu_ids = possible;
> +}

Shouldn't we just avoid marking those CPUs as possible in smp_cpu_setup,
rather than rewriting things later on?

Also, can you explain exactly what functionality is missing at the moment,
please? I assume it's the nr_cpus= option not working correctly?

Will
