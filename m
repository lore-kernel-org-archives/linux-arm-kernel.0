From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Sat, 18 May 2013 22:50:40 +0200
Subject: [RFC 4/4] DRM: tda998x: add missing include
In-Reply-To: <20130518202604.GM18614@n2100.arm.linux.org.uk>
References: <20130516192510.GV18614@n2100.arm.linux.org.uk>
 <1368897139-25485-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1368897139-25485-5-git-send-email-sebastian.hesselbarth@gmail.com>
 <20130518194644.2a02a4fc@armhf>
 <CAF6AEGtx7RbvKEEc5uSFvz-2uveB1cnJNf_ESn6JYhfte5UmZQ@mail.gmail.com>
 <20130518205845.2dfe9fe5@armhf> <5197D6C1.3060702@gmail.com>
 <20130518202604.GM18614@n2100.arm.linux.org.uk>
Message-ID: <5197E9A0.1020607@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/18/2013 10:26 PM, Russell King - ARM Linux wrote:
> On Sat, May 18, 2013 at 09:30:09PM +0200, Sebastian Hesselbarth wrote:
>> The device for tda998x yes, but not the driver. Anyway, Russel decided
>> to have tda998x probed by his drm_driver.
>
> For the simple reason that _that_ is how DRM slave encoders work.
> Sometimes, reading the code of the subsystem you're using is well
> worth the effort.

I agree and add that the probing itself doesn't prevent you from using
DT for tda driver at all. You can still have an marvell,external-slave
property pointing to the phandle of tda node. With that you get the
adapter and i2c slave address for what is currently called
dove_tda19989.c and may become e.g. dove_ext_i2c.c. In tda998x_drv you
find the node and get all properties for input config or interrupt
gpio.

I have done that in the drivers before, but DT node parsing here is
_added_ to the driver as it can be used on other non-DT platforms as
well.

>> The connection of Dove LCD and tda998x is _not_ Cubox specific, it is
>> also on the D2Plug. To be precise, even "Dove LCD" is not Dove specific
>> as you can find the very same controller on other Marvell SoCs with
>> little differences.
>
> Well, to spoil the argument a little, actually, the interconnection
> between the two is in no way "standardized".  There's many different
> ways to wire the two chips together and have it work - because the
> TDA998x chips have a set of input muxes and swaps which allow you to
> connect the red, green, blue high/low nibbles in various ways and
> still have a correctly working system.  The TDA998x connectivity is
> _highly_ configuable.
>
> So, just because one board connects LCD_D0 (red bit 0) to a particular
> pin on the TDA998x does not mean that another board does it that way
> too.
>
> So Jean-Francois is quite correct that this data needs to be provided
> by the board in some manner.  The question is - how to do that sensibly.
>
> One possible stop-gap solution is to provide a default set which just
> happens to match the cubox, and allow OF to override it. :)

While I agree, Rob may have a different view on that for tda998x ;)

>> There is so much to take care of like pixel format on lcd pins driving
>> an external encoder (_not_ only tda998x), what gpio pin is connected to
>> TDA interrupt line, one or two lcds, ...
>
> Luckily, drivers/gpu/drm/i2c/tda998x.c does not make use of the IRQ
> signal at present - it's fairly basic and it currently operates by
> polling.  Eventually, this could change of course. :)

Again, that is in the driver Jean-Francois has available. Make sure irq
handler runs in a separate thread from get_edid and hpd and you will
be interrupted on hpd. Having said, that should finally lead to the
slave encoder setting .connector_type and .polled as this is where you
know it.

Sebastian
