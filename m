From: laforge@gnumonks.org (Harald Welte)
Date: Fri, 6 Nov 2009 12:18:45 +0900
Subject: [PATCH 02/17] ARM: S5PC1XX: registers rename
In-Reply-To: <1255421482-26455-3-git-send-email-m.szyprowski@samsung.com>
References: <1255421482-26455-1-git-send-email-m.szyprowski@samsung.com>
	<1255421482-26455-2-git-send-email-m.szyprowski@samsung.com>
	<1255421482-26455-3-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20091106031845.GG3913@prithivi.gnumonks.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

On Tue, Oct 13, 2009 at 10:11:07AM +0200, Marek Szyprowski wrote:

> S5PC110 and S5PC100 register maps differs in many places, rename all
> defined registers to be S5PC100 specific. System map has been also updated
> to cover more integrated peripherals.

The general idea of this patch is fine.  However, I have some questions:

>  /* System */
> -#define S5PC100_PA_SYS		(0xE0100000)
> -#define S5PC100_PA_CLK		(S5PC100_PA_SYS + 0x0)
> -#define S5PC100_PA_PWR		(S5PC100_PA_SYS + 0x8000)
> +#define S5PC100_PA_CLK		(0xE0100000)
> +#define S5PC100_PA_CLK_OTHER	(0xE0200000)
> +#define S5PC100_PA_PWR		(0xE0108000)

this is more like a rename.  Why was this done?  It would be good to explain in
the commitlog

> +/* GPIO */
> +#define S5PC100_PA_GPIO		(0xE0300000)
> +#define S5PC1XX_PA_GPIO		S5PC100_PA_GPIO
> +#define S5PC1XX_VA_GPIO		S3C_ADDR(0x00500000)

If the address is different for c100 and c110: why do we need a S5CP1XX_*
definition?  In my personal opinion, all those compile-time defines are a
kludge and we should not introduce more of them.  They will bite us in the back
if we ever in the future want to build a kernel that can boot on both c100 and
c110.

>  /* ETC */
>  #define S5PC100_PA_SDRAM	(0x20000000)
> +#define S5PC1XX_PA_SDRAM	S5PC100_PA_SDRAM

Again here. We already have the c100 specific define.  Why add a new c1xx define?

>  	/* Maintainer: Byungho Min <bhmin@samsung.com> */
> -	.phys_io	= S5PC1XX_PA_UART & 0xfff00000,
> +	.phys_io	= S5PC100_PA_UART & 0xfff00000,

this is the change I like.

>  	.io_pg_offst	= (((u32)S5PC1XX_VA_UART) >> 18) & 0xfffc,
> -	.boot_params	= S5PC100_PA_SDRAM + 0x100,
> +	.boot_params	= S5PC1XX_PA_SDRAM + 0x100,

This is the wrong kind of change, from my point of view.  We don't know yet
if all future s5pc1xx products will also have the same address, do we?

-- 
- Harald Welte <laforge@gnumonks.org>           http://laforge.gnumonks.org/
============================================================================
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)
