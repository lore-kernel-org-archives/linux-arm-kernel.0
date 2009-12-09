From: paulius.zaleckas@gmail.com (Paulius Zaleckas)
Date: Wed, 09 Dec 2009 16:09:33 +0200
Subject: [PATCH] Fix AT91SAM9G20 reset
In-Reply-To: <20091209135048.GA30670@turtle.localnet>
References: <20091209135048.GA30670@turtle.localnet>
Message-ID: <4B1FAF9D.9050506@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/09/2009 03:50 PM, Peter Horton wrote:
> Fix AT91SAM9G20 reset as per the errata in the data sheet.
>
> If the SDRAM is not cleanly shutdown before reset it can be left driving
> the bus, which then stops the bootloader booting from NAND.
>
> Signed-off-by: Peter Horton<phorton@bitbox.co.uk>
> --
>

[...]

> Index: linux-2.6.32/arch/arm/mach-at91/at91sam9g20_reset.S
> ===================================================================
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux-2.6.32/arch/arm/mach-at91/at91sam9g20_reset.S	2009-12-09 13:33:28.000000000 +0000
> @@ -0,0 +1,52 @@
> +/*
> + * (C) BitBox Ltd 2009
> + *
> + * reset AT91SAM9G20 as per errata
> + *
> + * unless the SDRAM is cleanly shutdown before we hit the
> + * reset register it can be left driving the data bus and
> + * killing the chance of a subsequent boot from NAND
> + */
> +
> +#define CP15_CR_I			(1<<  12)
> +
> +#define SYS_VIRT_OFS			(-0x01000000)
> +
> +#define SDRAMC_BASE			(SYS_VIRT_OFS + 0xffffea00)
> +#define  SDRAMC_TR			0x0004
> +#define  SDRAMC_LPR			0x0010
> +#define   SDRAMC_LPCB_POWER_DOWN	2
> +
> +#define RSTC_BASE			(SYS_VIRT_OFS + 0xfffffd00)
> +#define  RSTC_CR			0x0000
> +#define   RSTC_PROCRST			(1<<  0)
> +#define   RSTC_PERRST			(1<<  2)
> +#define   RSTC_KEY			(0xa5<<  24)
> +
> +			.arm
> +
> +			.globl	at91sam9g20_reset
> +
> +at91sam9g20_reset:	mov	r0, #0
> +			mcr	p15, 0, r0, c7, c5, 0	@ flush I-cache
> +
> +			mrc	p15, 0, r0, c1, c0, 0
> +			orr	r0, r0, #CP15_CR_I
> +			mcr	p15, 0, r0, c1, c0, 0	@ enable I-cache
> +
> +			ldr	r0, =SDRAMC_BASE	@ preload constants
> +			ldr	r1, =RSTC_BASE
> +
> +			mov	r2, #1
> +			mov	r3, #SDRAMC_LPCB_POWER_DOWN
> +			ldr	r4, =RSTC_KEY | RSTC_PERRST | RSTC_PROCRST
> +
> +			.balign	32			@ align to cache line
> +
> +			str	r2, [r0, #SDRAMC_TR]	@ disable SDRAM access
> +			str	r3, [r0, #SDRAMC_LPR]	@ power down SDRAM
> +			str	r4, [r1, #RSTC_CR]	@ reset processor
> +
> +			b	.
> +
> +/* vi:set ft=ignore ai: */

Please remove the vi bits.
