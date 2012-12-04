From: josephl@nvidia.com (Joseph Lo)
Date: Tue, 4 Dec 2012 15:25:20 +0800
Subject: [PATCH 4/5] ARM: tegra20: cpuidle: add powered-down state for CPU0
In-Reply-To: <50BCF226.1080501@wwwdotorg.org>
References: <1354503607-13707-1-git-send-email-josephl@nvidia.com>
 <1354503607-13707-5-git-send-email-josephl@nvidia.com>
 <50BCF226.1080501@wwwdotorg.org>
Message-ID: <1354605920.30563.38.camel@jlo-ubuntu-64.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2012-12-04 at 02:40 +0800, Stephen Warren wrote:
> On 12/02/2012 08:00 PM, Joseph Lo wrote:
> > The powered-down state of Tegra20 requires power gating both CPU cores.
> > When the secondary CPU requests to enter powered-down state, it saves
> > its own contexts and then enters WFI for waiting CPU0 in the same state.
> > When the CPU0 requests powered-down state, it attempts to put the secondary
> > CPU into reset to prevent it from waking up. Then power down both CPUs
> > together and power off the cpu rail.
> > 
> > Be aware of that, you may see the legacy power state "LP2" in the code
> > which is exactly the same meaning of "CPU power down".
> 
> > diff --git a/arch/arm/mach-tegra/cpuidle-tegra20.c b/arch/arm/mach-tegra/cpuidle-tegra20.c
> 
> > +static int tegra20_reset_sleeping_cpu(int cpu)
> > +{
> > +	int ret = 0;
> > +
> > +	BUG_ON(cpu == 0);
> > +	BUG_ON(cpu == smp_processor_id());
> 
> Will this code ever be used on anything other than Tegra20? I assume not
> since it's in a Tegra20-specific file. Given that, it seems much of the
> code could be made a lot simpler, e.g. by removing the "cpu" parameter
> here, which would avoid requiring those BUG()s. You'd probably want to
> rename the function e.g. tegra20_reset_cpu_1_sleeping().
> 
Good idea. Will follow your suggestion to refine this.

> 
> > diff --git a/arch/arm/mach-tegra/sleep-tegra20.S b/arch/arm/mach-tegra/sleep-tegra20.S
> > diff --git a/arch/arm/mach-tegra/sleep.S b/arch/arm/mach-tegra/sleep.S
> 
> Similar comments about C-vs-assembly here as before, for at least some
> of the functions.
> 
OK. I will think about this. Will do it later (maybe after LP1/LP0
suspend code be ready). I need to confirm whole the scenario here first.

> > +/*
> > + * tegra_cpu_pllp
> > + *
> > + * In LP2 the normal cpu clock pllx will be turned off. Switch the CPU to pllp
> > + */
> > +ENTRY(tegra_cpu_pllp)
> 
> There's no verb in that function name. tegra_switch_cpu_to_pllp() might
> be a better name.

OK. Will fix.

Thanks,
Joseph
