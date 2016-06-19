From: stefan@agner.ch (Stefan Agner)
Date: Sat, 18 Jun 2016 18:08:54 -0700
Subject: [PATCH v2 4/5] mfd: rn5t618: register power off callback
 optionally
In-Reply-To: <20160616145907.GD4948@dell>
References: <20160608010429.19618-1-stefan@agner.ch>
 <20160608010429.19618-5-stefan@agner.ch> <20160616145907.GD4948@dell>
Message-ID: <876c6fc0a1e300e95eda616c8c71a3ec@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016-06-16 07:59, Lee Jones wrote:
> On Tue, 07 Jun 2016, Stefan Agner wrote:
> 
>> Only register power off if the PMIC is defined as system power
>> controller (see Documentation/devicetree/bindings/power/
>> power-controller.txt).
>>
>> Reviewed-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
>> Signed-off-by: Stefan Agner <stefan@agner.ch>
> 
> These should be chronological.
> 

Has been discussed already here:
http://lists.infradead.org/pipermail/linux-arm-kernel/2015-May/345835.html

It's an artifact of my development process, I keep the commits in my
local branches without signed off lines and add them before sending out
patches. So whenever I prepare a new revision, collected acks, sobs are
chronological, but end up before my sob.

But since you are the second maintainer which has objection to that
style I probably should change that...

>> ---
>>  drivers/mfd/rn5t618.c | 10 +++++++---
>>  1 file changed, 7 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/mfd/rn5t618.c b/drivers/mfd/rn5t618.c
>> index 7607ced..d9b4d40 100644
>> --- a/drivers/mfd/rn5t618.c
>> +++ b/drivers/mfd/rn5t618.c
>> @@ -103,9 +103,13 @@ static int rn5t618_i2c_probe(struct i2c_client *i2c,
>>  		return ret;
>>  	}
>>
>> -	if (!pm_power_off) {
>> -		rn5t618_pm_power_off = priv;
>> -		pm_power_off = rn5t618_power_off;
>> +	if (of_device_is_system_power_controller(i2c->dev.of_node)) {
>> +		if (!pm_power_off) {
>> +			rn5t618_pm_power_off = priv;
>> +			pm_power_off = rn5t618_power_off;
>> +		} else {
>> +			dev_err(&i2c->dev, "Failed to set poweroff capability, already defined\n");
> 
> This is not an error.  Please use dev_warn() instead.
> 

Hm, I agree... FWIW, I copied the code (and that message) from here,
where dev_err is probably also not appropriate:
drivers/regulator/act8865-regulator.c


> Also, is this message actually accurate?  Your commit message would
> indicate that it's not.

Hm, maybe we should bail out with an error in that case since DT
explicitly asks to be power controller... Is that what you mean?

--
Stefan

> 
>> +		}
>>  	}
>>
>>  	return 0;
