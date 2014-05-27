From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Tue, 27 May 2014 12:14:18 +0200
Subject: [PATCH v3 1/6] mfd: axp20x: add AXP221 PMIC support
In-Reply-To: <20140527100540.GJ5875@lee--X1>
References: <1401183535-31003-1-git-send-email-boris.brezillon@free-electrons.com>
 <1401183535-31003-2-git-send-email-boris.brezillon@free-electrons.com>
 <20140527100540.GJ5875@lee--X1>
Message-ID: <5384657A.3030207@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 27/05/2014 12:05, Lee Jones wrote:
>> Add support for the AXP221 PMIC device to the existing AXP20x driver.
>>
>> The AXP221 defines a new set of registers, power supplies and regulators,
>> but most of the API is similar to the AXP20x ones.
>> The AXP20x irq chip definition is reused, though some interrupts are not
>> available in the AXP221.
>>
>> Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
>> ---
>>  drivers/mfd/axp20x.c       | 58 +++++++++++++++++++++++++++++++++++++++++++---
> Quite a difference from 237 lines, eh?

Yep.

I never said my RFC was using the best approach, I actually asked how
code sharing should be done in my cover letter ;-).

>>  include/linux/mfd/axp20x.h | 56 ++++++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 111 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
>> index dee6539..119a7ed 100644
>> --- a/drivers/mfd/axp20x.c
>> +++ b/drivers/mfd/axp20x.c
> [...]
>
>> @@ -190,7 +233,12 @@ static int axp20x_i2c_probe(struct i2c_client *i2c,
>>  	axp20x->dev = &i2c->dev;
>>  	dev_set_drvdata(axp20x->dev, axp20x);
>>  
>> -	axp20x->regmap = devm_regmap_init_i2c(i2c, &axp20x_regmap_config);
>> +	if (axp20x->variant == AXP221_ID)
>> +		axp20x->regmap = devm_regmap_init_i2c(i2c,
>> +						      &axp22x_regmap_config);
>> +	else
>> +		axp20x->regmap = devm_regmap_init_i2c(i2c,
>> +						      &axp20x_regmap_config);
> Better to put these into a variable and have one instance of
> devm_regmap_init_i2c() where you pass said variable as the second
> parameter.

Sure, I'll change that.

Thanks for your review.

Best Regards,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
