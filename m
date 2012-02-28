From: mturquette@ti.com (Turquette, Mike)
Date: Mon, 27 Feb 2012 16:06:30 -0800
Subject: [PATCH v5 1/9] cpuidle: Add commonly used functionality for
 consolidation
In-Reply-To: <1330318063-25460-2-git-send-email-rob.lee@linaro.org>
References: <1330318063-25460-1-git-send-email-rob.lee@linaro.org>
 <1330318063-25460-2-git-send-email-rob.lee@linaro.org>
Message-ID: <CAJOA=zOmUTqXdMDcY6Bbs51SsRmTJMMu9xtbPxsyq4oNgSdNjg@mail.gmail.com>
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

Any reason that this code is in the header?  Why not in cpuidle.c?

Regards,
Mike
