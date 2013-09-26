From: gang.chen@asianux.com (Chen Gang)
Date: Thu, 26 Sep 2013 19:03:43 +0800
Subject: [PATCH v2] ARM: include: asm: use 'long long' instead of 'u64'
 within atomic.h
In-Reply-To: <20130926100422.GE2855@mudshark.cambridge.arm.com>
References: <523D7DC7.8030603@asianux.com>
 <20130924093041.GB15119@mudshark.cambridge.arm.com>
 <5242498F.8060407@asianux.com>
 <20130925160746.GC14502@mudshark.cambridge.arm.com>
 <5243953E.6010405@asianux.com>
 <20130926100422.GE2855@mudshark.cambridge.arm.com>
Message-ID: <5244148F.6080405@asianux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/26/2013 06:04 PM, Will Deacon wrote:
> On Thu, Sep 26, 2013 at 03:00:30AM +0100, Chen Gang wrote:
>> On 09/26/2013 12:07 AM, Will Deacon wrote:
>>> On Wed, Sep 25, 2013 at 03:25:19AM +0100, Chen Gang wrote:
>>>> atomic* value is signed value, and atomic* functions need also process
>>>> signed value (parameter value, and return value), so 32-bit arm need
>>>> use 'long long' instead of 'u64'.
>>>>
>>>> After replacement, it will also fix a bug for atomic64_add_negative():
>>>> "u64 is never less than 0".
>>>>
>>>> The modifications are:
>>>>
>>>>   in vim, use "1,% s/\<u64\>/long long/g" command.
>>>>   remove '__aligned(8)' which is useless for 64-bit.
>>>>   be sure of 80 column limitation after replacement.
>>>>
>>>>
>>>> Signed-off-by: Chen Gang <gang.chen@asianux.com>
>>>
>>> Looks better to me, thanks. While you're here, we could also replace the use
>>> of `unsigned long' with `int' for the 32-bit atomics, then the whole header
>>> is consistent with the generic types.
>>>
>>> Will
>>>
>>>
>>
>> Hmm... at least, it seems we can let "use 'int' for 32-bit atomics" in
>> another patch.
> 
> Sure, it can be a follow-up to this one.
> 

OK, if it is really a useful patch too, I will follow-up.


>> Firstly, this 'fix' is not belong to API, and either, it has no related
>> 'standard' 'demo' in "asm-generic/" (it is architecture independent, so
>> no related inline assembly code).
> 
> I was simply going by the types of atomic_t and atomic64_t, which are both
> constructed using signed types.
> 

So, it is not quite necessary (but still better) to let it 'consistent'
with 'generic' types (in fact, I feel, for a register related variable,
'unsigned long' is more 'generic' than 'int').

Since it is not belong to API, if some architectures have some reasons
(or excuse) to keep 'inconsistent' with 'generic' types, it is still
acceptable.


>> After a random check, another 3 architectures (maybe more) are also may
>> using 'unsigned long': "arm64/include/asm/atomic.h",
>> "sh/include/asm/atomic-llsc.h", and "xtensa/include/asm/atomic.h".
>>
>> And as far as I know, for a register related variable, 'unsigned long'
>> is also a common using way for both 32-bit and 64-bit (at least, it is a
>> simple way to prevent issues).
> 
> Maybe, but atomic_t is always 32-bit and atomic64_t is always 64-bit, so I
> don't think unsigned long buys you anything with regards to sizing.
> 

'unsigned long' can be used as a register related variable, it is always
32-bit under 32-bit machine, and always 64-bit under 64-bit machine.

So can use it for both arm and arm64, for arm, it can not cause issue,
and for arm64, it is also OK (if changed to 'int' under arm64, may cause
real issue).

So I feel, current arm/arm64 implementation for 'unsigned long' is well
done, not need additional improvement.

> Will
> 
> 

Thanks.
-- 
Chen Gang
