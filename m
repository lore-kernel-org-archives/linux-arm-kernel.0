From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 28 Jun 2013 20:34:24 +0200
Subject: [PATCH 06/11] ARM: tegra114: hook tegra_tear_down_cpu function
In-Reply-To: <51CC7B01.30503@wwwdotorg.org>
References: <1372152475-18617-1-git-send-email-josephl@nvidia.com>
 <1372152475-18617-7-git-send-email-josephl@nvidia.com>
 <20130627101335.GB15081@mithrandir> <51CC7B01.30503@wwwdotorg.org>
Message-ID: <20130628183423.GA15416@manwe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 27, 2013 at 11:48:49AM -0600, Stephen Warren wrote:
> On 06/27/2013 04:13 AM, Thierry Reding wrote:
> > On Tue, Jun 25, 2013 at 05:27:50PM +0800, Joseph Lo wrote:
> >> Hooking tegra_tear_down_cpu for Tegra114 for supporting cluster
> >> power down when CPU cluster suspneded in LP2.
> >> 
> >> Signed-off-by: Joseph Lo <josephl@nvidia.com> --- 
> >> arch/arm/mach-tegra/pm.c | 1 + 1 file changed, 1 insertion(+)
> >> 
> >> diff --git a/arch/arm/mach-tegra/pm.c b/arch/arm/mach-tegra/pm.c 
> >> index 94e69be..a0668a2 100644 --- a/arch/arm/mach-tegra/pm.c +++
> >> b/arch/arm/mach-tegra/pm.c @@ -52,6 +52,7 @@ static void
> >> tegra_tear_down_cpu_init(void) tegra_tear_down_cpu =
> >> tegra20_tear_down_cpu; break; case TEGRA30: +	case TEGRA114: if
> >> (IS_ENABLED(CONFIG_ARCH_TEGRA_3x_SOC)) tegra_tear_down_cpu =
> >> tegra30_tear_down_cpu;
> > 
> > This is getting a little weird. Suppose I want to build a Tegra114
> > only kernel. With the above code it means the tegra_tear_down_cpu
> > won't be hooked because ARCH_TEGRA_3x_SOC isn't selected.
> > 
> > Perhaps tegra30_tear_down_cpu() should be built unconditionally so
> > that it's always available? I suspect that something similar will
> > need to be done for future chips too, further complicating
> > matters.
> > 
> > There are other alternatives like adding another Kconfig symbol
> > which doesn't cover all of Tegra30 but only code shared with
> > Tegra114 (and possible future chips) or building sleep-tegra30.S if
> > either one of the ARCH_TEGRA_3x_SOC or ARCH_TEGRA_114_SOC symbols
> > is selected.
> 
> To be honest, I wonder if we should just get rid of ARCH_TEGRA_*_SOC,
> and build everything if ARCH_TEGRA is defined. tegra_defconfig enables
> all ARCH_TEGRA_*_SOC anyway, and I'm afraid I don't test other
> configurations very often, and I assume that distros will enable
> everything...

The same thing had occurred to me as well. Obviously there could be some
savings in executable code for people that really only need one specific
generation. But, without having any concrete numbers, I suspect that all
the ARCH_TEGRA code is less than 100 KiB in total so I don't think it
matters that much given that there aren't any devices with less than 256
MiB of RAM (that I've heard of at least).

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130628/157358c0/attachment.sig>
