From: thunder.leizhen@huawei.com (Leizhen (ThunderTown))
Date: Mon, 6 Jun 2016 09:43:53 +0800
Subject: [PATCH v3 3/5] arm64/numa: add nid check for memory block
In-Reply-To: <20160603095229.GH9915@arm.com>
References: <1464834491-12024-1-git-send-email-thunder.leizhen@huawei.com>
 <1464834491-12024-4-git-send-email-thunder.leizhen@huawei.com>
 <20160603095229.GH9915@arm.com>
Message-ID: <5754D559.2030109@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016/6/3 17:52, Will Deacon wrote:
> On Thu, Jun 02, 2016 at 10:28:09AM +0800, Zhen Lei wrote:
>> Use the same tactic to cpu and numa-distance nodes.
> 
> Sorry, I don't understand... :/

In function of_numa_parse_cpu_nodes:
for_each_child_of_node(cpus, np) {
	...
	r = of_property_read_u32(np, "numa-node-id", &nid);
	...
	if (nid >= MAX_NUMNODES)									//check nid
			pr_warn("NUMA: Node id %u exceeds maximum value\n", nid);			//print warning info
	...


In function numa_set_distance:
	if (from >= numa_distance_cnt || to >= numa_distance_cnt ||					//check nid
			from < 0 || to < 0) {
		pr_warn_once("NUMA: Warning: node ids are out of bound, from=%d to=%d distance=%d\n",	//print warning info
			    from, to, distance);
		return;
	}

Both these two functions will check that whether nid(configured in dts, the subnodes of
cpus and distance-map) is right or not. So memory@ should also be checked.


	memory@c00000 {
		device_type = "memory";
		reg = <0x0 0xc00000 0x0 0x80000000>;
		/* node 0 */
		numa-node-id = <0>;				//have not been checked yet.
	};							//suppose I configued a wrong nid, it will not print any warning info

	cpus {
		#address-cells = <2>;
		#size-cells = <0>;

		cpu at 0 {
			device_type = "cpu";
			compatible =  "arm,armv8";
			reg = <0x0 0x0>;
			enable-method = "psci";
			/* node 0 */
			numa-node-id = <0>;			//checked in of_numa_parse_cpu_nodes
		};

	distance-map {
		compatible = "numa-distance-map-v1";
		distance-matrix = <0 0 10>,			//checked in of_numa_parse_distance_map_v1 --> numa_set_distance
				  <0 1 20>,
				  <1 1 10>;
	};

> 
> Will
> 
>>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> ---
>>  arch/arm64/mm/numa.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/arch/arm64/mm/numa.c b/arch/arm64/mm/numa.c
>> index c7fe3ec..2601660 100644
>> --- a/arch/arm64/mm/numa.c
>> +++ b/arch/arm64/mm/numa.c
>> @@ -141,6 +141,11 @@ int __init numa_add_memblk(int nid, u64 start, u64 end)
>>  {
>>  	int ret;
>>
>> +	if (nid >= MAX_NUMNODES) {
>> +		pr_warn("NUMA: Node id %u exceeds maximum value\n", nid);
>> +		return -EINVAL;
>> +	}
>> +
>>  	ret = memblock_set_node(start, (end - start), &memblock.memory, nid);
>>  	if (ret < 0) {
>>  		pr_err("NUMA: memblock [0x%llx - 0x%llx] failed to add on node %d\n",
>> --
>> 2.5.0
>>
>>
> 
> .
> 
