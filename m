From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 27 Jan 2013 10:35:32 -0500
Subject: [PATCH V4 10/11] ARM: kirkwood: mv643xx_eth dt conversion
In-Reply-To: <51052E6C.1020102@gmail.com>
References: <cover.1358983578.git.jason@lakedaemon.net>
 <cover.1359232975.git.jason@lakedaemon.net>
 <6f3e1f0ee3c5fd06fb3ca918a6c3b13552f32cac.1359232975.git.jason@lakedaemon.net>
 <51052E6C.1020102@gmail.com>
Message-ID: <20130127153532.GZ1758@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 27, 2013 at 02:41:00PM +0100, Sebastian Hesselbarth wrote:
> On 01/26/2013 09:50 PM, Jason Cooper wrote:
> >Tested on the dreamplug:
> >
> >mv643xx_eth: MV-643xx 10/100/1000 ethernet driver version 1.4
> >libphy: mv643xx_eth smi: probed
> >libphy: mv643xx_eth smi: probed
> >mv643xx_eth_port f1072000.egiga0 eth0: port 0 with MAC address XX:XX:XX...
> >mv643xx_eth_port f1076000.egiga1 eth1: port 0 with MAC address XX:XX:XX...
> >
> >Successfully pulled an ip address and pinged through the interface
> >
> >...
> >
> >diff --git a/arch/arm/boot/dts/kirkwood.dtsi b/arch/arm/boot/dts/kirkwood.dtsi
> >index 2c738d9..b13a405 100644
> >--- a/arch/arm/boot/dts/kirkwood.dtsi
> >+++ b/arch/arm/boot/dts/kirkwood.dtsi
> >@@ -201,5 +201,43 @@
> >  			clocks =<&gate_clk 4>;
> >  			status = "disabled";
> >  		};
> >+
> >+		smi0: mdio at 72000 {
> >+			compatible = "marvell,mdio-mv643xx";
> >+			reg =<0x72000 0x4000>;
> >+			interrupts =<46>;
> >+			tx_csum_limit =<1600>;
> >+			status = "disabled";
> >+		};
> >+
> >+		smi1: mdio at 76000 {
> >+			compatible = "marvell,mdio-mv643xx";
> >+			reg =<0x76000 0x4000>;
> >+			interrupts =<47>;
> >+			tx_csum_limit =<1600>;
> >+			status = "disabled";
> >+		};
> >+
> >+		egiga0 {
> >+			compatible = "marvell,mv643xx-eth";
> >+			reg =<0x72000 0x4000>;
> >+			mdio =<&smi0>;
> >+			port_number =<0>;
> >+			phy_addr =<0x80>;
> 
> Jason,
> 
> This will break phy_scan on all kirkwood boards as 0x80 is _not_ equal
> MV643XX_ETH_PHY_ADDR_DEFAULT.

Good point.

> I suggest not to set phy_addr in kirkwood.dtsi at all and let the
> board specific DT files set the phy addresses (or rely on phy_scan if not
> set).
> 
> Also, you are ORing the address passed by phy_addr with 0x80 anyway. So
> all phy addresses should be passed as <0> or <1> instead the ORed ones.

agreed.  I'll make the changes for V5.

thanks for the review.

Jason.
