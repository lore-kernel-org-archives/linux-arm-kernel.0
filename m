From: josephl@nvidia.com (Joseph Lo)
Date: Thu, 27 Jun 2013 18:22:37 +0800
Subject: [PATCH 06/11] ARM: tegra114: hook tegra_tear_down_cpu function
In-Reply-To: <20130627101335.GB15081@mithrandir>
References: <1372152475-18617-1-git-send-email-josephl@nvidia.com>
 <1372152475-18617-7-git-send-email-josephl@nvidia.com>
 <20130627101335.GB15081@mithrandir>
Message-ID: <1372328557.9389.40.camel@jlo-ubuntu-64.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2013-06-27 at 18:13 +0800, Thierry Reding wrote:
> * PGP Signed by an unknown key
> 
> On Tue, Jun 25, 2013 at 05:27:50PM +0800, Joseph Lo wrote:
> > Hooking tegra_tear_down_cpu for Tegra114 for supporting cluster power
> > down when CPU cluster suspneded in LP2.
> > 
> > Signed-off-by: Joseph Lo <josephl@nvidia.com>
> > ---
> >  arch/arm/mach-tegra/pm.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/arm/mach-tegra/pm.c b/arch/arm/mach-tegra/pm.c
> > index 94e69be..a0668a2 100644
> > --- a/arch/arm/mach-tegra/pm.c
> > +++ b/arch/arm/mach-tegra/pm.c
> > @@ -52,6 +52,7 @@ static void tegra_tear_down_cpu_init(void)
> >  			tegra_tear_down_cpu = tegra20_tear_down_cpu;
> >  		break;
> >  	case TEGRA30:
> > +	case TEGRA114:
> >  		if (IS_ENABLED(CONFIG_ARCH_TEGRA_3x_SOC))
> >  			tegra_tear_down_cpu = tegra30_tear_down_cpu;
> 
> This is getting a little weird. Suppose I want to build a Tegra114 only
> kernel. With the above code it means the tegra_tear_down_cpu won't be
> hooked because ARCH_TEGRA_3x_SOC isn't selected.
> 
Oops. You are right. Will fix.

> Perhaps tegra30_tear_down_cpu() should be built unconditionally so that
> it's always available?
The tegra30_tear_down_cpu will be built for both Tegra30 or Tegra114.

> 
> There are other alternatives like adding another Kconfig symbol which
> doesn't cover all of Tegra30 but only code shared with Tegra114 (and
> possible future chips) or building sleep-tegra30.S if either one of the
> ARCH_TEGRA_3x_SOC or ARCH_TEGRA_114_SOC symbols is selected.
> 
Yes, we building "sleep-tegra30.S" when either one of the
ARCH_TEGRA_3x_SOC or ARCH_TEGRA_114_SOC symbols is selected.

Thanks,
Joseph
