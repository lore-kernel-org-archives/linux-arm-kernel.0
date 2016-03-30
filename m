From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Wed, 30 Mar 2016 16:01:44 +0900
Subject: [PATCH 1/2] ARM: uniphier: fix up cache ops broadcast of ACTLR
In-Reply-To: <20160329100308.GW19428@n2100.arm.linux.org.uk>
References: <1459215505-18035-1-git-send-email-yamada.masahiro@socionext.com>
 <1459215505-18035-2-git-send-email-yamada.masahiro@socionext.com>
 <20160329100308.GW19428@n2100.arm.linux.org.uk>
Message-ID: <CAK7LNASYFuKTV2Wp-xaRXdxV6uyrg9+jOCv=AipQN_Ue5GCF_w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

2016-03-29 19:03 GMT+09:00 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Tue, Mar 29, 2016 at 10:38:23AM +0900, Masahiro Yamada wrote:
>> The Boot ROM of the UniPhier ARMv7 SoCs sets ACTLR (Auxiliary Control
>> Register) to different values for different secure states:
>>
>> [1] Set ACTLR to 0x41 for Non-secure boot
>> [2] Set ACTLR to 0x40 for Secure boot
>>
>> [1] is okay, but [2] is a problem.  Because of commit 1b3a02eb4523
>> ("ARMv7: Check whether the SMP/nAMP mode was already enabled"),
>> if bit 6 (SMP bit) is already set, the kernel skips the ACTLR setting.
>> In that case, bit 0 (FW bit) is never set, so cache ops is not
>> broadcasted, causing a cache coherency problem.
>>
>> To solve the problem, this commit sets the bit 0 of ACTLR if the bit 4
>> has already been set.  This change is harmless for [1] because the
>> Boot ROM has already set NSACR (Non-secure Access Control Register)
>> bit 18 (NS_SMP bit) before switching to Non-secure state in order to
>> allow write access to the ACTLR.
>
> The test in proc-v7.S is too weak, we should probably tighten it to
> prevent these kinds of problems, iow:
>
>  arch/arm/mm/proc-v7.S | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
> index 0f8963a7e7d9..6fcaac8e200f 100644
> --- a/arch/arm/mm/proc-v7.S
> +++ b/arch/arm/mm/proc-v7.S
> @@ -281,12 +281,12 @@ __v7_ca17mp_setup:
>         bl      v7_invalidate_l1
>         ldmia   r12, {r1-r6, lr}
>  #ifdef CONFIG_SMP
> +       orr     r10, r10, #(1 << 6)             @ Enable SMP/nAMP mode
>         ALT_SMP(mrc     p15, 0, r0, c1, c0, 1)
> -       ALT_UP(mov      r0, #(1 << 6))          @ fake it for UP
> -       tst     r0, #(1 << 6)                   @ SMP/nAMP mode enabled?
> -       orreq   r0, r0, #(1 << 6)               @ Enable SMP/nAMP mode
> -       orreq   r0, r0, r10                     @ Enable CPU-specific SMP bits
> -       mcreq   p15, 0, r0, c1, c0, 1
> +       ALT_UP(mov      r0, r10)                @ fake it for UP
> +       orr     r10, r10, r0                    @ Set required bits
> +       teq     r10, r0                         @ Were they already set?
> +       mcrne   p15, 0, r10, c1, c0, 1          @ No, update register
>  #endif
>         b       __v7_setup_cont
>
>
>

I tested it on some of my Cortex-A9 based boards.
(all the combinations of SMP/UP SoC and Secure/Non-secure boot)
and your patch worked fine!

Could you send it as a patch with git-log, please?
Please feel free to add my
Tested-by: Masahiro Yamada <yamada.masahiro@socionext.com>


I retract my crap patch.

Thank you!


-- 
Best Regards
Masahiro Yamada
