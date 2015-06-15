From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 15 Jun 2015 08:33:25 +0200
Subject: [PATCH v2 1/2] ARM: Add cpu_resume_arm() for firmwares that
 resume in ARM state
In-Reply-To: <1433272378-8470-2-git-send-email-sboyd@codeaurora.org>
References: <1433272378-8470-1-git-send-email-sboyd@codeaurora.org>
 <1433272378-8470-2-git-send-email-sboyd@codeaurora.org>
Message-ID: <20150615063324.GY18985@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, Jun 02, 2015 at 12:12:57PM -0700, Stephen Boyd wrote:
> Some platforms always enter the kernel in the ARM state even if
> the kernel is compiled for THUMB2. Add a small wrapper on top of
> cpu_resume() that switches into THUMB2 state.
> 
> This fixes a problem reported by Kevin Hilman on next-20150601
> where the ifc6410 fails to boot a THUMB2 kernel because the
> platform's firmware always enters the kernel in ARM mode from
> deep idle states.
> 
> Reported-by: Kevin Hilman <khilman@linaro.org>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Lina Iyer <lina.iyer@linaro.org>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>

> diff --git a/arch/arm/kernel/sleep.S b/arch/arm/kernel/sleep.S
> index 76bb3128e135..f37593567ef5 100644
> --- a/arch/arm/kernel/sleep.S
> +++ b/arch/arm/kernel/sleep.S
> @@ -118,6 +118,12 @@ ENDPROC(cpu_resume_after_mmu)
>  
>  	.text
>  	.align
> +	.arm
> +ENTRY(cpu_resume_arm)
> + THUMB(	badr	r9, 1f		)	@ Kernel is entered in ARM.
> + THUMB(	bx	r9		)	@ If this is a Thumb-2 kernel,
> + THUMB(	.thumb			)	@ switch to Thumb now.
> + THUMB(1:			)
>  ENTRY(cpu_resume)
>  ARM_BE8(setend be)			@ ensure we are in BE mode
>  #ifdef CONFIG_ARM_VIRT_EXT
this patch is in next as 51ac91b7f6b11b0da55ac93885ee7b864865bcb1 and
breaks efm32_defconfig. The exact error message is:

  AS      arch/arm/kernel/sleep.o
arch/arm/kernel/sleep.S: Assembler messages:
arch/arm/kernel/sleep.S:121: Error: selected processor does not support ARM opcodes
arch/arm/kernel/sleep.S:123: Error: bad instruction `badr r9,1f'
arch/arm/kernel/sleep.S:124: Error: attempt to use an ARM instruction on a Thumb-only processor -- `bx r9'
scripts/Makefile.build:294: recipe for target 'arch/arm/kernel/sleep.o' failed
make[3]: *** [arch/arm/kernel/sleep.o] Error 1

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
