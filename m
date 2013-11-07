From: neko@bakuhatsu.net (Matt Sealey)
Date: Thu, 7 Nov 2013 10:58:19 -0600
Subject: [PATCH v7] pinctrl: imx27: imx27 pincontrol driver
In-Reply-To: <20131107103859.GI15098@pengutronix.de>
References: <1382950843-26066-3-git-send-email-mpa@pengutronix.de>
 <1383057139-25304-1-git-send-email-mpa@pengutronix.de>
 <CACRpkdYKgA5E4-APSTHsM=zVbb3X2R4v+V4EeK3+W1tKPR1FeA@mail.gmail.com>
 <CAHCPf3v3dsTyk9Cd93GBLBKQLSQ+Mb0mpq134X7Ko4U8m-b-qg@mail.gmail.com>
 <20131107091212.GH15098@pengutronix.de>
 <1383816481.4115.2.camel@weser.hi.pengutronix.de>
 <20131107103859.GI15098@pengutronix.de>
Message-ID: <CAHCPf3uHy+u5ssRU1yk9TnYEtNZSRUkeLzXOp=__PGKVGQWW3Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 7, 2013 at 4:38 AM, Markus Pargmann <mpa@pengutronix.de> wrote:
> On Thu, Nov 07, 2013 at 10:28:01AM +0100, Lucas Stach wrote:
>> Am Donnerstag, den 07.11.2013, 10:12 +0100 schrieb Markus Pargmann:
>> > On Wed, Nov 06, 2013 at 10:54:02AM -0600, Matt Sealey wrote:
>> [...]
>> > >
>> > > Would it be so bad to implement this as a regmap and have two drivers
>> > > access the same regmap on the Linux side? You don't need two nodes for
>> > > that, and the IOMUX definitions can live under the GPIO node. There is
>> > > NOTHING stopping two drivers on Linux matching the same compatible
>> > > property. Locking and coordination in software of a single IP block
>> > > used by two drivers shouldn't be arbitrated by the device tree.
>> >
>> > I am not sure if it is practical to use the GPIO nodes for the IOMUX
>> > driver. There are actually 6 GPIO nodes. This would lead to 6
>> > iomux controllers? The different pin functions may be distributed over
>> > different controllers then.
>> >
>> > The first version of this series [1] was designed to have a iomux node
>> > with 6 gpio subnodes.
>>
>> Why was this changed? Having two different DT nodes requesting the same
>> IO region is certainly the wrong thing to do.
>
> It was suggested to map the same memory range from both drivers, so I
> changed the layout completely. Perhaps it would have been better to keep
> the DT node structure while not passing the memory to the gpio
> subdevices.

Mapping the same memory range is a function of the driver, NOT the
device tree. The DT should match the reality of the hardware, not try
and copy the internal driver structure. I am not sure if 6 independent
GPIO ports makes sense vs. 1 single all-encompassing GPIO node.. I
don't think it affects defining GPIO or mux configuration adversely
either way.

The docs for the memory map are there's one GPIO controller, with a
bank of registers from 0x10015000 to 0x10015FFF (4KiB). Internally it
may be 6 instantiations of the same IP block inside some fabric
wrapper, but the docs don't make any assertions to this effect except
by definition of the registers (in fact, the registers are documented
once, and the locations of each port register are documented within
the block).

I would suggest just one GPIO block, which contains all the pinctrl
definitions (refering to port, pin, mux, etc. and not just pin, mux)
and the GPIO binding gets modified to specify not only the pin number
but the port as well, in the same way, so that the driver can
calculate which register offset inside the controller it uses.

That's a bit of a driver rewrite to achieve, but it'd be worth it to
preserve the design details of the hardware and letting the drivers do
the work they should be doing instead of shunting the details into the
DT unecessarily.

Matt Sealey <neko@bakuhatsu.net>
