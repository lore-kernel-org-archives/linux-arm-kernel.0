From: rob.lee@linaro.org (Rob Lee)
Date: Tue, 24 Jan 2012 17:10:14 -0600
Subject: [PATCH v3 1/7] cpuidle: Add common init interface and idle
 functionality
In-Reply-To: <87hazkhn47.fsf@ti.com>
References: <1327379854-12403-1-git-send-email-rob.lee@linaro.org>
 <1327379854-12403-2-git-send-email-rob.lee@linaro.org>
 <87hazkhn47.fsf@ti.com>
Message-ID: <CAMXH7KGYas6GeaVPGBJ3qvOK=z2VKD4q1mG9weKfix57Hr-ONw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 24, 2012 at 2:16 PM, Kevin Hilman <khilman@ti.com> wrote:
> Robert Lee <rob.lee@linaro.org> writes:
>
>> The patch adds some cpuidle initialization functionality commonly
>> duplicated by many platforms.
>>
>> Signed-off-by: Robert Lee <rob.lee@linaro.org>
>
> [...]
>
>> +static int simple_enter(struct cpuidle_device *dev,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ?struct cpuidle_driver *drv, int index)
>> +{
>> + ? ? ktime_t time_start, time_end;
>> +
>> + ? ? local_irq_disable();
>
> Is this needed? ? arch/arm/kernel/process.c:cpu_idle() already disables IRQs
>

As far as I can tell, all calls into cpuidle_idle_call have already
called this.  I had left it just in case someone wanted to call
cpuidle_idle_call directly, but that probably doesn't make sense.
Perhaps in the comments of cpuidle_idle_call I just list this as a
requirement and remove it from simple_enter.

>> + ? ? time_start = ktime_get();
>> +
>> + ? ? index = do_idle[index](dev, drv, index);
>> +
>> + ? ? time_end = ktime_get();
>> +
>> + ? ? local_irq_enable();
>> +
>> + ? ? dev->last_residency =
>> + ? ? ? ? ? ? (int)ktime_to_us(ktime_sub(time_end, time_start));
>
> I don't think this cast is quite right here, since last_residency is an
> int, it needs to be capped, or you'll end up with negative last_residency.
>
> I think you need to do something like is done in poll_idle() in
> drivers/cpuidle/cpuidle.c:
>
> ? ? ? ?diff = ktime_to_us(ktime_sub(t2, t1));
> ? ? ? ?if (diff > INT_MAX)
> ? ? ? ? ? ? ? ?diff = INT_MAX;
>
>

Thanks, I missed that.  Will fix in v4.

> Speaking of poll_idle(), simple_idle() looks quite similar to it. ? Maybe
> they can be combined?

Good point.  I'll look into that.

>
> Kevin
>
