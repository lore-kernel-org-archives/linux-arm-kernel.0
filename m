From: gangchen@rdamicro.com (=?utf-8?B?6ZmI5YiaKEdhbmdjaGVuKQ==?=)
Date: Tue, 29 Mar 2016 10:58:20 +0000
Subject: [PATCH 1/1] ARM : missing corrupted reg in __do_div_asm
In-Reply-To: <20160329103418.GX19428@n2100.arm.linux.org.uk>
References: <1459138743-10477-1-git-send-email-chengang.beijing@gmail.com>
 <3792990.eCI4tPEEyD@wuerfel>
 <20160329102605.GC3701@e103592.cambridge.arm.com>
 <20160329103418.GX19428@n2100.arm.linux.org.uk>
Message-ID: <56FA5FCB.2050609@rdamicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/29/2016 06:34 PM, Russell King - ARM Linux wrote:
> On Tue, Mar 29, 2016 at 11:26:05AM +0100, Dave Martin wrote:
>> On Tue, Mar 29, 2016 at 12:19:49PM +0200, Arnd Bergmann wrote:
>>> On Monday 28 March 2016 12:19:03 Chen Gang wrote:
>>>> __xl(R0 in little endian system, or R1 in big endian system) is corrupted
>>>> after calling __do_div64 and compiler is not informed about this in
>>>> macro __do_div_asm. If n is used again afterwards, __xl won't be
>>>> reloaded and n will contain incorrect value.
>>>>
>>>> Signed-off-by: Chen Gang <gangchen@rdamicro.com>
>>>> Signed-off-by: Chen Gang <chengang.beijing@gmail.com>
>>>> ---
>>> How did you find this? Did you run into this problem on a live system
>>> or see it through inspection?
>>>
We (in RDAMicro) found  the problem when we added TLC nand support in 
MTD driver.
I submit this patch several time last year.
And this patch also fix one problems of XFS:
http://permalink.gmane.org/gmane.comp.file-systems.xfs.general/69224
>>>>   arch/arm/include/asm/div64.h | 6 ++++--
>>>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/arch/arm/include/asm/div64.h b/arch/arm/include/asm/div64.h
>>>> index e1f0776..1a6e91a 100644
>>>> --- a/arch/arm/include/asm/div64.h
>>>> +++ b/arch/arm/include/asm/div64.h
>>>> @@ -35,12 +35,14 @@ static inline uint32_t __div64_32(uint64_t *n, uint32_t base)
>>>>          register unsigned long long __n   asm("r0") = *n;
>>>>          register unsigned long long __res asm("r2");
>>>>          register unsigned int __rem       asm(__xh);
>>>> +       register unsigned int __clobber   asm(__xl);
>>>>          asm(    __asmeq("%0", __xh)
>>>>                  __asmeq("%1", "r2")
>>>> +               __asmeq("%3", "r0")
>>>> +               __asmeq("%4", "r4")
>>>>                  __asmeq("%2", "r0")
>>>> -               __asmeq("%3", "r4")
>>>>                  "bl     __do_div64"
>>>> -               : "=r" (__rem), "=r" (__res)
>>>> +               : "=r" (__rem), "=r" (__res), "=r" (__clobber)
>>>>                  : "r" (__n), "r" (__base)
>>>>                  : "ip", "lr", "cc");
>>>>          *n = __res;
>>> Doesn't the clobber normally go in the third line along with
>>> "ip" and "lr"?
>> Since __xl is not used for any real argument to the asm, I think
>> we can just add __xl to the clobber list directly, without needing
>> to introduce an extra register variable ... no?
> No, you can't.  The clobber list is not allowed to specify registers
> that may be used for input or output operands, and since __xl may be
> r0, and __n _is_ r0, you can't specify r0 in the clobber list.
>
