From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 14 Nov 2016 18:10:34 +0100
Subject: [PATCH 2/2] ARM: dts: vf610-zii-dev: Add .dts file for rev. C
In-Reply-To: <1479141306-15141-2-git-send-email-andrew.smirnov@gmail.com>
References: <1479141306-15141-1-git-send-email-andrew.smirnov@gmail.com>
 <1479141306-15141-2-git-send-email-andrew.smirnov@gmail.com>
Message-ID: <20161114171034.GC24546@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +		mdio_mux_1: mdio at 1 {
> +			reg = <1>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			switch0: switch0 at 0 {
> +				compatible = "marvell,mv88e6390";

Hi Andrey

The driver for this is not in net-next yet. And when it is, it will
probably be called "marvell,mv88e6190", keeping to the pattern of the
lowest product ID which supports these features.

> +					port at 4 {
> +						reg = <4>;
> +						label = "lan4";
> +					};
> +
> +					port at 9 {
> +						reg = <9>;
> +						label = "lan4";
> +						phy-handle = <&switch0phy0>;
> +					};
> +

You have two "lan4". I would also suggest leaving port 9 out for the
moment. It needs clause 45 MDIO to talk to the PHY, which we don't
have yet. Hence it cannot find it, and so give an error.

> +
> +					switch0port10: port at 10 {
> +						reg = <10>;
> +						label = "dsa";
> +						phy-mode = "xgmii";
> +						link = <&switch1port10>;
> +						fixed-link {
> +							speed = <10000>;
> +							full-duplex;
> +						};

This fixed-link node is wrong, and invalid. 10000 is not supported by
the fixed link driver, only 10, 100, and 1000. Also, it is not
required. The DSA driver should configure the link to the fastest
possible speed the port supports. You only need a fixed-link property
when you need to configure it at a lower speed. Rev B also gets this
wrong.

> +					};
> +				};
> +
> +				mdio {
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +					switch0phy0: switch0phy0 at 0 {
> +						reg = <0>;
> +					};

I think the strapping for the PHY is such that it is at address 9.
Also, it is on the external mdio bus, not the internal mdio bus. The
6390 family has two MDIO busses. I have patches to support this, which
will appear eventually.

  Andrew
