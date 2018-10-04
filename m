From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 4 Oct 2018 19:44:19 +0200
Subject: [RFC PATCH] skb: Define NET_IP_ALIGN based on
 CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
In-Reply-To: <CAKv+Gu9MBJ0w+23XMg+w_EYEf0Hx8dkW-w-rf4Bzu_c3GN_YiQ@mail.gmail.com>
References: <20181004173631.3nchegr6rm3jgz24@xylophone.i.decadent.org.uk>
 <CAKv+Gu9MBJ0w+23XMg+w_EYEf0Hx8dkW-w-rf4Bzu_c3GN_YiQ@mail.gmail.com>
Message-ID: <CAKv+Gu-nuZzueP9mJFdXP_=gBzLZ2iPLRVqLfRSkixZPvSw7Qg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(+ Arnd but really)

On 4 October 2018 at 19:43, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> (+ Arnd, Russell, Catalin, Will)
>
> On 4 October 2018 at 19:36, Ben Hutchings <ben.hutchings@codethink.co.uk> wrote:
>> NET_IP_ALIGN is supposed to be defined as 0 if DMA writes to an
>> unaligned buffer would be more expensive than CPU access to unaligned
>> header fields, and otherwise defined as 2.
>>
>> Currently only ppc64 and x86 configurations define it to be 0.
>> However several other architectures (conditionally) define
>> CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS, which seems to imply that
>> NET_IP_ALIGN should be 0.
>>
>> Remove the overriding definitions for ppc64 and x86 and define
>> NET_IP_ALIGN solely based on CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS.
>>
>> Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
>
> While this makes sense for arm64, I don't think it is appropriate for
> ARM per se.
>
> The unusual thing about ARM is that some instructions require 32-bit
> alignment even when CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS is set,
> (i.e., load/store multiple, load/store double), and we rely on
> alignment fixups done by the kernel to deal with the fallout if such
> instructions happen to be used on unaligned quantities (Russell,
> please correct me if this is inaccurate)
>
>
>> ---
>>  arch/powerpc/include/asm/processor.h | 11 -----------
>>  arch/x86/include/asm/processor.h     |  8 --------
>>  include/linux/skbuff.h               |  7 +++----
>>  3 files changed, 3 insertions(+), 23 deletions(-)
>>
>> diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
>> index 52fadded5c1e..65c8210d2787 100644
>> --- a/arch/powerpc/include/asm/processor.h
>> +++ b/arch/powerpc/include/asm/processor.h
>> @@ -525,17 +525,6 @@ extern void cvt_fd(float *from, double *to);
>>  extern void cvt_df(double *from, float *to);
>>  extern void _nmask_and_or_msr(unsigned long nmask, unsigned long or_val);
>>
>> -#ifdef CONFIG_PPC64
>> -/*
>> - * We handle most unaligned accesses in hardware. On the other hand
>> - * unaligned DMA can be very expensive on some ppc64 IO chips (it does
>> - * powers of 2 writes until it reaches sufficient alignment).
>> - *
>> - * Based on this we disable the IP header alignment in network drivers.
>> - */
>> -#define NET_IP_ALIGN   0
>> -#endif
>> -
>>  #endif /* __KERNEL__ */
>>  #endif /* __ASSEMBLY__ */
>>  #endif /* _ASM_POWERPC_PROCESSOR_H */
>> diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
>> index d53c54b842da..0108efc9726e 100644
>> --- a/arch/x86/include/asm/processor.h
>> +++ b/arch/x86/include/asm/processor.h
>> @@ -33,14 +33,6 @@ struct vm86;
>>  #include <linux/irqflags.h>
>>  #include <linux/mem_encrypt.h>
>>
>> -/*
>> - * We handle most unaligned accesses in hardware.  On the other hand
>> - * unaligned DMA can be quite expensive on some Nehalem processors.
>> - *
>> - * Based on this we disable the IP header alignment in network drivers.
>> - */
>> -#define NET_IP_ALIGN   0
>> -
>>  #define HBP_NUM 4
>>  /*
>>   * Default implementation of macro that returns current
>> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
>> index 17a13e4785fc..42467be8021f 100644
>> --- a/include/linux/skbuff.h
>> +++ b/include/linux/skbuff.h
>> @@ -2435,11 +2435,10 @@ static inline int pskb_network_may_pull(struct sk_buff *skb, unsigned int len)
>>   * The downside to this alignment of the IP header is that the DMA is now
>>   * unaligned. On some architectures the cost of an unaligned DMA is high
>>   * and this cost outweighs the gains made by aligning the IP header.
>> - *
>> - * Since this trade off varies between architectures, we allow NET_IP_ALIGN
>> - * to be overridden.
>>   */
>> -#ifndef NET_IP_ALIGN
>> +#ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
>> +#define NET_IP_ALIGN   0
>> +#else
>>  #define NET_IP_ALIGN   2
>>  #endif
>>
>> --
>> Ben Hutchings, Software Developer                         Codethink Ltd
>> https://www.codethink.co.uk/                 Dale House, 35 Dale Street
>>                                      Manchester, M1 2HF, United Kingdom
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
