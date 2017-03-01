From: carlo@endlessm.com (Carlo Caione)
Date: Wed, 1 Mar 2017 18:09:29 +0100
Subject: [PATCH] hwmon: (scpi) Add slope and offset to SCP sensor readings
In-Reply-To: <87inntorz7.fsf@e105922-lin.cambridge.arm.com>
References: <20170301132028.25309-1-carlo@caione.org>
 <41f19cd3-5086-1da9-915a-8987cfc119f9@roeck-us.net>
 <CAL9uMOG5qEgyGTue=n7abbFROKGBpUrWDOPi5_bEDUWuiHEUKg@mail.gmail.com>
 <87inntorz7.fsf@e105922-lin.cambridge.arm.com>
Message-ID: <CAL9uMOHsKXpf01sw3NBJ8z=+9fOzW8E7meEg9r+YTJgxdsta7g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 1, 2017 at 5:57 PM, Punit Agrawal <punit.agrawal@arm.com> wrote:
> Carlo Caione <carlo@endlessm.com> writes:
>>> Are you saying that SCPI does not specify or provide the units to be used
>>> when reading values, and thus effectively just reports a more or less
>>> random number ?
>>
>> AFAICT the standard does not specify the units to be used for the
>> values or a way to get that information. For the Amlogic case the SCP
>> returns the value of the temperature in degree celsius and I'm not
>> sure how common is that.
>
> The standard does specify the units, but the way it is written seems to
> suggest that the units are part of the platform implementation rather
> than part of the standard [0].
>
> [0] http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.dui0922g/CABBCJGH.html

Oh, I missed that, odd indeed. Fantastic, one more non-compliancy.

>> [cut]
>>>> -       *temp = value;
>>>> +       slope = thermal_zone_get_slope(zone->z);
>>>> +       offset = thermal_zone_get_offset(zone->z);
>>>
>>>
>>> This is conceptually wrong. The functions return -ENODEV if thermal is
>>> disabled.
>>> While a negative slope does not make sense, a negative offset does.
>>
>> Yeah, but in that case we would have already failed to register the
>> thermal zone at all in devm_thermal_zone_of_sensor_register().
>>
>
> In addition to the thermal sub-subsystem, hwmon sysfs interface also
> expects temperature in millidegree Celsius. Ideally, any change should
> fix the reporting there as well. More below.

[cut]

> Another way to fix this would be to add optional properties to the scpi
> sensors binding and use them instead. This could then be used to fixup
> values reported to both thermal and hwmon.

Yeah, if we want to fix also the hwmon side probably it's the best solution.

Cheers,

-- 
Carlo Caione  |  +39.340.80.30.096  |  Endless
