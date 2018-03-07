From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 7 Mar 2018 12:18:33 +0000
Subject: [PATCH v4 10/10] ARM: sunxi: smp: Add initialization of CNTVOFF
In-Reply-To: <20180223133742.26044-11-mylene.josserand@bootlin.com>
References: <20180223133742.26044-1-mylene.josserand@bootlin.com>
 <20180223133742.26044-11-mylene.josserand@bootlin.com>
Message-ID: <6329fbb6-13a1-41fe-f6cf-f2f0d4b2e5f9@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/02/18 13:37, Myl?ne Josserand wrote:
> On Cortex-A7, the CNTVOFF register from arch timer is uninitialized.

Only on A7? Is that specific to your platform?

> It should be done by the bootloader but it is currently not the case,
> even for boot CPU because this SoC is booting in secure mode.
> It leads to an random offset value meaning that each CPU will have a
> different time, which isn't working very well.
> 
> Add assembly code used for boot CPU and secondary CPU cores to make
> sure that the CNTVOFF register is initialized.
> 
> Signed-off-by: Myl?ne Josserand <mylene.josserand@bootlin.com>
> ---
>  arch/arm/mach-sunxi/headsmp.S | 21 +++++++++++++++++++++
>  arch/arm/mach-sunxi/sunxi.c   |  4 ++++
>  2 files changed, 25 insertions(+)
> 
> diff --git a/arch/arm/mach-sunxi/headsmp.S b/arch/arm/mach-sunxi/headsmp.S
> index d5c97e945e69..605896251927 100644
> --- a/arch/arm/mach-sunxi/headsmp.S
> +++ b/arch/arm/mach-sunxi/headsmp.S
> @@ -65,9 +65,30 @@ ENTRY(sunxi_mc_smp_cluster_cache_enable)
>  	first: .word sunxi_mc_smp_first_comer - .
>  ENDPROC(sunxi_mc_smp_cluster_cache_enable)
>  
> +ENTRY(sunxi_init_cntvoff)
> +	/*
> +	 * CNTVOFF has to be initialized either from non-secure Hypervisor
> +	 * mode or secure Monitor mode with SCR.NS==1. If TrustZone is enabled
> +	 * then it should be handled by the secure code
> +	 */
> +	cps	#MON_MODE
> +	mrc	p15, 0, r1, c1, c1, 0		/* Get Secure Config */
> +	orr	r0, r1, #1
> +	mcr	p15, 0, r0, c1, c1, 0		/* Set Non Secure bit */
> +	instr_sync

Since these CPUs are all ARMv7, you can use isb directly. Nobody wants
to see more of the CP15 barriers.

> +	mov	r0, #0
> +	mcrr	p15, 4, r0, r0, c14		/* CNTVOFF = 0 */
> +	instr_sync
> +	mcr	p15, 0, r1, c1, c1, 0		/* Set Secure bit */
> +	instr_sync
> +	cps	#SVC_MODE
> +	ret	lr

Given that this code is identical to the shmobile hack, it'd be good to
make it common, one way or another.

> +ENDPROC(sunxi_init_cntvoff)
> +
>  #ifdef CONFIG_SMP
>  ENTRY(sunxi_boot)
>  	bl	sunxi_mc_smp_cluster_cache_enable
> +	bl	sunxi_init_cntvoff
>  	b	secondary_startup
>  ENDPROC(sunxi_boot)
>  
> diff --git a/arch/arm/mach-sunxi/sunxi.c b/arch/arm/mach-sunxi/sunxi.c
> index 5e9602ce1573..4bb041492b54 100644
> --- a/arch/arm/mach-sunxi/sunxi.c
> +++ b/arch/arm/mach-sunxi/sunxi.c
> @@ -37,8 +37,12 @@ static const char * const sun6i_board_dt_compat[] = {
>  };
>  
>  extern void __init sun6i_reset_init(void);
> +extern void sunxi_init_cntvoff(void);
> +
>  static void __init sun6i_timer_init(void)
>  {
> +	sunxi_init_cntvoff();
> +

It is slightly odd that some CPUs get initialized from the early asm
code, and some others do a detour via some C code. I'm sure this could
be made to work

>  	of_clk_init(NULL);
>  	if (IS_ENABLED(CONFIG_RESET_CONTROLLER))
>  		sun6i_reset_init();
> 

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
