From: ext-heikki.krogerus@nokia.com (Heikki Krogerus)
Date: Wed, 18 Aug 2010 12:49:39 +0300
Subject: [PATCH 3/3] usb/otg/ulpi: extend the generic ulpi driver.
In-Reply-To: <4C6AB605.1050305@compulab.co.il>
References: <1279198816-30367-1-git-send-email-grinberg@compulab.co.il>
	<1279198816-30367-4-git-send-email-grinberg@compulab.co.il>
	<20100813132717.GA6986@as23.pp.htv.fi>
	<4C679772.3090802@compulab.co.il>
	<20100816093724.GA2916@esdhcp041123.research.nokia.com>
	<4C6AB605.1050305@compulab.co.il>
Message-ID: <20100818094939.GB9876@esdhcp041123.research.nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 17, 2010 at 06:17:09PM +0200, ext Igor Grinberg wrote:
>On 08/16/10 12:37, Heikki Krogerus wrote:
>> OK, I get your idea now with the flags now. Should have read the code
>> more carefully. I'm not sure if it's the right way though, but if you
>> can show that they are beneficial in more then one case, then I'm sure
>> there is no problem with them.
> 
> Indeed, this can be not the best way, but at least it is better then letting
> everyone around access the ulpi defined registers in a way they like.
> There is a ulpi standard and kernel should provide a framework/driver
> that follows the standard (at least for the ulpi defined registers).
> 
>>  Please consider the following.
>>
>> It seems that many ulpi transceivers are autonomous as they say.
>> There is little if any need to access ulpi registers expect the
>> vendor specific ones. The vendor specific stuff will require register
>> access in any case and in some cases they need the transceivers to be
>> programmed in a specific way. Right now to me using the flags for the
>> common parts and then separately programming the vendor specific stuff
>> does not seem very efficient. 
> 
> Well, vendor specific registers are very important issue.
> This is how I see it:
> 
> platform core   <-------wired-------->   ulpi    phy
>       /                                 /           \
>      /                     ulpi generic regs  |  vendor specific regs
>     /                                 /               \
> ulpi access ops <-----> ulpi generic driver <---> ulpi phy specific driver(s)
>                           /           \
>                   otg framework        \
>                           \            /
>                  usb subsystems e.g. musb, ehci...
> 
> 
> If the ulpi transceiver is autonomous and platform does not need to
> do any setup of the transceiver, then I think you don't need to
> access the transceiver in any way, just setup the platform core,
> which can be done in platform specific code.
> 
> If there is a need to access the ulpi transceiver, then it should be done
> by using the ulpi driver. ulpi transceiver usually is a chip, so if it needs
> to be setup, then it deserves a driver, I think.
> 
> Anyway, we need a good generic ulpi driver, which will provide some
> kind of interface for the ulpi specific drivers that are aware of the
> vendor specific registers and setup. This interface should make the
> task of developing ulpi specific driver easy.

I'm totally _not_ against a generic ulpi driver, and see it can be
something very useful.

> The driver does not have to end up with flags. The intension of those
> flags is to give a start for something bigger... otherwise people will
> continue to setup the hardware specific stuff in the generic drivers
> (like the recent ulpi phy reset code in omap-ehci glue) instead of
> contributing to the ulpi driver, so other platforms could reuse it.

Unfortunately this is not generating enough interest in people. I
guess this is one of those cases where people prefer to wait for
someone else to make the ulpi driver more mature instead of
contributing themselves, and in the meantime, hack their existing or
new driver (like me) :(. Someone simply needs to put effort in
developing it, but as I understood, you are too busy at the moment,
and so am I.

>> I need to re-send the charger driver for isp170x. These transceivers
>> are fairly commonly used with musb, and most platform probable only
>> need nop-usb-xceiv.c with them. However, the charger detection needs
>> access to the common ulpi registers as well as the vendor specific
>> ones. If you see that you can make this kind of functions work with
>> the flags, then I'm OK with them. 
> 
> Is this series (part of it) you need to resend:
> http://www.spinics.net/lists/linux-usb/msg29643.html
> 
> isp1704_test_ulpi() - can be done fully by the generic ulpi driver,
> in fact it is already reads the id. May be we should think of a way to export
> it, so drivers like this one can do the matching.

Yes it would make sense for now.

> isp1704_charger_detect() - isp170x specific ulpi registers accesses.
> 
> isp1704_charger_verify() - I don't fully understand the purpose of this,
> I see the reset (can be done by the generic driver) and then some
> ulpi generic and specific accesses to the transceiver.
> I think it can be handled by the ulpi generic and specific driver
> and with help of the flags.

This transceiver is a bit difficult as RX51 platform uses it as it's
second transceiver. So the primary transceiver provides the struct
otg_transceiver, and from software's point of view only charger
detection is done with isp170x, so I was unable to take advantage of
the ulpi driver.

This kind of oddities make things even more complicated. The otg
framework is not suited for multiple transceivers (maybe it newer
will), but the platform needs to be considered in any case :(.

Unfortunately I have to send the driver as it is, and can't spend any
time with it right now. I need to put more though into this at one
point.

br,
-- 
heikki
