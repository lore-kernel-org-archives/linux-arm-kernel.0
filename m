From: peng.fan@nxp.com (Peng Fan)
Date: Mon, 25 Dec 2017 01:24:24 +0000
Subject: [PATCH] arm: imx: suspend/resume: use outer_disable/resume
In-Reply-To: <20171210120718.15197-1-peng.fan@nxp.com>
References: <20171210120718.15197-1-peng.fan@nxp.com>
Message-ID: <DB6PR04MB3221410C5981FF2659B5F34988010@DB6PR04MB3221.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

Ping...

> -----Original Message-----
> From: Peng Fan
> Sent: Sunday, December 10, 2017 8:07 PM
> To: shawnguo at kernel.org
> Cc: linux-arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org;
> van.freenix at gmail.com; Peng Fan <peng.fan@nxp.com>; Sascha Hauer
> <kernel@pengutronix.de>; Fabio Estevam <fabio.estevam@nxp.com>; Russell
> King <linux@armlinux.org.uk>; A.s. Dong <aisheng.dong@nxp.com>
> Subject: [PATCH] arm: imx: suspend/resume: use outer_disable/resume
> 
> Use outer_disable/resume for suspend/resume.
> With the two APIs used, code could be simplified and easy to extend to
> introduce l2c_write_sec for i.MX platforms when moving Linux Kernel runs in
> non-secure world.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Dong Aisheng <aisheng.dong@nxp.com>
> ---
>  arch/arm/mach-imx/pm-imx6.c      |  2 ++
>  arch/arm/mach-imx/suspend-imx6.S | 24 ------------------------
>  2 files changed, 2 insertions(+), 24 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/pm-imx6.c b/arch/arm/mach-imx/pm-imx6.c
> index ecdf071653d4..153a0afc7645 100644
> --- a/arch/arm/mach-imx/pm-imx6.c
> +++ b/arch/arm/mach-imx/pm-imx6.c
> @@ -392,8 +392,10 @@ static int imx6q_pm_enter(suspend_state_t state)
>  			imx6_enable_rbc(true);
>  		imx_gpc_pre_suspend(true);
>  		imx_anatop_pre_suspend();
> +		outer_disable();
>  		/* Zzz ... */
>  		cpu_suspend(0, imx6q_suspend_finish);
> +		outer_resume();
>  		if (cpu_is_imx6q() || cpu_is_imx6dl())
>  			imx_smp_prepare();
>  		imx_anatop_post_resume();
> diff --git a/arch/arm/mach-imx/suspend-imx6.S b/arch/arm/mach-
> imx/suspend-imx6.S
> index 76ee2ceec8d5..324f6b165e82 100644
> --- a/arch/arm/mach-imx/suspend-imx6.S
> +++ b/arch/arm/mach-imx/suspend-imx6.S
> @@ -74,24 +74,6 @@
> 
>  	.align 3
> 
> -	.macro  sync_l2_cache
> -
> -	/* sync L2 cache to drain L2's buffers to DRAM. */
> -#ifdef CONFIG_CACHE_L2X0
> -	ldr	r11, [r0, #PM_INFO_MX6Q_L2_V_OFFSET]
> -	teq	r11, #0
> -	beq	6f
> -	mov	r6, #0x0
> -	str	r6, [r11, #L2X0_CACHE_SYNC]
> -1:
> -	ldr	r6, [r11, #L2X0_CACHE_SYNC]
> -	ands	r6, r6, #0x1
> -	bne	1b
> -6:
> -#endif
> -
> -	.endm
> -
>  	.macro	resume_mmdc
> 
>  	/* restore MMDC IO */
> @@ -185,9 +167,6 @@ ENTRY(imx6_suspend)
>  	str	r9, [r11, #MX6Q_SRC_GPR1]
>  	str	r1, [r11, #MX6Q_SRC_GPR2]
> 
> -	/* need to sync L2 cache before DSM. */
> -	sync_l2_cache
> -
>  	ldr	r11, [r0, #PM_INFO_MX6Q_MMDC_V_OFFSET]
>  	/*
>  	 * put DDR explicitly into self-refresh and @@ -342,8 +321,5 @@
> ENDPROC(imx6_suspend)
> 
>  ENTRY(v7_cpu_resume)
>  	bl	v7_invalidate_l1
> -#ifdef CONFIG_CACHE_L2X0
> -	bl	l2c310_early_resume
> -#endif
>  	b	cpu_resume
>  ENDPROC(v7_cpu_resume)
> --
> 2.14.1

Thanks,
Peng.
