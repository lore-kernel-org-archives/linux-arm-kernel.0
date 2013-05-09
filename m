From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 09 May 2013 11:14:30 +0100
Subject: [PATCH] arm64: KVM: Add bits for specifying memory type in stage2
 PTE
In-Reply-To: <CAAhSdy35d3BKscxE=N5Ltb-_dnoHe-oy3YjsYwvk9qsh=t59_Q@mail.gmail.com>
References: <1368078813-16904-1-git-send-email-anup.patel@linaro.org>
 <518B6D1C.3020603@arm.com>
 <CAAhSdy35d3BKscxE=N5Ltb-_dnoHe-oy3YjsYwvk9qsh=t59_Q@mail.gmail.com>
Message-ID: <518B7706.1080407@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/05/13 11:03, Anup Patel wrote:
> On Thu, May 9, 2013 at 3:02 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
>> [Looping in Catalin, as we just had an interesting discussion about this]
>>
>> Hi Anup,
>>
>> On 09/05/13 06:53, Anup Patel wrote:
>>> We cannot use existing stage1 PTE_ATTRINDX() macro for specifying
>>> stage2 memory type because stage1 ATTRINDX = PTE[4:2] and stage2
>>> MEMATTR = PTE[5:2].
>>
>> You're right, this is a bug. But...
>>
>>> This patch adds bit definetions for specifying device, noncacheable,
>>> writethrough, and writeback memory types in stage2 PTE and also uses
>>> it in PAGE_S2 and PAGE_S2_DEVICE.
>>
>> ... I have the feeling we don't need most of this:
>>
>> Stage-2 memory attributes can only restrict what the guest puts in its
>> Stage-1. Which means that unless we really need to play some ugly tricks
>> on the guest (which we don't), it is probably best to leave everything
>> as Normal, Outer Write-Back, Inner Write-Back.
>>
>> So I think the right fix is to get rid of of PAGE_S2_DEVICE, use PAGE_S2
>> for everything, and set MemAttr[3:0] to 0b1111.
> 
> IMHO, its good to have separate PAGE_S2_DEVICE because using this we
> are enforcing strongly-ordered and non-cacheable memory for devices directly
> accessed by guest (such as GIC CPU interface).
> 
> But ...
> 
> Having just PAGE_S2 will also work assuming that guest always uses
> correct memory type for devices (specifically GIC CPU interface).

That's the idea. If the guest screws up, we're not going to fix it up.

> The most important thing on real HW is to have MemAttr = 0xF for proper
> guest access to RAM.

Definitely.

>>
>> I'll try that and cook a separate patch if it looks good enough (it is
>> likely to impact the 32bit code as well...).
> 
> Yes, 32bit code also has PAGE_S2_DEVICE macro.
> 
> I am fine with your suggestion. Go ahead with your patch.

Just booted a v7 guest without PAGE_S2_device, and it seems happy
enough. I'll fix v8 accordingly and push the result out.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
