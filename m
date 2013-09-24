From: gang.chen@asianux.com (Chen Gang)
Date: Tue, 24 Sep 2013 18:37:25 +0800
Subject: [PATCH] ARM: include: asm: atomic.h: use type cast 's64' for
 the return value of atomic64_add_return().
In-Reply-To: <20130924102736.GA12758@n2100.arm.linux.org.uk>
References: <523D7DC7.8030603@asianux.com>
 <20130924093041.GB15119@mudshark.cambridge.arm.com>
 <20130924102736.GA12758@n2100.arm.linux.org.uk>
Message-ID: <52416B65.4070601@asianux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/24/2013 06:27 PM, Russell King - ARM Linux wrote:
> On Tue, Sep 24, 2013 at 10:30:41AM +0100, Will Deacon wrote:
>> On Sat, Sep 21, 2013 at 12:06:47PM +0100, Chen Gang wrote:
>>> diff --git a/arch/arm/include/asm/atomic.h b/arch/arm/include/asm/atomic.h
>>> index da1c77d..8cf005d 100644
>>> --- a/arch/arm/include/asm/atomic.h
>>> +++ b/arch/arm/include/asm/atomic.h
>>> @@ -475,7 +475,7 @@ static inline int atomic64_add_unless(atomic64_t *v, u64 a, u64 u)
>>>  	return ret;
>>>  }
>>>  
>>> -#define atomic64_add_negative(a, v)	(atomic64_add_return((a), (v)) < 0)
>>> +#define atomic64_add_negative(a, v)	((s64)atomic64_add_return((a), (v)) < 0)
>>>  #define atomic64_inc(v)			atomic64_add(1LL, (v))
>>>  #define atomic64_inc_return(v)		atomic64_add_return(1LL, (v))
>>>  #define atomic64_inc_and_test(v)	(atomic64_inc_return(v) == 0)
>>
>> Is this the right fix? It looks more like atomic[64]_t should be signed, but
>> some 32-bit architectures (ARM, x86, tile) are actually implementing
>> atomic64_t as u64. Furthermore, there are discrepencies in the operands to
>> the various atomic64_* function (long long vs u64) which probably need
>> sorting out.
> 
> Even though our underlying type is u64, we could change the arguments to
> be 'long long' as per the asm-generic/atomic64.h version.  Remember that
> this is ARM specific code, and we know that long long == 64-bit int.
> 
> 

That sounds reasonable, too, I will change them in patch v2 for arm
(also for tile).

Thanks.
-- 
Chen Gang
