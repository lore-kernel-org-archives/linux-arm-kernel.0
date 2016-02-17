From: robert.richter@caviumnetworks.com (Robert Richter)
Date: Wed, 17 Feb 2016 13:16:05 +0100
Subject: [PATCH v3] irqchip, gicv3-its, numa: Workaround for Cavium
 thunderx erratum 23144
In-Reply-To: <1455628282-8939-1-git-send-email-gkulkarni@caviumnetworks.com>
References: <1455628282-8939-1-git-send-email-gkulkarni@caviumnetworks.com>
Message-ID: <20160217121605.GE24726@rric.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16.02.16 18:41:22, Ganapatrao Kulkarni wrote:
> The erratum fixes the hang of ITS SYNC command by avoiding inter node
> io and collections/cpu mapping on thunderx dual-socket platform.
> 
> This is based on NUMA v10 series.
> https://lkml.org/lkml/2016/2/2/134
> 
> v3:
> updatated as per Marc Zyngier's review comments.
> http://www.spinics.net/lists/arm-kernel/msg443462.html
> 
> v2:
> updatated as per Marc Zyngier's review comments.
> 
> Signed-off-by: Ganapatrao Kulkarni <gkulkarni@caviumnetworks.com>
> 
> ---
>  arch/arm64/Kconfig               |  9 ++++++++
>  drivers/irqchip/irq-gic-v3-its.c | 46 ++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 53 insertions(+), 2 deletions(-)

> @@ -1086,6 +1098,14 @@ static void its_cpu_init_collection(void)
>  	list_for_each_entry(its, &its_nodes, entry) {
>  		u64 target;
>  
> +		/* avoid cross node collections and its mapping */
> +		if (its->flags & ITS_FLAGS_WORKAROUND_CAVIUM_23144) {
> +			struct device_node *cpu_node;
> +			cpu_node = of_get_cpu_node(cpu, NULL);
> +			if (its->numa_node != of_node_to_nid(cpu_node))
> +				continue;

I think you may not continue in case of its->numa_node ==
NUMA_NO_NODE. This is the case if no numa node info is provided and
thus ITS is systemwide. So the check needs to be extended accordingly.

-Robert

> +		}
> +
>  		/*
>  		 * We now have to bind each collection to its target
>  		 * redistributor.
