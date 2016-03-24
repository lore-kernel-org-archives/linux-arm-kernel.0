From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 24 Mar 2016 21:07:32 +0100
Subject: [PATCH v2] spi: orion.c: Add direct access mode
In-Reply-To: <56F42939.4020803@denx.de>
References: <1458663893-13766-1-git-send-email-sr@denx.de>
 <30176583.aSTyzO0qS3@wuerfel> <56F42939.4020803@denx.de>
Message-ID: <12540712.SXPhdxqg9f@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 24 March 2016 18:51:53 Stefan Roese wrote:
> On 24.03.2016 17:48, Arnd Bergmann wrote:
> > On Thursday 24 March 2016 17:15:49 Stefan Roese wrote:
> >>>
> >>>        soc@ {
> >>>                spi0 {
> >>>                          compatible = "marvell,armada-370-spi",
> >>>                                       "marvell,orion-spi";
> >>>                        reg = <MBUS_ID(0xf0, 0x01) 0x10600 0x28>,
> >>>                              <MBUS_ID(0x01, 0x5e) 0 0x100000>;
> >>>                          #address-cells = <1>;
> >>>                          #size-cells = <0>;
> >>>                          pinctrl-0 = <&spi0_pins1>;
> >>>                          pinctrl-names = "default";
> >>>                          cell-index = <0>;
> >>>                          interrupts = <30>;
> >>>                          clocks = <&coreclk 0>;
> >>>                          status = "disabled";
> >>>                };
> >>>        };
> >>
> >> Do I understand this correctly, that you suggest to list all MBus
> >> windows here, that the SoC supports (e.g. 8 for the Armada XP).
> >> And let the SPI driver then extract and dynamically enable (map)
> >> the one that is currently used?
> >
> > Actually the syntax above doesn't imply any mapping at all, it
> > just describes how the hardware is wired up, so that really
> > needs to list all windows, and then the ranges property in the
> > soc node can statically map the ones that are used on the
> > particular machine.
> 
> I see. But with this we are back to statically mapping the MBus
> windows that are used. Resulting in potentially multiple windows
> per SPI controller, which is not necessary (Andrew and Mark
> objected against that).

I'm not following here. Do you mean we should set up and tear
down the windows in the runtime PM callbacks so they are only
present when we actually access a device instead?

If a controller has multiple high-speed devices connected to
it, and we want them all to use the direct mapping, it doesn't
seem overly wasteful to have one mbus window per device, but
doing the dynamic switching doesn't seem wrong either.

Among the dts files we ship with the kernel, how many would
actually use more than one mapping in practice if we decide to
do the static ranges property? I had a quick look and could not
even find one that has more than one chip-select connected.

> > Alternatively, we might encode this in the 'reg' property in
> > some way?
> >
> > How do we know whether a device supports the mode or not?
> 
> Currently, only a very limited number of SPI devices will support
> it. As its really only useful right now for full-speed tx-transfer.
> In my case its downloading a bitstream into a FPGA (only SPI
> writes). In the future, SPI NOR flash devices can be supported.
> But this needs additional work. So SPI devices should not use
> this direct access mode as default for now. It needs to get
> opted-in via some DT property.
 
Ok, so with the static mapping it could be done very easily, or
we need a more complex solution for the dynamic mapping.

	Arnd
