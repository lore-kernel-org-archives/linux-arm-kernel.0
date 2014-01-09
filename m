From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 9 Jan 2014 12:21:34 +0100
Subject: [PATCH v4] ARM: prima2: move to generic reset controller driver
 framework
In-Reply-To: <CAGsJ_4x=SdqCjcCwFYFXy88z0xhWaDp2rE_HXOhRxs_7miireQ@mail.gmail.com>
References: <1389003878-10094-1-git-send-email-21cnbao@gmail.com>
 <201401071653.49964.arnd@arndb.de>
 <CAGsJ_4x=SdqCjcCwFYFXy88z0xhWaDp2rE_HXOhRxs_7miireQ@mail.gmail.com>
Message-ID: <201401091221.34496.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 09 January 2014, Barry Song wrote:
> 2014/1/7 Arnd Bergmann <arnd@arndb.de>:
> > On Tuesday 07 January 2014, Barry Song wrote:
> >> > Can't this be a regular platform device? Drivers that get the reference to
> >> > the reset controller should respect a -EPROBE_DEFER error message if they
> >> > get initialized in the wrong order.
> >>
> >> Arnd, it is ok if prima2 is not a platform for automotive. here prima2
> >> actually wants a "right" order for products.
> >> for example, there are some local hacking to move camera for rearview
> >> started earlier than other devices as this feature needs to be ready
> >> as early as possible.
> >> some earlier boot devices depend on reset module to be ready. so if we
> >> move to regular platform driver for upstream, it still requires some
> >> local hacking to move it earlier.
> >
> > I don't understand what you mean. It should be a matter of a few miliseconds
> > at most to retry initialization, more likely in the microseconds. How big
> > are the delays you are worried about?
> 
> what i am worrried about is 100ms or more. device drivers need time to
> initialize and that will take time, if some devices initialization
> happen before the deferred probing, the deferred probing might be
> delayed 100ms.
> for example, we want camera begin to show rear-view in several
> hundreds of ms, there are some local hacking to move i2c and camera
> probe earlier than other devices.
> that means actually there is requirement for right order of probing
> but not defer probing sometimes.

I see, this seems like a valid concern. I had not considered that other
drivers might need more time for initialization. In general of course
they should not, but I understand that hardware is not perfect and
some drivers you don't own may have bugs that cause unnecessary delays.

We have discussed probe ordering a lot of times on the mailing lists
and also during the last kernel summit, but those discussions are usually
focused on trying to correctly boot up a system, which is hard enough
even without additional requirements like yours.

Generally the hack that people use when things fail to work correctly
is to hijack an earlier initcall level, e.g. subsys_initcall rather
than using module_init. Please first see if that can solve your problem.
If it doesn't help, please resubmit your current patch with a detailed
description in the code on why you have to do it like this.

	Arnd
