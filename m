From: pavel@denx.de (Pavel Machek)
Date: Wed, 15 May 2013 11:46:31 +0200
Subject: [RFC PATCH] ARM: SOCFPGA: Enable PMU through the CTI
In-Reply-To: <1368586682-19848-1-git-send-email-dinguyen@altera.com>
References: <1368586682-19848-1-git-send-email-dinguyen@altera.com>
Message-ID: <20130515094631.GA5050@amd.pavel.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> SOCFPGA has a PMU(Performance Measurement Unit) that has its
> IRQs routed through Coresight using the CTI(Cross-Trigger Interface).
> 
> This patch enables the PMU and initializes the CTI for usage by
> oprofile/perfmon.
> 
> A lot of the code/idea was taken from this:
> https://patchwork.kernel.org/patch/1432541/

> --- a/arch/arm/kernel/perf_event.c
> +++ b/arch/arm/kernel/perf_event.c
> @@ -305,6 +305,11 @@ static irqreturn_t armpmu_dispatch_irq(int irq, void *dev)
>  static void
>  armpmu_release_hardware(struct arm_pmu *armpmu)
>  {
> +	struct platform_device *plat_device = armpmu->plat_device;
> +	struct arm_pmu_platdata *plat = dev_get_platdata(&plat_device->dev);
> +
...
> @@ -314,6 +319,7 @@ armpmu_reserve_hardware(struct arm_pmu *armpmu)
>  {
>  	int err;
>  	struct platform_device *pmu_device = armpmu->plat_device;

pmu_device == plat_device, AFAICT. One of them should be renamed for
consistency. Or maybe even make it "pdev" ... shorter and used in the
code below...

> +int socfpga_init_cti(struct platform_device *pdev)
> +{

> +	/*configure CTI0 for pmu irq routing*/

Comments should normally be "/* word */"...

I'll take a more detailed look later.

Thanks,
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
