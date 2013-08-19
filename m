From: robherring2@gmail.com (Rob Herring)
Date: Mon, 19 Aug 2013 08:11:11 -0500
Subject: [RFC PATCH v2 4/4] of: move of_get_cpu_node implementation to
 DT core library
In-Reply-To: <1376674791-28244-3-git-send-email-Sudeep.KarkadaNagesha@arm.com>
References: <1376586580-5409-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1376674791-28244-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1376674791-28244-3-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Message-ID: <5212196F.4060708@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/16/2013 12:39 PM, Sudeep KarkadaNagesha wrote:
> From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
> 
> This patch moves the generalized implementation of of_get_cpu_node from
> PowerPC to DT core library, thereby adding support for retrieving cpu
> node for a given logical cpu index on any architecture.
> 
> The CPU subsystem can now use this function to assign of_node in the
> cpu device while registering CPUs.
> 
> It is recommended to use these helper function only in pre-SMP/early
> initialisation stages to retrieve CPU device node pointers in logical
> ordering. Once the cpu devices are registered, it can be retrieved easily
> from cpu device of_node which avoids unnecessary parsing and matching.
> 
> Cc: Rob Herring <rob.herring@calxeda.com>
> Cc: Grant Likely <grant.likely@linaro.org>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>

[snip]

> +/**
> + * of_get_cpu_node - Get device node associated with the given logical CPU
> + *
> + * @cpu: CPU number(logical index) for which device node is required
> + * @thread: if not NULL, local thread number within the physical core is
> + *          returned
> + *
> + * The main purpose of this function is to retrieve the device node for the
> + * given logical CPU index. It should be used to initialize the of_node in
> + * cpu device. Once of_node in cpu device is populated, all the further
> + * references can use that instead.
> + *
> + * CPU logical to physical index mapping is architecture specific and is built
> + * before booting secondary cores. This function uses arch_match_cpu_phys_id
> + * which can be overridden by architecture specific implementation.
> + *
> + * Returns a node pointer for the logical cpu if found, else NULL.
> + */
> +struct device_node *of_get_cpu_node(int cpu, unsigned int *thread)
> +{
> +	struct device_node *cpun, *cpus;
> +
> +	cpus = of_find_node_by_path("/cpus");
> +	if (!cpus) {
> +		pr_warn("Missing cpus node, bailing out\n");
> +		return NULL;
> +	}
> +
> +	for_each_child_of_node(cpus, cpun) {
> +		if (of_node_cmp(cpun->type, "cpu"))
> +			continue;
> +#ifdef CONFIG_PPC

You don't really need this ifdef as this function should never succeed
on other arches. Alternatively, you can use "IS_ENABLED(CONFIG_PPC)"
instead.

Otherwise,

Acked-by: Rob Herring <rob.herring@calxeda.com>

Rob
