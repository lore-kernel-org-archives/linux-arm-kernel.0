From: andy.yan@rock-chips.com (Andy Yan)
Date: Tue,  2 Feb 2016 18:10:37 +0800
Subject: [PATCH v3 3/4] ARM: dts: rockchip: add syscon-reboot-mode DT node
In-Reply-To: <1454406981-4692-1-git-send-email-andy.yan@rock-chips.com>
References: <1454406981-4692-1-git-send-email-andy.yan@rock-chips.com>
Message-ID: <1454407837-5421-1-git-send-email-andy.yan@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rockchip platform use a SYSCON mapped register store
the reboot mode magic value for bootloader to use when
system reboot. So add syscon-reboot-mode driver DT node
for rk3xxx,rk3036, rk3288 platform

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
Signed-off-by: Andy Yan <andy.yan@rock-chips.com>

---

Changes in v3:
- descirbe all reboot mode as property instead of subnode
- add rk3036 support

Changes in v2:
- make this node as a subnode of PMU

Changes in v1:
- correct the maskrom magic number
- use macro defined in rockchip_boot-mode.h for reboot-mode DT node

 arch/arm/boot/dts/rk3036.dtsi                | 11 +++++++++-
 arch/arm/boot/dts/rk3288.dtsi                | 11 ++++++++++
 arch/arm/boot/dts/rk3xxx.dtsi                | 13 +++++++++++-
 include/dt-bindings/soc/rockchip_boot-mode.h | 30 ++++++++++++++++++++++++++++
 4 files changed, 63 insertions(+), 2 deletions(-)
 create mode 100644 include/dt-bindings/soc/rockchip_boot-mode.h

diff --git a/arch/arm/boot/dts/rk3036.dtsi b/arch/arm/boot/dts/rk3036.dtsi
index b9567c1..64527c6 100644
--- a/arch/arm/boot/dts/rk3036.dtsi
+++ b/arch/arm/boot/dts/rk3036.dtsi
@@ -43,6 +43,7 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/pinctrl/rockchip.h>
 #include <dt-bindings/clock/rk3036-cru.h>
+#include <dt-bindings/soc/rockchip_boot-mode.h>
 #include "skeleton.dtsi"
 
 / {
@@ -261,8 +262,16 @@
 	};
 
 	grf: syscon at 20008000 {
-		compatible = "rockchip,rk3036-grf", "syscon";
+		compatible = "rockchip,rk3036-grf", "syscon", "simple-mfd";
 		reg = <0x20008000 0x1000>;
+		reboot-mode {
+			compatible = "syscon-reboot-mode";
+			offset = <0x1d8>;
+			mode-normal = <BOOT_NORMAL>;
+			mode-recovery = <BOOT_RECOVERY>;
+			mode-fastboot = <BOOT_FASTBOOT>;
+			mode-loader = <BOOT_LOADER>;
+		};
 	};
 
 	acodec: acodec-ana at 20030000 {
diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 8ac49f3..4d06d84 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -45,6 +45,7 @@
 #include <dt-bindings/clock/rk3288-cru.h>
 #include <dt-bindings/thermal/thermal.h>
 #include <dt-bindings/power/rk3288-power.h>
+#include <dt-bindings/soc/rockchip_boot-mode.h>
 #include "skeleton.dtsi"
 
 / {
@@ -713,6 +714,16 @@
 				clocks = <&cru ACLK_GPU>;
 			};
 		};
+
+		reboot-mode {
+			compatible = "syscon-reboot-mode";
+			offset = <0x94>;
+			mode-normal = <BOOT_NORMAL>;
+			mode-recovery = <BOOT_RECOVERY>;
+			mode-fastboot = <BOOT_FASTBOOT>;
+			mode-loader = <BOOT_LOADER>;
+			mode-maskrom = <BOOT_MASKROM>;
+		};
 	};
 
 	sgrf: syscon at ff740000 {
diff --git a/arch/arm/boot/dts/rk3xxx.dtsi b/arch/arm/boot/dts/rk3xxx.dtsi
index 99eeea7..d21ed43 100644
--- a/arch/arm/boot/dts/rk3xxx.dtsi
+++ b/arch/arm/boot/dts/rk3xxx.dtsi
@@ -43,6 +43,7 @@
 
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/soc/rockchip_boot-mode.h>
 #include "skeleton.dtsi"
 
 / {
@@ -243,8 +244,18 @@
 	};
 
 	pmu: pmu at 20004000 {
-		compatible = "rockchip,rk3066-pmu", "syscon";
+		compatible = "rockchip,rk3066-pmu", "syscon", "simple-mfd";
 		reg = <0x20004000 0x100>;
+
+		reboot-mode {
+			compatible = "syscon-reboot-mode";
+			offset = <0x40>;
+			mode-normal = <BOOT_NORMAL>;
+			mode-recovery = <BOOT_RECOVERY>;
+			mode-fastboot = <BOOT_FASTBOOT>;
+			mode-loader = <BOOT_LOADER>;
+			mode-maskrom = <BOOT_MASKROM>;
+		};
 	};
 
 	grf: grf at 20008000 {
diff --git a/include/dt-bindings/soc/rockchip_boot-mode.h b/include/dt-bindings/soc/rockchip_boot-mode.h
new file mode 100644
index 0000000..eedf113
--- /dev/null
+++ b/include/dt-bindings/soc/rockchip_boot-mode.h
@@ -0,0 +1,30 @@
+#ifndef __ROCKCHIP_BOOT_MODE_H
+#define __ROCKCHIP_BOOT_MODE_H
+
+/*high 24 bits is tag, low 8 bits is type*/
+#define	REBOOT_FLAG		0x5242C300
+/* normal boot */
+#define	BOOT_NORMAL		(REBOOT_FLAG + 0)
+/* enter loader rockusb mode */
+#define	BOOT_LOADER		(REBOOT_FLAG + 1)
+/* enter maskrom rockusb mode */
+#define	BOOT_MASKROM		(0xEF08A53C)
+/* enter recovery */
+#define	BOOT_RECOVERY		(REBOOT_FLAG + 3)
+/* do not enter recover */
+#define	BOOT_NORECOVER		(REBOOT_FLAG + 4)
+/* boot second OS*/
+#define	BOOT_SECONDOS		(REBOOT_FLAG + 5)
+/* enter recover and wipe data. */
+#define	BOOT_WIPEDATA		(REBOOT_FLAG + 6)
+/* enter recover and wipe all data. */
+#define	BOOT_WIPEALL		(REBOOT_FLAG + 7)
+/* check firmware img with backup part*/
+#define	BOOT_CHECKIMG		(REBOOT_FLAG + 8)
+ /* enter fast boot mode */
+#define	BOOT_FASTBOOT		(REBOOT_FLAG + 9)
+#define	BOOT_SECUREBOOT_DISABLE	(REBOOT_FLAG + 10)
+/* enter charge mode */
+#define	BOOT_CHARGING		(REBOOT_FLAG + 11)
+
+#endif
-- 
1.9.1
