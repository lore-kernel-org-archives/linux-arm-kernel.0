From: josephl@nvidia.com (Joseph Lo)
Date: Mon, 5 Aug 2013 14:46:28 +0800
Subject: [PATCH 5/8] ARM: tegra30: add LP1 suspend support
In-Reply-To: <51F6FE89.4060402@wwwdotorg.org>
References: <1374830110-30685-1-git-send-email-josephl@nvidia.com>
 <1374830110-30685-6-git-send-email-josephl@nvidia.com>
 <51F6FE89.4060402@wwwdotorg.org>
Message-ID: <1375685188.1731.19.camel@jlo-ubuntu-64.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2013-07-30 at 07:45 +0800, Stephen Warren wrote:
> On 07/26/2013 03:15 AM, Joseph Lo wrote:
> > The LP1 suspend mode will power off the CPU, clock gated the PLLs and put
> > SDRAM to self-refresh mode. Any interrupt can wake up device from LP1. The
> > sequence when LP1 suspending:
> 
> > diff --git a/arch/arm/mach-tegra/pm-tegra30.c b/arch/arm/mach-tegra/pm-tegra30.c
> 
> > +void tegra30_lp1_iram_hook(void)
> > +{
> > +	tegra30_lp1_iram.start_addr = &tegra30_iram_start;
> > +	tegra30_lp1_iram.end_addr = &tegra30_iram_end;
> 
> If you need to fill in the values in that struct dynamically anyway, why
> not make tegra_lp1_iram be a struct rather than a pointer, and write
> directly to it?
> 
OK. Will fix.

> > +/*
> > + * tegra30_lp1_reset
> > + *
> > + * reset vector for LP1 restore; copied into IRAM during suspend.
> > + * Brings the system back up to a safe staring point (SDRAM out of
> > + * self-refresh, PLLC, PLLM and PLLP reenabled, CPU running on PLLX,
> > + * system clock running on the same PLL that it suspended at), and
> > + * jumps to tegra_resume to restore virtual addressing.
> > + * The physical address of tegra_resume expected to be stored in
> > + * PMC_SCRATCH41.
> > + *
> > + * NOTE: THIS *MUST* BE RELOCATED TO TEGRA_IRAM_CODE_AREA AND MUST BE FIRST.
> 
> What does "AND MUST BE FIRST" mean?
> 
It means the LP1 reset vector needs to be copied to IRAM_CODE_AREA first
before suspend to LP1. Looks no need this. Will remove it.

> > +ENTRY(tegra30_lp1_reset)
> > +	/*
> > +	 * The CPU and system bus are running at 32KHz and executing from
> > +	 * IRAM when this code is executed; immediately switch to CLKM and
> > +	 * enable PLLP, PLLM, PLLC, PLLA and PLLX.
> > +	 */
> > +	mov32	r0, TEGRA_CLK_RESET_BASE
> > +
> > +	mov	r1, #(1 << 28)
> 
> Some #defines for the various magic values used in this code would be
> useful.
It may still cause some confuse if I add a #defines value for it.
Because it includes a clock policy and the clock source (the value maybe
just 0). I add some comments for these codes about what they are doing.
> 
> > +tegra30_sdram_pad_save:
> > +	.word	0
> > +	.word	0
> > +	.word	0
> > +	.word	0
> > +	.word	0
> > +	.word	0
> > +	.word	0
> > +	.word	0
> 
> This might be simpler, and easier to validate it's the right length:
> 
>         .rept   8
>         .long   0
>         .endr
> 
> > +tegra30_sdram_pad_address:
> > +	.word	TEGRA_EMC_BASE + EMC_CFG				@0x0
> > +	.word	TEGRA_EMC_BASE + EMC_ZCAL_INTERVAL			@0x4
> > +	.word	TEGRA_EMC_BASE + EMC_AUTO_CAL_INTERVAL			@0x8
> > +	.word	TEGRA_EMC_BASE + EMC_XM2VTTGENPADCTRL			@0xc
> > +	.word	TEGRA_EMC_BASE + EMC_XM2VTTGENPADCTRL2			@0x10
> > +	.word	TEGRA_PMC_BASE + PMC_IO_DPD_STATUS			@0x14
> > +	.word	TEGRA_CLK_RESET_BASE + CLK_RESET_CLK_SOURCE_MSELECT	@0x18
> > +	.word	TEGRA_CLK_RESET_BASE + CLK_RESET_SCLK_BURST		@0x1c
> > +
> > +tegra30_sdram_pad_size:
> > +	.word	tegra30_sdram_pad_address - tegra30_sdram_pad_save
> 
> Perhaps if you swapp the order of declaring tegra30_sdram_pad_save and
> tegra30_sdram_pad_address, you can even do something like:
> 
> 	.rept (tegra30_sdram_pad_addr_end - tegra30_sdram_pad_addr) / 4
> 
> ?
OK. Looks better. Will do this.

> 
> > +	/* 2uS delay delay between changing SCLK and CCLK */
> > +	wait_for_us r1, r7, r9
> > +	add	r1, r1, #2
> > +	wait_until r1, r7, r9
> 
> Ah, I see how wait_for_us is used now. Perhaps rename it
> wait_for_us_boundary or wait_for_us_tick? Alternatively, perhaps
> wait_until can just incorporate that logic itself?
Indeed. Will fix.
