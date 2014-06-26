From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 25 Jun 2014 17:19:12 -0700
Subject: [PATCH 8/9] ARM: kernel: add support for cpu cache information
In-Reply-To: <1403717444-23559-9-git-send-email-sudeep.holla@arm.com>
References: <1403717444-23559-1-git-send-email-sudeep.holla@arm.com>
 <1403717444-23559-9-git-send-email-sudeep.holla@arm.com>
Message-ID: <53AB6700.2060807@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/25/14 10:30, Sudeep Holla wrote:
> +
> +/*
> + * Which cache CCSIDR represents depends on CSSELR value
> + * Make sure no one else changes CSSELR during this
> + * smp_call_function_single prevents preemption for us
> + */

Where's the smp_call_function_single() or preemption disable happening?

> +static inline u32 get_ccsidr(u32 csselr)
> +{
> +	u32 ccsidr;
> +
> +	/* Put value into CSSELR */
> +	asm volatile ("mcr p15, 2, %0, c0, c0, 0" : : "r" (csselr));
> +	isb();
> +	/* Read result out of CCSIDR */
> +	asm volatile ("mrc p15, 1, %0, c0, c0, 0" : "=r" (ccsidr));
> +
> +	return ccsidr;
> +}
> +

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
