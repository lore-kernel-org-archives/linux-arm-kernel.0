From: zhaoshenglong@huawei.com (Shannon Zhao)
Date: Sat, 28 Nov 2015 17:30:07 +0800
Subject: [PATCH v7 3/4] arm64/arm, numa,
 dt: adding numa dt binding implementation for arm64 platforms.
In-Reply-To: <1447780843-9223-4-git-send-email-gkulkarni@caviumnetworks.com>
References: <1447780843-9223-1-git-send-email-gkulkarni@caviumnetworks.com>
 <1447780843-9223-4-git-send-email-gkulkarni@caviumnetworks.com>
Message-ID: <5659741F.9090606@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2015/11/18 1:20, Ganapatrao Kulkarni wrote:
> +static int __init early_init_parse_memory_node(unsigned long node)
> +{
> +	const __be32 *reg, *endp;
> +	int length;
> +	int nid;
> +
> +	const char *type = of_get_flat_dt_prop(node, "device_type", NULL);
> +
> +	/* We are scanning "memory" nodes only */
> +	if (type == NULL)
> +		return 0;
> +	else if (strcmp(type, "memory") != 0)
> +		return 0;
> +
> +	nid = early_init_of_get_numa_nid(node);
> +
> +	if (nid == NUMA_NO_NODE)
> +		return -EINVAL;
> +
> +	reg = of_get_flat_dt_prop(node, "reg", &length);
> +	endp = reg + (length / sizeof(__be32));
> +
> +	while ((endp - reg) >= (dt_root_addr_cells + dt_root_size_cells)) {
> +		u64 base, size;
> +		struct memblock_region *mblk;
> +
> +		base = dt_mem_next_cell(dt_root_addr_cells, &reg);
> +		size = dt_mem_next_cell(dt_root_size_cells, &reg);
> +		pr_debug("NUMA-DT:  base = %llx , node = %u\n",
> +				base, nid);
> +
> +		for_each_memblock(memory, mblk) {
> +			if (mblk->base == base) {
> +				if (numa_add_memblk(nid,
> +							mblk->base,
> +							mblk->size) < 0)
> +					return -EINVAL;
> +				break;
> +			}
> +		}

Maybe this is not right. If the memory spaces of NUMA nodes are
continuous like below:

        memory at 60000000 {
                numa-node-id = <0x1>;
                reg = <0x0 0x60000000 0x0 0x20000000>;
                device_type = "memory";
        };

        memory at 40000000 {
                numa-node-id = <0x0>;
                reg = <0x0 0x40000000 0x0 0x20000000>;
                device_type = "memory";
        };

There is only one memory region [0x00000040000000-0x0000007fffffff] and
the mblk->base is 40000000, so it will not add the memory node 1.

I think this should do the same thing like ACPI_NUMA but add some codes
to check if the [base, base + size] is located in some memory region.
Or don't check because numa_add_memblk will fail if the [base, base +
size] is not located in some memory region.

Thanks,
-- 
Shannon
