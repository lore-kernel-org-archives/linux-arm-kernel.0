From: tony@atomide.com (Tony Lindgren)
Date: Tue, 13 Jun 2017 22:27:50 -0700
Subject: [RESEND PATCH 1/2] arm:omap2+: put omap_uart_phys/virt/lsr in
 .text section when ZIMAGE is true
In-Reply-To: <1497316206-11110-1-git-send-email-hoeun.ryu@gmail.com>
References: <1497316206-11110-1-git-send-email-hoeun.ryu@gmail.com>
Message-ID: <20170614052750.GC3730@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

* Hoeun Ryu <hoeun.ryu@gmail.com> [170612 18:18]:
> --- a/arch/arm/include/debug/omap2plus.S
> +++ b/arch/arm/include/debug/omap2plus.S
> @@ -58,11 +58,22 @@
>  
>  #define UART_OFFSET(addr)	((addr) & 0x00ffffff)
>  
> +/*
> + * Definition of ZIMAGE is in arch/arm/boot/compressed/Makefile.
> + * Place the following block in .text section only when this file is
> + * included by arch/arm/boot/compressed/* to make it possible to
> + * enable CONFIG_DEBUG_UNCOMPRESS and DEBUG in arch/arm/boot/compressed/head.S
> + * on OMAP2+ SoCs.
> + */
> +#ifndef ZIMAGE
>  		.pushsection .data
> +#endif
>  omap_uart_phys:	.word	0
>  omap_uart_virt:	.word	0
>  omap_uart_lsr:	.word	0
> +#ifndef ZIMAGE
>  		.popsection
> +#endif

So I converted all these to use the 8250 debug_ll yesterday
which should solve the DEBUG_UNCOMPRESS issue for you and
allows us to remove this file. Will post the series shortly
for testing with you in Cc after I've done a bit more testing
here.

Regards,

Tony
