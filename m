From: hns@goldelico.com (Dr. H. Nikolaus Schaller)
Date: Wed, 1 Apr 2015 10:18:05 +0200
Subject: [PATCH v4 3/6] Documentation: DT: Document twl4030-madc-battery
 bindings
In-Reply-To: <20150331072643.GB30788@amd>
References: <1426022847-30912-1-git-send-email-marek@goldelico.com>
 <1426022847-30912-4-git-send-email-marek@goldelico.com>
 <20150311152414.GX5264@atomide.com>
 <844740CD-C95B-4411-A2C8-4906F58DBEE8@goldelico.com>
 <20150311164442.GA5264@atomide.com> <20150331072643.GB30788@amd>
Message-ID: <BC5A7447-CAD7-4CCE-8F08-8CEFBB5C6905@goldelico.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pavel,

Am 31.03.2015 um 09:26 schrieb Pavel Machek <pavel@ucw.cz>:

> Hi!
> 
>>>>> +		io-channels = <&twl_madc 1>,
>>>>> +	                      <&twl_madc 10>,
>>>>> +			      <&twl_madc 12>;
>>>>> +		io-channel-names = "temp",
>>>>> +		                   "ichg",
>>>>> +		                   "vbat";
>>>>> +	};
>>>> 
>>>> Rather than just making platform_data into device tree properties..
>>>> 
>>>> Can't you hide the these custom properties behind the compatible flag?
>>>> 
>>>> You can initialize that data in the driver based on the compatible
>>>> flag and the match data.
>>>> 
>>>> This makes sense if you can group things to similar configurations.
>>> 
>>> Maybe I have not completely understood your proposal.
>>> 
>>> Do you mean to go back to have big parameter tables for each device/battery
>>> combination in the driver code and the compatible flag (e.g. compatible = ?board17?)
>>> chooses the right data set for the charging map and channels?
>> 
>> If you can somehow group them, then yes. Not for every board if there
>> are many of them naturally.
>> 
>>> I thought this is what the DT was introduced for - to have the same driver 
>>> code but adapt to different boards depending on hardware variations.
>> 
>> Yeah but you also need to consider the issues related to introducing
>> new device tree properties. The device tree properties introduced
>> should be generic where possible.
>> 
>>> And batteries have very different characteristics and vary between devices?
>> 
>> Right. Maybe that has been already agreed on to use capacity-uah for
>> batteries in general? In that case I have not problem with that as
>> it's a generic property :)
>> 
>>> The charging maps are depending on the battery type connected to the twl4030
>>> and which madc channel is which value is also a little hardware dependent
>>> (although the twl4030 doesn?t give much choice).
>> 
>> Just to consider alternatives before introducing driver specific
>> property for the maps.. Maybe here you could have few different type
>> of maps and select something safe by default? Of course it could be this
>> is higly board specific, I think some devices may be able to run below
>> 3.3V for example..
> 
> As I explained in some other mail, those tables should not be
> neccessary at all. They can be computed from li-ion characteristics
> and internal resistance, and assumed current during charge and
> discharge.

I already explained that we do not know the charging and discharging
current well enough for such a calculation.

And I explained that the ?internal resistance? is a system (battery + cables +
connectors + other circuits) parameter that is not easy to derive or measure
and type into the .dts source code.

At least I have no idea how I should find it out for my boards. While I can
easily determine the curves (and we already have them for the platform_data
driver).

Please propose your own code doing that so that we can test if it is
better.

> 
> Running below 3.3V.. not really. At that point, the battery is really
> _empty_, and voltage is going down really really fast.

It is the diffference between 2% and 0% where a fuel indication might
be most important?

> 
> Plus, you are damaging the battery at that point.

The power controller will shut down - but the driver should report
reasonable (but IMHO not necessarily perfect) values until the last
moment.

BR,
Nikolaus
