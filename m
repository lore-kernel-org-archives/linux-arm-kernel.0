From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 17 Mar 2017 18:05:13 +0000
Subject: [PATCH v21 01/13] clocksource: arm_arch_timer: introduce two
 functions to get the frequency from mmio and sysreg.
In-Reply-To: <20170206185015.12296-2-fu.wei@linaro.org>
References: <20170206185015.12296-1-fu.wei@linaro.org>
 <20170206185015.12296-2-fu.wei@linaro.org>
Message-ID: <20170317180513.GB15909@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 07, 2017 at 02:50:03AM +0800, fu.wei at linaro.org wrote:
> +static u32 arch_timer_get_sysreg_freq(void)
> +{
> +	/*
> +	 * Try to get the frequency from the CNTFRQ of sysreg.
> +	 */
> +	return arch_timer_get_cntfrq();
> +}

We already have arch_timer_get_cntfrq(), so I don't see the point in
this wrapper.

> +static u32 arch_timer_get_mmio_freq(void __iomem *cntbase)
> +{
> +	/*
> +	 * Try to get the frequency from the CNTFRQ of timer frame registers.
> +	 * Note: please verify cntbase in caller.
> +	 */
> +	return readl_relaxed(cntbase + CNTFRQ);
> +}

Wrapping the MMIO read makes sense if we're going to do this in more
than one place, so I'm happy with this wrapper.

If you can s/arch_timer_get_mmio_freq/arch_timer_get_cntfrq/, and drop
the comments, then this looks fine to me.

Thanks,
Mark.
