From: sbranden@broadcom.com (Scott Branden)
Date: Thu, 26 Feb 2015 11:37:20 -0800
Subject: [PATCH v2 2/2] hwrng: iproc-rng200 - Add Broadcom IPROC RNG driver
In-Reply-To: <3062825.7b1oYP4yuL@wuerfel>
References: <1424888184-22180-3-git-send-email-sbranden@broadcom.com>
 <3062825.7b1oYP4yuL@wuerfel>
Message-ID: <54EF75F0.7000901@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Response inline.

On 15-02-25 11:17 AM, Arnd Bergmann wrote:
> On Wednesday 25 February 2015 10:16:24 Scott Branden wrote:
>> This adds a driver for random number generator present on Broadcom
>> IPROC devices.
>>
>> Reviewed-by: Ray Jui <rjui@broadcom.com>
>> Signed-off-by: Scott Branden <sbranden@broadcom.com>
>
> The driver looks reasonable overall, I have just one question about
> something that sticks out:
>
>> +	while ((num_remaining > 0) && time_before(jiffies, idle_endtime)) {
> ...
>> +
>> +		/* Are there any random numbers available? */
>> +		if ((ioread32(rng_base + RNG_FIFO_COUNT_OFFSET) &
>> +				RNG_FIFO_COUNT_RNG_FIFO_COUNT_MASK) > 0) {
> ...
>> +		} else {
>> +			if (!wait)
>> +				/* Cannot wait, return immediately */
>> +				return max - num_remaining;
>> +
>> +			/* Can wait, give others chance to run */
>> +			cpu_relax();
>> +		}
>> +	}
>> +
>
> It looks like you do a busy-loop around cpu_relax here if asked to wait.
> Is this intentional? I would normally expect either cond_resched() or
> some msleep() instead.

This code was following examples of other open source drivers - bcm2835 
and exynos both use cpu_relax.  I'll have to look into this more to 
understand.

>
> 	Arnd
>
