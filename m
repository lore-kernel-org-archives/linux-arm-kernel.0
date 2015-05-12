From: nm@ti.com (Nishanth Menon)
Date: Tue, 12 May 2015 14:14:19 -0500
Subject: [PATCH V4 1/3] OPP: Redefine bindings to overcome shortcomings
In-Reply-To: <20150512190134.16410.89041@quantum>
References: <20150505105714.GA22845@sirena.org.uk>
 <20150505171252.GI22845@sirena.org.uk>
 <CAKohpo=kJs076afzERPMqjELgwpN6nR2yoyEjW6XY7YSEbRuCA@mail.gmail.com>
 <20150507055231.GB32399@codeaurora.org>
 <20150507110233.GR15510@sirena.org.uk> <20150507211855.GA2455@codeaurora.org>
 <20150507221842.GW22845@sirena.org.uk>
 <CAKohpomU8wm0T=A7EkosdOjXbP8q2Cb726Hsjh08KTKYjoz3-A@mail.gmail.com>
 <555000B6.2010107@ti.com> <20150512052033.GC32300@linux>
 <20150512190134.16410.89041@quantum>
Message-ID: <5552510B.9010306@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mike,
On 05/12/2015 02:01 PM, Michael Turquette wrote:
> Quoting Viresh Kumar (2015-05-11 22:20:33)
>> On 10-05-15, 20:07, Nishanth Menon wrote:
>>> just one minor concern being in the SoC end of the world :). In most
>>> times, the current consumption for a specific OPP varies depending on
>>> the specific location in the process node the die is -> this is even
>>> true among a single lot of wafers as well. some SoC vendors use hot,
>>> nominal and cold terminology to indicate the characteristics of the
>>> specific sample.
>>>
>>> it might help state which sample end of the spectrum we are talking
>>> about here. reason being: if I put in values based on my board
>>> measurement, the results may not be similar to what someone else's
>>> sample be. Depending on technology, speed binning strategy used by the
>>> vendor, temperature and few other characteristics, these numbers could
>>> be widely divergent.
>>
>> I don't have any clue about this.. :(
>>
>> @Mark/stephen: Any inputs ?
> 
> I do not think the idea of the mA property is to perfectly model current
> consumption at a given opp. Instead it is a nominal value that may be
> useful, e.g. for configuring a regulator in Stephen's case.
> 
> The TWLxxxx series of PMICs from TI have configurable SMPS which could
> possibly benefit from this info as well. Most of the time those are left
> in an "automatic mode", but there are manual programming steps to
> achieve higher efficiencies and this property could potentially help you
> do that.

While TWLxx series was kind of nascent in it's ability of choosing
PWM/PFM or auto mode depending on the current targets, newer PMICs
have their own unique techniques -> but, that said, this is a
description of power consumption for a given OPP for the "device", How
would stephen's case work with a PMIC and 2 devices which have
different leakage characteristics (based on which end of the process
spectrum they come from), Lets take an example:
device X consumes 800mA for OPPx
device Y consumes 900mA for OPPy

Taking the simpler example of TWLxxx, the PMIC switches to PWM mode at
850mA for efficiency reasons, below 850mA, it is better to operate for
accuracy and efficiency reasons at PFM mode.

by putting 800mA we break efficiency on device Y, and if we choose to
put 900mA or 850mA, we break efficiency on device X.

It is a lot more impactful than using relative numbers for other
purposes - for example energy aware scheduling as an example -> here
the actuals might have better optimization, but hints of relative
power numbers by itself is pretty powerful information to help
scheduling. The usage, in this case, unlike the usage for a PMIC
efficiency selection, is not based on absolutes and is meant more of a
hint (closer to usage such as clock transition latency numbers).

This is the reason I suggested to have a clear guidance in the
bindings, since we'd very much like bindings to be ABI.

-- 
Regards,
Nishanth Menon
