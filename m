From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 21 Jul 2014 20:29:54 +0200
Subject: [RFC] arm: section split in boot/compressed/head.S
In-Reply-To: <20140721175432.GB4179@bivouac.eciton.net>
References: <20140721175432.GB4179@bivouac.eciton.net>
Message-ID: <CAKv+Gu8k=1M9Y7mjYVYYqe94YNFAkG-MRw_GipvN7ORxo4CAMA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21 July 2014 19:54, Leif Lindholm <leif.lindholm@linaro.org> wrote:
> Reported-by: Roy Franz <roy.franz@linaro.org>
>
> The current code in boot/compressed/head.S executes pretty much
> sequentially from "start", all the way until the end of
> "dtb_check_done". However, shortly after the "not_angel" symbol, there
> is a section change, in the form of a ".text" directive.
>
> This means any literal pools in .start end up getting inserted into
> the middle of the instruction stream.
>
> Would something like the below (pardon the semantic silliness) be an
> acceptable fix?
>
> diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
> index 3a8b32d..8ee05e9 100644
> --- a/arch/arm/boot/compressed/head.S
> +++ b/arch/arm/boot/compressed/head.S
> @@ -149,6 +149,10 @@ start:
>                 mov     r0, #0x17               @ angel_SWIreason_EnterSVC
>   ARM(          swi     0x123456        )       @ angel_SWI_ARM
>   THUMB(                svc     0xab            )       @ angel_SWI_THUMB
> +               b       angel


The idea appears to be that code in .start sections from other
platform specific object files gets put there, so it gets executed
extremely early.
Jumping over it kind of defeats the purpose here.

Instead, adding an explicit .ltorg and jumping over /that/ should do
the trick, I think, but perhaps it's better just to open code the
literal pool in this case.

-- 
Ard.

> +
> +               .text
> +angel:
>  not_angel:
>                 safe_svcmode_maskall r0
>                 msr     spsr_cxsf, r9           @ Save the CPU boot mode in
> @@ -163,8 +167,6 @@ not_angel:
>                  * by the linker here, but it should preserve r7, r8, and r9.
>                  */
>
> -               .text
> -
>  #ifdef CONFIG_AUTO_ZRELADDR
>                 @ determine final kernel image address
>                 mov     r4, pc
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
