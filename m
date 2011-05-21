From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Sat, 21 May 2011 22:35:12 +0400
Subject: PXA: Handling of UDC with no VBUS pins
In-Reply-To: <4DD6AF07.9060306@free.fr>
References: <20110518120633.GA9860@doriath.ww600.siemens.net>
	<4DD6AF07.9060306@free.fr>
Message-ID: <BANLkTi=Yjf3oopLLikbRQC4uBkmQgHdS2Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5/20/11, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
> On 05/18/2011 02:06 PM, Dmitry Eremin-Solenikov wrote:
>> Hello, colleagues,
>>
>> There are several PXA platforms which on the UDC tranceiver part have
>> a pullup pin to support connect/disconnect but no VBUS pin to detect
>> host presense. Currently such platforms are supported through udc driver
>> itself. I'd like to clean that part of pxa25x_udc/pxa27x_udc drivers and
>> to move gpio pullup handling to tranceiver.
> So, you want to concentrate USB pullup handling, right ?

Basically I'd like to cleanup this part of pxa udc drivers.

>> My question is what would be better: to extend gpio-vbus to work w/o
>> VBUS pin or to write new transceiver driver only handling gpio-pullup?
>
> My personnal feeling is neither, let them be. The generic pullup would
> have to ask itself :
>    - should the pullup be applied on D+ (on USB 2.0 and 3.0 devices) ?
>    - should the pullup be applied on D- (on USB 1.1 devices) ?

gpio-vbus driver doesn't do this. It simply handles D+ pullup. I think I'd
start with simple D+ pullup driver and the one may add D- functionality
if required.

> The common driver will have to handle the suspend/resume in an
> homogenous way.

Do pxa25x_udc/pxa27x_udc handle pullup during suspend/resume?

> If the gadget driver is removed, the pullup should be pulled low.
>
> All of this work for only 2 drivers looks overkill to me.

3 boards only from PXA. I don't know about other platforms/soc-families.

> And if you want to gather it in a driver, "gpio-vbus" purpose was to
> handle VBUS sensing, ie. power presence on +5V/Gnd lines. The D+
> handling was not part of its duties, and you'll probably end up with a
> new driver, which is ... overkill IMHO.

gpio-vbus handles D+ already (except suspend/resume).

-- 
With best wishes
Dmitry
