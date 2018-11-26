From: huanglingyan2@huawei.com (huanglingyan (A))
Date: Mon, 26 Nov 2018 19:28:46 +0800
Subject: [PATCH] arm64: lib: accelerate do_csum() with NEON instruction
In-Reply-To: <01fe3a6d-0991-eeb0-378e-7a1caaa87680@arm.com>
References: <1542792065-98282-1-git-send-email-huanglingyan2@huawei.com>
 <01fe3a6d-0991-eeb0-378e-7a1caaa87680@arm.com>
Message-ID: <409b5736-b2c1-43f1-24fb-fafb184be906@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



? 2018/11/21 22:41, Robin Murphy ??:
> On 21/11/2018 09:21, huanglingyan wrote:
>> From: Lingyan Huang <huanglingyan2@huawei.com>
>>
>> Function do_csum() in lib/checksum.c is used to compute checksum,
>> which is turned out to be slowly and costs a lot of resources.
>
> Can you say how slow exactly it is? I had been meaning to come back and take a look at do_csum() since I did a rough perf profile on a little Cortex-A53 box with ethernet checksum offloading disabled, but I've not found the time for a proper analysis yet.

Here is the comparison results of function ip_compute_csum() between general do_csum() and neon instruction do_csum().

    pkt_len, 1000        64     128     129     512     513    1024    1500
    gene_ip_cpt(ns):   55980   80730   81440  228330  228900  424930  607990
    neon_ip_cpt(ns):  117610  115110  116160  132440  131520  150910  169020

ip_compute_csum() is an export function which calls do_csum().

     __sum16 ip_compute_csum(const void *buff, int len)
    {
         return (__force __sum16)~do_csum(buff, len);
    }

It seems that a threshold should be set about packet length. We can use neon instructions only when packet length exceeds the threshold. The spending maybe introduced when reservering/restoring neon registers with kernel_neon_begin()/kernel_neon_end().


>> Let's use neon instructions to accelerate the checksum computation
>> for arm64.
>
> How much improvement have you measured with this change? Ideally for a range of different-sized workloads on more than one microarchitecture - some CPUs have weaker SIMD pipelines than others, so any possible benefit is still going to have some variance overall.
>

This sounds good. We can get others' help for testing since I only have one microarchitecture.


