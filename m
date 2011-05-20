From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Fri, 20 May 2011 20:12:23 +0200
Subject: PXA: Handling of UDC with no VBUS pins
In-Reply-To: <20110518120633.GA9860@doriath.ww600.siemens.net>
References: <20110518120633.GA9860@doriath.ww600.siemens.net>
Message-ID: <4DD6AF07.9060306@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/18/2011 02:06 PM, Dmitry Eremin-Solenikov wrote:
> Hello, colleagues,
>
> There are several PXA platforms which on the UDC tranceiver part have
> a pullup pin to support connect/disconnect but no VBUS pin to detect
> host presense. Currently such platforms are supported through udc driver
> itself. I'd like to clean that part of pxa25x_udc/pxa27x_udc drivers and
> to move gpio pullup handling to tranceiver.
So, you want to concentrate USB pullup handling, right ?
> My question is what would be better: to extend gpio-vbus to work w/o
> VBUS pin or to write new transceiver driver only handling gpio-pullup?
My personnal feeling is neither, let them be. The generic pullup would 
have to ask itself :
   - should the pullup be applied on D+ (on USB 2.0 and 3.0 devices) ?
   - should the pullup be applied on D- (on USB 1.1 devices) ?
The common driver will have to handle the suspend/resume in an 
homogenous way.
If the gadget driver is removed, the pullup should be pulled low.

All of this work for only 2 drivers looks overkill to me.

And if you want to gather it in a driver, "gpio-vbus" purpose was to 
handle VBUS sensing, ie. power presence on +5V/Gnd lines. The D+ 
handling was not part of its duties, and you'll probably end up with a 
new driver, which is ... overkill IMHO.

Cheers.

--
Robert
