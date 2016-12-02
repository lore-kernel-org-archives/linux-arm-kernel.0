From: scott.branden@broadcom.com (Scott Branden)
Date: Thu, 1 Dec 2016 18:38:46 -0800
Subject: [RFC PATCH 0/2] arm64: memory-hotplug: Add Memory Hotplug support
In-Reply-To: <5840D333.9050801@huawei.com>
References: <1480637999-4320-1-git-send-email-scott.branden@broadcom.com>
 <5840D333.9050801@huawei.com>
Message-ID: <9cfa95ca-a9e9-299d-d020-7e565562dcf5@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Xishi,

Thanks for the reply - please see comments below.

On 16-12-01 05:49 PM, Xishi Qiu wrote:
> On 2016/12/2 8:19, Scott Branden wrote:
>
>> This patchset is sent for comment to add memory hotplug support for ARM64
>> based platforms.  It follows hotplug code added for other architectures
>> in the linux kernel.
>>
>> I tried testing the memory hotplug feature following documentation from
>> Documentation/memory-hotplug.txt.  I don't think it is working as expected
>> - see below:
>>
>> To add memory to the system I did the following:
>> echo 0x400000000 > /sys/devices/system/memory/probe
>>
>> The memory is displayed as system ram:
>> cat /proc/iomem:
>> 74000000-77ffffff : System RAM
>>   74080000-748dffff : Kernel code
>>   74950000-749d2fff : Kernel data
>> 400000000-43fffffff : System RAM
>>
>> But does not seem to be added to the kernel memory.
>> /proc/meminfo did not change.
>>
>> What else needs to be done so the memory is added to the kernel memory
>> pool for normal allocation?
>>
>
> Hi Scott,
>
> Do you mean it still don't support hod-add after apply this patchset?

After applying the patch it appears to partially support hot-add. 
Please let me know if you think it is working as expected?

The memory probe functions in that the memory is registered with the 
system and shows up in /proc/iomem.  But, the memory is not available in 
/proc/meminfo.  Do you think something else needs to be adjusted for 
ARM64 to hotadd the memory

I just found another clue:
under /sys/devices/system/memory I only see one memory entry (before or 
after I try to hotadd additional memory).

/sys/devices/system/memory # ls
auto_online_blocks  memory0            uevent
block_size_bytes    probe

In arch/arm64/include/asm/sparsemem.h if I change SECTION_SIZE_BITS from 
30 to 28 and recompile I get the following:
/sys/devices/system/memory # ls
auto_online_blocks  memory7            uevent
block_size_bytes    probe


In arch/arm64/include/asm/sparsemem.h if I change SECTION_SIZE_BITS from 
30 to 27 and recompile I get the following:
/sys/devices/system/memory # ls
auto_online_blocks  memory14            uevent
block_size_bytes    probe

If looks to me like something is not working properly in the ARM64 
implementation.  I should expect to see multiple memoryX entries under 
/sys/devices/system/memory?



>
> Thanks,
> Xishi Qiu
>
>> Scott Branden (2):
>>   arm64: memory-hotplug: Add MEMORY_HOTPLUG, MEMORY_HOTREMOVE,
>>     MEMORY_PROBE
>>   arm64: defconfig: enable MEMORY_HOTPLUG config options
>>
>>  arch/arm64/Kconfig           | 10 ++++++++++
>>  arch/arm64/configs/defconfig |  3 +++
>>  arch/arm64/mm/init.c         | 42 ++++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 55 insertions(+)
>>
>
>
>
