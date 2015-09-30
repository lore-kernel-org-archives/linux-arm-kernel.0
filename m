From: punit.agrawal@arm.com (Punit Agrawal)
Date: Wed, 30 Sep 2015 12:07:04 +0100
Subject: [PATCH 2/3] thermal: Add Mediatek thermal controller support
In-Reply-To: <20150930103704.GA7858@pengutronix.de> (Sascha Hauer's message of
 "Wed, 30 Sep 2015 12:37:04 +0200")
References: <1443015463-23639-1-git-send-email-s.hauer@pengutronix.de>
 <1443015463-23639-3-git-send-email-s.hauer@pengutronix.de>
 <9hhpp105jw1.fsf@e105922-lin.cambridge.arm.com>
 <20150930103704.GA7858@pengutronix.de>
Message-ID: <9hha8s45fon.fsf@e105922-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sascha Hauer <s.hauer@pengutronix.de> writes:

> Hi Punit,
>
> On Wed, Sep 30, 2015 at 10:36:14AM +0100, Punit Agrawal wrote:
>> Hi Sascha,
>> 
>> Re-posting a comment from v7. Perhaps you missed it...
>
> Uh, sorry. In fact I didn't miss it and I thought I have answered it.
> Appearantly I haven't.
>
>> > +	struct mtk_thermal *mt = bank->mt;
>> > +	int temp, i, max;
>> > +	u32 raw;
>> > +
>> > +	temp = max = INT_MIN;
>> > +
>> > +	for (i = 0; i < bank_data[bank->id].num_sensors; i++) {
>> > +		raw = readl(mt->thermal_base + sensing_points[i].msr);
>> > +
>> > +		temp = raw_to_mcelsius(mt, raw);
>> > +
>> > +		/*
>> > +		 * The first read of a sensor often contains very high bogus
>> > +		 * temperature value. Filter these out so that the system does
>> > +		 * not immediately shut down.
>> > +		 */
>> > +		if (temp > 200000)
>> > +			temp = 0;
>> > +
>> 
>> If the bogus value is only the first time the sensor is read, instead of
>> filtering here, you could call mtk_thermal_bank_temperature at probe
>> time when you are initialising the banks and ignore the returned value.
>
> It seems that after initialization the hardware needs some time to
> settle before correct values can be read. Doing what you suggest would
> mean we have to delay the boot by several 100ms. I'd rather not do that.

Fair enough. Thanks for clarifying.

>
> Sascha
