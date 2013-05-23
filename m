From: josephl@nvidia.com (Joseph Lo)
Date: Thu, 23 May 2013 18:03:57 +0800
Subject: [PATCH] ARM: tegra: add cpu_disable for hotplug
In-Reply-To: <519D363E.4000409@wwwdotorg.org>
References: <1369131215-2920-1-git-send-email-josephl@nvidia.com>
 <519B9DB4.7070106@wwwdotorg.org>
 <20130522090304.GT21944@tbergstrom-lnx.Nvidia.com>
 <519D363E.4000409@wwwdotorg.org>
Message-ID: <1369303437.9559.7.camel@jlo-ubuntu-64.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2013-05-23 at 05:18 +0800, Stephen Warren wrote:
> On 05/22/2013 03:03 AM, Peter De Schrijver wrote:
> > On Tue, May 21, 2013 at 06:15:48PM +0200, Stephen Warren wrote:
> >> On 05/21/2013 04:13 AM, Joseph Lo wrote:
> >>> The Tegra114 could hotplug the CPU0, but the common cpu_disable didn't
> >>> support that. Adding a Tegra specific cpu_disable function for it.
> >>>
> >>> Signed-off-by: Joseph Lo <josephl@nvidia.com>
> >>
> >>> diff --git a/arch/arm/mach-tegra/hotplug.c b/arch/arm/mach-tegra/hotplug.c
> >>
> >>> +int tegra_cpu_disable(unsigned int cpu)
> >>> +{
> >>> +	switch (tegra_chip_id) {
> >>> +	case TEGRA114:
> >>> +		return 0;
> >>> +	default:
> >>> +		return cpu == 0 ? -EPERM : 0;
> >>> +	}
> >>> +}
> >>
> >> Do we expect all/most future chips to support hotplug of CPU0? Or at
> >> least, fewer chips to have the restriction than not? If so, it might be
> > 
> > Yes. I think we can safely assume future chips will support hotplugging CPU0.
> > 
> >> more forward-looking to write that as:
> >>
> >> if (tegra_chip_id == TEGRA30)
> >>     return cpu == 0 ? -EPERM : 0;
> >>
> > 
> > Also Tegra20 doesn't support hotplugging CPU0?
> 
> Oh right, this isn't a Tegra30+ file. How about just inverting the
> switch so it doesn't need to change later:
> 
> 	switch (tegra_chip_id) {
> 	case TEGRA20:
> 	case TEGRA30:
> 		return cpu == 0 ? -EPERM : 0;
> 	default:
> 		return 0;
> 	}
> 
OK. Will update a newer version later.

Thanks,
Joseph
