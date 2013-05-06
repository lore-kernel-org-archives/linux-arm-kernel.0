From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon,  6 May 2013 17:33:37 +0200
Subject: [PATCH v3 4/7] ARM: dove: add gigabit ethernet and mvmdio device tree
 nodes
In-Reply-To: <1367854420-8006-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1365071235-11611-1-git-send-email-florian@openwrt.org>
 <1367854420-8006-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1367854420-8006-5-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds mv643xx_eth and mvmdio device tree nodes for DT enabled
Dove boards. As there is only one ethernet controller on Dove, a default
phy node is also added with a note to overwrite its reg property on a
per-board basis.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Cc: Grant Likely <grant.likely@linaro.org>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Rob Landley <rob@landley.net>
Cc: Lennert Buytenhek <buytenh@wantstofly.org>
Cc: David Miller <davem@davemloft.net>
Cc: Florian Fainelli <florian@openwrt.org>
Cc: Arnaud Patard <arnaud.patard@rtp-net.org>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Jean-Francois Moine <moinejf@free.fr>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Simon Guinot <simon.guinot@sequanux.org>
Cc: Jamie Lentin <jm@lentin.co.uk>
Cc: Michael Walle <michael@walle.cc>
Cc: Eric Hutter <hutter.eric@gmail.com>
Cc: Joshua Coombs <josh.coombs@gmail.com>
Cc: Willy Tarreau <w@1wt.eu>
Cc: Simon Baatz <gmbnomis@gmail.com>
Cc: Alan M Butler <alanbutty12@gmail.com>
Cc: Nigel Roberts <nigel@nobiscuit.com>
Cc: Valentin Longchamp <valentin.longchamp@keymile.com>
Cc: Stefan Peter <s.peter@mpl.ch>
Cc: Arnaud Ebalard <arno@natisbad.org>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: netdev at vger.kernel.org
Cc: devicetree-discuss at lists.ozlabs.org
Cc: linux-doc at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 arch/arm/boot/dts/dove-cubox.dts |    8 ++++++++
 arch/arm/boot/dts/dove.dtsi      |   35 +++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/dove-cubox.dts b/arch/arm/boot/dts/dove-cubox.dts
index 7e3065a..a52f016 100644
--- a/arch/arm/boot/dts/dove-cubox.dts
+++ b/arch/arm/boot/dts/dove-cubox.dts
@@ -49,6 +49,14 @@
 &uart0 { status = "okay"; };
 &sata0 { status = "okay"; };
 &i2c0 { status = "okay"; };
+&mdio { status = "okay"; };
+&eth { status = "okay"; };
+&eth0 { status = "okay"; };
+
+&ethphy {
+	compatible = "marvell,88e1310";
+	reg = <1>;
+};
 
 &sdio0 {
 	status = "okay";
diff --git a/arch/arm/boot/dts/dove.dtsi b/arch/arm/boot/dts/dove.dtsi
index 6cab468..8bb46c4 100644
--- a/arch/arm/boot/dts/dove.dtsi
+++ b/arch/arm/boot/dts/dove.dtsi
@@ -258,5 +258,40 @@
 				dmacap,xor;
 			};
 		};
+
+		mdio: mdio-bus at 72004 {
+			compatible = "marvell,orion-mdio";
+			reg = <0x72004 0x84>;
+			interrupts = <30>;
+			clocks = <&gate_clk 2>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+
+			ethphy: ethernet-phy {
+				device_type = "ethernet-phy";
+				/* overwrite reg property in board file */
+			};
+		};
+
+		eth: ethernet-controller at 72000 {
+			compatible = "marvell,mv643xx-eth-block";
+			reg = <0x72000 0x4000>;
+			clocks = <&gate_clk 2>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			tx-csum-limit = <1600>;
+			status = "disabled";
+
+			eth0: ethernet-port at 0 {
+				compatible = "marvell,mv643xx-eth";
+				device_type = "network";
+				reg = <0>;
+				interrupts = <29>;
+				clocks = <&gate_clk 2>;
+				phy = <&ethphy>;
+				status = "disabled";
+			};
+		};
 	};
 };
-- 
1.7.2.5
