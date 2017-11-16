From: liuwenliang@huawei.com (Liuwenliang (Abbott Liu))
Date: Thu, 16 Nov 2017 03:07:54 +0000
Subject: [PATCH 01/11] Initialize the mapping of KASan shadow memory
In-Reply-To: <bbf43f92-3d0c-940d-b66b-68f92eb9b282@arm.com>
References: <20171011082227.20546-1-liuwenliang@huawei.com>
 <20171011082227.20546-2-liuwenliang@huawei.com>
 <227e2c6e-f479-849d-8942-1d5ff4ccd440@arm.com>
 <B8AC3E80E903784988AB3003E3E97330C0063172@dggemm510-mbs.china.huawei.com>
 <8e959f69-a578-793b-6c32-18b5b0cd08c2@arm.com>
 <B8AC3E80E903784988AB3003E3E97330C0063545@dggemm510-mbs.china.huawei.com>
 <87a7znsubp.fsf@on-the-bus.cambridge.arm.com>
 <B8AC3E80E903784988AB3003E3E97330C0063587@dggemm510-mbs.china.huawei.com>
 <bbf43f92-3d0c-940d-b66b-68f92eb9b282@arm.com>
Message-ID: <B8AC3E80E903784988AB3003E3E97330C00635F3@dggemm510-mbs.china.huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


>On 15/11/17 13:16, Liuwenliang (Abbott Liu) wrote:
>> On 09/11/17  18:36 Marc Zyngier [mailto:marc.zyngier at arm.com] wrote:
>>> On Wed, Nov 15 2017 at 10:20:02 am GMT, "Liuwenliang (Abbott Liu)" <liuwenliang@huawei.com> wrote:
>>>> diff --git a/arch/arm/include/asm/cp15.h b/arch/arm/include/asm/cp15.h
>>>> index dbdbce1..6db1f51 100644
>>>> --- a/arch/arm/include/asm/cp15.h
>>>> +++ b/arch/arm/include/asm/cp15.h
>>>> @@ -64,6 +64,43 @@
>>>>  #define __write_sysreg(v, r, w, c, t)  asm volatile(w " " c : : "r" ((t)(v)))
>>>>  #define write_sysreg(v, ...)           __write_sysreg(v, __VA_ARGS__)
>>>>
>>>> +#ifdef CONFIG_ARM_LPAE
>>>> +#define TTBR0           __ACCESS_CP15_64(0, c2)
>>>> +#define TTBR1           __ACCESS_CP15_64(1, c2)
>>>> +#define PAR             __ACCESS_CP15_64(0, c7)
>>>> +#else
>>>> +#define TTBR0           __ACCESS_CP15(c2, 0, c0, 0)
>>>> +#define TTBR1           __ACCESS_CP15(c2, 0, c0, 1)
>>>> +#define PAR             __ACCESS_CP15(c7, 0, c4, 0)
>>>> +#endif
>>> Again: there is no point in not having these register encodings
>>> cohabiting. They are both perfectly defined in the architecture. Just
>>> suffix one (or even both) with their respective size, making it obvious
>>> which one you're talking about.
>> 
>> I am sorry that I didn't point why I need to define TTBR0/ TTBR1/PAR in to different way
>> between CONFIG_ARM_LPAE and non CONFIG_ARM_LPAE.
>> The following description is the reason:
>> Here is the description come from DDI0406C2c_arm_architecture_reference_manual.pdf:
>[...]
>
>You're missing the point. TTBR0 existence as a 64bit CP15 register has
>nothing to do the kernel being compiled with LPAE or not. It has
>everything to do with the HW supporting LPAE, and it is the kernel's job
>to use the right accessor depending on how it is compiled. On a CPU
>supporting LPAE, both TTBR0 accessors are valid. It is the kernel that
>chooses to use one rather than the other.

Thanks for your review.
I don't think both TTBR0 accessors(64bit accessor and 32bit accessor) are valid on a CPU supporting
LPAE which the LPAE is enabled. Here is the description come form DDI0406C2c_arm_architecture_reference_manual.pdf
(=ARM? Architecture Reference Manual ARMv7-A and ARMv7-R edition) which you can get the document
by google "ARM? Architecture Reference Manual ARMv7-A and ARMv7-R edition". 

64-bit TTBR0 and TTBR1 format
The bit assignments for the 64-bit implementations of TTBR0 and TTBR1 are identical, and are:
Bits[63:56] UNK/SBZP.
ASID, bits[55:48]:
  An ASID for the translation table base address. The TTBCR.A1 field selects either TTBR0.ASID
or TTBR1.ASID.
Bits[47:40] UNK/SBZP.
BADDR, bits[39:x]:
   Translation table base address, bits[39:x]. Defining the translation table base address width on
page B4-1698 describes how x is defined.
The value of x determines the required alignment of the translation table, which must be aligned to
2x bytes.

Bits[x-1:0] UNK/SBZP.
...
To access a 64-bit TTBR0, software performs a 64-bit read or write of the CP15 registers with <CRm> set to c2 and
<opc1> set to 0. For example:
MRRC p15,0,<Rt>,<Rt2>, c2 ; Read 64-bit TTBR0 into Rt (low word) and Rt2 (high word)
MCRR p15,0,<Rt>,<Rt2>, c2 ; Write Rt (low word) and Rt2 (high word) to 64-bit TTBR0

So, I think if you access TTBR0/TTBR1 on CPU supporting LPAE, you must use "mcrr/mrrc" instruction
(__ACCESS_CP15_64). If you access TTBR0/TTBR1 on CPU supporting LPAE by "mcr/mrc" instruction 
which is 32bit version (__ACCESS_CP15), even if the CPU doesn't report error, you also lose the high
or low 32bit of the TTBR0/TTBR1.

>Also, if I follow your reasoning, why are you bothering defining PAR in
>the non-LPAE case? It is not used by anything, as far as I can see...

I don't use the PAR, I change the defining PAR just because I think it will be wrong in
a non LPAE CPU.
