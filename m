From: will.deacon@arm.com (Will Deacon)
Date: Wed, 24 Oct 2012 10:31:50 +0100
Subject: [PATCH] ARM: PMU: fix runtime PM enable
In-Reply-To: <1351024268-26734-1-git-send-email-jon-hunter@ti.com>
References: <1351024268-26734-1-git-send-email-jon-hunter@ti.com>
Message-ID: <20121024093150.GA23775@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jon,

On Tue, Oct 23, 2012 at 09:31:08PM +0100, Jon Hunter wrote:
> Commit 7be2958 (ARM: PMU: Add runtime PM Support) updated the ARM PMU code to
> use runtime PM which was prototyped and validated on the OMAP devices. In this
> commit, there is no call pm_runtime_enable() and for OMAP devices
> pm_runtime_enable() is currently being called from the OMAP PMU code when the
> PMU device is created. However, there are two problems with this:
> 
> 1. For any other ARM device wishing to use runtime PM for PMU they will need
>    to call pm_runtime_enable() for runtime PM to work.
> 2. When booting with device-tree and using device-tree to create the PMU
>    device, pm_runtime_enable() needs to be called from within the ARM PERF
>    driver as we are no longer calling any device specific code to create the
>    device. Hence, PMU does not work on OMAP devices that use the runtime PM
>    callbacks when using device-tree to create the PMU device.
> 
> Therefore, add a new platform data variable to indicate whether runtime PM is
> used and if so call pm_runtime_enable() when the PMU device is registered. Note
> that devices using runtime PM may not use the runtime_resume/suspend callbacks
> and so we cannot use the presence of these handlers in the platform data to
> determine whether we should call pm_runtime_enable().

[...]

> diff --git a/arch/arm/include/asm/pmu.h b/arch/arm/include/asm/pmu.h
> index a26170d..50a6c3b 100644
> --- a/arch/arm/include/asm/pmu.h
> +++ b/arch/arm/include/asm/pmu.h
> @@ -36,6 +36,7 @@
>  struct arm_pmu_platdata {
>  	irqreturn_t (*handle_irq)(int irq, void *dev,
>  				  irq_handler_t pmu_handler);
> +	bool use_runtime_pm;
>  	int (*runtime_resume)(struct device *dev);
>  	int (*runtime_suspend)(struct device *dev);

Can we not just use the presence of the resume/suspend function pointers to
indicate whether we should enable runtime pm or not? i.e. if they're not
NULL, then enable the thing?

Cheers,

Will
