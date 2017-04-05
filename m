From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 5 Apr 2017 19:42:30 +0100
Subject: [PATCH v23 06/11] clocksource: arm_arch_timer: refactor MMIO
 timer probing.
In-Reply-To: <20170331175105.8370-7-fu.wei@linaro.org>
References: <20170331175105.8370-1-fu.wei@linaro.org>
 <20170331175105.8370-7-fu.wei@linaro.org>
Message-ID: <20170405184229.GA29338@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 01, 2017 at 01:51:00AM +0800, fu.wei at linaro.org wrote:
> +	arch_timer_mem_freq = arch_timer_mem_get_cntfrq(base);
> +	if (!arch_timer_rate && arch_timer_mem_freq) {
> +		arch_timer_rate = arch_timer_mem_freq;
> +	} else if (!arch_timer_rate || arch_timer_rate != arch_timer_mem_freq) {
> +		pr_err(FW_BUG "invalid MMIO frequency.\n");
> +		iounmap(base);
> +		return -EINVAL;
> +	}

I thought I had previously mentioned that this last check has the
potential to break DT systems, which may be inadvertently relying on the
probe order.

I agree we must do this check for ACPI, but I think that for DT it needs
to be relaxed.

I'm happy to rework that locally, if you can address my comments on
patch 9.

Thanks,
Mark.
