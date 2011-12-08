From: rob.lee@linaro.org (Rob Lee)
Date: Thu, 8 Dec 2011 11:34:34 -0600
Subject: [RFC PATCH 1/8] ARM: Add commonly used cpuidle init code
In-Reply-To: <20111206114737.GF17194@sirena.org.uk>
References: <1323146291-10676-1-git-send-email-rob.lee@linaro.org>
 <1323146291-10676-2-git-send-email-rob.lee@linaro.org>
 <20111206114737.GF17194@sirena.org.uk>
Message-ID: <CAMXH7KHqmEB+adCB3OUSUUoYL85o_zqEv03tuxB9DEAo08KhoA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6 December 2011 05:47, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Mon, Dec 05, 2011 at 10:38:04PM -0600, Robert Lee wrote:
>
>> +static int arm_enter_idle(struct cpuidle_device *dev,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ?struct cpuidle_driver *drv, int index)
>> +{
>> + ? ? ktime_t time_start, time_end;
>> +
>> + ? ? local_irq_disable();
>> + ? ? local_fiq_disable();
>
> Apart from the IRQ disables this code isn't really ARM specific at all
> and I bet it'd be useful on a lot of other architectures.
>

I agree and had considered this as well.  Can you (or anyone else)
suggest the best/most community friendly method of doing this?  If
this code is moved to drivers/idle or drivers/cpuidle, then perhaps
just making empty fiq enable/disable functions would be ok.

>> + ? ? time_start = ktime_get();
>
>> + ? ? index = mach_cpuidle(dev, drv, index);
>
> Given the number of systems that at least start off with just a call to
> cpu_do_idle() here shouldn't we have a defualt mach_cpu_idle() which
> does that? ?Currently the code requires the caller to provide one.
>

Good point.  I'll add this to v2.

> Please CC me on any iterations, I've got a S3C64xx implementation I'm
> pushing which could probably use this.

Will do Mark.  Thanks for your review and comments.
