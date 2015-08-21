From: petr.cvek@tul.cz (Petr Cvek)
Date: Sat, 22 Aug 2015 00:09:10 +0200
Subject: [PATCH v2 09/21] ARM: pxa: magician: Add OV9640 camera support
In-Reply-To: <874mjs5yt2.fsf@belgarion.home>
References: <cover.1439843482.git.petr.cvek@tul.cz>
 <2889798.x6xcIzdYMU@wuerfel> <55D65722.9030508@tul.cz>
 <1634812.ZDaECJ9ClW@wuerfel> <874mjs5yt2.fsf@belgarion.home>
Message-ID: <55D7A186.4000505@tul.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne 21.8.2015 v 19:36 Robert Jarzmik napsal(a):
> I shrunk a bit the mailing list.
> 
> Arnd Bergmann <arnd@arndb.de> writes:
> 
>> On Friday 21 August 2015 00:39:30 Petr Cvek wrote:
>>> Dne 20.8.2015 v 22:26 Arnd Bergmann napsal(a):
>>>> On Thursday 20 August 2015 21:48:20 Robert Jarzmik wrote:
>>>>> Petr Cvek <petr.cvek@tul.cz> writes:
>>> Datasheet says:
>>>
>>>         tS:RESET        Setting time after software/hardware reset      1 ms
>>>
>>> So at least one ~1 ms should be left there. Are msleep less than 20ms valid? 
>>>
>>> (checkpatch: msleep < 20ms  can sleep for up to 20ms)
>>
>> On most kernels, an msleep(1) will sleep somewhere between 1 and 3 milliseconds
>> (but could be much longer), while an mdelay(1) tries to sleep around one
>> millisecond, more or less.
> 
> I have rethought of that a bit more. I'm convinced a delay of "at least 1ms" is
> necessary according to the specification, it can also be more.
> 
> Moreover, I came to the conclusion this reset sequence is not something that is
> "magician" specific (see palmz72_camera_reset() in
> .../mach-pxa/palmz72.c). Actually it's not even mach-pxa specific, it's "ov9640"
> specific.
> 
> Now add this to the fact that it would be good to have a solution working for
> devicetree as well, and on any board, and the conclusion I came to was that this
> handling deserves to be in ov9640 driver (please correct me if I'm wrong).
> 
> The idea behind it is have the reset handled in ov9640, and the gpio provided by
> platform data or devicetree.
> 
> So Guennadi, is it possible to add a gpio through platform data to ov9640
> driver, does it make sense, and would you accept to have the reset handled there
> ? And if yes, would you, Petr, accept to revamp your patch to have the reset and
> power handled in ov9640 ?
> 

OK, why not, so power and reset gpio with polarity settings?

> Please note that it is a proposal, I'm not forcing anybody, I'd like to choose a
> path that agrees with the future push to remove as many machine files as possible.

Anyway I'm planning to send patch for OV9640 in future too (color correction matrix is not complete and some registers too).

> 
> Cheers.
> 
