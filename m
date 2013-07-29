From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 29 Jul 2013 17:13:41 -0600
Subject: [PATCH 4/8] ARM: tegra: add common LP1 suspend support
In-Reply-To: <1374830110-30685-5-git-send-email-josephl@nvidia.com>
References: <1374830110-30685-1-git-send-email-josephl@nvidia.com>
 <1374830110-30685-5-git-send-email-josephl@nvidia.com>
Message-ID: <51F6F725.6000106@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/26/2013 03:15 AM, Joseph Lo wrote:
> The LP1 suspending mode on Tegra means CPU rail off, devices and PLLs are
> clock gated and SDRAM in self-refresh mode. That means the low level LP1
> suspending and resuming code couldn't be run on DRAM and the CPU must
> switch to the always on clock domain (a.k.a. CLK_M 12MHz oscillator). And
> the system clock (SCLK) would be switched to CLK_S, a 32KHz oscillator.
> The LP1 low level handling code need to be moved to IRAM area first. And
> marking the LP1 mask for indicating the Tegra device is in LP1. The CPU
> power timer needs to be re-calculated based on 32KHz that was originally
> based on PCLK.

> diff --git a/arch/arm/mach-tegra/pm.c b/arch/arm/mach-tegra/pm.c

>  #ifdef CONFIG_PM_SLEEP
>  static DEFINE_SPINLOCK(tegra_lp2_lock);
> +static void __iomem *iram_code = IO_ADDRESS(TEGRA_IRAM_CODE_AREA);
> +static u32 iram_save_size;
> +static void *iram_save_addr;
> +struct tegra_lp1_iram *tegra_lp1_iram;
>  void (*tegra_tear_down_cpu)(void);
> +void (*tegra_sleep_core_finish)(unsigned long v2p);

I'm not sure all of those are required to be global variables. For
example, iram_code is just a constant, so you could easily just use it
directly in code.

> @@ -174,14 +180,75 @@ enum tegra_suspend_mode tegra_pm_validate_suspend_mode(
>  				enum tegra_suspend_mode mode)
>  {
>  	/*
> -	 * The Tegra devices only support suspending to LP2 currently.
> +	 * The Tegra devices only support suspending to LP1 currently.

That now says that only LP1 is supported. That's not true; both LP1 and
LP2 are supported. How about s/LP1/LP1 or lower/ or s:LP1:LP1/LP2: ?

> +static bool tegra_sleep_core_init(void)
> +{
> +	if (!tegra_sleep_core_finish)
> +		return false;
> +
> +	return true;
> +}

That function seems a little pointless. Why not just check the value of
tegra_sleep_core_finish directly in tegra_init_suspend()?

> +static void tegra_suspend_enter_lp1(void)
> +{
> +	tegra_pmc_suspend();
> +
> +	/* copy the reset vector & SDRAM shutdown code into IRAM */
> +	memcpy(iram_save_addr, iram_code, iram_save_size);
> +	memcpy(iram_code, tegra_lp1_iram->start_addr, iram_save_size);
> +
> +	*((u32 *)tegra_cpu_lp1_mask) = 1;
> +}
> +
> +static void tegra_suspend_exit_lp1(void)
> +{
> +	tegra_pmc_resume();
> +
> +	/* restore IRAM */
> +	memcpy(iram_code, iram_save_addr, iram_save_size);
> +
> +	*(u32 *)tegra_cpu_lp1_mask = 0;
> +}

I'm not really sure I like that, but I suppose it's OK. It sure seems
like a performance limiter, but I suppose LP1 is so slow it doesn't
matter, due to the need to ramp power rails, PLLs, SDRAM controller, etc.

It'd be nice to simply reserve more IRAM for the kernel's use. Right
now, only 1K is reserved, and presumably the code running on the AVP
can't use the rest of that page anyway, or can it?

> @@ -212,9 +282,15 @@ static int tegra_suspend_enter(suspend_state_t state)
>  		break;
>  	}
>  
> -	cpu_suspend(PHYS_OFFSET - PAGE_OFFSET, &tegra_sleep_cpu);
> +	if (mode == TEGRA_SUSPEND_LP2)
> +		cpu_suspend(PHYS_OFFSET - PAGE_OFFSET, &tegra_sleep_cpu);
> +	else
> +		cpu_suspend(PHYS_OFFSET - PAGE_OFFSET, &tegra_sleep_core);

Nit: It might be slightly simpler to simply calculate the parameter to
cpu_suspend(), but then take the same code-path:

if (mode == TEGRA_SUSPEND_LP2)
	sleep_func = tegra_sleep_cpu;
else
	sleep_func = tegra_sleep_core;
cpu_suspend(PHYS_OFFSET - PAGE_OFFSET, sleep_func);

That way, it's a little more obvious that the code always calls
cpu_suspend() in the same way, but simply passes a different function to
it to power things down at the end.

> diff --git a/arch/arm/mach-tegra/pmc.c b/arch/arm/mach-tegra/pmc.c

>  void tegra_pmc_pm_set(enum tegra_suspend_mode mode)
>  {
>  	u32 reg, csr_reg;
> -	unsigned long rate = 0;
> +	unsigned long rate = 32768;

That's LP1-specific. You should add a "case TEGRA_SUSPEND_LP1:" to the
switch statement that calculates rate instead; after all, that's the
whole point of having that switch statement.
