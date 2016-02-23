From: ddaney@caviumnetworks.com (David Daney)
Date: Tue, 23 Feb 2016 09:34:24 -0800
Subject: [PATCH v12 4/5] arm64, numa: Add NUMA support for arm64 platforms.
In-Reply-To: <20160223102610.GD3966@arm.com>
References: <1456192703-2274-1-git-send-email-ddaney.cavm@gmail.com>
 <1456192703-2274-5-git-send-email-ddaney.cavm@gmail.com>
 <20160223102610.GD3966@arm.com>
Message-ID: <56CC9820.3010406@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/23/2016 02:26 AM, Will Deacon wrote:
> On Mon, Feb 22, 2016 at 05:58:22PM -0800, David Daney wrote:
>> From: Ganapatrao Kulkarni <gkulkarni@caviumnetworks.com>
>>
>> Attempt to get the memory and CPU NUMA node via of_numa.  If that
>> fails, default the dummy NUMA node and map all memory and CPUs to node
>> 0.
>>
>> Tested-by: Shannon Zhao <shannon.zhao@linaro.org>
>> Reviewed-by: Robert Richter <rrichter@cavium.com>
>> Signed-off-by: Ganapatrao Kulkarni <gkulkarni@caviumnetworks.com>
>> Signed-off-by: David Daney <david.daney@cavium.com>
>> ---
>>   arch/arm64/Kconfig                |  26 +++
>>   arch/arm64/include/asm/mmzone.h   |  12 ++
>>   arch/arm64/include/asm/numa.h     |  45 +++++
>>   arch/arm64/include/asm/topology.h |  10 +
>>   arch/arm64/kernel/pci.c           |  10 +
>>   arch/arm64/kernel/setup.c         |   4 +
>>   arch/arm64/kernel/smp.c           |   4 +
>>   arch/arm64/mm/Makefile            |   1 +
>>   arch/arm64/mm/init.c              |  34 +++-
>>   arch/arm64/mm/mmu.c               |   1 +
>>   arch/arm64/mm/numa.c              | 403 ++++++++++++++++++++++++++++++++++++++
>>   11 files changed, 545 insertions(+), 5 deletions(-)
>>   create mode 100644 arch/arm64/include/asm/mmzone.h
>>   create mode 100644 arch/arm64/include/asm/numa.h
>>   create mode 100644 arch/arm64/mm/numa.c
>
> [...]
>
>> diff --git a/arch/arm64/include/asm/mmzone.h b/arch/arm64/include/asm/mmzone.h
>> new file mode 100644
>> index 0000000..a0de9e6
>> --- /dev/null
>> +++ b/arch/arm64/include/asm/mmzone.h
>> @@ -0,0 +1,12 @@
>> +#ifndef __ASM_MMZONE_H
>> +#define __ASM_MMZONE_H
>> +
>> +#ifdef CONFIG_NUMA
>> +
>> +#include <asm/numa.h>
>> +
>> +extern struct pglist_data *node_data[];
>> +#define NODE_DATA(nid)		(node_data[(nid)])
>> +
>> +#endif /* CONFIG_NUMA */
>> +#endif /* __ASM_MMZONE_H */
>
> What happened to the patch cleaning this up in generic code?

As per 0/5 :

    v11:
	- Dropped cleanup patches for other architectures, they will be
           submitted as a separate set after more testing.

The "cleanup patches" were not building on x86, which is a bit of a
problem.  I believe I have corrected that issue, but would like to do
a little more build testing on all the other architectures that are
effected.

I probably should have supplied more detail as to my plan of attack
for these.  To make review more manageable, I would like to consider
the arm64 patches separately.  The parties interested in getting arm64
NUMA working can proceed without waiting for the cleanups to be fully
tested and acknowledged.  I am working on testing the cleanups on each
architecture touched, and will resubmit them as a separate patch set
this week.  I think splitting them like this will streamline the
process of getting to the eventual goal of having both arm64 NUMA and
the cleanups merged.

David.
