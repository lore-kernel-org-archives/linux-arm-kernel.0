From: gpkulkarni@gmail.com (Ganapatrao Kulkarni)
Date: Tue, 6 Jan 2015 14:55:53 +0530
Subject: [RFC PATCH v3 4/4] arm64:numa: adding numa support for arm64
 platforms.
In-Reply-To: <1849719.f6Z6RhZjTc@wuerfel>
References: <1420011208-7051-1-git-send-email-ganapatrao.kulkarni@caviumnetworks.com>
 <1420011208-7051-5-git-send-email-ganapatrao.kulkarni@caviumnetworks.com>
 <1849719.f6Z6RhZjTc@wuerfel>
Message-ID: <CAFpQJXVQnRY9wZRk-83bQLw0m=41ZxH2v-YZCHdF0fvC8LS_Tw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,


On Sat, Jan 3, 2015 at 2:40 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> [re-sent with correct mailing list address]
>
> On Wednesday 31 December 2014 13:03:28 Ganapatrao Kulkarni wrote:
>> Adding numa support for arm64 based platforms.
>> Adding dt node pasring for numa topology using property arm,associativity.
>>
>> Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@caviumnetworks.com>
>
> Maybe the parts that are common with powerpc can be moved to drivers/of/numa.c?
> We can always look for both arm,associativity and ibm,associativity, I don't
> think we should be worried about any conflicts that way.
ok, i will move common functions from powerpc and arm64 to driver/of/numa.c
>
>> +#define MAX_DISTANCE_REF_POINTS 4
>
> I think we should use 8 here like powerpc, four levels might get exceeded
> on complex SoCs.
sure.
>
>> +int dt_get_cpu_node_id(int cpu)
>> +{
>> +     struct device_node *dn = NULL;
>> +
>> +     while ((dn = of_find_node_by_type(dn, "cpu"))) {
>> +             const u32 *cell;
>> +             u64 hwid;
>> +
>> +             /*
>> +              * A cpu node with missing "reg" property is
>> +              * considered invalid to build a cpu_logical_map
>> +              * entry.
>> +              */
>> +             cell = of_get_property(dn, "reg", NULL);
>> +             if (!cell) {
>> +                     pr_err("%s: missing reg property\n", dn->full_name);
>> +                     return default_nid;
>> +             }
>> +             hwid = of_read_number(cell, of_n_addr_cells(dn));
>> +
>> +             if (cpu_logical_map(cpu) == hwid)
>> +             return of_node_to_nid_single(dn);
>> +     }
>> +     return NUMA_NO_NODE;
>> +}
>> +EXPORT_SYMBOL(dt_get_cpu_node_id);
>
> Maybe just expose a function to the device node for a CPU ID here, and
> expect callers to use of_node_to_nid?
shall i make this wrapper function in dt_numa.c, which will use
functions _of_node_to_nid and  _of_cpu_to_node(cpu)
And,  this function can be a weak function in numa.c which returns 0.
>
>> +
>> +/**
>> + * early_init_dt_scan_numa_map - parse memory node and map nid to memory range.
>> + */
>> +int __init early_init_dt_scan_numa_map(unsigned long node, const char *uname,
>> +                                  int depth, void *data)
>> +{
>> +     const char *type = of_get_flat_dt_prop(node, "device_type", NULL);
>> +
>> +     /* We are scanning "numa-map" nodes only */
>
> a stale comment?
oops, will remove.
>
>> +/* DT node mapping is done already early_init_dt_scan_memory */
>> +int __init arm64_dt_numa_init(void)
>> +{
>> +     int i;
>> +     u32 nodea, nodeb, distance, node_count = 0;
>> +
>> +     of_scan_flat_dt(early_init_dt_scan_numa_map, NULL);
>> +
>> +     for_each_node_mask(i, numa_nodes_parsed)
>> +             node_count = i;
>> +     node_count++;
>> +
>> +     for (nodea =  0; nodea < node_count; nodea++) {
>> +             for (nodeb = 0; nodeb < node_count; nodeb++) {
>> +                     distance = dt_get_node_distance(nodea, nodeb);
>> +                     numa_set_distance(nodea, nodeb, distance);
>> +             }
>> +     }
>> +     return 0;
>> +}
>> +EXPORT_SYMBOL(arm64_dt_numa_init);
>
> No need to export functions that are called only be architecture code.
> Since this works on the flattened device tree format, you can never
> have loadable modules calling it.
yes, will do.
>
>> @@ -461,7 +464,12 @@ static int c_show(struct seq_file *m, void *v)
>>                * "processor".  Give glibc what it expects.
>>                */
>>  #ifdef CONFIG_SMP
>> +     if (IS_ENABLED(CONFIG_NUMA)) {
>> +             seq_printf(m, "processor\t: %d", i);
>> +             seq_printf(m, " [nid: %d]\n", cpu_to_node(i));
>> +     } else {
>>               seq_printf(m, "processor\t: %d\n", i);
>> +     }
>>  #endif
>>       }
>
> Do we need to make this conditional? I think we can just always
> print the node number, even if it's going to be zero for systems
> without the associativity properties.
yes, we can.
>
>> +
>> +int cpu_to_node_map[NR_CPUS];
>> +EXPORT_SYMBOL(cpu_to_node_map);
>
> This seems to be x86 specific, do we need it?
>
>> +/*
>> + *  Set the cpu to node and mem mapping
>> + */
>> +void numa_store_cpu_info(int cpu)
>> +{
>> +#ifdef CONFIG_ARM64_DT_NUMA
>> +     node_cpu_hwid[cpu].node_id  =  dt_get_cpu_node_id(cpu);
>> +#endif
>
> I would try to avoid the #ifdef here, by providing a stub function of
> dt_get_cpu_node_id or whichever function we end up calling here when
> NUMA is disabled.
as commented above.
.>
>> +
>> +/**
>> + * arm64_numa_init - Initialize NUMA
>> + *
>> + * Try each configured NUMA initialization method until one succeeds.  The
>> + * last fallback is dummy single node config encomapssing whole memory and
>> + * never fails.
>> + */
>> +void __init arm64_numa_init(void)
>> +{
>> +     if (!numa_off) {
>> +#ifdef CONFIG_ARM64_DT_NUMA
>> +             if (!numa_init(arm64_dt_numa_init))
>> +                     return;
>> +#endif
>> +     }
>> +
>> +     numa_init(dummy_numa_init);
>> +}
>
> I don't think we need the CONFIG_ARM64_DT_NUMA=n case here, it should just
> not be conditional, and the arm64_dt_numa_init should fall back to doing
> something reasonable when numa is turned off or there are no associativity
> properties.
i think we can remove ifdef, will do it.
>
>         Arnd

thanks
ganapat
