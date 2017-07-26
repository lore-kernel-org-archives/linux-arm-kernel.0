From: thunder.leizhen@huawei.com (Leizhen (ThunderTown))
Date: Wed, 26 Jul 2017 19:17:28 +0800
Subject: [PATCH v2 0/4] Optimise 64-bit IOVA allocations
In-Reply-To: <20170726110807.GN15833@8bytes.org>
References: <cover.1500636791.git.robin.murphy@arm.com>
 <20170726110807.GN15833@8bytes.org>
Message-ID: <59787A48.6060200@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2017/7/26 19:08, Joerg Roedel wrote:
> Hi Robin.
> 
> On Fri, Jul 21, 2017 at 12:41:57PM +0100, Robin Murphy wrote:
>> Hi all,
>>
>> In the wake of the ARM SMMU optimisation efforts, it seems that certain
>> workloads (e.g. storage I/O with large scatterlists) probably remain quite
>> heavily influenced by IOVA allocation performance. Separately, Ard also
>> reported massive performance drops for a graphical desktop on AMD Seattle
>> when enabling SMMUs via IORT, which we traced to dma_32bit_pfn in the DMA
>> ops domain getting initialised differently for ACPI vs. DT, and exposing
>> the overhead of the rbtree slow path. Whilst we could go around trying to
>> close up all the little gaps that lead to hitting the slowest case, it
>> seems a much better idea to simply make said slowest case a lot less slow.
> 
> Do you have some numbers here? How big was the impact before these
> patches and how is it with the patches?
Here are some numbers:

(before)$ iperf -s
------------------------------------------------------------
Server listening on TCP port 5001
TCP window size: 85.3 KByte (default)
------------------------------------------------------------
[  4] local 192.168.1.106 port 5001 connected with 192.168.1.198 port 35898
[ ID] Interval       Transfer     Bandwidth
[  4]  0.0-10.2 sec  7.88 MBytes  6.48 Mbits/sec
[  5] local 192.168.1.106 port 5001 connected with 192.168.1.198 port 35900
[  5]  0.0-10.3 sec  7.88 MBytes  6.43 Mbits/sec
[  4] local 192.168.1.106 port 5001 connected with 192.168.1.198 port 35902
[  4]  0.0-10.3 sec  7.88 MBytes  6.43 Mbits/sec

(after)$ iperf -s
------------------------------------------------------------
Server listening on TCP port 5001
TCP window size: 85.3 KByte (default)
------------------------------------------------------------
[  4] local 192.168.1.106 port 5001 connected with 192.168.1.198 port 36330
[ ID] Interval       Transfer     Bandwidth
[  4]  0.0-10.0 sec  1.09 GBytes   933 Mbits/sec
[  5] local 192.168.1.106 port 5001 connected with 192.168.1.198 port 36332
[  5]  0.0-10.0 sec  1.10 GBytes   939 Mbits/sec
[  4] local 192.168.1.106 port 5001 connected with 192.168.1.198 port 36334
[  4]  0.0-10.0 sec  1.10 GBytes   938 Mbits/sec

> 
> 
> 	Joerg
> 
> 
> .
> 

-- 
Thanks!
BestRegards
