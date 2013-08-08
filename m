From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 08 Aug 2013 11:30:30 -0600
Subject: [PATCH v2 1/3] hwmon: (lm90) Add power control
In-Reply-To: <520359E9.1000600@roeck-us.net>
References: <1375944991-29182-1-git-send-email-wni@nvidia.com>
 <1375944991-29182-2-git-send-email-wni@nvidia.com>
 <520359E9.1000600@roeck-us.net>
Message-ID: <5203D5B6.3060806@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/08/2013 02:42 AM, Guenter Roeck wrote:
> On 08/07/2013 11:56 PM, Wei Ni wrote:
>> The device lm90 can be controlled by the vdd rail.
>> Adding the power control support to power on/off the vdd rail.
>> And make sure that power is enabled before accessing the device.

>> diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c

>>   static int lm90_probe(struct i2c_client *client,
>>                 const struct i2c_device_id *id)
>>   {
>> @@ -1406,6 +1434,20 @@ static int lm90_probe(struct i2c_client *client,
>>       i2c_set_clientdata(client, data);
>>       mutex_init(&data->update_lock);
>>
>> +    data->lm90_reg = regulator_get(&client->dev, "vdd");
> 
> You should use devm_regulator_get(). Then you also don't need the call
> to regulator_put().
> 
>> +    if (IS_ERR_OR_NULL(data->lm90_reg)) {
> 
> The function never returns NULL except if the regulator subsystem is not
> configured,
> so IS_ERR() is more appropriate.
> 
> If the regulator subsystem is not configured, you especially don't need
> or want
> to pollute the log with an error message.

DT parsing errors should be reported. However, if there's nothing to
parse, it's not an error.

So, I think this should report an error message *if* there is a DT
property that defines the regulator to use. If there's no property, just
use no regulator. If there is a property, it had better be possible to
parse it.
