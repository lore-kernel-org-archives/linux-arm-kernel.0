From: thunder.leizhen@huawei.com (Leizhen (ThunderTown))
Date: Thu, 27 Oct 2016 11:54:35 +0800
Subject: [PATCH 2/2] arm64/numa: support HAVE_MEMORYLESS_NODES
In-Reply-To: <20161026183614.GJ15216@arm.com>
References: <1477364358-10620-1-git-send-email-thunder.leizhen@huawei.com>
 <1477364358-10620-3-git-send-email-thunder.leizhen@huawei.com>
 <20161026183614.GJ15216@arm.com>
Message-ID: <58117A7B.1040004@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2016/10/27 2:36, Will Deacon wrote:
> On Tue, Oct 25, 2016 at 10:59:18AM +0800, Zhen Lei wrote:
>> Some numa nodes may have no memory. For example:
>> 1) a node has no memory bank plugged.
>> 2) a node has no memory bank slots.
>>
>> To ensure percpu variable areas and numa control blocks of the
>> memoryless numa nodes to be allocated from the nearest available node to
>> improve performance, defined node_distance_ready. And make its value to be
>> true immediately after node distances have been initialized.
>>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> ---
>>  arch/arm64/Kconfig            | 4 ++++
>>  arch/arm64/include/asm/numa.h | 3 +++
>>  arch/arm64/mm/numa.c          | 6 +++++-
>>  3 files changed, 12 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index 30398db..648dd13 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -609,6 +609,10 @@ config NEED_PER_CPU_EMBED_FIRST_CHUNK
>>  	def_bool y
>>  	depends on NUMA
>>
>> +config HAVE_MEMORYLESS_NODES
>> +	def_bool y
>> +	depends on NUMA
> 
> Given that patch 1 and the associated node_distance_ready stuff is all
> an unqualified performance optimisation, is there any merit in just
> enabling HAVE_MEMORYLESS_NODES in Kconfig and then optimising things as
> a separate series when you have numbers to back it up?
HAVE_MEMORYLESS_NODES is also an performance optimisation for memoryless scenario.
For example:
node0 is a memoryless node, node1 is the nearest node of node0.
We want to allocate memory from node0, normally memory manager will try node0 first, then node1.
But we have already kwown that node0 have no memory, so we can tell memory manager directly try
node1 first. So HAVE_MEMORYLESS_NODES is used to skip the memoryless nodes, don't try them.

So I think the title of this patch is misleading, I will rewrite it in V2.

Or, Do you mean separate it into a new patch?


> 
> Will
> 
> .
> 
