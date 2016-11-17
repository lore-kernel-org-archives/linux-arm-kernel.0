From: kernel@martin.sperl.org (Martin Sperl)
Date: Thu, 17 Nov 2016 10:51:33 +0100
Subject: [PATCH V8 2/6] thermal: bcm2835: add thermal driver for bcm2835
 soc
In-Reply-To: <20161117021107.GA2647@localhost.localdomain>
References: <1478081906-12009-1-git-send-email-kernel@martin.sperl.org>
 <1478081906-12009-3-git-send-email-kernel@martin.sperl.org>
 <20161117021107.GA2647@localhost.localdomain>
Message-ID: <766e1b70-d83a-eb52-fa2b-aec435e85673@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 17.11.2016 03:11, Eduardo Valentin wrote:
> Hey Martin,
>
> Very sorry for the late feedback. Not so sure if this one got queued
> already or not. Anyways, just minor questions as follows:
>
> On Wed, Nov 02, 2016 at 10:18:22AM +0000, kernel at martin.sperl.org wrote:
>> From: Martin Sperl <kernel@martin.sperl.org>
>>
>> Add basic thermal driver for bcm2835 SOC.
>>
>> This driver currently relies on the firmware setting up the
>> tsense HW block and does not set it up itself.
>>
>> Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
>> Acked-by: Eric Anholt <eric@anholt.net>
>> Acked-by: Stefan Wahren <stefan.wahren@i2se.com>
>>
...
>> +static int bcm2835_thermal_adc2temp(
>> +	const struct bcm2835_thermal_info *info, u32 adc)
>> +{
>> +	return info->offset + (adc * info->slope);
>
> Any specific reason we cannot use thermal_zone_params->slope and
> thermal_zone_params->offset?

You could - the patch was just rebased to 4.9 and those slope and
offset just got merged during this cycle.

Do we really need to modify it - the patch has been around since 4.6.

>> +
>> +static int bcm2835_thermal_get_trip_temp(
>> +	struct thermal_zone_device *tz, int trip, int *temp)
>> +{
>> +	struct bcm2835_thermal_data *data = tz->devdata;
>> +	u32 val = readl(data->regs + BCM2835_TS_TSENSCTL);
>> +
>> +	/* get the THOLD bits */
>> +	val &= BCM2835_TS_TSENSCTL_THOLD_MASK;
>> +	val >>= BCM2835_TS_TSENSCTL_THOLD_SHIFT;
>> +
>> +	/* if it is zero then use the info value */
>> +	if (val)
>
> Is this a read only register or is this driver supposed to program it?
> In which scenario it would be 0? Can this be added as comments?

It is RW, but the Firmware typically sets up the thermal device with the 
correct values already - this is just a fallback.

>> +static int bcm2835_thermal_get_temp(struct thermal_zone_device *tz,
>> +				    int *temp)
>> +{
>> +	struct bcm2835_thermal_data *data = tz->devdata;
>> +	u32 val = readl(data->regs + BCM2835_TS_TSENSSTAT);
>> +
>> +	if (!(val & BCM2835_TS_TSENSSTAT_VALID))
>
> What cases you would get the valid bit not set? Do you need to wait for
> the conversion to finish?

I guess: if you have just enabled the HW-block (which the FW does much
in advance) and start to read the value immediately (before the first 
sample period has finished), then this will not be valid.

So do you need another version of the patchset that uses that new API?

Thanks,
	Martin
