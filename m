From: jhugo@codeaurora.org (Jeffrey Hugo)
Date: Mon, 7 Aug 2017 11:10:12 -0600
Subject: [RFC 0/4] Parse ACPI/PPTT for cache information
In-Reply-To: <39b916f8-4d38-6c24-fc5f-4d2ad3888e49@linaro.org>
References: <20170805001159.12769-1-jeremy.linton@arm.com>
 <39b916f8-4d38-6c24-fc5f-4d2ad3888e49@linaro.org>
Message-ID: <de7ec511-182d-9739-ce4f-d39760730227@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/7/2017 4:20 AM, Hanjun Guo wrote:
> +Cc Xiongfeng (who is also working on the PPTT but focusing on
> CPU topology)
> 
> Hi Jeremy,
> 
> On 2017/8/5 8:11, Jeremy Linton wrote:
>> ACPI 6.2 adds the Processor Properties Topology Table (PPTT), which is
>> used to describe the processor and cache topologies. Ideally it is
>> used to extend/override information provided by the hardware, but
>> right now ARM64 is entirely dependent on firmware provided tables.
>>
>> This patch parses the table for the cache topology only. Its quite
>> trivial to add processor/cluster/???/socket level parsing as well,
>> but that information isn't as useful as the already provided NUMA
>> SRAT/SLIT information which provides relative distances. The one
>> useful thing, is the number of physical sockets but due to the
>> way arm64 considers "clusters" to be sockets, a larger discussion
>> is required here.
> 
> I think we need the socket to represent the true topology of
> the SoC, which means that considering clusters to be sockets is
> wrong on ARM64 server platforms, a "socket" needs to be a memory
> controller attached I think.
> 
> Take D05 for example, there are two physical SoC sockets on
> the board but with two CPU DIE (with memory controller) on each
> physical socket, and 4 clusters on each CPU DIE.
> 
> When considering clusters as sockets (that's the code for now),
> there are 16 "sockets" to represent to OS for schedule input,
> but only 4 NUMA nodes, which are confusing the scheduler a lot...
> 
> Xiongfeng was working on the CPU topology based on PPTT, and the code
> is under internal review, if it's OK for you, we can send them out
> for review comments to see if we can join our effort together, or
> we can work on top of your patches, as you like :)
> 
>>
>> An example of lstopo with this patch:
>>
>> [root at mammon-juno-rh ~]# lstopo-no-graphics
>> Machine (8072MB)
>>    Package L#0 + L2 L#0 (1024KB)
>>      L1d L#0 (32KB) + L1i L#0 (32KB) + Core L#0 + PU L#0 (P#0)
>>      L1d L#1 (32KB) + L1i L#1 (32KB) + Core L#1 + PU L#1 (P#1)
>>      L1d L#2 (32KB) + L1i L#2 (32KB) + Core L#2 + PU L#2 (P#2)
>>      L1d L#3 (32KB) + L1i L#3 (32KB) + Core L#3 + PU L#3 (P#3)
>>    Package L#1 + L2 L#1 (2048KB)
>>      L1d L#4 (32KB) + L1i L#4 (48KB) + Core L#4 + PU L#4 (P#4)
>>      L1d L#5 (32KB) + L1i L#5 (48KB) + Core L#5 + PU L#5 (P#5)
>>    HostBridge L#0
>>      PCIBridge
>>        PCIBridge
>>          PCIBridge
>>            PCI 1095:3132
>>              Block(Disk) L#0 "sda"
>>          PCIBridge
>>            PCI 11ab:4380
>>              Net L#1 "enp8s0"
>>
>> Jeremy Linton (4):
>>    drivers: base: cacheinfo: Add support for ACPI based firmware tables
>>    arm64: cacheinfo: Add support for ACPI/PPTT generated topology
>>    ACPI/PPTT: Add Processor Properties Topology Table parsing
>>    ACPI: Enable PPTT support on ARM64
>>
>>   arch/arm64/kernel/cacheinfo.c |  23 ++-
>>   drivers/acpi/arm64/Kconfig    |   3 +
>>   drivers/acpi/arm64/Makefile   |   1 +
>>   drivers/acpi/arm64/pptt.c     | 389 
>> ++++++++++++++++++++++++++++++++++++++++++
> 
> I think PPTT is not ARM64 only, can be used for x86 too,
> shall we locate them on drivers/acpi?

Austin and I have been working on the CPU topology.  Sounds like we have 
some overlap with your work.  We have a working prototype at 
https://source.codeaurora.org/quic/server/kernel/log/?h=jhugo/pptt but 
are still doing some cleanup and fixes for our needs.

Drivers/acpi makes sense to us, and was our working assumption.

> 
> Rafael was working a lot on the PPTT proposal for the
> spec, I think he can comment on this :)
> 
> Rafael, what do you think?
> 
> Thanks
> Hanjun
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


-- 
Jeffrey Hugo
Qualcomm Datacenter Technologies as an affiliate of Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
