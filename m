From: timur@codeaurora.org (Timur Tabi)
Date: Fri, 22 Jun 2018 08:11:07 -0500
Subject: [PATCH 1/2] hwrng: msm: add a spinlock and support for blocking
 reads
In-Reply-To: <152964579304.16708.2651020848216712299@swboyd.mtv.corp.google.com>
References: <1529594276-12210-1-git-send-email-timur@codeaurora.org>
 <152964579304.16708.2651020848216712299@swboyd.mtv.corp.google.com>
Message-ID: <33df2915-ae2e-3cbd-fa84-b3d83bcc82b6@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/22/18 12:36 AM, Stephen Boyd wrote:
> Quoting Timur Tabi (2018-06-21 08:17:55)
>> @@ -96,11 +110,39 @@ static int msm_rng_read(struct hwrng *hwrng, void *data, size_t max, bool wait)
>>   
>>          /* read random data from hardware */
>>          do {
>> -               val = readl_relaxed(rng->base + PRNG_STATUS);
>> -               if (!(val & PRNG_STATUS_DATA_AVAIL))
>> -                       break;
>> +               spin_lock(&rng->lock);
>> +
>> +               /*
>> +                * First check the status bit.  If 'wait' is true, then wait
>> +                * up to TIMEOUT microseconds for data to be available.
>> +                */
>> +               if (wait) {
>> +                       int ret;
> Please don't do local variables like this. Put them at the top of the
> function.

Ok.

> 
>> +
>> +                       ret = readl_poll_timeout_atomic(rng->base + PRNG_STATUS,
>> +                               val, val & PRNG_STATUS_DATA_AVAIL, 0, TIMEOUT);
>> +                       if (ret) {
>> +                               /* Timed out */
>> +                               spin_unlock(&rng->lock);
>> +                               break;
>> +                       }
>> +               } else {
>> +                       val = readl_relaxed(rng->base + PRNG_STATUS);
>> +                       if (!(val & PRNG_STATUS_DATA_AVAIL)) {
>> +                               spin_unlock(&rng->lock);
>> +                               break;
>> +                       }
>> +               }
>>   
>>                  val = readl_relaxed(rng->base + PRNG_DATA_OUT);
>> +               spin_unlock(&rng->lock);
> Maybe this should be written as:
> 
> 		spin_lock()
> 		if (wait) {
> 			has_data = readl_poll_timeout_atomic(...) == 0;
> 		} else {
> 			val = readl_relaxed(rng->base + PRNG_STATUS);
> 			has_data = val & PRNG_STATUS_DATA_AVAIL;
> 		}
> 
> 		if (has_data)
> 			val = readl_relaxed(rng->base + PRNG_DATA_OUT);
> 		spin_unlock();
> 
> 		if (!has_data)
> 			break;

That would work, but I don't really see this as better, just different.

>> +               /*
>> +                * Zero is technically a valid random number, but it's also
>> +                * the value returned if the PRNG is not enabled properly.
>> +                * To avoid accidentally returning all zeros, treat it as
>> +                * invalid and just return what we've already read.
>> +                */
>>                  if (!val)
>>                          break;
> Is this a related change? Looks like a nice comment that isn't related
> to locking.

It's slightly related in that the locking is needed to reduce the number 
of times we read zero from the DATA_OUT register.

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
