From: josephl@nvidia.com (Joseph Lo)
Date: Fri, 21 Dec 2012 16:07:51 +0800
Subject: [PATCH] ARM: tegra30: fix power up sequence for boot_secondary
In-Reply-To: <50D3430A.4020901@wwwdotorg.org>
References: <1355970603-28531-1-git-send-email-josephl@nvidia.com>
 <50D3430A.4020901@wwwdotorg.org>
Message-ID: <1356077271.26029.81.camel@jlo-ubuntu-64.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2012-12-21 at 00:55 +0800, Stephen Warren wrote:
> On 12/19/2012 07:30 PM, Joseph Lo wrote:
> > The power up sequence is different on the cold boot CPU and the CPU
> > that resumed from the hotplug. For the cold boot CPU, it was been power
> > gated as default. To power up the cold boot CPU, the power should be
> > un-gated by un toggling the power gate register manually.
> > 
> > For the CPU that resumed from the hotplug, after un-halted the CPU. The
> > flow controller will un-gate the power of the CPU. No need to manually
> > control, just wait the power be resumed and continue the power up
> > sequence after the CPU power is ready.
> 
> I'd like Peter to review this too (CC'd). I guess it looks OK...
> 
> > diff --git a/arch/arm/mach-tegra/platsmp.c b/arch/arm/mach-tegra/platsmp.c
> 
> > @@ -72,7 +75,27 @@ static int tegra30_power_up_cpu(unsigned int cpu)
> >  	if (pwrgateid < 0)
> >  		return pwrgateid;
> >  
> > -	/* If this is the first boot, toggle powergates directly. */
> > +	/*
> > +	 * If the CPU had booted and went through here after CPU
> > +	 * had been already un-gated by flow controller. Wait
> > +	 * for confirmation that the CPU is powered then remove
> > +	 * the IO clamps. On the cold boot entry, do not wait.
> > +	 */
> 
> That comment is quite unclear. In particular the first sentence says "if
> something" rather than "if something then something". Can you please
> re-write it?
> 
OK.
> Also, it'd be good to explain (or at least briefly reference) the boot
> path for a cold-boot CPU and a warm boot CPU; I assume that somehow a
> cold boot CPU doesn't execute tegra_secondary_init(), but a warm boot
> CPU does?
> 
The boot path was the same. Both of the conditions were booted from
tegra_boot_secondary. Just the power sequence has been different. We add
the code to recover the power up sequence of warm boot CPU.

Thanks,
Joseph
