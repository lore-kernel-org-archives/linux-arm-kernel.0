From: punit.agrawal@arm.com (Punit Agrawal)
Date: Wed, 13 Jun 2018 18:39:00 +0100
Subject: [PATCH 1/2] arm64: avoid alloc memory on offline node
In-Reply-To: <87lgbk59gs.fsf@e105922-lin.cambridge.arm.com> (Punit Agrawal's
 message of "Tue, 12 Jun 2018 16:08:03 +0100")
References: <1527768879-88161-2-git-send-email-xiexiuqi@huawei.com>
 <20180606154516.GL6631@arm.com>
 <CAErSpo6S0qtR42tjGZrFu4aMFFyThx1hkHTSowTt6t3XerpHnA@mail.gmail.com>
 <20180607105514.GA13139@dhcp22.suse.cz>
 <5ed798a0-6c9c-086e-e5e8-906f593ca33e@huawei.com>
 <20180607122152.GP32433@dhcp22.suse.cz>
 <a880df29-b656-d98d-3037-b04761c7ed78@huawei.com>
 <20180611085237.GI13364@dhcp22.suse.cz>
 <16c4db2f-bc70-d0f2-fb38-341d9117ff66@huawei.com>
 <20180611134303.GC75679@bhelgaas-glaptop.roam.corp.google.com>
 <20180611145330.GO13364@dhcp22.suse.cz>
 <87lgbk59gs.fsf@e105922-lin.cambridge.arm.com>
Message-ID: <87bmce60y3.fsf@e105922-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Punit Agrawal <punit.agrawal@arm.com> writes:


[...]

>
> CONFIG_HAVE_MEMORYLESS node is not enabled on arm64 which means we end
> up returning the original node in the fallback path.
>
> Xie, does the below patch help? I can submit a proper patch if this
> fixes the issue for you.
>
> -- >8 --
> Subject: [PATCH] arm64/numa: Enable memoryless numa nodes
>
> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
> ---
>  arch/arm64/Kconfig   | 4 ++++
>  arch/arm64/mm/numa.c | 2 ++
>  2 files changed, 6 insertions(+)
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index eb2cf4938f6d..5317e9aa93ab 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -756,6 +756,10 @@ config USE_PERCPU_NUMA_NODE_ID
>  	def_bool y
>  	depends on NUMA
>  
> +config HAVE_MEMORYLESS_NODES
> +       def_bool y
> +       depends on NUMA
> +
>  config HAVE_SETUP_PER_CPU_AREA
>  	def_bool y
>  	depends on NUMA
> diff --git a/arch/arm64/mm/numa.c b/arch/arm64/mm/numa.c
> index dad128ba98bf..c699dcfe93de 100644
> --- a/arch/arm64/mm/numa.c
> +++ b/arch/arm64/mm/numa.c
> @@ -73,6 +73,8 @@ EXPORT_SYMBOL(cpumask_of_node);
>  static void map_cpu_to_node(unsigned int cpu, int nid)
>  {
>  	set_cpu_numa_node(cpu, nid);
> +	set_numa_mem(local_memory_node(nid));

Argh, this should be

        set_cpu_numa_mem(cpu, local_memory_node(nid));

There is not guarantee that map_cpu_to_node() will be called on the
local cpu.

Hanjun, Xie - can you try with the update please?

Thanks,
Punit

> +
>  	if (nid >= 0)
>  		cpumask_set_cpu(cpu, node_to_cpumask_map[nid]);
>  }
