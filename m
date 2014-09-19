From: linux@roeck-us.net (Guenter Roeck)
Date: Thu, 18 Sep 2014 21:03:18 -0700
Subject: [PATCH 3/3] watchdog: qcom: register a restart notifier
In-Reply-To: <20140919033202.GF3749@joshc.qualcomm.com>
References: <cover.1411078425.git.joshc@codeaurora.org>
 <d0f4cd93ad3f6690d637413b1171ac3c71aba861.1411078426.git.joshc@codeaurora.org>
 <541B995A.6000609@roeck-us.net> <20140919033202.GF3749@joshc.qualcomm.com>
Message-ID: <541BAB06.7040502@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/18/2014 08:32 PM, Josh Cartwright wrote:
> On Thu, Sep 18, 2014 at 07:47:54PM -0700, Guenter Roeck wrote:
>> On 09/18/2014 03:27 PM, Josh Cartwright wrote:
>>> The WDT's BITE_TIME warm-reset behavior can be leveraged as a last
>>> resort mechanism for triggering chip reset.  Usually, other restart
>>> methods (such as PS_HOLD) are preferrable for issuing a more complete
>>> reset of the chip.  As such, keep the priority of the watchdog notifier
>>> low.
>>>
>>> Signed-off-by: Josh Cartwright <joshc@codeaurora.org>
> [..]
>>> +static int qcom_wdt_restart(struct notifier_block *nb, unsigned long action,
>>> +			    void *data)
>>> +{
>>> +	struct qcom_wdt *wdt = container_of(nb, struct qcom_wdt, restart_nb);
>>> +
>>> +	/*
>>> +	 * Trigger watchdog bite:
>>> +	 *    Setup BITE_TIME to be very low, and enable WDT.
>>> +	 */
>>> +	mutex_lock(&wdt->wdd.lock);
>>
>> At this time you don't need to worry about locks.
>>
>> Actually, this might be dangerous if the lock happens to be taken,
>> as it won't be released (there is no other code running anymore
>> when this function is called).
>
> Ah, great.  I'll drop the locking.
>
>>> +	writel_relaxed(0, wdt->base + WDT_EN);
>>> +	writel_relaxed(1, wdt->base + WDT_RST);
>>> +	writel_relaxed(0x31F3, wdt->base + WDT_BITE_TIME);
>>
>> What is the magic here, ie what does 0x31F3 stand for ?
>
> Nothing magic, it's just a reasonably low value to set the bite time
> counter at.  It also happens to be the value at reset.
>
Can you add a note explaining that this reflects a reset delay of <n>
milliseconds or whatever it is ?

>>> +	writel_relaxed(1, wdt->base + WDT_EN);
>>> +	mutex_unlock(&wdt->wdd.lock);
>>> +	return NOTIFY_DONE;
>>> +}
>>> +
>>>   static int qcom_watchdog_probe(struct platform_device *pdev)
>>>   {
>>>   	struct qcom_wdt *wdt;
>>> @@ -121,6 +141,17 @@ static int qcom_watchdog_probe(struct platform_device *pdev)
>>>   		return ret;
>>>   	}
>>>
>>> +	/*
>>> +	 * WDT restart notifier has priority 0 (use as a last resort)
>>> +	 */
>>> +	wdt->restart_nb.notifier_call = qcom_wdt_restart;
>>> +	ret = register_restart_handler(&wdt->restart_nb);
>>> +	if (ret) {
>>> +		dev_err(&pdev->dev, "failed to setup restart handler\n");
>>> +		watchdog_unregister_device(&wdt->wdd);
>>> +		return ret;
>>
>> Sure you want to return an error here ? The watchdog itself is still working,
>> and this is supposed to be a restart method of last resort. Causing the driver
>> to fail loading because it can not register its restart handler seems to be
>> a bit aggressive.
>
> It is a bit aggressive.  I'll at least drop it to a dev_warn(); even
> though it is a "last resort", on some boards it's the only available
> mechanism for reliable restart.
>
Sure, but the problem is that you don't let people use the watchdog just
because restart handler registration failed. dev_err or dev_warn is fine,
my concern was not the message but that you abort watchdog registration
in this case.

Kind of letting people not use their car just because one of its lights
failed.

Guenter
