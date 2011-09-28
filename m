From: b-cousson@ti.com (Cousson, Benoit)
Date: Wed, 28 Sep 2011 10:06:17 +0200
Subject: [PATCH 2/9] regulator: helper routine to extract
	regulator_init_data
In-Reply-To: <20110927150511.GM4289@opensource.wolfsonmicro.com>
References: <1317118372-17052-1-git-send-email-rnayak@ti.com>
	<1317118372-17052-3-git-send-email-rnayak@ti.com>
	<20110927121003.GB4289@opensource.wolfsonmicro.com>
	<4E81E224.2070408@ti.com>
	<20110927150511.GM4289@opensource.wolfsonmicro.com>
Message-ID: <4E82D579.3080503@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/27/2011 5:05 PM, Mark Brown wrote:
> On Tue, Sep 27, 2011 at 08:18:04PM +0530, Rajendra Nayak wrote:
>> On Tuesday 27 September 2011 05:40 PM, Mark Brown wrote:
>>> On Tue, Sep 27, 2011 at 03:42:45PM +0530, Rajendra Nayak wrote:
>
>>>> +	init_data = devm_kzalloc(dev, sizeof(struct regulator_init_data),
>>>> +						 GFP_KERNEL);
>>>> +	if (!init_data)
>>>> +		return NULL; /* Out of memory? */
>
>>> This means that the init data will be kept around for the entire
>>> lifetime of the device rather than being discarded.
>
>> Wasn't it the same while this was passed around as platform_data?
>
> It was in the past but I remember fixing it at some point.  Perhaps I'm
> imagining things.
>
>>>> +	init_data->supply_regulator = (char *)of_get_property(dev->of_node,
>>>> +						"regulator-supplies", NULL);
>
>>> I'd expect that in the device tree world the supply regulator would
>>> reference the node for that regulator.
>
>> You mean using phandles? Thats what Grant proposed too but
>> I thought you instead had an inclination towards names? Or maybe
>> I misunderstood.
>
> They need both.  We need to reference the device that provides the
> supply and use a name to say which of the potentially multiple supplies
> on the consumer device is which.
>
>>> Hrm, I think loosing the signs here is bad karma - negative voltages do
>>> exist after all.
>
>> Oops.. they do? didn't know about that.
>
> Yup, ground is just a reference point.

Yep, we do have a negative charge pump to generate -1.9v from 3.8v to 
supply the audio power amplifier part in twl6040 for example.

Benoit
