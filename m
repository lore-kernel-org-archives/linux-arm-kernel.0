From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Wed, 25 Jun 2014 12:29:55 +0200
Subject: [PATCH v3 02/14] mfd: max77686: Allow the max77686 rtc to wakeup
 the system
In-Reply-To: <1403690742.22107.7.camel@AMDC1943>
References: <1403202040-12641-1-git-send-email-javier.martinez@collabora.co.uk>
 <1403202040-12641-3-git-send-email-javier.martinez@collabora.co.uk>
 <1403690742.22107.7.camel@AMDC1943>
Message-ID: <53AAA4A3.50400@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

On 06/25/2014 12:05 PM, Krzysztof Kozlowski wrote:
> On czw, 2014-06-19 at 20:20 +0200, Javier Martinez Canillas wrote:
>> From: Doug Anderson <dianders@chromium.org>
>> 
>> The max77686 includes an RTC that keeps power during suspend.  It's
>> convenient to be able to use it as a wakeup source.
>> 
>> Signed-off-by: Doug Anderson <dianders@chromium.org>
>> ---
>>  drivers/rtc/rtc-max77686.c | 28 ++++++++++++++++++++++++++++
>>  1 file changed, 28 insertions(+)
>> 
>> diff --git a/drivers/rtc/rtc-max77686.c b/drivers/rtc/rtc-max77686.c
>> index d20a7f0..c1c6055 100644
>> --- a/drivers/rtc/rtc-max77686.c
>> +++ b/drivers/rtc/rtc-max77686.c
>> @@ -583,6 +583,33 @@ static void max77686_rtc_shutdown(struct platform_device *pdev)
>>  #endif /* MAX77686_RTC_WTSR_SMPL */
>>  }
>>  
>> +#ifdef CONFIG_PM_SLEEP
>> +static int max77686_rtc_suspend(struct device *dev)
>> +{
>> +	if (device_may_wakeup(dev)) {
>> +		struct max77686_rtc_info *info = dev_get_drvdata(dev);
>> +
>> +		return enable_irq_wake(info->virq);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int max77686_rtc_resume(struct device *dev)
>> +{
>> +	if (device_may_wakeup(dev)) {
>> +		struct max77686_rtc_info *info = dev_get_drvdata(dev);
>> +
>> +		return disable_irq_wake(info->virq);
>> +	}
>> +
>> +	return 0;
>> +}
>> +#endif
> 
> Haven't you noticed un-acked interrupts after first resume? Does the
> alarm IRQ works after first suspend-resume?
> 
> This happens quite often (at least on boards with max14577, max77836 and
> s2m/s5m). The drivers implementing own irq_chip often just call irq
> worker thread (see max77693_irq_resume [1]). With regmap_irq_chip you
> can disable/enable the IRQ [2][3].
> 

Yes, the original Chrome OS 3.8 max77xxx also called the irq worker thread to
ack the interrupt.

So the real problem is that an interrupt occurs before the I2C bus controller is
resumed and so the interrupt handler is not able to access the registers over I2C.

Doug posted the following patches [0,1] that AFAIU solves the issue by making
I2C controllers to be resumed in the noirq time to ensure that drivers will be
able to use the I2C bus to handler their wakeup.

In fact, Doug's original patch had this as a part of the commit message:

NOTE: due to wakeup ordering problems this patch alone doesn't work so
well on exynos5250-snow.  You also need something that brings the i2c
bus up before the max77686 wakeup runs.

I removed that note since I (probably wrong) thought that he didn't mean it to
be part of the commit message but just was side information.

> 
> P.S. Sorry for late reply. I was on holidays.
> 

No worries, thanks a lot for your feedback.

> 
> [1] http://lxr.free-electrons.com/source/drivers/mfd/max77693-irq.c#L233
> [2] http://lxr.free-electrons.com/source/drivers/mfd/max14577.c#L181
> [2] http://lxr.free-electrons.com/source/drivers/mfd/sec-core.c#L444
> 
> Best regards,
> Krzysztof
> 
> 
> 

Best regards,
Javier

[0]: https://patchwork.kernel.org/patch/4414851/
[1]: https://patchwork.kernel.org/patch/4414871/
