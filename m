From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 24 Mar 2016 17:48:23 +0100
Subject: [PATCH v2] spi: orion.c: Add direct access mode
In-Reply-To: <56F412B5.2080200@denx.de>
References: <1458663893-13766-1-git-send-email-sr@denx.de>
 <3250653.vvT0RgK8yg@wuerfel> <56F412B5.2080200@denx.de>
Message-ID: <30176583.aSTyzO0qS3@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 24 March 2016 17:15:49 Stefan Roese wrote:
> >
> >       soc@ {
> >               spi0 {
> >                         compatible = "marvell,armada-370-spi",
> >                                      "marvell,orion-spi";
> >                       reg = <MBUS_ID(0xf0, 0x01) 0x10600 0x28>,
> >                             <MBUS_ID(0x01, 0x5e) 0 0x100000>;
> >                         #address-cells = <1>;
> >                         #size-cells = <0>;
> >                         pinctrl-0 = <&spi0_pins1>;
> >                         pinctrl-names = "default";
> >                         cell-index = <0>;
> >                         interrupts = <30>;
> >                         clocks = <&coreclk 0>;
> >                         status = "disabled";
> >               };
> >       };
> 
> Do I understand this correctly, that you suggest to list all MBus
> windows here, that the SoC supports (e.g. 8 for the Armada XP).
> And let the SPI driver then extract and dynamically enable (map)
> the one that is currently used?

Actually the syntax above doesn't imply any mapping at all, it
just describes how the hardware is wired up, so that really
needs to list all windows, and then the ranges property in the
soc node can statically map the ones that are used on the
particular machine.

> We also need a per-SPI-device DT property to enable this direct
> access mode for this specific SPI device. As not all SPI devices
> support this mode - at least not yet. How about this one:
> 
>                 flash0: flash at 0 {
>                         compatible = "m25p128";
>                         reg = <0>;
>                         direct-access-enable;
>                         ...
>                 };
> 
> ?

Maybe the spi driver can just check whether the window is mapped
or not, and then have no ranges entry for the devices that don't
support it?

Alternatively, we might encode this in the 'reg' property in
some way?

How do we know whether a device supports the mode or not?

	Arnd
