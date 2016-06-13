From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 13 Jun 2016 18:27:25 +0200
Subject: [PATCH v5 4/5] arm64: add support for ACPI Low Power Idle(LPI)
In-Reply-To: <20160610125028.GA24002@red-moon>
References: <1462981062-24909-1-git-send-email-sudeep.holla@arm.com>
 <1462981062-24909-5-git-send-email-sudeep.holla@arm.com>
 <20160610125028.GA24002@red-moon>
Message-ID: <20160613162725.GH10634@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 10, 2016 at 01:50:28PM +0100, Lorenzo Pieralisi wrote:
> [+ Daniel, Kevin]
> 
> On Wed, May 11, 2016 at 04:37:41PM +0100, Sudeep Holla wrote:
> > This patch adds appropriate callbacks to support ACPI Low Power Idle
> > (LPI) on ARM64.
> > 
> > Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: linux-arm-kernel at lists.infradead.org
> > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > ---

[ ... ]

> > +#define ACPI_FFH_LPI_ARM_FLAGS_CORE_CONTEXT	BIT(0)
> > +#define ACPI_FFH_LPI_ARM_FLAGS_TRACE_CONTEXT	BIT(1)
> > +#define ACPI_FFH_LPI_ARM_FLAGS_GICR_CONTEXT	BIT(2)
> > +#define ACPI_FFH_LPI_ARM_FLAGS_GICD_CONTEXT	BIT(3)
> > +#define ACPI_FFH_LPI_ARM_FLAGS_ALL_CONTEXT	\
> > +	(ACPI_FFH_LPI_ARM_FLAGS_CORE_CONTEXT |	\
> > +	 ACPI_FFH_LPI_ARM_FLAGS_TRACE_CONTEXT |	\
> > +	 ACPI_FFH_LPI_ARM_FLAGS_GICR_CONTEXT |	\
> > +	 ACPI_FFH_LPI_ARM_FLAGS_GICD_CONTEXT)
> > +
> > +struct acpi_lpi_state *lpi;
> > +int acpi_processor_ffh_lpi_enter(struct acpi_lpi_state *lpi, int idx)
> > +{
> > +	int ret = 0;
> > +	bool save_ctx = lpi->arch_flags & ACPI_FFH_LPI_ARM_FLAGS_ALL_CONTEXT;
> 
> I am not really that keen on this, as you know. Those flags are
> there to say "save these components registers". I see the CPU PM
> notifiers as a way to save/restore CPU peripheral state, but
> they should *not* carry out any action that affects the power
> state itself, that's down to the suspend finisher (eg PSCI),
> because that's where the specific idle states are managed.
> 
> I agree we have no clue whatsoever on what we *really* need
> to save/restore, but that's orthogonal to what you are solving
> here.
> 
> See eg gic_cpu_if_down(). Do we call it from the GIC CPU PM notifier ?
> No. We should not handle the same problem differently.
> 
> On top of that, we have no way to solve this problem for DT,
> all I am saying is that it is ill-defined and given that LPI
> is new I'd rather we got it right from the beginning.
> 
> I am open to suggestions here.

There is a part of the idle state flags integer which is reserved for the 
arch specific flag and can be masked with:

	CPUIDLE_DRIVER_FLAGS_MASK()

May be these context flags can be added in the generic cpuidle driver and 
reused.

Concerning the DT, why not use the power domains to tell which context to 
save ? yeah, probably mentionned n-th times :)

> > +
> > +	if (!idx) {
> > +		cpu_do_idle();
> > +		return idx;
> > +	}
> > +
> > +	/* TODO cpu_pm_{enter,exit} can be done in generic code ? */
> > +	if (save_ctx)
> > +		ret = cpu_pm_enter();
> > +	if (!ret) {
> > +		/*
> > +		 * Pass idle state index to cpu_suspend which in turn will
> > +		 * call the CPU ops suspend protocol with idle index as a
> > +		 * parameter.
> > +		 */
> > +		ret = arm_cpuidle_suspend(idx);
> > +
> > +		if (save_ctx)
> > +			cpu_pm_exit();
> > +	}
> > +
> > +	return ret ? -1 : idx;
> 
> The body of this function (if we remove save_ctx) is identical
> to arm_enter_idle_state(), it would be nice if we found a way
> where to put this code and share it with the ARM CPUidle driver,

+1

We don't want to redo another unmaintable acpi idle driver.

  -- Daniel
