From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 14 Feb 2013 09:52:41 +0100
Subject: Getting your opinion about the best place to put one specific
 device driver...
In-Reply-To: <201302131104.01793.arnd@arndb.de>
References: <511A0F11.1050608@stericsson.com>
 <201302121741.31494.arnd@arndb.de>
 <511B59E2.5060402@stericsson.com>
 <201302131104.01793.arnd@arndb.de>
Message-ID: <CACRpkdbGLoXY=g_pkF42FZgH+8yRUnKafvMmab_gwqDhYpE69A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 13, 2013 at 12:04 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 13 February 2013, Jean-Nicolas GRAUX wrote:
>> Le 02/12/2013 06:41 PM, Arnd Bergmann a ?crit :
>> > On Tuesday 12 February 2013, Jean-Nicolas GRAUX wrote:
>> > If a more dynamic user interface is needed, I think it would be good
>> > to have a generic mechanism in the pinctrl subsystem to reroute pins
>> > like these, which can work for all pins in the system (or at least
>> > those that have not been claimed by another device). I don't know if
>> > that interface already exists, but Linus would be the right person
>> > to answer that.
>>
>> I think i have one colleague that recently made a patch for that purpose.
>> But i believe this is still in progress. It consists in improving the
>> pinctrl
>> debugfs interface to be able to manually change the pin muxing and
>> the gpio configuration for debug/testing purpose.
>
> Sounds good to me. Peter, Tony, do you think that would be a good enough
> interface for other platforms as well?

We're talking about this:
http://marc.info/?l=linux-kernel&m=136052713530502&w=2

We're discussing it right now but Stephen Warren has some
valid concerns so I'm pondering the right way forward.

However that patch is about pin configuration, which is
dealing with an opaque unsigned long. This usecase would
be a debugfs interface to set up muxing and a totally different
piece of code in drivers/pinctrl/pinmux.c. But I think it's
a good idea!

Traditionally, hardware observation and stuff like this has been
kept out of the mainline kernel, and the fact that we're getting to
it now is due to the fact that all the basic stuff is already quite
nicely lined up. So it's basically a good sign.

>> > If there is a generic way to configure pinmux from user space, you
>> > can essentially move this driver into an application running outside
>> > of the kernel.
>> >
>> The matter is that this hwobs driver do more than just changing
>> the muxing of one pin group in the digital baseband.
>> It also control some specific registers to configure the hwobs IP.
>> More in details, for each of the 18 external IOs, it is possible to
>> select one observer mode among several. We also provide some
>> facility for the user to easily detect the pin to monitor on the
>> output connector.
>
> Hmm, I wonder if that is something that makes sense to have
> in a generic pinctrl debugfs interface. Maybe it can instead
> be part of the new pinctrl driver for this hw block then, which
> should be able to create additional sysfs files in the pinctrl
> debugfs directories. Linus, does that make sense to you?

That is one way to achieve it, like this driver spawns some
custom debugfs entries, fine.

The hardware observer already use the pinctrl interfaces from
pinctrl-nomadik.c to set up the pins per se: i.e. to set up so
that these pins are available to put signals on. But then we
can plug this stuff as a front-end, and yeah.
drivers/pinctrl/ux500-hwobs.c might be a good idea!

Yours,
Linus Walleij
