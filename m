From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 24 Feb 2014 19:01:35 +0100
Subject: [PATCH v2 2/5] ARM: mvebu: Add i2c alias so setting bus number
In-Reply-To: <1393264898-28939-1-git-send-email-andrew@lunn.ch>
References: <1393264898-28939-1-git-send-email-andrew@lunn.ch>
Message-ID: <1393264898-28939-3-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When using platform_driver instantiation, the i2c bus was given bus
number 0. The kirkwood-t5325 audio driver has this bus number hard
coded for the address of the codec. However by default device tree i2c
busses are dynamically allocated a bus number, starting from 1. Thus
the kirkwood-t5325 cannot find its audio codec. By adding an alias in
the DT file we can control the bus number and set it to 0. The codec
can then be found.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/boot/dts/kirkwood.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/kirkwood.dtsi b/arch/arm/boot/dts/kirkwood.dtsi
index 180dc69ff742..d8e34fab835b 100644
--- a/arch/arm/boot/dts/kirkwood.dtsi
+++ b/arch/arm/boot/dts/kirkwood.dtsi
@@ -24,6 +24,7 @@
 	aliases {
 	       gpio0 = &gpio0;
 	       gpio1 = &gpio1;
+	       i2c0 = &i2c0;
 	};
 
 	mbus {
@@ -111,7 +112,7 @@
 			clocks = <&gate_clk 7>;
 		};
 
-		i2c at 11000 {
+		i2c0: i2c at 11000 {
 			compatible = "marvell,mv64xxx-i2c";
 			reg = <0x11000 0x20>;
 			#address-cells = <1>;
-- 
1.8.5.3
