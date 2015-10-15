From: Suzuki.Poulose@arm.com (Suzuki K. Poulose)
Date: Thu, 15 Oct 2015 16:48:33 +0100
Subject: [PATCHv3 10/11] arm64: Add 16K page size support
In-Reply-To: <CAPvkgC3c3yGYMsMZrZWwKq5CEyTDEJzr=8Pf3RGnwFR-nW07_w@mail.gmail.com>
References: <1444821634-1689-1-git-send-email-suzuki.poulose@arm.com>
 <1444821634-1689-11-git-send-email-suzuki.poulose@arm.com>
 <20151015140646.GJ8825@leverpostej> <561FBCC9.2000106@arm.com>
 <CAPvkgC3c3yGYMsMZrZWwKq5CEyTDEJzr=8Pf3RGnwFR-nW07_w@mail.gmail.com>
Message-ID: <561FCAD1.6080701@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/10/15 16:36, Steve Capper wrote:
> On 15 October 2015 at 15:48, Suzuki K. Poulose <Suzuki.Poulose@arm.com> wrote:
>> On 15/10/15 15:06, Mark Rutland wrote:
>>>
>>> Hi,
>>>
>>
>> I have fixed all the nits locally. Thanks for pointing them out.
>>
>>>>    config FORCE_MAX_ZONEORDER
>>>>          int
>>>>          default "14" if (ARM64_64K_PAGES && TRANSPARENT_HUGEPAGE)
>>>> +       default "12" if (ARM64_16K_PAGES && TRANSPARENT_HUGEPAGE)
>>>>          default "11"
>>>
>>>
>>> I'm a little lost here. How are these numbers derived?
>>>
>>
>> I struggled to find the right value for 16K. Thanks to Steve Capper
>> for the following explanation. I will add it as a comment.
>>
>> All allocations from the buddy allocator have to have compound order
>> strictly less than MAX_ORDER. i.e, the maximum allocation size is
>> (MAX_ORDER - 1) PAGES. To align with the transparent huge page size,
>> we get :
>>
>>   (MAX_ORDER - 1) + PAGE_SHIFT = PMD_SHIFT
>>
>> Which gives us:
>>
>> MAX_ORDER = PAGE_SHIFT - 3 + PAGE_SHIFT - PAGE_SHIFT + 1
>>            = PAGE_SHIFT - 2
>>
>> That raises an interesting question about the selection of the value
>> for 4K. Shouldn't that be 10 instead of 11 ?
>>
>> Steve ?
>
> Hi,
> My understanding is that 11 is a "good minimum" value for the page
> allocator with 4KB pages.
> (There are references to it being 10 in 2.4 kernels but raised to 11
> on 2.6 kernels?)
>
> We need to raise the minimum when we have a 16KB or 64KB PAGE_SIZE to
> be able allocate a 32MB or 512MB Transparent HugePages.
>

Thanks Steve, for the clarification. I will add the following comment
to the Kconfig

#
# All allocations from the buddy allocator have to have compound order
# strictly less than MAX_ORDER. i.e, the maximum allocation size is
# (MAX_ORDER - 1) PAGES. To align with the transparent huge page size,
# we get :
#
#  (MAX_ORDER - 1) + PAGE_SHIFT = PMD_SHIFT
#
# Which gives us:
#
# MAX_ORDER = PAGE_SHIFT - 3 + PAGE_SHIFT - PAGE_SHIFT + 1
#           = PAGE_SHIFT - 2
#
# However for 4K, we choose a higher default value 11 as opposed to 10, (giving us size 4M)
# matching the default value used by the generic code.
#


Thanks
Suzuki
