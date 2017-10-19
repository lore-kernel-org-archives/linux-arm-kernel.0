From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 19 Oct 2017 13:40:34 +0100
Subject: [PATCH 04/11] Define the virtual space of KASan's shadow region
In-Reply-To: <B8AC3E80E903784988AB3003E3E97330C005B9BF@dggemm510-mbx.china.huawei.com>
References: <20171011082227.20546-5-liuwenliang@huawei.com>
 <201710141957.mbxeZJHB%fengguang.wu@intel.com>
 <B8AC3E80E903784988AB3003E3E97330C005B9BF@dggemm510-mbx.china.huawei.com>
Message-ID: <20171019124034.GW20805@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 16, 2017 at 11:42:05AM +0000, Liuwenliang (Lamb) wrote:
> On 10/16/2017 07:03 PM, Abbott Liu wrote:
> >arch/arm/kernel/entry-armv.S:348: Error: selected processor does not support `movw r1,
>   #:lower16:((((0xC0000000-0x01000000)>>3)+((0xC0000000-0x01000000)-(1<<29))))' in ARM mode
> >arch/arm/kernel/entry-armv.S:348: Error: selected processor does not support `movt r1,
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

We can surely do better than this with macros and condition support -
we can build-time test in the assembler whether TASK_SIZE can fit in a
normal "mov", whether we can use the movw/movt instructions, or fall
back to ldr if necessary.  I'd rather we avoided "ldr" here where
possible.

> @@ -446,7 +445,12 @@ ENDPROC(__fiq_abt)
>         @ if it was interrupted in a critical region.  Here we
>         @ perform a quick test inline since it should be false
>         @ 99.9999% of the time.  The rest is done out of line.
> +#if CONFIG_KASAN
> + ldr r0, =TASK_SIZE
> + cmp r4, r0
> +#else
>         cmp     r4, #TASK_SIZE

Same sort of thing goes for here - we can select the instruction at
runtime using the assembler's macros and condition support.

We know that TASK_SIZE is going to be one of a limited set of values.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
