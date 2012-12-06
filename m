From: josephl@nvidia.com (Joseph Lo)
Date: Thu, 6 Dec 2012 15:22:56 +0800
Subject: [PATCH V2 2/6] ARM: tegra20: cpuidle: add powered-down state
 for secondary CPU
In-Reply-To: <50BFC826.1020705@wwwdotorg.org>
References: <1354701715-24150-1-git-send-email-josephl@nvidia.com>
 <1354701715-24150-3-git-send-email-josephl@nvidia.com>
 <50BFC826.1020705@wwwdotorg.org>
Message-ID: <1354778576.13857.19.camel@jlo-ubuntu-64.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2012-12-06 at 06:18 +0800, Stephen Warren wrote:
> On 12/05/2012 03:01 AM, Joseph Lo wrote:
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
> > +static int __cpuinit tegra20_idle_lp2(struct cpuidle_device *dev,
> 
> > +	return (entered_lp2) ? index : 0;
> 
> No need for the brackets there.
> 
OK. Will fix.

> BTW, could you Cc Colin Cross on any future revisions of these patches;
> it'd be good to get his take on them.
> 
OK. The next version will directly support coupled cpuidle. I will add
Colin into Cc.

> > diff --git a/arch/arm/mach-tegra/sleep-tegra20.S b/arch/arm/mach-tegra/sleep-tegra20.S
> 
> > +/*
> > + * tegra_pen_lock
> 
> > + * on cpu 0:
> > + * SCRATCH38 = r2 = flag[0]
> > + * SCRATCH39 = r3 = flag[1]
> 
> It would be slightly clearer if that was written:
> 
> * r2 = flag[0] (in SCRATCH38)
> * r3 = flag[1] (in SCRATCH39)
> 
> since the meaning of r2/r3 is what's being selected.
> 
OK. Will fix.

> > +	mov	r12, #1
> > +	str	r12, [r2]		@ flag[cpu] = 1
> > +	dsb
> > +	str	r12, [r1]		@ !turn = cpu
> 
> Should that be "str r0, [r1]"? Otherwise, you're always writing 1 there,
> not writing the CPU ID as expected.

The CPU_ID was not used to lock or un-lock the flag. Wriging 1 to lock
and 0 to release.

Thanks,
Joseph