>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Signed-off-by: Lingyan Huang <huanglingyan2@huawei.com>
>> ---
>>   arch/arm64/include/asm/checksum.h |   8 ++
>>   arch/arm64/lib/Makefile           |   3 +
>>   arch/arm64/lib/checksum.c         |  30 +++++++
>>   arch/arm64/lib/do_csum.S          | 182 ++++++++++++++++++++++++++++++++++++++
>>   lib/checksum.c                    |   6 +-
>>   5 files changed, 226 insertions(+), 3 deletions(-)
>>   create mode 100644 arch/arm64/lib/checksum.c
>>   create mode 100644 arch/arm64/lib/do_csum.S
>>
>> diff --git a/arch/arm64/include/asm/checksum.h b/arch/arm64/include/asm/checksum.h
>> index 0b6f5a7..9faf642 100644
>> --- a/arch/arm64/include/asm/checksum.h
>> +++ b/arch/arm64/include/asm/checksum.h
>> @@ -24,8 +24,16 @@ static inline __sum16 csum_fold(__wsum csum)
>>       sum += (sum >> 16) | (sum << 16);
>>       return ~(__force __sum16)(sum >> 16);
>>   }
>> +
>
> Please clean up unnecessary noise like this from your patches before posting.
>
>>   #define csum_fold csum_fold
>>   +#ifdef CONFIG_KERNEL_MODE_NEON
>> +extern unsigned int do_csum_generic(const unsigned char *buff, int len);
>> +unsigned int do_csum_neon(const unsigned char *buff, unsigned int len);
>> +unsigned int do_csum(const unsigned char *buff, unsigned int len);
>> +#define do_csum do_csum
>> +#endif
>> +
>>   static inline __sum16 ip_fast_csum(const void *iph, unsigned int ihl)
>>   {
>>       __uint128_t tmp;
>> diff --git a/arch/arm64/lib/Makefile b/arch/arm64/lib/Makefile
>> index 69ff988..9596fd8 100644
>> --- a/arch/arm64/lib/Makefile
>> +++ b/arch/arm64/lib/Makefile
>> @@ -5,6 +5,9 @@ lib-y        := clear_user.o delay.o copy_from_user.o        \
>>              memcmp.o strcmp.o strncmp.o strlen.o strnlen.o    \
>>              strchr.o strrchr.o tishift.o
>>   +# If NEON mode is supported, compile this file to speed up do_csum.
>> +lib-$(CONFIG_KERNEL_MODE_NEON) += do_csum.o checksum.o
>> +
>>   # Tell the compiler to treat all general purpose registers (with the
>>   # exception of the IP registers, which are already handled by the caller
>>   # in case of a PLT) as callee-saved, which allows for efficient runtime
>> diff --git a/arch/arm64/lib/checksum.c b/arch/arm64/lib/checksum.c
>> new file mode 100644
>> index 0000000..61dee8b
>> --- /dev/null
>> +++ b/arch/arm64/lib/checksum.c
>> @@ -0,0 +1,30 @@
>> +/*
>> + * Generic C or neon implementation of do_csum operations.
>> + * Choose faster neon instructions when NEON is supported.
>> + *
>> + * Copyright (C) 2018 Hisilicon, Inc. All Rights Reserved.
>> + * Written by Lingyan Huang (huanglingyan2 at huawei.com)
>> + *
>> + * This program is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU General Public Licence
>> + * as published by the Free Software Foundation; either version
>> + * 2 of the Licence, or (at your option) any later version.
>> + */
>> +
>> +#include <asm/neon.h>
>> +#include <asm/simd.h>
>> +#include <asm/checksum.h>
>> +#include <asm/byteorder.h>
>> +
>> +unsigned int do_csum(const unsigned char *buff, unsigned int len)
>> +{
>> +    if (may_use_simd()) {
>
> There's a significant overhead involved with kernel_neon_{begin,end} which means that for sufficiently small values of len, taking this path will almost certainly be slower than even the dumb generic C implementation. For starters, with len<32 your code doesn't even use SIMD anyway, so it's just pure waste.
>
>> +        unsigned int res;
>> +
>> +        kernel_neon_begin();
>
> Also note that you've got preemption disabled the whole time in here - I don't know off-hand how large a single buffer might possibly be checksummed in a single call, but the potential latency there is a problem until proven otherwise, especially for RT.
>
>> +        res = do_csum_neon(buff, len);
>> +        kernel_neon_end();
>> +        return res;
>> +    } else
>> +        return do_csum_generic(buff, len);
>> +}
>> diff --git a/arch/arm64/lib/do_csum.S b/arch/arm64/lib/do_csum.S
>> new file mode 100644
>> index 0000000..820302c
>> --- /dev/null
>> +++ b/arch/arm64/lib/do_csum.S
>> @@ -0,0 +1,182 @@
>> +/*
>> + * Copyright (C) 2018 Huawei Inc.
>> + *
>> + * Optmized version of the standard do_csum() function
>> + *
>> + * Parameters:
>> + *    x0 - address of buffer to checksum (const unsigned char *)
>> + *    x1 - length of the buffer (int)
>> + * Returns:
>> + *    x0 - the return checksum of the buffer
>> + */
>> +
>> +#include <linux/linkage.h>
>> +#include <asm/assembler.h>
>> +ENTRY(do_csum_neon)
>> +    ldr    x13, =0xffff
>> +    eor    x4, x4, x4
>> +    eor    x5, x5, x5
>> +    eor    v0.16b, v0.16b, v0.16b // clear v0,x4,x5
>> +
>> +    /*
>> +     * len is zero or negative
>> +     */
>> +    and    x6, x1, #0x80000000
>> +    cmp    x6, #0
>> +    b.gt    out
>> +    cbz    w1, out
>
> Um... how is that more optimal than
>
>     cmp    x1, #0
>     b.le    out
> ?
>
>> +
>> +    tst    x0, #1
>> +    b.eq    addr_not_odd
>> +
>> +    /*
>> +     * addr is odd
>> +     */
>> +    mov    x4, #1
>> +    ldr    x6, [x0], #1
>> +#ifdef __AARCH64EB__
>> +    and     x6, x6, #0xff
>> +#else
>> +    lsl   x6, x6, #8
>> +    and   x6, x6, x13
>> +#endif
>
> Did you just manage to open-code an ldrb instruction? :/
>
> AFAICS the aim here is to load a byte, and shift it left if little-endian - there's no way that needs 4 instructions.
>


>> +    add     x5, x5, x6
>> +    sub     x1, x1, #1
>> +
>> +addr_not_odd:
>> +    cmp    x1, #32
>> +    b.lt    len_4
>> +    cmp    x1, #128
>> +    b.ge    len_gt_128
>> +    b    do_loop_16
>> +
>
> Surely you want to align the source pointer to more than just even/odd given that the subsequent loops load in chunks much larger than 2 bytes?
>
> Also, are you actually tuning this for typical static branch prediction on the assumption that len<128 is the likely case (which would really warrant a comment), or is this just an unnecessarily long-winded way of saying:
>
>     cmp    x1, #128
>     b.lt    do_loop_16
>
> ?
>
>> +len_gt_128:
>> +    movi v0.4s, #0
>
> We already zeroed v0 earlier (and frankly if we'd done it this way it wouldn't have needed a comment there either).
>
>> +    movi v1.4s, #0
>> +    movi v2.4s, #0
>> +    movi v3.4s, #0
>> +
>> +do_loop_64:
>> +
>> +    ldp    q5, q4, [x0], #32
>> +    ldp    q7, q6, [x0], #32
>
> Using post-index writeback is liable to cause an unnecessary register dependency stall between these two loads in at least some cases.
>
>> +
>> +    uadalp v0.4s, v4.8h
>> +    uadalp v1.4s, v5.8h
>> +    uadalp v2.4s, v6.8h
>> +    uadalp v3.4s, v7.8h
>
> What if we're checksumming a buffer larger than 4MB and lose the carry-out when one or more of these accumulations overflow?
>
>> +
>> +    sub    x1, x1, #64
>> +    cmp    x1, #64
>> +    b.ge    do_loop_64
>> +
>> +    add    v0.4s, v0.4s, v1.4s
>> +    add    v2.4s, v2.4s, v3.4s
>> +    add    v0.4s, v0.4s, v2.4s
>> +
>> +    cmp    x1, #16
>> +    b.lt    get_64
>> +
>> +
>> +do_loop_16:
>> +    ldr    q6, [x0], #16
>> +
>> +    uaddl    v24.4s, v0.4h, v6.4h
>> +    uaddl2    v25.4s, v0.8h, v6.8h
>> +    add    v0.4s, v24.4s, v25.4s
>> +
>> +
>> +    sub    x1, x1, #16
>> +    cmp    x1, #16
>> +    b.ge    do_loop_16
>> +
>> +get_64:
>> +    mov    x6, v0.d[0]
>> +    add    x5, x5, x6
>> +    mov    x6, v0.d[1]
>> +
>> +    add    x5, x5, x6
>
> Is that really more efficient than an addp (or addh) and extracting a single element?
>
>> +    cmp    x5, x6
>> +    b.ge    len_4
>> +    add    x5, x5, #1
>
> Is this... manual carry logic without using adds/adc? :/
>
>> +
>> +len_4:
>> +    cmp    x1, #4
>> +    b.lt    len_2
>> +
>> +    sub    x1, x1, #4
>> +    ldr    w6, [x0], #4
>> +    and    x6, x6, #0xffffffff
>
> What's that and for?
>
>> +    add    x5, x5, x6
>> +    b    len_4
>> +
>> +len_2:
>> +    cmp    x1, #2
>> +    b.lt    len_1
>> +    sub    x1, x1, #2
>> +    ldrh    w6, [x0], #2
>> +    and    x6, x6, x13
>> +    add    x5, x5, x6
>> +
>> +len_1:
>> +    cmp    x1, #1
>> +    b.lt    fold_32
>> +    ldr    x6, [x0], #1
>> +#ifdef __AARCH64EB__
>> +    lsl    x6, x6, #8
>> +    and    x6, x6, x13
>> +#else
>> +    and    x6, x6, #0xff
>> +#endif
>> +    add    x5, x5, x6
>> +
>> +fold_32:
>> +    and    x9, x5, x13        /* [15:0] */
>> +    and    x10, x13, x5, lsr #16    /* [31:16] */
>> +    and    x11, x13, x5, lsr #32    /* [47:32] */
>> +    and    x12, x13, x5, lsr #48    /* [47:32] */
>> +
>> +    add    x9, x9, x10
>> +    add    x11, x11, x12
>> +
>> +    add    x9, x9, x11
>> +
>> +    and    x10, x9, x13
>> +    and    x11, x13, x9, lsr #16
>> +
>> +    add    x5, x10, x11
>> +
>> +    and     x9, x5, x13             /* add carry */
>> +    and     x10, x13, x5, lsr #16
>> +    add    x5, x9, x10
>> +
>> +    cbz    x4, out            /* addr isn't odd */
>> +
>> +    lsr    x6, x5, #8
>> +    and    x6, x6, #0xff
>> +    and    x7, x5, #0xff
>> +    lsl    x7, x7, #8
>> +
>> +    orr    x5, x6, x7
>
> I know folding a 32-bit partial sum to 16 bits needs at most 3 instructions (ror/add/lsr), and I can't imagine the additional odd-byte correction can need more than about 4 on top of that. As it stands, there's more code in this "optimised" fold alone than in the entire ip_fast_csum() routine.
>
>> +
>> +out:
>> +    mov    x0, x5
>> +
>> +    /*
>> +     * pop neon register from stack
>> +     */
>> +/*    ldp    q24, q25, [sp], #0x20
>> +    ldp    q22, q23, [sp], #0x20
>> +    ldp    q20, q21, [sp], #0x20
>> +    ldp    q18, q19, [sp], #0x20
>> +    ldp    q16, q17, [sp], #0x20
>> +    ldp    q14, q15, [sp], #0x20
>> +    ldp    q12, q13, [sp], #0x20
>> +    ldp    q10, q11, [sp], #0x20
>> +    ldp    q8, q9, [sp], #0x20
>> +    ldp    q6, q7, [sp], #0x20
>> +    ldp    q4, q5, [sp], #0x20
>> +    ldp    q2, q3, [sp], #0x20
>> +    ldp    q0, q1, [sp], #0x20
>> +*/
>
> Why's this here?
>
>> +    ret
>> diff --git a/lib/checksum.c b/lib/checksum.c
>> index d3ec93f..422949c 100644
>> --- a/lib/checksum.c
>> +++ b/lib/checksum.c
>> @@ -34,10 +34,8 @@
>>     #include <linux/export.h>
>>   #include <net/checksum.h>
>> -
>>   #include <asm/byteorder.h>
>>   -#ifndef do_csum
>>   static inline unsigned short from32to16(unsigned int x)
>>   {
>>       /* add up 16-bit and 16-bit for 16+c bit */
>> @@ -47,7 +45,7 @@ static inline unsigned short from32to16(unsigned int x)
>>       return x;
>>   }
>>   -static unsigned int do_csum(const unsigned char *buff, int len)
>> +unsigned int do_csum_generic(const unsigned char *buff, int len)
>>   {
>>       int odd;
>>       unsigned int result = 0;
>> @@ -100,6 +98,8 @@ static unsigned int do_csum(const unsigned char *buff, int len)
>>   out:
>>       return result;
>>   }
>> +#ifndef do_csum
>> +#define do_csum do_csum_generic
>
> AFAICS this now means that at least one architecture (hexagon) gets the generic version built in despite it being entirely redundant.
>
> Robin.
>
>>   #endif
>>     #ifndef ip_fast_csum
>>
>
> .
>
