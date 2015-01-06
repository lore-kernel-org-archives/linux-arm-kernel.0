From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 6 Jan 2015 18:31:01 +0100
Subject: [PATCH v2 7/7] ARM: mvebu: Add Armada 385 Access Point
 Development Board support
In-Reply-To: <20150106155705.GB23784@lunn.ch>
References: <1420558100-4700-1-git-send-email-maxime.ripard@free-electrons.com>
 <1420558100-4700-8-git-send-email-maxime.ripard@free-electrons.com>
 <20150106155705.GB23784@lunn.ch>
Message-ID: <20150106173101.GB7853@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

On Tue, Jan 06, 2015 at 04:57:05PM +0100, Andrew Lunn wrote:
> On Tue, Jan 06, 2015 at 04:28:20PM +0100, Maxime Ripard wrote:
> 
> Hi Maxime
> 
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/armada-385-ap.dts
> > @@ -0,0 +1,140 @@
> > +/*
> > + * Device Tree file for Marvell Armada 385 Access Point Development board
> > + * (DB-88F6820-AP)
> > + *
> > + *  Copyright (C) 2014 Marvell
> > + *
> > + * Nadav Haklai <nadavh@marvell.com>
> > + *
> > + * This file is licensed under the terms of the GNU General Public
> > + * License version 2.  This program is licensed "as is" without any
> > + * warranty of any kind, whether express or implied.
> > + */
> 
> Gregory is in the process of dual licensing some of the other mvebu DT
> files. This one is single license. Should it be dual?

I'm not the original author though. Nadav, would you be ok to make a
switch to a GPL/X11 dual-license?

> > +
> > +/dts-v1/;
> > +#include "armada-385.dtsi"
> > +
> > +#include <dt-bindings/gpio/gpio.h>
> > +
> > +/ {
> > +	model = "Marvell Armada 385 Access Point Development Board";
> > +	compatible = "marvell,a385-db-ap", "marvell,armada385", "marvell,armada38x";
> > +
> > +	chosen {
> > +		bootargs = "console=ttyS0,115200";
> 
> Humm, ttyS0? Then why add the LL_DEBUG via UART1?

Yeah, my bad :)

It's obviously ttyS1

> Maybe add
> 
> stdout-path = &uart1;

Does that even work with the 8250? Last time I tried with a 3.18, it
didn't, and you still needed the console= bootargs.

> > +	};
> > +
> > +	memory {
> > +		device_type = "memory";
> > +		reg = <0x00000000 0x80000000>; /* 2GB */
> > +	};
> > +
> > +	soc {
> > +		ranges = <MBUS_ID(0xf0, 0x01) 0 0xf1000000 0x100000
> > +			  MBUS_ID(0x01, 0x1d) 0 0xfff00000 0x100000>;
> > +
> > +		internal-regs {
> > +			spi1: spi at 10680 {
> > +				pinctrl-names = "default";
> > +				pinctrl-0 = <&spi1_pins>;
> > +				status = "okay";
> > +
> > +				spi-flash at 0 {
> > +					#address-cells = <1>;
> > +					#size-cells = <1>;
> > +					compatible = "st,m25p128";
> > +					reg = <0>; /* Chip select 0 */
> > +					spi-max-frequency = <108000000>;
> > +				};
> > +			};
> > +
> > +			i2c0: i2c at 11000 {
> > +				pinctrl-names = "default";
> > +				pinctrl-0 = <&i2c0_pins>;
> > +				status = "okay";
> > +				clock-frequency = <100000>;
> > +			};
> > +
> > +			i2c1: i2c at 11100 {
> > +				status = "okay";
> > +				clock-frequency = <100000>;
> > +			};
> 
> Is there anything on these two i2c busses?

One goes to some pin of the mPCIe slot, the other is connected to the
EEPROM.

> If not, why enable them and increase the clock speed?

The clock speed is not increased, it's actually the driver's default.

> 
> > +			mdio at 72004 {
> > +				pinctrl-names = <&mdio_pins>;
> > +
> > +				phy0: ethernet-phy at 0 {
> > +					reg = <1>;
> > +				};
> > +
> > +				phy1: ethernet-phy at 1 {
> > +					reg = <6>;
> > +				};
> > +
> > +				phy2: ethernet-phy at 2 {
> > +					reg = <4>;
> > +				};
> > +			};
> > +
> > +			uart0: serial at 12000 {
> > +				pinctrl-names = "default";
> > +				pinctrl-0 = <&uart0_pins>;
> > +				status = "okay";
> > +			};
> > +
> > +			uart1: serial at 12100 {
> > +				pinctrl-names = "default";
> > +				pinctrl-0 = <&uart1_pins>;
> > +				status = "okay";
> > +			};
> 
> If it is not obvious from the silk screen, could you describe which
> connector this uart is on, what pins are what?

There's two UART connectors documented in the user guide (JP8 and
JP9). UART1 is also connected to a FTDI chip, that is exposed through
a mini-USB connector.

> > +
> > +			ethernet at 30000 {
> > +				status = "okay";
> > +				phy = <&phy1>;
> > +				phy-mode = "sgmii";
> > +			};
> > +
> > +			ethernet at 34000 {
> > +				status = "okay";
> > +				phy = <&phy2>;
> > +				phy-mode = "sgmii";
> > +			};
> > +
> > +			ethernet at 70000 {
> > +				pinctrl-names = "default";
> > +
> > +				/*
> > +				 * The Reference Clock 0 is used to
> > +				 * provide a clock to the PHY
> > +				 */
> 
> Does this clock need enabling? Should it be listed in the clocks
> property?

>From what I understood, this clock is always running, it's just
exposed to some external pin, and hence needs some muxing.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150106/cd39c0b5/attachment.sig>
