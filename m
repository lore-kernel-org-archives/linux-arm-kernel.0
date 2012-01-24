From: khilman@ti.com (Kevin Hilman)
Date: Tue, 24 Jan 2012 12:16:56 -0800
Subject: [PATCH v3 1/7] cpuidle: Add common init interface and idle
 functionality
In-Reply-To: <1327379854-12403-2-git-send-email-rob.lee@linaro.org> (Robert
 Lee's message of "Mon, 23 Jan 2012 22:37:28 -0600")
References: <1327379854-12403-1-git-send-email-rob.lee@linaro.org>
 <1327379854-12403-2-git-send-email-rob.lee@linaro.org>
Message-ID: <87hazkhn47.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Robert Lee <rob.lee@linaro.org> writes:

> The patch adds some cpuidle initialization functionality commonly
> duplicated by many platforms.
>
> Signed-off-by: Robert Lee <rob.lee@linaro.org>

[...]

> +static int simple_enter(struct cpuidle_device *dev,
> +			       struct cpuidle_driver *drv, int index)
> +{
> +	ktime_t time_start, time_end;
> +
> +	local_irq_disable();

Is this needed?   arch/arm/kernel/process.c:cpu_idle() already disables IRQs

> +	time_start = ktime_get();
> +
> +	index = do_idle[index](dev, drv, index);
> +
> +	time_end = ktime_get();
> +
> +	local_irq_enable();
> +
> +	dev->last_residency =
> +		(int)ktime_to_us(ktime_sub(time_end, time_start));

I don't think this cast is quite right here, since last_residency is an
int, it needs to be capped, or you'll end up with negative last_residency.

I think you need to do something like is done in poll_idle() in
drivers/cpuidle/cpuidle.c:

	diff = ktime_to_us(ktime_sub(t2, t1));
	if (diff > INT_MAX)
		diff = INT_MAX;


Speaking of poll_idle(), simple_idle() looks quite similar to it.   Maybe
they can be combined?

Kevin
