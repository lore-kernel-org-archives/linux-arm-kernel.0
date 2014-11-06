From: arno@natisbad.org (Arnaud Ebalard)
Date: Fri, 07 Nov 2014 00:30:48 +0100
Subject: [PATCHv0 3/3] rtc: rtc-isl12057: add alarm support to Intersil
 ISL12057 RTC driver
References: <cover.1415222752.git.arno@natisbad.org>
 <148403c0ab1d556cbb99d9242c65f714a77843e5.1415222752.git.arno@natisbad.org>
 <20141106055017.GL8509@sirena.org.uk>
Message-ID: <87ppcznbyv.fsf@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Mark Brown <broonie@kernel.org> writes:

> On Wed, Nov 05, 2014 at 10:42:52PM +0100, Arnaud Ebalard wrote:
>
>> +static int _isl12057_rtc_toggle_alarm(struct device *dev, int enable)
>> +{
>> +	struct isl12057_rtc_data *data = dev_get_drvdata(dev);
>
> I can't help but think that toggle is a confusing name for this.
> enable?

I'll fix the name to use update_alarm, as proposed by Guenter.


>> +	ret = regmap_update_bits(data->regmap, ISL12057_REG_INT,
>> +				 ISL12057_REG_INT_A1IE,
>> +				 enable ? ISL12057_REG_INT_A1IE : 0);
>> +	if (ret)
>> +		dev_err(dev, "%s: writing INT failed\n", __func__);
>
> It's generally helpful to log the error code as well.

WILCO


>> +static int _isl12057_rtc_read_time(struct device *dev, struct rtc_time *tm)
>>  {
>>  	struct isl12057_rtc_data *data = dev_get_drvdata(dev);
>>  	u8 regs[ISL12057_RTC_SEC_LEN];
>>  	int ret;
>>  
>> -	mutex_lock(&data->lock);
>>  	ret = regmap_bulk_read(data->regmap, ISL12057_REG_RTC_SC, regs,
>>  			       ISL12057_RTC_SEC_LEN);
>> -	mutex_unlock(&data->lock);
>> -
>
> This is a perfectly sensible change (there's no need for the lock,
> regmap locks the physical I/O and there's no other interaction) but it's
> not related to enabling alarm functionality so should be in a separate
> patch.
>
>> +static int isl12057_rtc_read_time(struct device *dev, struct rtc_time *tm)
>> +{
>> +	struct isl12057_rtc_data *data = dev_get_drvdata(dev);
>> +	int ret;
>> +
>> +	mutex_lock(&data->lock);
>> +	ret = _isl12057_rtc_read_time(dev, tm);
>> +	mutex_unlock(&data->lock);
>
> Why lock?  I guess this is due to the above change but it seems better
> to just not lock since it's redundant.

I am aware regmap has an inner lock to protect access. But later in the
patch, there are functions (e.g. isl12057_rtc_set_alarm()) which need to
do various consecutive accesses to the device; the main purpose of the
mutex is to protect those multiple accesses. In those functions, I cannot
call functions which do try and get the lock, hence the creation of an
underscore version (_isl12057_rtc_read_time()) which does not lock.

That being said, regarding isl12057_rtc_read_time() (the version I
declare in rtc_ops structure), I agree that it does not need to get the
lock as it only reads (and does not modify the device) and the regmap
inner lock protection is ok in that context. As it is the only one to be
in that case (read_alarm() is more complex and needs the lock).


>> +	ret = rtc_tm_to_time(&rtc_tm, &rtc_secs);
>> +	if (ret)
>> +		goto err_unlock;
>> +
>> +	ret = rtc_tm_to_time(alarm_tm, &alarm_secs);
>> +	if (ret)
>> +		goto err_unlock;
>> +
>> +	/* If alarm time is before current time, disable the alarm */
>> +	if (!alarm->enabled || alarm_secs <= rtc_secs) {
>> +		enable = 0;
>
> Shouldn't there be some margin for time rolling forwards when checking
> for alarm times in the past (or just refuse to set them, I've not
> checked if this is following existing practice for RTC drivers)?

No strong feeling on that point. ISL12008 on which this driver is based
has a similar logic.


>> +	if (client->irq > 0) {
>> +		ret = devm_request_threaded_irq(&client->dev, client->irq, NULL,
>> +						isl12057_rtc_interrupt,
>> +						IRQF_SHARED|IRQF_ONESHOT,
>> +						DRV_NAME, client);
>> +		if (!ret) {
>> +			device_init_wakeup(&client->dev, true);
>> +		} else {
>> +			dev_err(dev, "irq %d unavailable, no alarm support\n",
>> +				client->irq);
>> +			client->irq = 0;
>> +		}
>> +	}
>> +
>
> None of the alarm functionality checks to see if there's actually an IRQ
> - is that OK? I'd at least expect the alarm interrupt enable call to
> check if the interrupt is wired up.

I can add those check BUT I would like some directions in order to
support the following use case too.

Current three in-tree users of ISL12057 are NAS devices (Netgear
ReadyNAS 102, 104 and 2120). All of them *do not have* the interrupt pin
of the RTC chip connected to an interrupt line of the SoC. Nonetheless,
the IRQ line of the chip being connected to a PMIC on the board (TI
TPS65251 [1] on ReadyNAS 102 and 104, I do not know for ReadyNAS
2120). When the device is off and the alarm rings, the device gets
powered on. AFAICT, the IRQ coming on the TPS65251 is not replicated on
any line of the SoC.

I think it's possible w/ some soldering to get somewhere where the RTC
framework wants me to be and finish the alarm part to have it merged
upstream but that's of limited interest if in-tree user cannot use it to
fit their need, i.e. configure an alarm value and enable the associated
interrupt which is routed externally, i.e. not visible by the SoC.

FWIW, we had a similar discussion a while ago, during driver inclusion:

  http://marc.info/?l=devicetree&m=138109313118504&w=2

Uwe, any idea?

> It's also bad form to overwrite client->irq - it's possible a future
> probe might work (eg, if the driver for the interrupt controller gets
> loaded).  Ideally we'd handle deferred probe, though I don't think the
> interrupt core supports that yet.

I'll add a field in my private structure to reference the irq, modify it
at will and leave client->irq alone.


>> +err:
>> +	if (client->irq > 0)
>> +		free_irq(client->irq, client);
>
> The whole point with devm_ is that you don't need to manually free
> anything, remove this (and the entire remove function).

good point. I'll remove the free_irq() call. I'll keep remove function
though for other reasons; I think I will need to have a conditional call
to device_init_wakeup() in it. 

a+

[1]: http://natisbad.org/NAS/refs/tps65251.pdf
