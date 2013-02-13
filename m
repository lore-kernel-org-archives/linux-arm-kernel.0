From: jean-nicolas.graux@stericsson.com (Jean-Nicolas GRAUX)
Date: Wed, 13 Feb 2013 10:16:18 +0100
Subject: Getting your opinion about the best place to put one specific
 device driver...
In-Reply-To: <201302121741.31494.arnd@arndb.de>
References: <511A0F11.1050608@stericsson.com>
 <201302121454.10231.arnd@arndb.de> <511A6D1E.50705@stericsson.com>
 <201302121741.31494.arnd@arndb.de>
Message-ID: <511B59E2.5060402@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 02/12/2013 06:41 PM, Arnd Bergmann a ?crit :
> On Tuesday 12 February 2013, Jean-Nicolas GRAUX wrote:
>> Le 02/12/2013 03:54 PM, Arnd Bergmann a ?crit :
>>> On Tuesday 12 February 2013, Jean-Nicolas GRAUX wrote:
>>> I think I need some more information to understand what that interface
>>> you are driving is actually about, since that is not clear from your
>>> description or from reading the source code.
>>>
>>> Why are there exactly 18 wires?
>> As you can imagine, this module is very specific to the ux500 digital
>> baseband family.
>> So, ux500 SoCs simply provide 18 external IOs that may be used to
>> observe some critical hardware signals.
>> Depending on what has been configured in the hwobs control registers, we
>> are able to observe
>> signals from the modem, the ddr controllers, the prcmu, the gfx ip, the
>> clock tree, ...
> Ah, so these are signals that are internal to the SoC and that normally
> don't need to get routed to a pad unless you want to monitor them, right?
Yes.
>>> What is the protocol that is used on these wires (i2c, spi, rs232, ...)
>> There is no specific devices connected behind those wires. So, no
>> protocol used.
>> Usually, once the required configuration has been set thanks to the
>> debugfs interface,
>> we directly monitor the signals by connecting the wires to a
>> oscilloscope or a digital analyser...
> Ok.
>
>>> Why do you actually need run-time configuration in the kernel?
>> Main aim of this driver is just to provide a user interface to
>> configure/enable the hardware observer
>> so that we may easily select the required signals to observe. Having
>> that at run time is mandatory for us.
>> This is mainly used by software/hardware teams to debug and verify
>> modem/ape power states.
> Ok, I see.
>
>>> It does look however like this code is related to the PRCMU, so maybe
>>> it should be part of the prcmu driver rather than a separate device?
>> It is true that the hardware observer registers are located in the
>> "PRCM" unit.
>> But to my mind, it has no real link with the dbx500-prcmu driver itself yet.
>> (dbx500-prcmu driver is dedicated to the handling of the communication
>> between the kernel and the firmware that run inside PRCMU xp70 controller.)
>> Moreover, I think we should keep a separate device for the harware observer
>> since it need to acquire its own pinctrl state.
>> That said, we might consider moving it to the mfd folder ?
>>
>> To be honest, in my initial patch, i was aiming to put the ux500_hwobs.*
>> files in the "misc" folder.
>> But Linus told me that this was probably not the good place ;)
> Correct, I try my best to avoid adding random stuff in there that might
> need a generic interface later. Tony already pointed out the similarity
> to the OMAP specific hwopbs feature, and whatever user interface we
> introduce for one should be generic enough to work on the other one as
> well, and ideally also on future ones to the degree that we can anticipate
> them today.
>
> I like the idea of making the in-kernel configuration part of this a
> pinctrl driver, which would already allow you to configure it through
> a custom device tree and no user interface at all.
Yes, that would be nice for sure.
> If a more dynamic user interface is needed, I think it would be good
> to have a generic mechanism in the pinctrl subsystem to reroute pins
> like these, which can work for all pins in the system (or at least
> those that have not been claimed by another device). I don't know if
> that interface already exists, but Linus would be the right person
> to answer that.
I think i have one colleague that recently made a patch for that purpose.
But i believe this is still in progress. It consists in improving the 
pinctrl
debugfs interface to be able to manually change the pin muxing and
the gpio configuration for debug/testing purpose.
> If there is a generic way to configure pinmux from user space, you
> can essentially move this driver into an application running outside
> of the kernel.
>
> 	Arnd
The matter is that this hwobs driver do more than just changing
the muxing of one pin group in the digital baseband.
It also control some specific registers to configure the hwobs IP.
More in details, for each of the 18 external IOs, it is possible to
select one observer mode among several. We also provide some
facility for the user to easily detect the pin to monitor on the
output connector.

Anyway, maybe this could be handled in one dedicated pinctrl
driver as suggested by Tony.

Thank you for your advises.
Jean-Nicolas.
