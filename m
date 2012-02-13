From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 13 Feb 2012 23:26:52 +0100
Subject: [PATCH] modpost: Fix section warnings for ARM for many compilers
In-Reply-To: <20120213212401.GH1426@atomide.com>
References: <20120213212401.GH1426@atomide.com>
Message-ID: <20120213222652.GL14173@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 13, 2012 at 01:24:01PM -0800, Tony Lindgren wrote:
> It turns out that many compilers don't show section warnings on ARM
> currently because handling for ARM_CALL relocs are missing from
> modpost.c.
> 
> Based on commit c2e26114 ([ARM] 3205/1: Handle new EABI relocations when
> loading kernel modules) it seems that R_ARM_PC24, R_ARM_CALL and
> R_ARM_JUMP24 can be handled the same way.
> 
> As modpost.c includes elf.h, we need to also consider that at least
> Debian libc6-dev is missing defines for both R_ARM_CALL and R_ARM_JUMP24
> in /usr/include/elf.h.
Huh, even unstable's /usr/include/elf.h doesn't have these symbols.

> So for now let's just use the numbers in modpost.c.
> 
> Cc: Rusty Russell <rusty@rustcorp.com.au>
> Cc: Ben Hutchings <ben@decadent.org.uk>
> Cc: Anders Kaseorg <andersk@ksplice.com>
> Cc: Greg KH <gregkh@linuxfoundation.org>
> Cc: Russell King <rmk+kernel@arm.linux.org.uk>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> ---
> 
> Anybody got better ideas for dealing with the missing elf.h
> defines?
Maybe:

#ifndef R_ARM_CALL
#warning "you're elf.h include is outdated"
#define R_ARM_CALL 28
#endif

Best regards
Uwe

> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -1505,6 +1505,8 @@ static int addend_arm_rel(struct elf_info *elf, Elf_Shdr *sechdr, Elf_Rela *r)
>  		              (elf->symtab_start + ELF_R_SYM(r->r_info));
>  		break;
>  	case R_ARM_PC24:
> +	case 28:		/* R_ARM_CALL */
> +	case 29:		/* R_ARM_JUMP24 */
>  		/* From ARM ABI: ((S + A) | T) - P */
>  		r->r_addend = (int)(long)(elf->hdr +
>  		              sechdr->sh_offset +

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
