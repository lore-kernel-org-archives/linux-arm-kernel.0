From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 29 Jul 2013 17:45:13 -0600
Subject: [PATCH 5/8] ARM: tegra30: add LP1 suspend support
In-Reply-To: <1374830110-30685-6-git-send-email-josephl@nvidia.com>
References: <1374830110-30685-1-git-send-email-josephl@nvidia.com>
 <1374830110-30685-6-git-send-email-josephl@nvidia.com>
Message-ID: <51F6FE89.4060402@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/26/2013 03:15 AM, Joseph Lo wrote:
> The LP1 suspend mode will power off the CPU, clock gated the PLLs and put
> SDRAM to self-refresh mode. Any interrupt can wake up device from LP1. The
> sequence when LP1 suspending:

> diff --git a/arch/arm/mach-tegra/pm-tegra30.c b/arch/arm/mach-tegra/pm-tegra30.c

> +void tegra30_lp1_iram_hook(void)
> +{
> +	tegra30_lp1_iram.start_addr = &tegra30_iram_start;
> +	tegra30_lp1_iram.end_addr = &tegra30_iram_end;

If you need to fill in the values in that struct dynamically anyway, why
not make tegra_lp1_iram be a struct rather than a pointer, and write
directly to it?

That said, aren't tegra30_iram_start constants that the linker can work
out, so I think you can just initialize the structure at compile-time,
and save some code.

> +	tegra_lp1_iram = &tegra30_lp1_iram;
> +}
> +
> +void tegra30_sleep_core_init(void)
> +{
> +	tegra_sleep_core_finish = tegra30_sleep_core_finish;
> +}

Is there a need to have separate iram_hook()/sleep_core_init()
functions? Perhaps they can be combined into a single function for
simplicity.

> diff --git a/arch/arm/mach-tegra/pm.h b/arch/arm/mach-tegra/pm.h

> +#ifdef CONFIG_ARCH_TEGRA_3x_SOC
> +void tegra30_lp1_iram_hook(void);
> +void tegra30_sleep_core_init(void);
> +#else
> +static inline void tegra30_lp1_iram_hook(void) {}
> +static inline void void tegra30_sleep_core_init(void) {}
> +#endif

It'd be nice to be consistent re: whether we define dummy static
inlines, or use IS_ENABLED() at the call-site. IIRC, there's lots of use
of IS_ENABLED() in the Tegra PM code now, so perhaps these patches
should use that instead?

> diff --git a/arch/arm/mach-tegra/sleep.h b/arch/arm/mach-tegra/sleep.h

> +/* waits until the microsecond counter (base) ticks, for exact timing loops */
> +.macro wait_for_us, rd, base, tmp
> +	ldr	\rd, [\base]
> +1001:	ldr	\tmp, [\base]
> +	cmp	\rd, \tmp
> +	beq	1001b
> +.endm

Doesn't this wait any amount of time from 0..1uS, and hence it actually
/isn't/ very exact?

> +/* waits until the microsecond counter (base) is > rn */
> +.macro wait_until, rn, base, tmp
> +	add	\rn, \rn, #1
> +1002:	ldr	\tmp, [\base]
> +	cmp	\tmp, \rn
> +	bmi	1002b
> +.endm

Parameter "rn" could be renamed to make its purpose clear from the name.
How about target_us or wait_until_this_time? "wait_until" is also rather
a generic name; wait_until_us would be much better, which would require
renaming wait_until_us above, which I think might be better deleted, or
renamed to wait_until_next_us?

> diff --git a/arch/arm/mach-tegra/sleep-tegra30.S b/arch/arm/mach-tegra/sleep-tegra30.S

> +ENTRY(tegra30_sleep_core_finish)

> +	/*
> +	 * Preload all the address literals that are needed for the
> +	 * CPU power-gating process, to avoid loading from SDRAM which
> +	 * are not supported once SDRAM is put into self-refresh.
> +	 * LP0 / LP1 use physical address, since the MMU needs to be
> +	 * disalbed before putting SDRAM into self-refresh to avoid

s/disalbed/disabled/

> +/*
> + * tegra30_lp1_reset
> + *
> + * reset vector for LP1 restore; copied into IRAM during suspend.
> + * Brings the system back up to a safe staring point (SDRAM out of
> + * self-refresh, PLLC, PLLM and PLLP reenabled, CPU running on PLLX,
> + * system clock running on the same PLL that it suspended at), and
> + * jumps to tegra_resume to restore virtual addressing.
> + * The physical address of tegra_resume expected to be stored in
> + * PMC_SCRATCH41.
> + *
> + * NOTE: THIS *MUST* BE RELOCATED TO TEGRA_IRAM_CODE_AREA AND MUST BE FIRST.

What does "AND MUST BE FIRST" mean?

> +ENTRY(tegra30_lp1_reset)
> +	/*
> +	 * The CPU and system bus are running at 32KHz and executing from
> +	 * IRAM when this code is executed; immediately switch to CLKM and
> +	 * enable PLLP, PLLM, PLLC, PLLA and PLLX.
> +	 */
> +	mov32	r0, TEGRA_CLK_RESET_BASE
> +
> +	mov	r1, #(1 << 28)

Some #defines for the various magic values used in this code would be
useful.

> +tegra30_sdram_pad_save:
> +	.word	0
> +	.word	0
> +	.word	0
> +	.word	0
> +	.word	0
> +	.word	0
> +	.word	0
> +	.word	0

This might be simpler, and easier to validate it's the right length:

        .rept   8
        .long   0
        .endr

> +tegra30_sdram_pad_address:
> +	.word	TEGRA_EMC_BASE + EMC_CFG				@0x0
> +	.word	TEGRA_EMC_BASE + EMC_ZCAL_INTERVAL			@0x4
> +	.word	TEGRA_EMC_BASE + EMC_AUTO_CAL_INTERVAL			@0x8
> +	.word	TEGRA_EMC_BASE + EMC_XM2VTTGENPADCTRL			@0xc
> +	.word	TEGRA_EMC_BASE + EMC_XM2VTTGENPADCTRL2			@0x10
> +	.word	TEGRA_PMC_BASE + PMC_IO_DPD_STATUS			@0x14
> +	.word	TEGRA_CLK_RESET_BASE + CLK_RESET_CLK_SOURCE_MSELECT	@0x18
> +	.word	TEGRA_CLK_RESET_BASE + CLK_RESET_SCLK_BURST		@0x1c
> +
> +tegra30_sdram_pad_size:
> +	.word	tegra30_sdram_pad_address - tegra30_sdram_pad_save

Perhaps if you swapp the order of declaring tegra30_sdram_pad_save and
tegra30_sdram_pad_address, you can even do something like:

	.rept (tegra30_sdram_pad_addr_end - tegra30_sdram_pad_addr) / 4

?

> +tegra30_switch_cpu_to_clk32k:
> +	/*
> +	 * start by jumping to CLKM to safely disable PLLs, then jump to

jumping sounds like a CPU program counter operation.
s/jumping/switching/ ?

> +	/* 2uS delay delay between changing SCLK and CCLK */
> +	wait_for_us r1, r7, r9
> +	add	r1, r1, #2
> +	wait_until r1, r7, r9

Ah, I see how wait_for_us is used now. Perhaps rename it
wait_for_us_boundary or wait_for_us_tick? Alternatively, perhaps
wait_until can just incorporate that logic itself?
