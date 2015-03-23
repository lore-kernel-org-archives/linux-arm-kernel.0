From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Mon, 23 Mar 2015 22:05:31 +0000
Subject: [PATCH v2 1/7] eeprom: Add a simple EEPROM framework for eeprom
 providers
In-Reply-To: <20150323210918.GS14954@sirena.org.uk>
References: <1426240157-2383-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1426240214-2434-1-git-send-email-srinivas.kandagatla@linaro.org>
 <20150323210918.GS14954@sirena.org.uk>
Message-ID: <55108E2B.7050305@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 23/03/15 21:09, Mark Brown wrote:
> On Fri, Mar 13, 2015 at 09:50:14AM +0000, Srinivas Kandagatla wrote:
>
> A couple of *very* minor points below, otherwise this looks OK to me.
>
Thankyou for the review.

>> +struct eeprom_device *eeprom_register(struct eeprom_config *config)
>> +{
>> +	struct eeprom_device *eeprom;
>> +	int rval;
>> +
>> +	if (!config->regmap || !config->size) {
>> +		dev_err(config->dev, "Regmap not found\n");
>> +		return ERR_PTR(-EINVAL);
>> +	}
>
> You have a struct device in the config and the regmap API has
> dev_get_regmap() which for most devices that don't have multiple regmaps
> will give the right regmap.  It would be nice to support this as a
> convenience for users.
Yes, sure that makes sense, I will give it a try.

>
>> +	eeprom = kzalloc(sizeof(*eeprom), GFP_KERNEL);
>> +	if (!eeprom)
>> +		return ERR_PTR(-ENOMEM);
>
> ...
>
>> +	rval = device_add(&eeprom->dev);
>> +	if (rval)
>> +		return ERR_PTR(rval);
>
> Don't you need a kfree() if device_add() fails?
I will fix it in next version.

--srini
>
