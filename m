From: rob.lee@linaro.org (Rob Lee)
Date: Tue, 28 Feb 2012 09:45:10 -0600
Subject: [PATCH v5 1/9] cpuidle: Add commonly used functionality for
 consolidation
In-Reply-To: <CAJOA=zOmUTqXdMDcY6Bbs51SsRmTJMMu9xtbPxsyq4oNgSdNjg@mail.gmail.com>
References: <1330318063-25460-1-git-send-email-rob.lee@linaro.org>
 <1330318063-25460-2-git-send-email-rob.lee@linaro.org>
 <CAJOA=zOmUTqXdMDcY6Bbs51SsRmTJMMu9xtbPxsyq4oNgSdNjg@mail.gmail.com>
Message-ID: <CAMXH7KEBggsYEq9irMoEG-fZEjgEFACFhZZ+-JQj0uvwpGsZHA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey Mike,

On Mon, Feb 27, 2012 at 6:06 PM, Turquette, Mike <mturquette@ti.com> wrote:
> On Sun, Feb 26, 2012 at 8:47 PM, Robert Lee <rob.lee@linaro.org> wrote:
>> +/**
>> + * cpuidle_enter_wrap - performing timekeeping and irq around enter function
>> + * @dev: pointer to a valid cpuidle_device object
>> + * @drv: pointer to a valid cpuidle_driver object
>> + * @index: index of the target cpuidle state.
>> + */
>> +static inline int cpuidle_wrap_enter(struct cpuidle_device *dev,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? struct cpuidle_driver *drv, int index,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? int (*enter)(struct cpuidle_device *dev,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? struct cpuidle_driver *drv, int index))
>> +{
>> + ? ? ? ktime_t time_start, time_end;
>> + ? ? ? s64 diff;
>> +
>> + ? ? ? time_start = ktime_get();
>> +
>> + ? ? ? index = enter(dev, drv, index);
>> +
>> + ? ? ? time_end = ktime_get();
>> +
>> + ? ? ? local_irq_enable();
>> +
>> + ? ? ? diff = ktime_to_us(ktime_sub(time_end, time_start));
>> + ? ? ? if (diff > INT_MAX)
>> + ? ? ? ? ? ? ? diff = INT_MAX;
>> +
>> + ? ? ? dev->last_residency = (int) diff;
>> +
>> + ? ? ? return index;
>> +}
>
> Any reason that this code is in the header? ?Why not in cpuidle.c?
>

Not a strong reason.  I thought making it an inline would introduce
slightly less new execution when adding this code (realizing that
there are function calls immediately after, so the only benefit is the
reduce popping and pushing).  But it does require an extra copy of
this code for any platform driver that does not enable
en_core_tk_irqen and instead makes calls to it directly (like omap3).
For this case, I don't think the inline implementation should add
extra code from what exists today as it should simply replace the
existing platform time keeping calls to a standard one defined by the
core cpuidle.

I don't have a strong preference with using the inline so if you or
others can give your opinion on which method to use and why, I'd be
glad to read it.

> Regards,
> Mike
