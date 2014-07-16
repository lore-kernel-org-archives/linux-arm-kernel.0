From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 16 Jul 2014 15:22:41 +0200
Subject: [PATCH 12/12] ARM: tegra: Convert PMC to a driver
In-Reply-To: <201407161356.44693.arnd@arndb.de>
References: <1405080971-7609-1-git-send-email-thierry.reding@gmail.com>
 <1405080971-7609-13-git-send-email-thierry.reding@gmail.com>
 <201407161356.44693.arnd@arndb.de>
Message-ID: <20140716132240.GC23384@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 16, 2014 at 01:56:44PM +0200, Arnd Bergmann wrote:
> On Friday 11 July 2014, Thierry Reding wrote:
> > +/*
> > + * PMC
> > + */
> > +enum tegra_suspend_mode {
> > +       TEGRA_SUSPEND_NONE = 0,
> > +       TEGRA_SUSPEND_LP2, /* CPU voltage off */
> > +       TEGRA_SUSPEND_LP1, /* CPU voltage off, DRAM self-refresh */
> > +       TEGRA_SUSPEND_LP0, /* CPU + core voltage off, DRAM self-refresh */
> > +       TEGRA_MAX_SUSPEND_MODE,
> > +};
> > +
> > +#ifdef CONFIG_PM_SLEEP
> > +enum tegra_suspend_mode tegra_pmc_get_suspend_mode(void);
> > +void tegra_pmc_set_suspend_mode(enum tegra_suspend_mode mode);
> > +void tegra_pmc_enter_suspend_mode(enum tegra_suspend_mode mode);
> > +
> > +bool tegra_pmc_cpu_is_powered(int cpuid);
> > +int tegra_pmc_cpu_power_on(int cpuid);
> > +int tegra_pmc_cpu_remove_clamping(int cpuid);
> > +
> > +void tegra_pmc_restart(enum reboot_mode mode, const char *cmd);
> > +#endif
> > +
> > +/*
> 
> This part is causing multiple build failures in the randconfig tests.
> You can avoid them by removing the #ifdef.

How is this causing build failures? I only see them used wherever
CONFIG_PM_SLEEP is defined.

Although I guess tegra-pmc.c could cause sparse warnings since it
implements these functions regardless of CONFIG_PM_SLEEP, which probably
is the bug that should be fixed.

Do you have a randconfig that I can use to reproduce this and come up
with a fix?

> On a more general note, why are you adding this stuff into a global
> header file in the first place? All users are in the same directory
> in which the functions are defined.

That's mostly preparatory work. We'll need to move tegra-pmc.c out of
arch/arm/mach-tegra at some point. I've proposed two patches already to
do that, one move the driver to drivers/soc/tegra and was massively
NAK'ed (I'm still not sure I agree) and people requested that this be
moved into drivers/power. I then posted a 2 patch series to move power
supply drivers into a subdirectory (drivers/power/supply) so that
drivers in drivers/power didn't have to depend on CONFIG_POWER_SUPPLY
for no good reason.

The latter series didn't receive any comments whatsoever in over a week,
so in order to keep things moving forward I respun the PMC patch to do
the conversion without moving the code out of arch/arm/mach-tegra yet.
That way moving the driver out of arch/arm/mach-tegra will be a simple
matter of moving and the rework will already be done. You were Cc'ed on
the second series, so if you want to take a look (and maybe help get
things moving) the patches are called:

	[PATCH 0/2] Restructure driver/power and add Tegra PMC driver
	[PATCH 1/2] power: Move power-supply drivers to subdirectory
	[PATCH 2/2] ARM: tegra: Convert PMC to a driver

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140716/3836f4bb/attachment.sig>
