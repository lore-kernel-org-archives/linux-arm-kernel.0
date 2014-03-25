From: cov@codeaurora.org (Christopher Covington)
Date: Tue, 25 Mar 2014 12:39:39 -0400
Subject: [PATCH] ARM: Use 64-bit DMA addresses for LPAE+VirtIO-MMIO
In-Reply-To: <4272242.L9VmujUH59@wuerfel>
References: <1395250522-30031-1-git-send-email-cov@codeaurora.org>
 <532C96B9.4090805@codeaurora.org>
 <90DB5198-051A-48EC-B577-5342BD706713@arm.com> <4272242.L9VmujUH59@wuerfel>
Message-ID: <5331B14B.7040103@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On 03/21/2014 07:52 PM, Arnd Bergmann wrote:
> On Friday 21 March 2014 23:27:24 Catalin Marinas wrote:
>> On 21 Mar 2014, at 19:44, Christopher Covington <cov@codeaurora.org> wrote:
>>> On 03/21/2014 12:27 PM, Catalin Marinas wrote:
>>>>> diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
>>>>> index 1f8fed9..a62bcc9 100644
>>>>> --- a/arch/arm/mm/Kconfig
>>>>> +++ b/arch/arm/mm/Kconfig
>>>>> @@ -617,6 +617,7 @@ config ARM_LPAE
>>>>>     bool "Support for the Large Physical Address Extension"
>>>>>     depends on MMU && CPU_32v7 && !CPU_32v6 && !CPU_32v5 && \
>>>>>             !CPU_32v4 && !CPU_32v3
>>>>> +   select ARCH_DMA_ADDR_T_64BIT if VIRTIO_MMIO
>>>>
>>>> That's the wrong place to enable ARCH_DMA_ADDR_T_64BIT. Do you have a
>>>> platform with >32-bit physical address space? If yes, it should be
>>>> selected there.
>>>
>>> The platforms I'm currently using are models like the Versatile Express
>>> RTSM/FVP. I can respin with changes to ARCH_VEXPRESS and ARCH_VIRT instead.
>>
>> But do you use RAM beyond 32-bit on such models?
> 
> I think the more important question here is what the normal behavior is
> for these platforms. I believe in most cases you don't have RAM above
> the boundary, so we should not enable the option by default as it can
> have noticeable overhead (we'd turn it on all the time if it didn't).

I don't understand why people concerned with the overhead of 64-bit pointers
to memory are turning on LPAE.

> In either case, platforms that need this support can always
> 'select' it, while a kernel built only for platforms that don't
> need it can offer this as a user-selectable option.

I was hoping to fix the issue of things mysteriously breaking at runtime,
regardless of what the user or randconfig selects. I'll have to investigate
the details, but it seems like one could enforce zone DMA at run-time if the
memory size is greater than the DMA pointers are able to address.

Thanks,
Christopher

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by the Linux Foundation.
