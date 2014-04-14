From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 14 Apr 2014 10:01:27 -0400 (EDT)
Subject: [PATCH 5/5] arm: exynos: Add MCPM call-back functions
In-Reply-To: <20140414104116.GA3844@e103592.cambridge.arm.com>
References: <1397239311-27717-1-git-send-email-a.kesavan@samsung.com>
 <1397239311-27717-6-git-send-email-a.kesavan@samsung.com>
 <alpine.LFD.2.11.1404111426510.980@knanqh.ubzr>
 <20140414104116.GA3844@e103592.cambridge.arm.com>
Message-ID: <alpine.LFD.2.11.1404140956060.980@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 14 Apr 2014, Dave Martin wrote:

> On Fri, Apr 11, 2014 at 04:23:04PM -0400, Nicolas Pitre wrote:
> > On Fri, 11 Apr 2014, Abhilash Kesavan wrote:
> > 
> > > Add machine-dependent MCPM call-backs for Exynos5420. These are used
> > > to power up/down the secondary CPUs during boot, shutdown, s2r and
> > > switching.
> > > 
> > > Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
> > > Signed-off-by: Inderpal Singh <inderpal.s@samsung.com>
> > > Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
> > > Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
> > 
> > See comments inline.
> 
> I won't duplicate Nico's review, but I have a couple of extra comments/
> questions, below.
> 
> [...]
> 
> > > diff --git a/arch/arm/mach-exynos/mcpm-exynos.c b/arch/arm/mach-exynos/mcpm-exynos.c
> > > new file mode 100644
> > > index 0000000..46d4968
> > > --- /dev/null
> > > +++ b/arch/arm/mach-exynos/mcpm-exynos.c
> > > @@ -0,0 +1,444 @@
> 
> [...]
> 
> > > +static void exynos_cluster_power_control(unsigned int cluster, int enable)
> > > +{
> > > +	unsigned long timeout = jiffies + msecs_to_jiffies(20);
> > > +	unsigned int status, val = EXYNOS_CORE_LOCAL_PWR_DIS;
> > > +
> > > +	if (enable)
> > > +		val = EXYNOS_CORE_LOCAL_PWR_EN;
> > > +
> > > +	status = __raw_readl(EXYNOS_COMMON_STATUS(cluster));
> > > +	if ((status & EXYNOS_CORE_LOCAL_PWR_EN) == val)
> > > +		return;
> > > +
> > > +	__raw_writel(val, EXYNOS_COMMON_CONFIGURATION(cluster));
> > > +	/* Wait until cluster power control is applied */
> > > +	while (time_before(jiffies, timeout)) {
> > > +		status = __raw_readl(EXYNOS_COMMON_STATUS(cluster));
> > > +
> > > +		if ((status & EXYNOS_CORE_LOCAL_PWR_EN) == val)
> > > +			return;
> > > +
> > > +		cpu_relax();
> > > +	}
> > > +	pr_warn("timed out waiting for cluster %u to power %s\n", cluster,
> > > +		enable ? "on" : "off");
> > 
> > You should not have to wait for the power status to change here.  
> > Simply signaling the desired state and returning is all that is 
> > expected.  And because IRQs are turned off, it is likely that 
> > time_before(jiffies, timeout) will always be true anyway because jiffies 
> > are not updated if there is no other CPU to service the timer interrupt.
> > 
> > The actual power status should be polled for in the mcpm_finish() 
> > method only.
> 
> Depending on the power controller, it might be possible for writes to
> the controller to be lost or not acted upon, if a previous change is
> still pending.
> 
> Does this issue apply to the exynos power controller?

Given the way the code is structured now, I suppose that has not been 
the case so far.

> 
> If this is the case, it might be necessary to ensure before a power-up
> request, that the power controller has caught up and reports the
> cluster/CPU as down.  Putting this poll before the write to the
> power controller maximises the chance of pipelining useful work
> in the meantime.  Putting the poll after the write is the worst case.

More useful might be a check on the actual _control_ bit.  If the 
control bits may be read back then I expect the indicated state will 
happen even if delayed.


Nicolas
