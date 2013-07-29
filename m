From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon, 29 Jul 2013 15:23:27 +0100
Subject: [RFC PATCH 3/3] cpuidle: big.LITTLE: vexpress-TC2 CPU idle driver
In-Reply-To: <51F67581.5080207@linaro.org>
References: <1374750866-750-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1374750866-750-4-git-send-email-lorenzo.pieralisi@arm.com>
 <51F67581.5080207@linaro.org>
Message-ID: <20130729142327.GC6184@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 29, 2013 at 03:00:33PM +0100, Daniel Lezcano wrote:
> On 07/25/2013 01:14 PM, Lorenzo Pieralisi wrote:

[...]

> > +/**
> > + * bl_enter_powerdown - Programs CPU to enter the specified state
> > + * @dev: cpuidle device
> > + * @drv: The target state to be programmed
> > + * @idx: state index
> > + *
> > + * Called from the CPUidle framework to program the device to the
> > + * specified target state selected by the governor.
> > + */
> > +static int bl_enter_powerdown(struct cpuidle_device *dev,
> > +				struct cpuidle_driver *drv, int idx)
> > +{
> > +	struct timespec ts_preidle, ts_postidle, ts_idle;
> > +	int ret;
> > +
> > +	/* Used to keep track of the total time in idle */
> > +	getnstimeofday(&ts_preidle);
> > +
> > +	cpu_pm_enter();
> > +
> > +	ret = cpu_suspend(0, bl_powerdown_finisher);
> > +	/* signals the MCPM core that CPU is out of low power state */
> > +	mcpm_cpu_powered_up();
> > +
> > +	cpu_pm_exit();
> > +
> > +	getnstimeofday(&ts_postidle);
> > +	ts_idle = timespec_sub(ts_postidle, ts_preidle);
> > +
> > +	dev->last_residency = ts_idle.tv_nsec / NSEC_PER_USEC +
> > +					ts_idle.tv_sec * USEC_PER_SEC;
> > +	local_irq_enable();
> 
> time computation and local irq enablement are handled by the cpuidle
> framework.

Absolutely, rebase leftover, sorry.

Thanks,
Lorenzo
