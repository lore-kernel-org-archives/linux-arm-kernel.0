From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu, 9 Jan 2014 12:50:52 +0000
Subject: [PATCH 2/4] arm64: topology: Add support for topology DT bindings
In-Reply-To: <1389208330-12495-2-git-send-email-broonie@kernel.org>
References: <1389208330-12495-1-git-send-email-broonie@kernel.org>
 <1389208330-12495-2-git-send-email-broonie@kernel.org>
Message-ID: <20140109125052.GB6089@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 08, 2014 at 07:12:08PM +0000, Mark Brown wrote:
> From: Mark Brown <broonie@linaro.org>
> diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
> index 20eef01a4707..e77c6b0844be 100644
> --- a/arch/arm64/kernel/topology.c
> +++ b/arch/arm64/kernel/topology.c
> @@ -17,10 +17,157 @@
>  #include <linux/percpu.h>
>  #include <linux/node.h>
>  #include <linux/nodemask.h>
> +#include <linux/of.h>
>  #include <linux/sched.h>
> +#include <linux/slab.h>

It does not belong here either.

>  #include <asm/topology.h>
>  
> +#ifdef CONFIG_OF
> +static int cluster_id;

This is __initdata. I think it is better to move it to parse_cluster
and pass it to parse_core as a parameter instead of using a global.

> +static int __init get_cpu_for_node(struct device_node *node)
> +{
> +	struct device_node *cpu_node;
> +	int cpu;
> +
> +	cpu_node = of_parse_phandle(node, "cpu", 0);
> +	if (!cpu_node) {
> +		pr_crit("%s: Unable to parse CPU phandle\n", node->full_name);

This messages is spit out anytime you try to grab a cpu phandle and it
is not there. In particular, in parse_core if core is not a leaf but you
still try to grab a cpu phandle this message is spit out and that's not
nice at all. Either we remove the message or we do not check the phandle
in core nodes that are not leaves.

> +		return -1;
> +	}
> +
> +	for_each_possible_cpu(cpu) {
> +		if (of_get_cpu_node(cpu, NULL) == cpu_node)
> +			return cpu;
> +	}
> +
> +	pr_crit("Unable to find CPU node for %s\n", cpu_node->full_name);
> +	return -1;
> +}
> +
> +static void __init parse_core(struct device_node *core, int core_id)
> +{
> +	char name[10];
> +	bool leaf = true;
> +	int i, cpu;
> +	struct device_node *t;
> +
> +	i = 0;
> +	do {
> +		snprintf(name, sizeof(name), "thread%d", i);
> +		t = of_get_child_by_name(core, name);
> +		if (t) {
> +			leaf = false;
> +			cpu = get_cpu_for_node(t);
> +			if (cpu >= 0) {
> +				pr_info("CPU%d: socket %d core %d thread %d\n",
> +					cpu, cluster_id, core_id, i);

Since all these variables are internal values that have no real meaning
I am not sure it is useful to print them out. Probably better to print
the resulting cpu masks on every cpu, problem is when to do that.

> +				cpu_topology[cpu].socket_id = cluster_id;
> +				cpu_topology[cpu].core_id = core_id;
> +				cpu_topology[cpu].thread_id = i;
> +			} else {
> +				pr_err("%s: Can't get CPU for thread\n",
> +				       t->full_name);
> +			}
> +		}
> +		i++;
> +	} while (t);
> +
> +	cpu = get_cpu_for_node(core);

This is what I am referring too above. For core nodes containing threads a
message is spit out and that must not be there. Either we avoid parsing
core nodes that are not leaves or we change get_cpu_core_for_node.

Lorenzo
