From: gang.chen@asianux.com (Chen Gang)
Date: Thu, 03 Oct 2013 18:05:31 +0800
Subject: [PATCH 2/2] ARM: include: asm: use 'int' instead of 'unsigned
 long' for normal register variables within atomic.h
In-Reply-To: <524C3981.20307@asianux.com>
References: <20130926100422.GE2855@mudshark.cambridge.arm.com>
 <5244148F.6080405@asianux.com>
 <20130927110618.GB9520@mudshark.cambridge.arm.com>
 <5247A1D1.6080505@asianux.com> <5247A1FA.4030305@asianux.com>
 <5247A3FC.9020508@asianux.com>
 <20130930161149.GI26036@mudshark.cambridge.arm.com>
 <524A2DE7.8040208@asianux.com>
 <20131001090119.GA17629@mudshark.cambridge.arm.com>
 <524ABA20.6060106@asianux.com>
 <20131002104158.GD28311@mudshark.cambridge.arm.com>
 <524C3981.20307@asianux.com>
Message-ID: <524D416B.5090709@asianux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


If need send patch v2 for it, I should try (if so, need patch 1 also
send again?).

Thanks.

On 10/02/2013 11:19 PM, Chen Gang wrote:
> On 10/02/2013 06:41 PM, Will Deacon wrote:
>> On Tue, Oct 01, 2013 at 01:03:44PM +0100, Chen Gang wrote:
>>> On 10/01/2013 05:01 PM, Will Deacon wrote:
>>>> On Tue, Oct 01, 2013 at 03:05:27AM +0100, Chen Gang wrote:
>>>>> OK, thanks. That means: "arm means arm 32-bit, arm64 means arm 64-bit.
>>>>> The current Linux kernel main line does not support arm 16-bit".
>>>>>
>>>>> Since "bringing our atomic_t ... with the atomic_t type definition", can
>>>>> we use 'atomic_t" instead of 'unsigned long'?
>>>>>
>>>>> And can we use 'atomic64_t" instead of 'unsigned long' in atomic64_*()?
>>>>
>>>> That's probably a bit dodgy, since they are typedefs to compound types
>>>> which, if ever extended, would fall to bits if we tried to pack them into a
>>>> single register.
>>>>
>>>
>>> Excuse me, my English is not quite well, I guess your meaning is: "in
>>> 'atomic.h', for arm/arm64, let register variables type equal to related
>>> atomic type: use 64-bit type if 'atomic64_t', 32-bit type if 'atomic_t'.
>>
>> Sorry, I think I've confused you. This should be a simple change:
>>
> 
> Oh, no sorry, my English is really not quite well, and I am not quite
> familiar with arm (even inline assembly language grammar, which I
> should familiar).
> 
> I really should see the deals about it.
> 
> 
>>   On ARM:
>>
>>   - The atomic_t typedef is a struct containing an int.
>>   - The atomic64_t typedef is a struct containing a long long.
>>
>>   On arm64:
>>
>>   - The atomic_t typedef is a struct containing an int.
>>   - The atomic64_t typedef is a struct containing a long.
>>
> 
> Yeah.
> 
>> Now, your first patch made the handling of atomic64_t on ARM use long long
>> instead of u64. That's good, because it fixes a signedness bug.
>>
> 
> OK, thanks.
> 
>> The second patch is just a clean-up, because our atomic_* functions on ARM
>> interchangeably use int and unsigned long when working with atomic_t types.
>> This can be tidied up by using int whenever we are reading or writing an
>> atomic_t, thus matching the type definition for that structure member.
>>
>> So, for example, atomic_add does not need changing because it always uses
>> int to hold the atomic_t variable (the unsigned long holds the status
>> returned from the strex instruction). atomic_cmpxchg, however, loads the
>> atomic_t into oldval, so that should be int.
>>
> 
> OK, thank you for your details information, originally I did not check
> the inline assembly code in details (which I should do).
> 
> And what you said above is reasonable to me.
> 
> After a check, I think for atomic64_*() in arm have no this kind of
> issue.
> 
> 
>> Given that this patch doesn't gain us anything in terms of functionality,
>> feel free to ignore it and I can take a look when there's a rainy day (which
>> should be real soon now). I also need to take a closer look at
>> atomic_clear_mask for arm64, because it looks broken to me.
>>
> 
> OK, thanks. 
> 
> Hmm... after read arm64 again, at least for me, it has no this kind of
> issue.
> 
> :-)
> 
>> Will
>>
>>
> 
> 
> So the related patch is below (still based on Patch 1):
> 
> -----------------------------patch begin--------------------------------
> 
> arm/include/asm/atomic.h: use 'int' instead of 'unsigned long' for 'oldval' in atomic_cmpxchg().
> 
>   For atomic_cmpxchg(), the type of 'oldval' need be 'int' to match the
>   type of "*ptr" (used by 'ldrex' instruction) and 'old' (used by 'teq'
>   instruction).
> 
> 
> Signed-off-by: Chen Gang <gang.chen@asianux.com>
> ---
>  arch/arm/include/asm/atomic.h |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/include/asm/atomic.h b/arch/arm/include/asm/atomic.h
> index a715ac0..9ee7e01 100644
> --- a/arch/arm/include/asm/atomic.h
> +++ b/arch/arm/include/asm/atomic.h
> @@ -114,7 +114,8 @@ static inline int atomic_sub_return(int i, atomic_t *v)
>  
>  static inline int atomic_cmpxchg(atomic_t *ptr, int old, int new)
>  {
> -	unsigned long oldval, res;
> +	int oldval;
> +	unsigned long res;
>  
>  	smp_mb();
>  
> 


-- 
Chen Gang
