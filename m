From: srinidhikasagar@gmail.com (srinidhi kasagar)
Date: Thu, 5 Nov 2009 09:41:13 +0530
Subject: [PATCH] ARMv7: Check whether the SMP/nAMP mode was already
	enabled
In-Reply-To: <20091015122601.1025.67524.stgit@pc1117.cambridge.arm.com>
References: <20091015122601.1025.67524.stgit@pc1117.cambridge.arm.com>
Message-ID: <b328b2050911042011s18986993va44df5275f51968f@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Catalin,
I have tested this patch on v7 based SMP system. This patch is mandatory to
if we are booting
from non-secure mode. I ack this patch.

thanks,
Srinidhi


On Thu, Oct 15, 2009 at 5:56 PM, Catalin Marinas <catalin.marinas@arm.com>wrote:

> From: Tony Thompson <Anthony.Thompson@arm.com>
>
> If running in non-secure mode, enabling this register will fault.
>
> Signed-off-by: Tony Thompson <Anthony.Thompson@arm.com>
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> ---
>  arch/arm/mm/proc-v7.S |    7 ++++---
>  1 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
> index 23ebcf6..119a322 100644
> --- a/arch/arm/mm/proc-v7.S
> +++ b/arch/arm/mm/proc-v7.S
> @@ -184,9 +184,10 @@ cpu_v7_name:
>  */
>  __v7_setup:
>  #ifdef CONFIG_SMP
> -       mrc     p15, 0, r0, c1, c0, 1           @ Enable SMP/nAMP mode and
> -       orr     r0, r0, #(1 << 6) | (1 << 0)    @ TLB ops broadcasting
> -       mcr     p15, 0, r0, c1, c0, 1
> +       mrc     p15, 0, r0, c1, c0, 1
> +       tst     r0, #(1 << 6)                   @ SMP/nAMP mode enabled?
> +       orreq   r0, r0, #(1 << 6) | (1 << 0)    @ Enable SMP/nAMP mode and
> +       mcreq   p15, 0, r0, c1, c0, 1           @ TLB ops broadcasting
>  #endif
>        adr     r12, __v7_setup_stack           @ the local stack
>        stmia   r12, {r0-r5, r7, r9, r11, lr}
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20091105/b225f576/attachment-0001.htm>
