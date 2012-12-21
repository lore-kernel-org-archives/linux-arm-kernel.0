From: josephl@nvidia.com (Joseph Lo)
Date: Fri, 21 Dec 2012 14:36:44 +0800
Subject: [PATCH V3 2/5] ARM: tegra20: cpuidle: add powered-down state
 for secondary CPU
In-Reply-To: <50D34E28.5000208@wwwdotorg.org>
References: <1355797861-12759-1-git-send-email-josephl@nvidia.com>
 <1355797861-12759-3-git-send-email-josephl@nvidia.com>
 <50D34E28.5000208@wwwdotorg.org>
Message-ID: <1356071804.26029.34.camel@jlo-ubuntu-64.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2012-12-21 at 01:43 +0800, Stephen Warren wrote:
> On 12/17/2012 07:30 PM, Joseph Lo wrote:
> > The powered-down state of Tegra20 requires power gating both CPU cores.
> > When the secondary CPU requests to enter powered-down state, it saves
> > its own contexts and then enters WFI. The Tegra20 had a limition to
> > power down both CPU cores. The secondary CPU must waits for CPU0 in
> > powered-down state too. If the secondary CPU be woken up before CPU0
> > entering powered-down state, then it needs to restore its CPU states
> > and waits for next chance.
> > 
> > Be aware of that, you may see the legacy power state "LP2" in the code
> > which is exactly the same meaning of "CPU power down".
> 
> > diff --git a/arch/arm/mach-tegra/cpuidle-tegra20.c b/arch/arm/mach-tegra/cpuidle-tegra20.c
> 
> >  int __init tegra20_cpuidle_init(void)
> 
> > +	drv->state_count = sizeof(tegra_idle_states) /
> > +			   sizeof(struct cpuidle_state);
> 
> Use ARRAY_SIZE() there?
> 
OK.
> 
> > +	for (i = 0; i < drv->state_count; i++)
> > +		memcpy(&drv->states[i], &tegra_idle_states[i],
> > +		       sizeof(struct cpuidle_state));
> 
> Can't you call memcpy() once:
> 
> memcpy(drv->states, tegra_idle_states,
> 		drv->state_count * sizeof(drv->states[0]));
> 
> ... although I personally much preferred when all this was just static
> initialization directly in tegra_idle_driver, rather than all this messy
> copying. Really, struct cpuidle_driver should point at the array, rather
> than including it.
> 
I think so. If you strongly prefer the original style, I can rollback to
the previous version here.

> > diff --git a/arch/arm/mach-tegra/pm.c b/arch/arm/mach-tegra/pm.c
> 
> > @@ -173,6 +173,8 @@ bool __cpuinit tegra_set_cpu_in_lp2(int phy_cpu_id)
> >  
> >  	if ((phy_cpu_id == 0) && cpumask_equal(cpu_lp2_mask, cpu_online_mask))
> >  		last_cpu = true;
> > +	else if (phy_cpu_id == 1)
> > +		tegra20_cpu_set_resettable_soon();
> >  
> >  	spin_unlock(&tegra_lp2_lock);
> >  	return last_cpu;
> 
> Shouldn't the code in that else branch have a run-time check for whether
> it's running on Tegra20? When compiled without Tegra20 support,
> tegra20_cpu_set_resettable_soon() is a dummy static inline, but when
> both Tegra20 and Tegra30 are compiled in, isn't that code going to run
> when it shouldn't; pm.c being a common file.
> 
Because the code didn't hurt Tegra30, so I didn't add a runtime
detection there. If you have concern, I can add runtime detection there.

Thanks,
Joseph
