From: narmstrong@baylibre.com (Neil Armstrong)
Date: Mon, 19 Oct 2015 14:41:26 +0200
Subject: [RFC PATCH 1/3] arm: plat-omap: dmtimer: Add clock source from DT
In-Reply-To: <87k2qmlt38.fsf@saruman.tx.rr.com>
References: <5620ED30.2050507@baylibre.com> <87k2qmlt38.fsf@saruman.tx.rr.com>
Message-ID: <5624E4F6.5000308@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 10/16/2015 05:40 PM, Felipe Balbi wrote:
>> +static int omap_dm_timer_of_set_source(struct omap_dm_timer *timer)
>> +{
>> +	int ret;
>> +	struct clk *parent;
>> +
>> +	if (unlikely(!timer))
>> +		return -EINVAL;
> 
> IMO, let this crash. If this happens we have bigger problems.
> 
>> +	if (IS_ERR(timer->fclk))
>> +		return -EINVAL;
> 
> We bail out if we can't get fclk, this check is unnecessary.

Sure, I will remove the checks.
This was also breaking OMAP1, fclk must be checked against NULL here to detect OMAP1 and return -ENODEV;

> 
>> +	parent = clk_get(&timer->pdev->dev, NULL);
> 
> why NULL ? You could use something more descriptive, but no strong
> feelings.


Actually, I just wanted the "default" clock for this device, NULL will select the first OF clock found.
If we specify a name, we should also specify it in the DT as clock-names, is it desired ?
If you feel I should name it somehow... I don't want it to conflict all the HWMOD clk namings actually.

> 
>> +	if (IS_ERR(parent))
>> +		return -ENODEV;
>> +
>> +	ret = clk_set_parent(timer->fclk, parent);
>> +	if (ret < 0)
>> +		pr_err("%s: failed to set parent\n", __func__);
>> +
>> +	clk_put(parent);
>> +
>> +	return ret;
>> +}
>> +
>>  static int omap_dm_timer_prepare(struct omap_dm_timer *timer)
>>  {
>> -	int rc;
>> +	int rc, ret;
> 
> doesn't seem like you need this extra 'ret' variable. Just use 'rc'.
> 
>> @@ -166,7 +190,11 @@ static int omap_dm_timer_prepare(struct omap_dm_timer *timer)
>>  	__omap_dm_timer_enable_posted(timer);
>>  	omap_dm_timer_disable(timer);
>>
>> -	return omap_dm_timer_set_source(timer, OMAP_TIMER_SRC_32_KHZ);
>> +	ret = omap_dm_timer_of_set_source(timer);
>> +	if (ret < 0 && ret == -ENODEV)
> 
> this < 0 check is pointless if you're going to check for equality to -ENODEV

Sure, I was certainly tired, this was a so stupid mistake...

Neil
