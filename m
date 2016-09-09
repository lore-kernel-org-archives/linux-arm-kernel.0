From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 9 Sep 2016 16:04:13 +0200
Subject: [PATCH v3 3/9] ARM: sun8i: dt: Add DT bindings documentation for
 Allwinner sun8i-emac
In-Reply-To: <1473425117-18645-4-git-send-email-clabbe.montjoie@gmail.com>
References: <1473425117-18645-1-git-send-email-clabbe.montjoie@gmail.com>
 <1473425117-18645-4-git-send-email-clabbe.montjoie@gmail.com>
Message-ID: <20160909140413.GD30871@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +The device node referenced by "phy" or "phy-handle" should be a child node
> +of this node. See phy.txt for the generic PHY bindings.

I've not looked at the code yet, but is this really true? Generally
there is not this limitation. You can point to any Ethernet phy
anyway, so long as it is on am MDIO bus.

> +
> +Optional properties:
> +- allwinner,tx-delay: TX clock delay chain value. Range value is 0-0x07. Default is 0)
> +- allwinner,rx-delay: RX clock delay chain value. Range value is 0-0x1F. Default is 0)
> +
> +The TX/RX clock delay chain settings are board specific.
> +
> +Optional properties for "allwinner,sun8i-h3-emac":
> +- allwinner,leds-active-low: EPHY LEDs are active low
> +
> +Example:
> +
> +emac: ethernet at 01c0b000 {
> +	compatible = "allwinner,sun8i-h3-emac";
> +	syscon = <&syscon>;
> +	reg = <0x01c0b000 0x104>;
> +	reg-names = "emac";
> +	interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
> +	resets = <&ccu RST_BUS_EMAC>, <<&ccu RST_BUS_EPHY>;
> +	reset-names = "ahb", "ephy";
> +	clocks = <&ccu CLK_BUS_EMAC>, <&ccu CLK_BUS_EPHY>;
> +	clock-names = "ahb", "ephy";
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +
> +	phy = <&phy1>;

ethernet.txt say:

- phy: the same as "phy-handle" property, not recommended for new bindings.

This is a new binding, please don't support it.

> +	phy-mode = "mii";
> +	allwinner,leds-active-low;
> +
> +	phy1: ethernet-phy at 1 {
> +		reg = <1>;
> +	};

It is normal to place these phy nodes inside an container node called
mdio.

	Andrew
