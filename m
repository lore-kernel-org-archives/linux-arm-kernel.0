From: wangxiongfeng2@huawei.com (Xiongfeng Wang)
Date: Mon, 21 Aug 2017 11:15:33 +0800
Subject: [RFC 0/4] Parse ACPI/PPTT for cache information
In-Reply-To: <CAGHbJ3AL6cPribriuV0G2TvQCx+Qi9URpnpSi=UVRjf_cv_vLg@mail.gmail.com>
References: <20170805001159.12769-1-jeremy.linton@arm.com>
 <39b916f8-4d38-6c24-fc5f-4d2ad3888e49@linaro.org>
 <edf59d9d-7c5c-2fca-7478-7c15a5f273ca@arm.com>
 <CAGHbJ3AL6cPribriuV0G2TvQCx+Qi9URpnpSi=UVRjf_cv_vLg@mail.gmail.com>
Message-ID: <e933ddb0-cb57-4374-d19b-257b581ad993@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hanjun

On 2017/8/9 22:08, Hanjun Guo wrote:
> Hi Jeremy,
> 
> On 8 August 2017 at 01:33, Jeremy Linton <jeremy.linton at arm.com <mailto:jeremy.linton@arm.com>> wrote:
>>
>> Hi,
>>
>> On 08/07/2017 05:20 AM, Hanjun Guo wrote:
>>>
>>> +Cc Xiongfeng (who is also working on the PPTT but focusing on
>>> CPU topology)
>>>
>>> Hi Jeremy,
>>>
>>> On 2017/8/5 8:11, Jeremy Linton wrote:
>>>>
>>>> ACPI 6.2 adds the Processor Properties Topology Table (PPTT), which is
>>>> used to describe the processor and cache topologies. Ideally it is
>>>> used to extend/override information provided by the hardware, but
>>>> right now ARM64 is entirely dependent on firmware provided tables.
>>>>
>>>> This patch parses the table for the cache topology only. Its quite
>>>> trivial to add processor/cluster/???/socket level parsing as well,
>>>> but that information isn't as useful as the already provided NUMA
>>>> SRAT/SLIT information which provides relative distances. The one
>>>> useful thing, is the number of physical sockets but due to the
>>>> way arm64 considers "clusters" to be sockets, a larger discussion
>>>> is required here.
>>>
>>>
>>> I think we need the socket to represent the true topology of
>>> the SoC, which means that considering clusters to be sockets is
>>> wrong on ARM64 server platforms, a "socket" needs to be a memory
>>> controller attached I think.
>>
I agree with you that clusters should not be considered as sockets. Cores in a
cluster may share a L2 cache and should stay in a same local sched_domain for
better performance. This is done in function cpu_coregroup_mask(), which use
cpu_topology[cpu].core_sibling to build a sched_domain. The core_sibling information
is also used in sysfs and considered as cores in a socket by "lscpu".

I think we may need to add members 'physical_package_id' and 'cluster_sibling' in
struct cpu_topology. So that cores in a cluster represented by 'core_sibling' are composed
in a same local sched_domain, and cores in a package represented by 'cluster_sibling'
are considered as a socket by 'lscpu'.


Thanks,
Xiongfeng Wang
