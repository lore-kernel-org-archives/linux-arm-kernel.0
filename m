From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 16 Oct 2017 13:14:54 +0100
Subject: [PATCH 04/11] Define the virtual space of KASan's shadow region
In-Reply-To: <B8AC3E80E903784988AB3003E3E97330C005B9BF@dggemm510-mbx.china.huawei.com>
References: <20171011082227.20546-5-liuwenliang@huawei.com>
 <201710141957.mbxeZJHB%fengguang.wu@intel.com>
 <B8AC3E80E903784988AB3003E3E97330C005B9BF@dggemm510-mbx.china.huawei.com>
Message-ID: <CAKv+Gu98M9PZk3qm0PYC8nQ3zMvLZmNmOn4=hNdFE7NTBuHbgg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16 October 2017 at 12:42, Liuwenliang (Lamb) <liuwenliang@huawei.com> wrote:
> On 10/16/2017 07:03 PM, Abbott Liu wrote:
>>arch/arm/kernel/entry-armv.S:348: Error: selected processor does not support `movw r1,
>   #:lower16:((((0xC0000000-0x01000000)>>3)+((0xC0000000-0x01000000)-(1<<29))))' in ARM mode
>>arch/arm/kernel/entry-armv.S:348: Error: selected processor does not support `movt r1,
>   #:upper16:((((0xC0000000-0x01000000)>>3)+((0xC0000000-0x01000000)-(1<<29))))' in ARM mode
>
> Thanks for building test. This error can be solved by following code:
> --- a/arch/arm/kernel/entry-armv.S
> +++ b/arch/arm/kernel/entry-armv.S
> @@ -188,8 +188,7 @@ ENDPROC(__und_invalid)
>         get_thread_info tsk
>         ldr     r0, [tsk, #TI_ADDR_LIMIT]
>  #ifdef CONFIG_KASAN
> -   movw r1, #:lower16:TASK_SIZE
> -   movt r1, #:upper16:TASK_SIZE
> + ldr r1, =TASK_SIZE
>  #else
>         mov r1, #TASK_SIZE
>  #endif

This is unnecessary:

ldr r1, =TASK_SIZE

will be converted to a mov instruction by the assembler if the value
of TASK_SIZE fits its 12-bit immediate field.

So please remove the whole #ifdef, and just use ldr r1, =xxx

> @@ -446,7 +445,12 @@ ENDPROC(__fiq_abt)
>         @ if it was interrupted in a critical region.  Here we
>         @ perform a quick test inline since it should be false
>         @ 99.9999% of the time.  The rest is done out of line.
> +#if CONFIG_KASAN
> + ldr r0, =TASK_SIZE
> + cmp r4, r0
> +#else
>         cmp     r4, #TASK_SIZE
> +#endif
>         blhs    kuser_cmpxchg64_fixup
>  #endif
>  #endif
>
> movt,movw can only be used in ARMv6*, ARMv7 instruction set. But ldr can be used in ARMv4*, ARMv5T*, ARMv6*, ARMv7.
> Maybe the performance is going to fall down by using ldr, but I think the influence of performance is very limited.
>
