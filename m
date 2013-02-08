From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 8 Feb 2013 12:59:39 +0000
Subject: [PATCH v2 2/2] ARM: uncompress debug support for multiplatform
 build
In-Reply-To: <20130207050434.GA7697@S2101-09.ap.freescale.net>
References: <1358436119-30808-3-git-send-email-shawn.guo@linaro.org>
 <1358477120-19673-1-git-send-email-shawn.guo@linaro.org>
 <20130204160133.GH17786@n2100.arm.linux.org.uk>
 <20130206093236.GD17833@n2100.arm.linux.org.uk>
 <5112A933.4090108@wwwdotorg.org>
 <20130207050434.GA7697@S2101-09.ap.freescale.net>
Message-ID: <20130208125939.GQ17833@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 07, 2013 at 01:04:36PM +0800, Shawn Guo wrote:
> === omap ===
> 
>   AS      arch/arm/boot/compressed/debug.o
>   LD      arch/arm/boot/compressed/vmlinux
> `.data' referenced in section `.text' of arch/arm/boot/compressed/debug.o: defined in discarded section `.data' of arch/arm/boot/compressed/debug.o
> make[3]: *** [arch/arm/boot/compressed/vmlinux] Error 1
> 
> The following change moving the variables out of stack section seems
> fixing the failure, but I'm not quite sure if it works.
> 
> 8<---
> diff --git a/arch/arm/mach-omap2/include/mach/debug-macro.S b/arch/arm/mach-omap2/include/mach/debug
> index cfaed13..7b2877e 100644
> --- a/arch/arm/mach-omap2/include/mach/debug-macro.S
> +++ b/arch/arm/mach-omap2/include/mach/debug-macro.S
> @@ -17,11 +17,9 @@
> 
>  #define UART_OFFSET(addr)      ((addr) & 0x00ffffff)
> 
> -               .pushsection .data
>  omap_uart_phys:        .word   0
>  omap_uart_virt:        .word   0
>  omap_uart_lsr: .word   0
> -               .popsection

No, this won't work, because now these variables are located in the text
section which may not be writable.  I don't know what the answer is to
this, but as things stand it's not something that can go into v3.8 until
these problems are addressed (because if it does it _will_ cause
regressions.)

We're basically on the last day of -rc6, so I think it's all too late to
try and get this sorted for this merge window.
