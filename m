From: josephl@nvidia.com (Joseph Lo)
Date: Tue, 6 Aug 2013 17:41:32 +0800
Subject: [PATCH V2 4/8] ARM: tegra: add common LP1 suspend support
In-Reply-To: <51FFE557.4000103@wwwdotorg.org>
References: <1375701664-14965-1-git-send-email-josephl@nvidia.com>
 <1375701664-14965-5-git-send-email-josephl@nvidia.com>
 <51FFE557.4000103@wwwdotorg.org>
Message-ID: <1375782092.2261.92.camel@jlo-ubuntu-64.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2013-08-06 at 01:48 +0800, Stephen Warren wrote:
> On 08/05/2013 05:21 AM, Joseph Lo wrote:
> > The LP1 suspending mode on Tegra means CPU rail off, devices and PLLs are
> > clock gated and SDRAM in self-refresh mode. That means the low level LP1
> > suspending and resuming code couldn't be run on DRAM and the CPU must
> > switch to the always on clock domain (a.k.a. CLK_M 12MHz oscillator). And
> > the system clock (SCLK) would be switched to CLK_S, a 32KHz oscillator.
> > The LP1 low level handling code need to be moved to IRAM area first. And
> > marking the LP1 mask for indicating the Tegra device is in LP1. The CPU
> > power timer needs to be re-calculated based on 32KHz that was originally
> > based on PCLK.
> > 
> > When resuming from LP1, the LP1 reset handler will resume PLLs and then
> > put DRAM to normal mode. Then jumping to the "tegra_resume" that will
> > restore full context before back to kernel. The "tegra_resume" handler
> > was expected to be found in PMC_SCRATCH41 register.
> > 
> > This is common LP1 procedures for Tegra, so we do these jobs mainly in
> > this patch:
> > * moving LP1 low level handling code to IRAM
> > * marking LP1 mask
> > * copying the physical address of "tegra_resume" to PMC_SCRATCH41
> > * re-calculate the CPU power timer based on 32KHz
> 
> > diff --git a/arch/arm/mach-tegra/pm.c b/arch/arm/mach-tegra/pm.c
> 
> > +static void __iomem *iram_code = IO_ADDRESS(TEGRA_IRAM_CODE_AREA);
> 
> I repeat: Why store that value in a global variable? It's constant.
> 
Sorry, I forgot this one. I will use a "#define" to replace it.
> > @@ -174,14 +181,75 @@ enum tegra_suspend_mode tegra_pm_validate_suspend_mode(
> >  				enum tegra_suspend_mode mode)
> >  {
> >  	/*
> > -	 * The Tegra devices only support suspending to LP2 currently.
> > +	 * The Tegra devices support suspending to LP1 or lower currently.
> >  	 */
> > -	if (mode > TEGRA_SUSPEND_LP2)
> > -		return TEGRA_SUSPEND_LP2;
> > +	if (mode > TEGRA_SUSPEND_LP1)
> > +		return TEGRA_SUSPEND_LP1;
> >  
> >  	return mode;
> >  }
> 
> I think that change needs to happen after patch 7. At this point in the
> series, LP1 doesn't work on any chip. After patch 7, it will work on all
> chips.
This code is safe here. Because we have some protection code.
> 
> If you don't make that change, you should move this change into patch 5,
> but only enable LP1 for Tegra30, then make patch 6 also enable it for
> Tegra20, then make patch 7 also enable it for Tegra114. That's a lot
> more complex, so just moving the change above into a new patch after
> patch 7 seems better.
We have the function (tegra_lp1_iram_hook and tegra_sleep_core_init) to
check if the system didn't support LP1 yet, then it will fall back to
LP2. I verified this too.

> 
> Note: You must assume that the DT changes are all checked in before any
> of the code changes, so the code needs to work correctly even if the DT
> contains the data that allows usage of LP1 before the driver actually
> implements LP1.
So should I still move them to the last patch?
