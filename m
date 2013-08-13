From: josephl@nvidia.com (Joseph Lo)
Date: Tue, 13 Aug 2013 14:58:42 +0800
Subject: [PATCH V3 4/8] ARM: tegra: add common LP1 suspend support
In-Reply-To: <5209367E.10900@wwwdotorg.org>
References: <1376300407-14750-1-git-send-email-josephl@nvidia.com>
 <1376300407-14750-5-git-send-email-josephl@nvidia.com>
 <5209367E.10900@wwwdotorg.org>
Message-ID: <1376377122.18689.252.camel@jlo-ubuntu-64.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2013-08-13 at 03:24 +0800, Stephen Warren wrote:
> On 08/12/2013 03:40 AM, Joseph Lo wrote:
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
> > 
> > Signed-off-by: Joseph Lo <josephl@nvidia.com>
> > ---
> > V3:
> > * using a "#define" of IRAM_CODE to replace original static variable
> 
> I didn't mean change the variable to a define, but rather simply to use
> the IO_ADDRESS() define instead of any new define. i.e.:
> 
> > diff --git a/arch/arm/mach-tegra/pm.c b/arch/arm/mach-tegra/pm.c
> 
> > +#define IRAM_CODE IO_ADDRESS(TEGRA_IRAM_CODE_AREA)
> 
> ... just don't add that, and ...
> 
> > +static void tegra_suspend_enter_lp1(void)
> > +{
> > +	tegra_pmc_suspend();
> > +
> > +	/* copy the reset vector & SDRAM shutdown code into IRAM */
> > +	memcpy(iram_save_addr, IRAM_CODE, iram_save_size);
> > +	memcpy(IRAM_CODE, tegra_lp1_iram.start_addr, iram_save_size);
> 
> ... and s/IRAM_CODE/IO_ADDRESS(TEGRA_IRAM_CODE_AREA)/ in that code.
> 
> I'll make that fixup when applying these patches.
OK. Thanks.

Joseph
