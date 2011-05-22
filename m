From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sun, 22 May 2011 10:51:54 +0200
Subject: PXA: Handling of UDC with no VBUS pins
In-Reply-To: <BANLkTi=Yjf3oopLLikbRQC4uBkmQgHdS2Q@mail.gmail.com>
References: <20110518120633.GA9860@doriath.ww600.siemens.net>	<4DD6AF07.9060306@free.fr>
	<BANLkTi=Yjf3oopLLikbRQC4uBkmQgHdS2Q@mail.gmail.com>
Message-ID: <4DD8CEAA.2010601@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/21/2011 08:35 PM, Dmitry Eremin-Solenikov wrote:
> My question is what would be better: to extend gpio-vbus to work w/o
>>> VBUS pin or to write new transceiver driver only handling gpio-pullup?
>> My personnal feeling is neither, let them be. The generic pullup would
>> have to ask itself :
>>     - should the pullup be applied on D+ (on USB 2.0 and 3.0 devices) ?
>>     - should the pullup be applied on D- (on USB 1.1 devices) ?
> gpio-vbus driver doesn't do this. It simply handles D+ pullup. I think I'd
> start with simple D+ pullup driver and the one may add D- functionality
> if required.
OK, as long as you don't touch the code in pxa27x_udc.c.
>> The common driver will have to handle the suspend/resume in an
>> homogenous way.
> Do pxa25x_udc/pxa27x_udc handle pullup during suspend/resume?
At least pxa27x_udc does, on suspend to RAM (you should look at 
pxa_udc_suspend()).
>> If the gadget driver is removed, the pullup should be pulled low.
>>
>> All of this work for only 2 drivers looks overkill to me.
> 3 boards only from PXA. I don't know about other platforms/soc-families.

One other point I've forgotten is that pxa27x_udc in its current state 
only supports gpio pullup/pulldown (ie. an external transciever handles 
D+ stimulation). But the PXA sillicon has an internal transciever which 
can be handled directly by pxa27x_udc (register UP2OCR).

Now, nobody uses it. If a board manufacturer is crazy enough to use it, 
the pullup can only be done from inside the pxa27x_udc driver (IO 
mappings driving).


I still think this driver is a bad idea. But if you wish to do it, go 
ahead. The only thing I'll block is removing the existing pullup code 
from pxa27x_udc.c.

Cheers.

--
Robert
