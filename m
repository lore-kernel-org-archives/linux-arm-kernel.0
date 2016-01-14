From: wxt@rock-chips.com (Caesar Wang)
Date: Thu, 14 Jan 2016 10:55:24 +0800
Subject: [PATCH v2] ARM: dts: rockchip: add reboot-mode node for rk3036 SoCs
In-Reply-To: <1452650930-22883-1-git-send-email-wxt@rock-chips.com>
References: <1452650930-22883-1-git-send-email-wxt@rock-chips.com>
Message-ID: <1452740124-32558-1-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add reboot mode driver DT node for rk3036 platform.

Signed-off-by: Caesar Wang <wxt@rock-chips.com>

---

 arch/arm/boot/dts/rk3036.dtsi | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/rk3036.dtsi b/arch/arm/boot/dts/rk3036.dtsi
index ccc69ab..74e3bc1 100644
--- a/arch/arm/boot/dts/rk3036.dtsi
+++ b/arch/arm/boot/dts/rk3036.dtsi
@@ -43,6 +43,7 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/pinctrl/rockchip.h>
 #include <dt-bindings/clock/rk3036-cru.h>
+#include <dt-bindings/soc/rockchip_boot-mode.h>
 #include "skeleton.dtsi"
 
 / {
@@ -307,8 +308,33 @@
 	};
 
 	grf: syscon at 20008000 {
-		compatible = "rockchip,rk3036-grf", "syscon";
+		compatible = "rockchip,rk3036-grf", "syscon", "simple-mfd";
 		reg = <0x20008000 0x1000>;
+
+		reboot-mode {
+			compatible = "syscon-reboot-mode";
+			offset = <0x1d8>;
+
+			normal {
+				linux,mode = "normal";
+				loader,magic = <BOOT_NORMAL>;
+			};
+
+			loader {
+				linux,mode = "loader";
+				loader,magic = <BOOT_LOADER>;
+			};
+
+			recovery {
+				linux,mode = "recovery";
+				loader,magic = <BOOT_RECOVERY>;
+			};
+
+			fastboot {
+				linux,mode = "fastboot";
+				loader,magic = <BOOT_FASTBOOT>;
+			};
+		};
 	};
 
 	acodec: acodec-ana at 20030000 {
-- 
1.9.1
