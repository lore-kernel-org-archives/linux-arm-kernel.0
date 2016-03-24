From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 24 Mar 2016 13:42:38 +0100
Subject: [PATCH v2] spi: orion.c: Add direct access mode
In-Reply-To: <56F395BC.6070108@denx.de>
References: <1458663893-13766-1-git-send-email-sr@denx.de>
 <12458203.7DzKuGjIvi@wuerfel> <56F395BC.6070108@denx.de>
Message-ID: <3250653.vvT0RgK8yg@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 24 March 2016 08:22:36 Stefan Roese wrote:
> 
> Arnd, thanks for your comments.
> 
> So we seem to agree, that one MBus window per SPI controller is the
> way to go. Only how should this be described in the DT? I've come up
> with these new DT properties in v2:
> 
> +- da-reg : The physical memory area that will be used for the direct
> +           access mode, if enabled in one of the SPI devices.
> +
> +Per SPI device:
> +- da-target-attribute : The target and attribute value for a specific
> +                        SPI-controller / SPI-device combination.
> +                       E.g. <0x01 0x5e>: SPI0-CS1 target and attribute
> 
> ...
> 
> +Example with direct access mode:
> +       spi at 10600 {
> +               compatible = "marvell,orion-spi";
> +               status = "okay";
> +               da-reg = <0xf2000000 0x100000>;
> +
> +               spi-fpga at 1 {
> +                       compatible = "altera,stratix-v";
> +                       reg = <1>;
> +                       /* 0x01 0x5e: SPI0-CS1 target and attribute */
> +                       da-target-attribute = <0x01 0x5e>;
> +               };
> +       };
> 
> I've added the "da-*" (Direct Access) properties to enable the
> SPI driver to dynamically allocate the MBus windows. Do you find
> these new bindings reasonable? Or do you have better suggestions for
> this per-SPI-device dynamic MBus allocation, perhaps by using
> MBUS_ID somehow?

I was thinking it would be statically set up, but then we have a
problem with how it uses both internal-regs and and its own mbus
based reg, so we probably have to move the spi node outside of
the internal-regs node to achieve that, similar to how we handle
the devbus devices:


	soc@ {
		spi0 {
                       compatible = "marvell,armada-370-spi",
                                    "marvell,orion-spi";
			reg = <MBUS_ID(0xf0, 0x01) 0x10600 0x28>,
			      <MBUS_ID(0x01, 0x5e) 0 0x100000>;
                       #address-cells = <1>;
                       #size-cells = <0>;
                       pinctrl-0 = <&spi0_pins1>;
                       pinctrl-names = "default";
                       cell-index = <0>;
                       interrupts = <30>;
                       clocks = <&coreclk 0>;
                       status = "disabled";
		};
	};

	Arnd
