From: rob.lee@linaro.org (Rob Lee)
Date: Sun, 25 Sep 2011 22:54:05 -0500
Subject: [PATCH v2 1/3] ARM: imx: Add imx cpuidle driver
In-Reply-To: <20110916213613.GA16381@n2100.arm.linux.org.uk>
References: <1316194070-21889-1-git-send-email-rob.lee@linaro.org>
	<1316194070-21889-2-git-send-email-rob.lee@linaro.org>
	<20110916213613.GA16381@n2100.arm.linux.org.uk>
Message-ID: <CAMXH7KEGyb+nu0ZbvwxFHe8+BZHp5qko_+goFNSxS3DxEoVBhg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Russell,

On 16 September 2011 16:36, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Sep 16, 2011 at 12:27:48PM -0500, Robert Lee wrote:
>> Introduce a new cpuidle driver which provides the common cpuidle
>> functionality necessary for any imx soc cpuidle implementation.
>
> I think its probably about time we said no to this duplication of CPU
> idle infrastructure. ?There seems to be a common pattern appearing
> through all SoCs - they're all doing this:
>
>> +static int imx_enter_idle(struct cpuidle_device *dev,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ?struct cpuidle_state *state)
>> +{
>> + ? ? struct timeval before, after;
>> + ? ? int idle_time;
>> +
>> + ? ? local_irq_disable();
>> + ? ? local_fiq_disable();
>> +
>> + ? ? do_gettimeofday(&before);
>> +
>> + ? ? mach_cpuidle(dev, state);
>> +
>> + ? ? do_gettimeofday(&after);
>> +
>> + ? ? local_fiq_enable();
>> + ? ? local_irq_enable();
>> +
>> + ? ? idle_time = (after.tv_sec - before.tv_sec) * USEC_PER_SEC +
>> + ? ? ? ? ? ? (after.tv_usec - before.tv_usec);
>> +
>> + ? ? return idle_time;
>> +}
>

If I understand you correctly, it sounds like you are suggesting
adding cpuidle initialization functionality that is common for all ARM.
Did you mean just the above function or also the functionality found
in imx_cpuidle_init and imx_cpuidle_dev_init?  For this common
ARM functionality, would a cpuidle.c file in arch/arm/common/ be the
right location?

> in some form, where 'do_gettimeofday' might be ktime_get() or
> getnstimeofday(). ?If we can standardize on which of the many time
> functions can be used (which would be a definite plus) we should move
> this out to common code.

Looking into the time keeping functionality more, of the time functions
you mentioned I think that ktime_get is preferable as its result it effectively
a monotonic time that won't be changed with calls to do_settimeofday
unlike the other two functions whose use of xtime only could result in
an error in the reported time difference on SMP systems.

>
> Maybe also the initialization code could be standardized and improved
> too - for instance, what if you boot with maxcpus=1 on a platform
> supporting 2 CPUs, and you bring CPU1 online from userspace? ?When
> these CPU idle initialization functions are called, only one CPU will
> be online, and as they use 'for_each_cpu(cpu_id, cpu_online_mask)'
> CPU1 will be missing the cpu idle init.
>
