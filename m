From: hoeun.ryu@gmail.com (Hoeun Ryu)
Date: Sat, 10 Jun 2017 13:44:00 +0900
Subject: [PATCH 1/2] arm:omap2+: put omap_uart_phys/virt/lsr in .text
 section when ZIMAGE is true
In-Reply-To: <1496888232-30764-1-git-send-email-hoeun.ryu@gmail.com>
References: <1496888232-30764-1-git-send-email-hoeun.ryu@gmail.com>
Message-ID: <6C915D66-C962-4264-89C1-C75A0530A2A1@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello, Russell.

Would you please review this patch ?

Than you

> On Jun 8, 2017, at 11:16 AM, Hoeun Ryu <hoeun.ryu@gmail.com> wrote:
> 
> omap_uart_phys, omap_uart_virt and omap_uart_lsr reside in .data section
> and it's right implementation. But because of this, we cannot enable
> CONFIG_DEBUG_UNCOMPRESS. LL_DEBUG and DEBUG_UNCOMPRESS are very useful tools
> for debugging early boot stage when something goes wrong if you don't have
> any hardware based debugging tools like a JTAG debugger.
> This patch is to put the variables into .text section instead only when the
> DEBUG_LL_INCLUDE file is included in the kernel decompressor, which is only
> when ZIMAGE is defined.
> This patch does not change anything when DEBUG_LL_INCLUDE is included in
> the other kernel parts like arch/arm/kernel/*
> 
> Signed-off-by: Hoeun Ryu <hoeun.ryu@gmail.com>
> ---
> arch/arm/include/debug/omap2plus.S | 11 +++++++++++
> 1 file changed, 11 insertions(+)
> 
> diff --git a/arch/arm/include/debug/omap2plus.S b/arch/arm/include/debug/omap2plus.S
> index 6d867ae..6ce6ef9 100644
> --- a/arch/arm/include/debug/omap2plus.S
> +++ b/arch/arm/include/debug/omap2plus.S
> @@ -58,11 +58,22 @@
> 
> #define UART_OFFSET(addr)    ((addr) & 0x00ffffff)
> 
> +/*
> + * Definition of ZIMAGE is in arch/arm/boot/compressed/Makefile.
> + * Place the following block in .text section only when this file is
> + * included by arch/arm/boot/compressed/* to make it possible to
> + * enable CONFIG_DEBUG_UNCOMPRESS and DEBUG in arch/arm/boot/compressed/head.S
> + * on OMAP2+ SoCs.
> + */
> +#ifndef ZIMAGE
>        .pushsection .data
> +#endif
> omap_uart_phys:    .word    0
> omap_uart_virt:    .word    0
> omap_uart_lsr:    .word    0
> +#ifndef ZIMAGE
>        .popsection
> +#endif
> 
>        .macro    addruart, rp, rv, tmp
> 
> -- 
> 2.7.4
> 
