From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 21 Dec 2017 22:44:20 +0100
Subject: [PATCH] ARM: dts: ls1021a: fix incorrect clock references
Message-ID: <20171221214432.3658852-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

dtc warns about two 'clocks' properties that have an extraneous '1'
at the end:

arch/arm/boot/dts/ls1021a-qds.dtb: Warning (clocks_property): arch/arm/boot/dts/ls1021a-twr.dtb: Warning (clocks_property): Property 'clocks', cell 1 is not a phandle reference in /soc/i2c at 2180000/mux at 77/i2c at 4/sgtl5000 at 2a
arch/arm/boot/dts/ls1021a-qds.dtb: Warning (clocks_property): Missing property '#clock-cells' in node /soc/interrupt-controller at 1400000 or bad phandle (referred from /soc/i2c at 2180000/mux at 77/i2c at 4/sgtl5000 at 2a:clocks[1])
Property 'clocks', cell 1 is not a phandle reference in /soc/i2c at 2190000/sgtl5000 at a
arch/arm/boot/dts/ls1021a-twr.dtb: Warning (clocks_property): Missing property '#clock-cells' in node /soc/interrupt-controller at 1400000 or bad phandle (referred from /soc/i2c at 2190000/sgtl5000 at a:clocks[1])

The clocks that get referenced here are fixed-rate, so they do not
take any argument, and dtc interprets the next cell as a phandle, which
is invalid.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/boot/dts/ls1021a-qds.dts | 2 +-
 arch/arm/boot/dts/ls1021a-twr.dts | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/ls1021a-qds.dts b/arch/arm/boot/dts/ls1021a-qds.dts
index 940875316d0f..67b4de0e3439 100644
--- a/arch/arm/boot/dts/ls1021a-qds.dts
+++ b/arch/arm/boot/dts/ls1021a-qds.dts
@@ -215,7 +215,7 @@
 				reg = <0x2a>;
 				VDDA-supply = <&reg_3p3v>;
 				VDDIO-supply = <&reg_3p3v>;
-				clocks = <&sys_mclk 1>;
+				clocks = <&sys_mclk>;
 			};
 		};
 	};
diff --git a/arch/arm/boot/dts/ls1021a-twr.dts b/arch/arm/boot/dts/ls1021a-twr.dts
index a8b148ad1dd2..44715c8ef756 100644
--- a/arch/arm/boot/dts/ls1021a-twr.dts
+++ b/arch/arm/boot/dts/ls1021a-twr.dts
@@ -187,7 +187,7 @@
 		reg = <0x0a>;
 		VDDA-supply = <&reg_3p3v>;
 		VDDIO-supply = <&reg_3p3v>;
-		clocks = <&sys_mclk 1>;
+		clocks = <&sys_mclk>;
 	};
 };
 
-- 
2.9.0
