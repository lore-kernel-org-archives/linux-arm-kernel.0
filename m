From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 5 Oct 2017 17:48:32 +0100
Subject: [PATCH 3/9] arm: cache-l2x0: share l2x0_base
In-Reply-To: <eb104cfdf44ef9bf7b4f271555e1496d2bf781bf.1500510157.git.mirq-linux@rere.qmqm.pl>
References: <cover.1500510157.git.mirq-linux@rere.qmqm.pl>
 <eb104cfdf44ef9bf7b4f271555e1496d2bf781bf.1500510157.git.mirq-linux@rere.qmqm.pl>
Message-ID: <20171005164831.GG5235@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 20, 2017 at 02:29:23AM +0200, Micha? Miros?aw wrote:
> Share l2x0_base between cache-l2x0 and pmu drivers.  They are duplicates.

This is not quite true, and this change introduces bugs.

The l2x0 pmu driver only sets its copy of the base for an l2x0 variant
it recognises:

> -void __init l2x0_pmu_register(void __iomem *base, u32 part)
> +void __init l2x0_pmu_register(u32 part)
>  {
>  	/*
>  	 * Determine whether we support the PMU, and choose the name for sysfs.
> @@ -503,8 +502,7 @@ void __init l2x0_pmu_register(void __iomem *base, u32 part)
>  	 * supported by this driver.
>  	 *
>  	 * We must defer registering the PMU until the perf subsystem is up and
> -	 * running, so just stash the name and base, and leave that to another
> -	 * initcall.
> +	 * running, so just stash the name, and leave that to another initcall.
>  	 */
>  	switch (part & L2X0_CACHE_ID_PART_MASK) {
>  	case L2X0_CACHE_ID_PART_L220:
> @@ -516,8 +514,6 @@ void __init l2x0_pmu_register(void __iomem *base, u32 part)
>  	default:
>  		return;
>  	}
> -
> -	l2x0_base = base;

... note that we may return *before* setting l2x0_base.

This (deliberately) prevents us from erroneously registering a PMU for
l2x0 variants for which we don't know how to drive any IMPLEMENTATION
DEFINED PMU functionality.

This cahnge breaks that, and will result in l2x0_pmu_init() trying to
register a PMU with a NULL name.

So NAK to this change.

Thanks,
Mark.
