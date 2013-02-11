From: olof@lixom.net (Olof Johansson)
Date: Mon, 11 Feb 2013 14:16:04 -0800
Subject: [PATCHv4 for soc 4/4] arm: socfpga: Add SMP support for actual
 socfpga harware
In-Reply-To: <1360008731-17021-5-git-send-email-dinguyen@altera.com>
References: <1360008731-17021-1-git-send-email-dinguyen@altera.com>
 <1360008731-17021-5-git-send-email-dinguyen@altera.com>
Message-ID: <20130211221604.GA12025@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Feb 04, 2013 at 02:12:11PM -0600, dinguyen at altera.com wrote:

> diff --git a/arch/arm/mach-socfpga/headsmp.S b/arch/arm/mach-socfpga/headsmp.S
> index f09b128..3c83582 100644
> --- a/arch/arm/mach-socfpga/headsmp.S
> +++ b/arch/arm/mach-socfpga/headsmp.S
> @@ -13,13 +13,21 @@
>  	__CPUINIT
>  	.arch	armv7-a
>  
> -#define CPU1_START_ADDR 	        0xffd08010
> -
>  ENTRY(secondary_trampoline)
> -	movw	r0, #:lower16:CPU1_START_ADDR
> -	movt  r0, #:upper16:CPU1_START_ADDR
> +	movw	r2, #:lower16:cpu1start_addr
> +	movt  r2, #:upper16:cpu1start_addr
> +
> +	/* The socfpga VT cannot handle a 0xC0000000 page offset when loading
> +		the cpu1start_addr, we bit clear it. Tested on HW and VT. */
> +	bic	r2, r2, #0x40000000
>  
> +	ldr	r0, [r2]
>  	ldr	r1, [r0]
>  	bx	r1
>  
>  ENTRY(secondary_trampoline_end)
> +
> +ENTRY(v7_secondary_startup)
> +       bl      v7_invalidate_l1
> +       b       secondary_startup
> +ENDPROC(v7_secondary_startup)

This breaks multiplatform where you build i.MX and socfpga together,
since both implement and export a v7_secondary_startup:

arch/arm/mach-socfpga/built-in.o: In function `v7_secondary_startup':
platsmp.c:(.cpuinit.text+0x18): multiple definition of `v7_secondary_startup'
arch/arm/mach-imx/built-in.o:platform-imx-dma.c:(.text.head+0x0): first defined here

It makes sense to rename this to socfpga_secondary_startup instead, or move
to a common location.


-Olof
