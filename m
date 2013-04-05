From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Fri, 5 Apr 2013 12:04:43 -0600
Subject: [PATCH 1/5 v2] mv643xx_eth: add Device Tree bindings
In-Reply-To: <CABJ1b_TdzE_Q9qLsdSGZy8byFpCTtVBUy5FtxiZAx7QqgG-rVg@mail.gmail.com>
References: <1365071235-11611-1-git-send-email-florian@openwrt.org>
 <1365071235-11611-2-git-send-email-florian@openwrt.org>
 <20130404212906.GA25904@schnuecks.de>
 <515E9FE0.8050402@openwrt.org>
 <CABJ1b_TdzE_Q9qLsdSGZy8byFpCTtVBUy5FtxiZAx7QqgG-rVg@mail.gmail.com>
Message-ID: <20130405180443.GE3598@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 05, 2013 at 03:58:03PM +0200, Sebastian Hesselbarth wrote:

> I don't think that the ethernet controller should probe the PHY's on mdio-bus
> at all. At least not for DT enabled platforms. I had a look at DT and non-DT
> mdio-bus sources, and realized that there is a bus scan for non-DT only.
> of_mdiobus_register requires you to set (and know) the PHY address.

DT platforms should have the option to use the standard phy-phandle
connection:


		mdio at 72004 {
			#address-cells = <1>;
			#size-cells = <0>;
			compatible = "marvell,orion-mdio";
			reg = <0x72004 0x84>;
			status = "disabled";

+                        PHY1: ethernet-phy at 1 {
+                                reg = <1>;
+                                device_type = "ethernet-phy";
+                        };
		};

		ethernet-group at 72000 {
			#address-cells = <1>;
			#size-cells = <0>;
			compatible = "marvell,mv643xx-eth-block";
			reg = <0x72000 0x4000>;
			tx-csum-limit = <1600>;
			status = "disabled";

			egiga0: ethernet at 0 {
				device_type = "network";
				compatible = "marvell,mv643xx-eth";
				reg = <0>;
				interrupts = <29>;
				clocks = <&gate_clk 2>;
+	                        phy-handle = <&PHY1>;
			};
		};

When phy-handle is present the ethernet driver should not probe/scan for
phys.

There is standard code to handle all of this - an important gain is
that the phy driver now has access to a DT node and can apply
phy-specific properties.

> We had a similar discussion whether to probe or not for DT nodes,
> and I guess there also will be some discussion about the above
> patch. OTOH we could just (again) ask users of every
> kirkwood/orion5x/dove board to tell their phy addresses and fail to
> probe the phy for new boards...

Maybe print a warning and call the no-DT phy probe code if phy-handle
is nor present?

Not sure this should be in the common code, phy probing is sketchy, it
shouldn't be encouraged, IMHO..

Jason
