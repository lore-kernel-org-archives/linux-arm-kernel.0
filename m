From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 18 Feb 2016 15:22:29 +0100
Subject: [PATCH 2/2] ARM: dts: meson: Adding hwrev syscon node
In-Reply-To: <CAOQ7t2byFoW657-1xnsBpeyPkB6K25R=_pPmRDmT32Sjef=kUw@mail.gmail.com>
References: <1455730114-2547-1-git-send-email-romain.perier@gmail.com>
 <4158343.mkrTsd5B4G@wuerfel>
 <CAOQ7t2byFoW657-1xnsBpeyPkB6K25R=_pPmRDmT32Sjef=kUw@mail.gmail.com>
Message-ID: <4136837.fyWFbJqZfO@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 18 February 2016 15:14:45 Carlo Caione wrote:
> >
> > Yes, you should describe the device that is actually there, which would be
> > something like
> >
> >         cbus at c1100000 {
> >                 compatible = "amlogic,meson8b-cbus", "syscon";
> >                 reg = <0xc1100000 0x10000>; /* no idea what the length is, fix it */
> >         };
> >
> > Don't just make things up because you happen to access them in a particular
> > way, but try to stay as close as you can to describing the actual hardware.
> 
> Arnd,
> in the cbus region are mapped a lot of different devices, do you think
> that it is a good idea mapping the whole region as a single syscon
> device?

It really depends on what those other devices do with the registers:

If each device just uses a couple of random registers from the cbus,
they should probably all be changed to go through syscon.

However, if some or all of the other devices actually are entirely
made up of register ranges within cbus, that would indicate that
cbus itself is not just a collection of random registers but something
that could be considered a bus of itself in hardware, and then
we could represent the other devices as children of this bus.

Usually once you have a list of all the register locations, you can
identify the hardware structure to a certain degree from that, even
if you don't have access to a data sheet that would clarify this
better.

	Arnd
