From: lee.jones@linaro.org (Lee Jones)
Date: Tue,  2 Apr 2013 14:21:54 +0100
Subject: [PATCH 7/9] ARM: ux500: Add a VQMMC (level-shifting) regulator DT
 node for Snowball
In-Reply-To: <1364908916-29803-1-git-send-email-lee.jones@linaro.org>
References: <1364908916-29803-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1364908916-29803-7-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Until recently platform code took care of all MMCI level-shifting by
way of an ios_handler() call-back. Now it is the driver's responsibility
to handle. In order to so that we need to provide the VQMMC regulator
reference in Device Tree. This patch takes care of that.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/snowball.dts |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/snowball.dts b/arch/arm/boot/dts/snowball.dts
index cc99447..6b4f8b9 100644
--- a/arch/arm/boot/dts/snowball.dts
+++ b/arch/arm/boot/dts/snowball.dts
@@ -119,6 +119,13 @@
 			};
 		};
 
+		vmmci: regulator-gpio {
+			gpios = <&gpio6 25 0x4>;
+			enable-gpio = <&gpio7 4 0x4>;
+
+			status = "okay";
+		};
+
 		// External Micro SD slot
 		sdi0_per1 at 80126000 {
 			arm,primecell-periphid = <0x10480180>;
@@ -126,6 +133,7 @@
 			bus-width = <4>;
 			mmc-cap-mmc-highspeed;
 			vmmc-supply = <&ab8500_ldo_aux3_reg>;
+			vqmmc-supply = <&vmmci>;
 
 			cd-gpios  = <&gpio6 26 0x4>; // 218
 			cd-inverted;
-- 
1.7.10.4
