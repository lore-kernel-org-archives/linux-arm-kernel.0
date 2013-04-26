From: will.deacon@arm.com (Will Deacon)
Date: Fri, 26 Apr 2013 14:21:30 +0100
Subject: [PATCH v3] ARM: imx: replicate the diagnostic register of boot
 cpu into secondary cores
In-Reply-To: <1366948645-12060-1-git-send-email-shawn.guo@linaro.org>
References: <1366948645-12060-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20130426132130.GE30858@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

Thanks for respinning this without the MMU enabled.

On Fri, Apr 26, 2013 at 04:57:25AM +0100, Shawn Guo wrote:
> The diagnostic register holds the errata bits.  Mostly bootloader
> does not bring up secondary cores, so that when errata bits are set
> in bootloader, they are set only for boot cpu.  But on a SMP
> configuration, it should be equally done on every single core.
> Set up the diagnostic register for secondary cores by replicating
> the register from boot cpu.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
> Changes since v2:
>  * Setting secondary cores' diagnostic register before MMU is enabled.
> 
>  arch/arm/mach-imx/headsmp.S |   12 ++++++++++++
>  arch/arm/mach-imx/platsmp.c |   14 ++++++++++++++
>  2 files changed, 26 insertions(+)
> 
> diff --git a/arch/arm/mach-imx/headsmp.S b/arch/arm/mach-imx/headsmp.S
> index a58c8b0..cd87970 100644
> --- a/arch/arm/mach-imx/headsmp.S
> +++ b/arch/arm/mach-imx/headsmp.S
> @@ -18,8 +18,20 @@
>  	.section ".text.head", "ax"
>  
>  #ifdef CONFIG_SMP
> +diag_reg_offset:
> +	.word	g_diag_reg - .
> +
> +	.macro	set_diag_reg
> +	adr	r0, diag_reg_offset
> +	ldr	r1, [r0]
> +	add	r1, r1, r0		@ r1 = physical &g_diag_reg
> +	ldr	r0, [r1]
> +	mcr	p15, 0, r0, c15, c0, 1	@ write diagnostic register
> +	.endm

Why not re-read the register directly, rather than mrc on the current core?
I feel uneasy about blindly copying one CPU's diagnostic bits into another.
It would also make the code simpler.

Will
