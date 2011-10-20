From: rnayak@ti.com (Rajendra Nayak)
Date: Thu, 20 Oct 2011 10:48:58 +0530
Subject: [PATCH v2 3/5] regulator: helper routine to extract
	regulator_init_data
In-Reply-To: <20111019144215.GA32007@S2100-06.ap.freescale.net>
References: <1318263578-7407-1-git-send-email-rnayak@ti.com>
	<1318263578-7407-4-git-send-email-rnayak@ti.com>
	<20111018132032.GD30703@S2100-06.ap.freescale.net>
	<4E9EB61C.1040207@ti.com>
	<20111019144215.GA32007@S2100-06.ap.freescale.net>
Message-ID: <4E9FAF42.5060200@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>
> I'm not sure why twl works in that way.  Is it a sign that those
> configuration peeked by twl regulator driver should be encoded in twl
> regulator driver itself instead of being passed from the board?  Or

No, the driver is just trying to make sure that nothing invalid (not
supported by hardware) gets passed from the boards.

> why the board does not pass something matching driver/hardware
> capability to save that peek?
>
>> or cases like the db8500 where
>> regulator_init_data for all regulators are bundled together and the
>> driver extracts and registers them as separate regulators.
>
> For this particular case, we just end up with having some duplicated
> constraints description in the dts file.  To me, it's not a problem.
>
>> Exporting an
>> api instead to extract regulator_init_data to the driver might help
>> in those cases.
>>
> IMO, these cases should be generalized to fit the common pattern of
> regulator drivers.
>
>>>
>>>> +{
>>>> +	struct regulator_init_data *init_data;
>>>> +
>>>> +	if (!dev->of_node)
>>>> +		return NULL;
>>>> +
>>>> +	init_data = devm_kzalloc(dev, sizeof(*init_data), GFP_KERNEL);
>>>> +	if (!init_data)
>>>> +		return NULL; /* Out of memory? */
>>>> +
>>>> +	of_get_regulation_constraints(dev->of_node,&init_data);
>>>
>>> Beside the 'dev' here with of_node attached, there will be another
>>> 'dev' created by regulator core function regulator_register(), which
>>> is wrapped by 'regulator_dev'.
>>>
>>> So we have two 'dev'.  One is created by DT core with of_node attached,
>>> and used to retrieve regulator_init_data from device tree.  Another one
>>> is created in regulator_register() and used by regulator core.
>>
>> But thats not something newly done now with DT. Thats how it was even
>> in the non-DT world. There were always two devices with the
>> regulator_dev device as the child.
>>
> Let's look at mc13892-regulator driver.  There are 23 regulators defined
> in array mc13892_regulators.  Needless to say, there is a dev behind
> mc13892-regulator driver.  And when getting probed, this driver will
> call regulator_register() to register those 23 regulators individually.
> That said, for non-dt world, we have 1 + 23 'dev' with that 1 as the
> parent of all other 23 'dev' (wrapped by regulator_dev).  But with the
> current DT implementation, we will have at least 1 + 23 * 2 'dev'.
> These extra 23 'dev' is totally new with DT.
>

but thats only because the mc13892-regulator driver is implemeted in
such a way that all the regulators on the platform are bundled in as
*one* device. It would again depend on how you would pass these from
the DT, if you indeed stick to the same way of bundling all regulators
as one device from DT, the mc13892-regulator probe would just get called
once and there would be one device associated, no?
