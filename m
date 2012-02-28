From: mturquette@ti.com (Turquette, Mike)
Date: Mon, 27 Feb 2012 16:49:32 -0800
Subject: [PATCH v5 1/9] cpuidle: Add commonly used functionality for
 consolidation
In-Reply-To: <1330318063-25460-2-git-send-email-rob.lee@linaro.org>
References: <1330318063-25460-1-git-send-email-rob.lee@linaro.org>
 <1330318063-25460-2-git-send-email-rob.lee@linaro.org>
Message-ID: <CAJOA=zNZ2xh34DTZc1gJwy0O6d=E=wdP4_sq_zrj3qjLcbj0kw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 26, 2012 at 8:47 PM, Robert Lee <rob.lee@linaro.org> wrote:
> +/**
> + * cpuidle_enter_wrap - performing timekeeping and irq around enter function
> + * @dev: pointer to a valid cpuidle_device object
> + * @drv: pointer to a valid cpuidle_driver object
> + * @index: index of the target cpuidle state.
> + */
> +static inline int cpuidle_wrap_enter(struct cpuidle_device *dev,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? struct cpuidle_driver *drv, int index,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? int (*enter)(struct cpuidle_device *dev,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? struct cpuidle_driver *drv, int index))
> +{
> + ? ? ? ktime_t time_start, time_end;
> + ? ? ? s64 diff;
> +
> + ? ? ? time_start = ktime_get();
> +
> + ? ? ? index = enter(dev, drv, index);
> +
> + ? ? ? time_end = ktime_get();
> +
> + ? ? ? local_irq_enable();
> +
> + ? ? ? diff = ktime_to_us(ktime_sub(time_end, time_start));
> + ? ? ? if (diff > INT_MAX)
> + ? ? ? ? ? ? ? diff = INT_MAX;
> +
> + ? ? ? dev->last_residency = (int) diff;
> +
> + ? ? ? return index;
> +}

Hi Rob,

In a previous series I brought up the idea of not accounting for time
if a C-state transition fails.  My post on that thread can be found
here:
http://article.gmane.org/gmane.linux.ports.arm.kernel/149293/

How do you feel about adding something like the following?

if (IS_ERR(index))
        dev->last_residency = 0;
        return index;

Obviously it will up to the platforms to figure out how to propagate
that error up from their respective low power code.

Regards,
Mike
