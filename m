From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Fri, 5 Oct 2018 16:13:48 +0200
Subject: [PATCH] irqchip/gic-v3-its: Add early memory allocation errata
In-Reply-To: <1d227152-2770-3e93-f78c-71e7a3b4fe76@arm.com>
References: <20180912095232.2110-1-matthias.bgg@kernel.org>
 <a08119a0-fc4e-6328-c3ad-04e5250f38d7@suse.com>
 <95733d12-ee1d-9874-16a7-c614cc0ce8cd@arm.com>
 <8ef6b381-e170-30de-ad0e-fae8ccf189e5@suse.com>
 <1d227152-2770-3e93-f78c-71e7a3b4fe76@arm.com>
Message-ID: <93532c6a-0a84-4063-3f9f-171490985cbb@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 05/10/2018 15:42, Marc Zyngier wrote:
> On 05/10/18 13:33, Matthias Brugger wrote:
>>
>>
>> On 05/10/2018 12:55, Marc Zyngier wrote:
>>> Hi Matthias,
>>>
>>> On 04/10/18 23:11, Matthias Brugger wrote:
>>>> Friendly reminder, if anyone has any comment on the patch :)
>>>>
>>>> On 9/12/18 11:52 AM, matthias.bgg at kernel.org wrote:
>>>>> From: Matthias Brugger <mbrugger@suse.com>
>>>>>
>>>>> Some hardware does not implement two-level page tables so that
>>>>> the amount of contigious memory needed by the baser is bigger
>>>>> then the zone order. This is a known problem on Cavium Thunderx
>>>>> with 4K page size.
>>>>>
>>>>> We fix this by adding an errata which allocates the memory early
>>>>> in the boot cycle, using the memblock allocator.
>>>>>
>>>>> Signed-off-by: Matthias Brugger <mbrugger@suse.com>
>>>>> ---
>>>>> ?? arch/arm64/Kconfig?????????????? | 12 ++++++++
>>>>> ?? arch/arm64/include/asm/cpucaps.h |? 3 +-
>>>>> ?? arch/arm64/kernel/cpu_errata.c?? | 33 +++++++++++++++++++++
>>>>> ?? drivers/irqchip/irq-gic-v3-its.c | 50 ++++++++++++++++++++------------
>>>>> ?? 4 files changed, 79 insertions(+), 19 deletions(-)
>>>
>>> My only comment would be to state how much I dislike both the HW and the
>>> patch... ;-) The idea that we have some erratum that depends on the page size
>>> doesn't feel good at all.
>>>
>>
>> Well ugly HW needs ugly patches ;-)
>>
>>>>>
>>>>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>>>>> index 1b1a0e95c751..dfd9fe08f0b2 100644
>>>>> --- a/arch/arm64/Kconfig
>>>>> +++ b/arch/arm64/Kconfig
>>>>> @@ -597,6 +597,18 @@ config QCOM_FALKOR_ERRATUM_E1041
>>>>> ?? ??????? If unsure, say Y.
>>>>> ?? +config CAVIUM_ALLOC_ITS_TABLE_EARLY
>>>>> +??? bool "Cavium Thunderx: Allocate the its table early"
>>>>> +??? default y
>>>>> +??? depends on ARM64_4K_PAGES && FORCE_MAX_ZONEORDER < 13
>>>
>>> Here's a though: Why don't we ensure that FORCE_MAX_ZONEORDER is such as we
>>> could always allocate the same amount of memory, no matter what the page size
>>> is? That, or bump FORCE_MAX_ZONEORDER to 13 if the kernel includes support
>>> for TX1.
>>>
>>
>> Bumping FORCE_MAX_ZONEORDER when TX1 is supported was proposed here:
>> https://patchwork.kernel.org/patch/6322281/
>>
>> To bring in some more history, the CMA approach ended with this discussion:
>> https://patchwork.kernel.org/patch/9888041/
>>
>>> Any of this of course requires buy-in from the arm64 maintainers, as this is
>>> quite a departure from the way things work so far.
>>>
>>
>> With my distribution head on, I would prefer a solution that does not change
>> FORCE_MAX_ZONEORDER. That's how I came to the idea providing a third solution to
>> the same problem :)
> 
> Why is that a problem? What impact does this have on your favourite distro?
> 

The impact is on changing FORCE_MAX_ZONEORDER on an already released kernel will
break Kernel ABI and with that all external modules. I know that's nothing
upstream cares too much about, but the distros do :)
