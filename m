From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 21 Dec 2016 17:49:07 +0100
Subject: [PATCH] ARM: dts: turris-omnia: add support for ethernet switch
In-Reply-To: <20161221102047.28036-1-uwe@kleine-koenig.org>
References: <20161221102047.28036-1-uwe@kleine-koenig.org>
Message-ID: <20161221164907.GN30952@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>  	/* Switch MV88E7176 at address 0x10 */
> +	switch at 10 {
> +		compatible = "marvell,mv88e6085";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		dsa,member = <0 0>;
> +
> +		reg = <0x10>;
> +
> +		ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			ports at 0 {
> +				reg = <0>;
> +				label = "lan0";
> +				phy-handle = <&lan0phy>;

snip

> +		mdio {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			lan0phy: ethernet-phy at 0 {
> +				compatible = "ethernet-phy-ieee802.3-c22";
> +				reg = <0>;
> +			};

You probably don't need the phy-handle's and the whole mdio node. So
long as there is a simple mapping, port 0 uses the phy at address 0,
it should just work. You only need the mdio node when you want to
support PHY interrupts, or there is an odd mapping between port and
PHY, like the new switch chip added recently.

   Andrew
