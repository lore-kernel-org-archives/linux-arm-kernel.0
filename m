From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 5 Oct 2018 11:55:48 +0100
Subject: [PATCH] irqchip/gic-v3-its: Add early memory allocation errata
In-Reply-To: <a08119a0-fc4e-6328-c3ad-04e5250f38d7@suse.com>
References: <20180912095232.2110-1-matthias.bgg@kernel.org>
 <a08119a0-fc4e-6328-c3ad-04e5250f38d7@suse.com>
Message-ID: <95733d12-ee1d-9874-16a7-c614cc0ce8cd@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Matthias,

On 04/10/18 23:11, Matthias Brugger wrote:
> Friendly reminder, if anyone has any comment on the patch :)
> 
> On 9/12/18 11:52 AM, matthias.bgg at kernel.org wrote:
>> From: Matthias Brugger <mbrugger@suse.com>
>>
>> Some hardware does not implement two-level page tables so that
>> the amount of contigious memory needed by the baser is bigger
>> then the zone order. This is a known problem on Cavium Thunderx
>> with 4K page size.
>>
>> We fix this by adding an errata which allocates the memory early
>> in the boot cycle, using the memblock allocator.
>>
>> Signed-off-by: Matthias Brugger <mbrugger@suse.com>
>> ---
>>   arch/arm64/Kconfig               | 12 ++++++++
>>   arch/arm64/include/asm/cpucaps.h |  3 +-
>>   arch/arm64/kernel/cpu_errata.c   | 33 +++++++++++++++++++++
>>   drivers/irqchip/irq-gic-v3-its.c | 50 ++++++++++++++++++++------------
>>   4 files changed, 79 insertions(+), 19 deletions(-)

My only comment would be to state how much I dislike both the HW and the 
patch... ;-) The idea that we have some erratum that depends on the page 
size doesn't feel good at all.

>>
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index 1b1a0e95c751..dfd9fe08f0b2 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -597,6 +597,18 @@ config QCOM_FALKOR_ERRATUM_E1041
>>   
>>   	  If unsure, say Y.
>>   
>> +config CAVIUM_ALLOC_ITS_TABLE_EARLY
>> +	bool "Cavium Thunderx: Allocate the its table early"
>> +	default y
>> +	depends on ARM64_4K_PAGES && FORCE_MAX_ZONEORDER < 13

Here's a though: Why don't we ensure that FORCE_MAX_ZONEORDER is such as 
we could always allocate the same amount of memory, no matter what the 
page size is? That, or bump FORCE_MAX_ZONEORDER to 13 if the kernel 
includes support for TX1.

Any of this of course requires buy-in from the arm64 maintainers, as 
this is quite a departure from the way things work so far.

Thanks,
	
	M.
-- 
Jazz is not dead. It just smells funny...
