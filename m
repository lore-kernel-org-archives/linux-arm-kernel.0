From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 9 Nov 2015 17:08:34 +0000
Subject: [PATCH] mvneta: add FIXED_PHY dependency
In-Reply-To: <6910088.dNmooXDTJR@wuerfel>
References: <4225885.EYXTHjRPmX@wuerfel> <20151109164232.GB3388@lunn.ch>
 <6910088.dNmooXDTJR@wuerfel>
Message-ID: <20151109170834.GE8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 09, 2015 at 05:57:43PM +0100, Arnd Bergmann wrote:
> I'm not sure what you are asking. A lot of DT bindings have both
> optional and mandatory properties. For mvneta, the "phy" and "phy-mode"
> properties are listed as mandatory, so the driver can safely assume
> that they are always present. If there are reasons to leave them out,
> and for the driver to handle that case correctly, the binding
> should be updated to mark them as optional.

They are "optional" because when you're using a DSA switch, you don't
specify a PHY (because, there isn't one).  For example, this is what
I'm using with an Armada 388 board with a Marvell DSA switch.  The
DSA does not appear as a PHY, and no node in the DSA stanza can be
referenced for a phy entry in the ethernet device's stanza.

                        eth1: ethernet at 30000 {
                                compatible = "marvell,armada-370-neta";
                                reg = <0x30000 0x4000>;
                                interrupts-extended = <&mpic 10>;
                                clocks = <&gateclk 3>;
                                managed = "in-band-status";
                                phy-mode = "sgmii";
                                status = "okay";
                        };

        dsa at 0 {
                compatible = "marvell,dsa";
                dsa,ethernet = <&eth1>;
                dsa,mii-bus = <&mdio>;
                pinctrl-0 = <&clearfog_dsa0_clk_pins &clearfog_dsa0_pins>;
                pinctrl-names = "default";
                #address-cells = <2>;
                #size-cells = <0>;

                switch at 0 {
		...
		};
	};

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
