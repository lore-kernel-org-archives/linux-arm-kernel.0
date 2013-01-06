From: grinberg@compulab.co.il (Igor Grinberg)
Date: Sun, 06 Jan 2013 18:10:38 +0200
Subject: [PATCH v2] ARM: pxa27x: fix ac97 controller warm reset code
In-Reply-To: <87k3rqbedi.fsf@free.fr>
References: <1357223976-9097-1-git-send-email-mikedunn@newsguy.com>
 <50E67BAD.7070702@compulab.co.il> <50E6AF88.8050800@compulab.co.il>
 <87obh4it6n.fsf@free.fr> <50E92385.5020107@compulab.co.il>
 <87k3rqbedi.fsf@free.fr>
Message-ID: <50E9A1FE.2090907@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/06/13 16:00, Robert Jarzmik wrote:
> Igor Grinberg <grinberg@compulab.co.il> writes:
> 
>> On 01/04/13 22:34, Robert Jarzmik wrote:
>>> This is not the original behaviour before commit
>>> fb1bf8cd13bfa7ed0364ab0d82f717fc020d35f6.
>>>
>>> The original behaviour was :
>>>  - on = 1 => set GPIO as output GPIO, set to 1
>>>  - on = 0 => set GPIO to the alternate function ac97reset, driven by PXA2xx AC97
>>>  IP.
>>>
>>> If you don't set the alternate function, the GCR register usage for reset is
>>> useless, isn't it ? So why do you set the GPIO as "input" with on == 0 ?
>>
>> Well, I've made a quick patch for Mike to test if this works and
>> since it works I will submit a proper one.
> Mmm...
> 
>> To your question about setting the direction,
>> I'd like us to be on a safe side and not drive the pin if AF is not GPIO.
>> Although it should not meter and changing the AF to ac97reset should do the job,
>> but just to be on the safe side, as I think GPDR/GPCR/GPSR settings are preserved
>> even if you change the AF to something other than GPIO.
> 
> I think I was not clear enough.

Definitely...

> 
> My point is that if you program the GPIO as input, then the PXA will not drive
> the pin anymore.

Not exactly. The MFP will not be driven by the GPIO subsystem,
but it will be driven by the AC97 controller, as the for
GPIO95 - AF1 means AC97_nRESET and for GPIO113 - AF2 also means AC97_nRESET.
No problem here - it is driven as it used to be in the original code.


> If you have a resistor doing the "pullup", everything will work
> (as I assume is the case in your board). If not, the AC97 codec (wm9713 and
> co...) could have its reset line asserted (ie. #RESET line), and *this* bothers me.

That is what the original workaround did.
Should not bother you, instead, can you test it?

> 
> So changing the AC97 #RESET line to "GPIO input" is incorrect, and I don't agree
> with the patch.

It is not incorrect, it just does not have any effect. Please, test it.

-- 
Regards,
Igor.
