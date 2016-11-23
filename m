From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 23 Nov 2016 01:35:05 +0100
Subject: [RFC PATCH] ARM: dts: Add support for Turris Omnia
In-Reply-To: <1479859770-9375-1-git-send-email-tmshlvck@gmail.com>
References: <1479851991.26813.2@smtp.gmail.com>
 <1479859770-9375-1-git-send-email-tmshlvck@gmail.com>
Message-ID: <20161123003505.GL2691@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +++ b/arch/arm/boot/dts/armada-385-turris-omnia.dts
> @@ -0,0 +1,279 @@
> +/*
> + * Device Tree file for the Turris Omnia
> + * Schematic available at https://www.turris.cz/doc/_media/rtrom01-schema.pdf

Hi Tomas

Cool that there is a link to the schematics. But please could you put
it lower down. It is more likely to be seen if it comes after the
copyright and license section.

> +			sdhci at d8000 {
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&sdhci_pins>;
> +				status = "okay";
> +
> +				bus-width = <8>;
> +				no-1-8-v;
> +				non-removable;
> +			};

> +&i2c0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c0_pins>;
> +	status = "okay";
> +
> +	i2cmux at 70 {
> +		compatible = "nxp,pca9547";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		reg = <0x70>;
> +		status = "okay";
> +
> +		/* Channel 1: Routed to PCIe0/mSATA connector (CN7A).
> +		 * Channel 2: Routed to PCIe1/USB2 connector (CN61A).
> +		 * Channel 3: Routed to PCIe2 connector (CN62A).
> +		 * Channel 4: Routed to SFP+.
> +		 * Channel 5: ATSHA204A at address 0x64.
> +		 * Channel 6: Routed to user pin header CN11.
> +		 */

I've not looked at how the pca9547 works.... Will it instantiate a bus
only if there is a node in the device tree with a reg property?

What i'm thinking is that it is possible to indicate to the i2c core
that a device is on a bus using echo to a file. But this only works if
the bus exists. You could for example say using echo that there is an
at24 EEPROM on channel 4 and get access to the EEPROM inside the SFP
module. But that only works if the i2c bus exists. Does it?

No leds? No buttons via gpio-keys?

   Andrew
