From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 11 Feb 2014 09:07:20 +0000
Subject: [PATCH v3 05/11] ARM: LPAE: provide an IPA capable pmd_addr_end
In-Reply-To: <20140207171057.GR9157@cbox>
References: <1391630151-7875-1-git-send-email-marc.zyngier@arm.com>
 <1391630151-7875-6-git-send-email-marc.zyngier@arm.com>
 <20140206104328.GB29446@arm.com> <20140207040456.GN9157@cbox>
 <20140207154401.GC5925@arm.com> <20140207171057.GR9157@cbox>
Message-ID: <52F9E848.3030300@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/02/14 17:10, Christoffer Dall wrote:
> On Fri, Feb 07, 2014 at 03:44:01PM +0000, Catalin Marinas wrote:
>> On Fri, Feb 07, 2014 at 04:04:56AM +0000, Christoffer Dall wrote:
>>> On Thu, Feb 06, 2014 at 10:43:28AM +0000, Catalin Marinas wrote:
>>>> On Wed, Feb 05, 2014 at 07:55:45PM +0000, Marc Zyngier wrote:
>>>>> The default pmd_addr_end macro uses an unsigned long to represent
>>>>> the VA. When used with KVM and stage-2 translation, the VA is
>>>>> actually an IPA, which is up to 40 bits. This also affect the
>>>>> SMMU driver, which also deals with stage-2 translation.
>>>>>
>>>>> Instead, provide an implementation that can cope with larger VAs
>>>>> by using a u64 instead. This version will overload the default
>>>>> one provided in include/asm-generic/pgtable.h.
>>>>>
>>>>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>>>>> ---
>>>>>  arch/arm/include/asm/pgtable-3level.h | 5 +++++
>>>>>  1 file changed, 5 insertions(+)
>>>>>
>>>>> diff --git a/arch/arm/include/asm/pgtable-3level.h b/arch/arm/include/asm/pgtable-3level.h
>>>>> index 03243f7..594867b 100644
>>>>> --- a/arch/arm/include/asm/pgtable-3level.h
>>>>> +++ b/arch/arm/include/asm/pgtable-3level.h
>>>>> @@ -262,6 +262,11 @@ static inline int has_transparent_hugepage(void)
>>>>>  	return 1;
>>>>>  }
>>>>>  
>>>>> +#define pmd_addr_end(addr, end)						\
>>>>> +({	u64 __boundary = ((addr) + PMD_SIZE) & PMD_MASK;		\
>>>>> +	(__boundary - 1 < (end) - 1)? __boundary: (end);		\
>>>>> +})
>>>>
>>>> I see why you need this but it affects all the other uses of
>>>> pmd_addr_end() with 32-bit VA. It would be slight performance, I don't
>>>> think it's noticeable.
>>>>
>>>> A different approach could be something like (untested):
>>>>
>>>> #define pmd_addr_end(addr, end)					\
>>>> ({	__typeof__(addr) __boundary = ...
>>>> 	...
>>>> })
>>>>
>>>> What about the pgd_addr_end(), do we need this or it's not used by KVM?
>>>>
>>>
>>> What about pud_addr_end(), is that defined as a noop on LPAE, or?
>>>
>>> I would be in favor of introducing them all using your approach to avoid
>>> somebody being inspired by the KVM code when dealing with IPAs and
>>> breaking things unknowingly.
>>
>> I had a brief chat with Marc yesterday around this and it may be safer
>> to simply introduce kvm_p*d_addr_end() macros. You already do this for
>> pgd_addr_end() since it cannot be overridden in the generic headers.
>>
> Sounds good to me.  We should introduce all of them then.

I'll repost a series with that change in.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
