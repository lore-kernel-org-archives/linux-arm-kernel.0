From: josephl@nvidia.com (Joseph Lo)
Date: Fri, 2 Aug 2013 17:27:00 +0800
Subject: [PATCH 4/8] ARM: tegra: add common LP1 suspend support
In-Reply-To: <51F6F725.6000106@wwwdotorg.org>
References: <1374830110-30685-1-git-send-email-josephl@nvidia.com>
 <1374830110-30685-5-git-send-email-josephl@nvidia.com>
 <51F6F725.6000106@wwwdotorg.org>
Message-ID: <1375435620.6761.120.camel@jlo-ubuntu-64.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2013-07-30 at 07:13 +0800, Stephen Warren wrote:
> On 07/26/2013 03:15 AM, Joseph Lo wrote:
> > The LP1 suspending mode on Tegra means CPU rail off, devices and PLLs are
> > clock gated and SDRAM in self-refresh mode. That means the low level LP1
> > suspending and resuming code couldn't be run on DRAM and the CPU must
> > switch to the always on clock domain (a.k.a. CLK_M 12MHz oscillator). And
> > the system clock (SCLK) would be switched to CLK_S, a 32KHz oscillator.
> > The LP1 low level handling code need to be moved to IRAM area first. And
> > marking the LP1 mask for indicating the Tegra device is in LP1. The CPU
> > power timer needs to be re-calculated based on 32KHz that was originally
> > based on PCLK.
> 
> > diff --git a/arch/arm/mach-tegra/pm.c b/arch/arm/mach-tegra/pm.c
> 
> >  #ifdef CONFIG_PM_SLEEP
> >  static DEFINE_SPINLOCK(tegra_lp2_lock);
> > +static void __iomem *iram_code = IO_ADDRESS(TEGRA_IRAM_CODE_AREA);
> > +static u32 iram_save_size;
> > +static void *iram_save_addr;
> > +struct tegra_lp1_iram *tegra_lp1_iram;
> >  void (*tegra_tear_down_cpu)(void);
> > +void (*tegra_sleep_core_finish)(unsigned long v2p);
> 
> I'm not sure all of those are required to be global variables. For
> example, iram_code is just a constant, so you could easily just use it
> directly in code.
> 
All of them does not mean the same thing. The LP1 resume code was built
in kernel image and store in RAM.
The tegra_lp1_iram hooks the LP1 resume code for different chips. Before
LP1 suspend, the original stuffs that in the area of IRAM would be store
in the iram_save_addr (RAM). Then copy the LP1 resume code to iram_code
area (IRAM).

> > +static bool tegra_sleep_core_init(void)
> > +{
> > +	if (!tegra_sleep_core_finish)
> > +		return false;
> > +
> > +	return true;
> > +}
> 
> That function seems a little pointless. Why not just check the value of
> tegra_sleep_core_finish directly in tegra_init_suspend()?
> 
I will add some code that wraps to different SoC later. We add some
common code for LP1 support here, but it didn't support by the chip yet.
Does that OK or should I move it to the next patch?

> > +static void tegra_suspend_enter_lp1(void)
> > +{
> > +	tegra_pmc_suspend();
> > +
> > +	/* copy the reset vector & SDRAM shutdown code into IRAM */
> > +	memcpy(iram_save_addr, iram_code, iram_save_size);
> > +	memcpy(iram_code, tegra_lp1_iram->start_addr, iram_save_size);
> > +
> > +	*((u32 *)tegra_cpu_lp1_mask) = 1;
> > +}
> > +
> > +static void tegra_suspend_exit_lp1(void)
> > +{
> > +	tegra_pmc_resume();
> > +
> > +	/* restore IRAM */
> > +	memcpy(iram_code, iram_save_addr, iram_save_size);
> > +
> > +	*(u32 *)tegra_cpu_lp1_mask = 0;
> > +}
> 
> I'm not really sure I like that, but I suppose it's OK. It sure seems
> like a performance limiter, but I suppose LP1 is so slow it doesn't
> matter, due to the need to ramp power rails, PLLs, SDRAM controller, etc.
> 
That's why we only back up the code size that exactly same with the LP1
resume code of the SoC.
> It'd be nice to simply reserve more IRAM for the kernel's use. Right
> now, only 1K is reserved, and presumably the code running on the AVP
> can't use the rest of that page anyway, or can it?
The LP1 resume code still running on the CPU (The LP0 would resume from
AVP).
> 
> > @@ -212,9 +282,15 @@ static int tegra_suspend_enter(suspend_state_t state)
> >  		break;
> >  	}
> >  
> > -	cpu_suspend(PHYS_OFFSET - PAGE_OFFSET, &tegra_sleep_cpu);
> > +	if (mode == TEGRA_SUSPEND_LP2)
> > +		cpu_suspend(PHYS_OFFSET - PAGE_OFFSET, &tegra_sleep_cpu);
> > +	else
> > +		cpu_suspend(PHYS_OFFSET - PAGE_OFFSET, &tegra_sleep_core);
> 
> Nit: It might be slightly simpler to simply calculate the parameter to
> cpu_suspend(), but then take the same code-path:
> 
> if (mode == TEGRA_SUSPEND_LP2)
> 	sleep_func = tegra_sleep_cpu;
> else
> 	sleep_func = tegra_sleep_core;
> cpu_suspend(PHYS_OFFSET - PAGE_OFFSET, sleep_func);
> 
> That way, it's a little more obvious that the code always calls
> cpu_suspend() in the same way, but simply passes a different function to
> it to power things down at the end.
OK. Will do.

> 
> > diff --git a/arch/arm/mach-tegra/pmc.c b/arch/arm/mach-tegra/pmc.c
> 
> >  void tegra_pmc_pm_set(enum tegra_suspend_mode mode)
> >  {
> >  	u32 reg, csr_reg;
> > -	unsigned long rate = 0;
> > +	unsigned long rate = 32768;
> 
> That's LP1-specific. You should add a "case TEGRA_SUSPEND_LP1:" to the
> switch statement that calculates rate instead; after all, that's the
> whole point of having that switch statement.
Will fix.
