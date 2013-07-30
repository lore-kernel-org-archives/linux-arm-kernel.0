From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Tue, 30 Jul 2013 15:46:41 +0800
Subject: [RFC][PATCH 2/2] ARM64: introduce cluster id and make a difference
 between socket id
In-Reply-To: <CAKfTPtBXi4C3ncLmsWZQEs3x80VbPhHo+gC9hG_EFwMdafJmOQ@mail.gmail.com>
References: <1374921728-9007-1-git-send-email-hanjun.guo@linaro.org>
 <1374921728-9007-2-git-send-email-hanjun.guo@linaro.org>
 <CAKfTPtBXi4C3ncLmsWZQEs3x80VbPhHo+gC9hG_EFwMdafJmOQ@mail.gmail.com>
Message-ID: <51F76F61.40206@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2013-7-29 17:38, Vincent Guittot wrote:
> On 27 July 2013 12:42, Hanjun Guo <hanjun.guo@linaro.org> wrote:
>> In the cpu topology information, we define topology_physical_package_id()
>> as cpu socket id, which means that the socket id is the idenfication for
>> physical processor, not for a cluster in a cpu die.
>>
>> On ARM64 platform, multi cluster in a cpu die will be normal, here is a
>> example with 2 cores in a cluster and 2 cluster in a socket:
>>
>> |--------------------------------------|
>> |                socket                |
>> |                                      |
>> | |---------------|  |---------------| |
>> | |    cluster    |  |    cluster    | |
>> | |               |  |               | |
>> | | |----| |----| |  | |----| |----| | |
>> | | |core| |core| |  | |core| |core| | |
>> | | |----| |----| |  | |----| |----| | |
>> | |               |  |               | |
>> | |---------------|  |---------------| |
>> |                                      |
>> |--------------------------------------|
>>
>> ARM64 extended the MPIDR into 64 bit and introduce another affinity level,
>> we can use this affinity level for socket id and use the third highest level
>> affinity for cluster id, which  make the socket id behavior in its original
>> way.
>>
>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>> ---
>>  arch/arm64/include/asm/topology.h |    1 +
>>  arch/arm64/kernel/topology.c      |    8 ++++++--
>>  2 files changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/topology.h b/arch/arm64/include/asm/topology.h
>> index 8631808..ff68ecc 100644
>> --- a/arch/arm64/include/asm/topology.h
>> +++ b/arch/arm64/include/asm/topology.h
>> @@ -8,6 +8,7 @@
>>  struct cputopo_arm64 {
>>         int thread_id;
>>         int core_id;
>> +       int cluster_id;
>>         int socket_id;
>>         cpumask_t thread_sibling;
>>         cpumask_t core_sibling;
>> diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
>> index 1eb0435..6d1e5a6 100644
>> --- a/arch/arm64/kernel/topology.c
>> +++ b/arch/arm64/kernel/topology.c
>> @@ -80,12 +80,14 @@ void store_cpu_topology(unsigned int cpuid)
>>                         /* core performance interdependency */
>>                         cpuid_topo->thread_id = MPIDR_AFFINITY_LEVEL_0(mpidr);
>>                         cpuid_topo->core_id = MPIDR_AFFINITY_LEVEL_1(mpidr);
>> -                       cpuid_topo->socket_id = MPIDR_AFFINITY_LEVEL_2(mpidr);
>> +                       cpuid_topo->cluster_id = MPIDR_AFFINITY_LEVEL_2(mpidr);
>> +                       cpuid_topo->socket_id = MPIDR_AFFINITY_LEVEL_3(mpidr);
> 
> socket_id is currently used by update_siblings_masks to update the
> core_sibling mask. This mask defines which CPUs share their cache and
> AFAICT, the cache are shared at the cluster level so cluster_id should
> be used instead socket_id.

For some architecture, cpu cores in a cluster share L2 cache, and clusters
in the cpu die share L3 cache, so I think we can make a difference between
socket id and cluster id.

> 
> Have you got more information about the goal of this new level_3 ?

Actually not, I think ARM should give some recommendations as ARMv7 did.

Thanks
Hanjun
