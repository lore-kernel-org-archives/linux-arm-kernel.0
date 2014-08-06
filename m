From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 6 Aug 2014 15:27:55 +0200
Subject: [PATCH v2 2/3] arm64: add helper functions to read I-cache
 attributes
In-Reply-To: <CAKv+Gu_T+FuoS4jEyrG8b5WN8E9=N6nDUL7JC_=9VhaJV-2Pzg@mail.gmail.com>
References: <1407230757-15305-1-git-send-email-ard.biesheuvel@linaro.org>
 <1407230757-15305-2-git-send-email-ard.biesheuvel@linaro.org>
 <20140806130026.GR25953@arm.com>
 <CAKv+Gu_T+FuoS4jEyrG8b5WN8E9=N6nDUL7JC_=9VhaJV-2Pzg@mail.gmail.com>
Message-ID: <CAKv+Gu-iGZMLgWHEPoc1w8HW3gUyuJXb6uerXg_kGQOhbqySSg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6 August 2014 15:17, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> On 6 August 2014 15:00, Will Deacon <will.deacon@arm.com> wrote:
>> On Tue, Aug 05, 2014 at 10:25:56AM +0100, Ard Biesheuvel wrote:
>>> This adds helper functions and #defines to <asm/cachetype.h> to read the
>>> line size and the number of sets from the level 1 instruction cache.
>>>
>>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>>> ---
>>> v2: put () around macro args, use 64-bit types for asm() mrs/msr calls
>>>
>>>  arch/arm64/include/asm/cachetype.h | 28 ++++++++++++++++++++++++++++
>>>  1 file changed, 28 insertions(+)
>>>
>>> diff --git a/arch/arm64/include/asm/cachetype.h b/arch/arm64/include/asm/cachetype.h
>>> index 7a2e0762cb40..e59c0c25b307 100644
>>> --- a/arch/arm64/include/asm/cachetype.h
>>> +++ b/arch/arm64/include/asm/cachetype.h
>>> @@ -39,6 +39,34 @@
>>>
>>>  extern unsigned long __icache_flags;
>>>
>>> +#define CCSIDR_EL1_LINESIZE_MASK     0x7
>>> +#define CCSIDR_EL1_LINESIZE(x)               ((x) & CCSIDR_EL1_LINESIZE_MASK)
>>> +
>>> +#define CCSIDR_EL1_NUMSETS_SHIFT     13
>>> +#define CCSIDR_EL1_NUMSETS_MASK              (0x7fff << CCSIDR_EL1_NUMSETS_SHIFT)
>>> +#define CCSIDR_EL1_NUMSETS(x) \
>>> +     (((x) & CCSIDR_EL1_NUMSETS_MASK) >> CCSIDR_EL1_NUMSETS_SHIFT)
>>> +
>>> +static inline __attribute_const__ u64 icache_get_ccsidr(void)
>>> +{
>>> +     u64 ccsidr;
>>> +
>>> +     /* Select L1 I-cache and read its size ID register */
>>> +     asm("msr csselr_el1, %1; isb; mrs %0, ccsidr_el1"
>>> +         : "=r"(ccsidr) : "r"(1L));
>>> +     return ccsidr;
>>
>> Is it worth having a WARN_ON(preemptible()) here?
>>
>
> Sure, why not.

... if it weren't for the fact that this triggers recursive header
inclusion hell

  CC      kernel/bounds.s
In file included from /home/ard/linux-2.6/include/asm-generic/preempt.h:4:0,
                 from arch/arm64/include/generated/asm/preempt.h:1,
                 from /home/ard/linux-2.6/include/linux/preempt.h:18,
                 from /home/ard/linux-2.6/arch/arm64/include/asm/cachetype.h:21,
                 from /home/ard/linux-2.6/arch/arm64/include/asm/cache.h:19,
                 from /home/ard/linux-2.6/include/linux/cache.h:5,
                 from /home/ard/linux-2.6/include/linux/printk.h:8,
                 from /home/ard/linux-2.6/include/linux/kernel.h:13,
                 from /home/ard/linux-2.6/include/asm-generic/bug.h:13,
                 from arch/arm64/include/generated/asm/bug.h:1,
                 from /home/ard/linux-2.6/include/linux/bug.h:4,
                 from /home/ard/linux-2.6/include/linux/page-flags.h:9,
                 from /home/ard/linux-2.6/kernel/bounds.c:9:
/home/ard/linux-2.6/include/linux/thread_info.h: In function
?set_restore_sigmask?:
/home/ard/linux-2.6/include/linux/thread_info.h:128:2: error: implicit
declaration of function ?WARN_ON?
[-Werror=implicit-function-declaration]
  WARN_ON(!test_thread_flag(TIF_SIGPENDING));
  ^
In file included from /home/ard/linux-2.6/arch/arm64/include/asm/cache.h:19:0,
                 from /home/ard/linux-2.6/include/linux/cache.h:5,
                 from /home/ard/linux-2.6/include/linux/printk.h:8,
                 from /home/ard/linux-2.6/include/linux/kernel.h:13,
                 from /home/ard/linux-2.6/include/asm-generic/bug.h:13,
                 from arch/arm64/include/generated/asm/bug.h:1,
                 from /home/ard/linux-2.6/include/linux/bug.h:4,
                 from /home/ard/linux-2.6/include/linux/page-flags.h:9,
                 from /home/ard/linux-2.6/kernel/bounds.c:9:
/home/ard/linux-2.6/arch/arm64/include/asm/cachetype.h: In function
?icache_get_ccsidr?:
/home/ard/linux-2.6/arch/arm64/include/asm/cachetype.h:59:2: error:
implicit declaration of function ?preemptible?
[-Werror=implicit-function-declaration]
  WARN_ON(preemptible());
  ^

i.e., linux/bug,h and linux/preempt.h already implicitly #include
cachetype.h, so including the former from the latter to import the
declaration of WARN_ON() and/or preemptible respectively produces this
error.

-- 
Ard.
