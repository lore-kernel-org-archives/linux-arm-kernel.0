From: ian.molton@codethink.co.uk (Ian Molton)
Date: Mon, 30 Jul 2012 16:15:58 +0100
Subject: [PATCH 5/6] csb1724: Enable device tree based mv643xx ethernet
 support.
In-Reply-To: <1343661359-10150-1-git-send-email-ian.molton@codethink.co.uk>
References: <1343661359-10150-1-git-send-email-ian.molton@codethink.co.uk>
Message-ID: <1343661359-10150-6-git-send-email-ian.molton@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

    This patch enables mv643xx based ethernet built into the SoM on the
    csb1724, via flattened device tree.

    Signed-off-by: Ian Molton <ian.molton@codethink.co.uk>
---
 arch/arm/boot/dts/kirkwood-csb1724.dts |   25 ++++++++++++++++++
 arch/arm/boot/dts/kirkwood.dtsi        |   16 ++++++++++++
 arch/arm/configs/csb1724_defconfig     |   45 ++++++++++++++++++++++++++++++++
 arch/arm/mach-kirkwood/board-csb1724.c |    3 +++
 4 files changed, 89 insertions(+)

diff --git a/arch/arm/boot/dts/kirkwood-csb1724.dts b/arch/arm/boot/dts/kirkwood-csb1724.dts
index 44dfe9a..f652797 100644
--- a/arch/arm/boot/dts/kirkwood-csb1724.dts
+++ b/arch/arm/boot/dts/kirkwood-csb1724.dts
@@ -25,6 +25,31 @@
 			nr-ports = <2>;
 			status = "ok";
 		};
+
+		smi0: mdio at 72000 {
+			status = "ok";
+		};
+
+		smi1: mdio at 76000 {
+			status = "ok";
+		};
+
+		egiga0 {
+			compatible = "marvell,mv643xx";
+			mdio = <&smi0>;
+			port_number = <0>;
+			phy_addr = <0x80>;
+			interrupts = <11>;
+		};
+
+		egiga1 {
+			compatible = "marvell,mv643xx";
+			mdio = <&smi1>;
+			port_number = <0>;
+			phy_addr = <0x81>;
+			interrupts = <15>;
+		};
+
 	};
 
 };
diff --git a/arch/arm/boot/dts/kirkwood.dtsi b/arch/arm/boot/dts/kirkwood.dtsi
index cef9616..dd10422 100644
--- a/arch/arm/boot/dts/kirkwood.dtsi
+++ b/arch/arm/boot/dts/kirkwood.dtsi
@@ -105,5 +105,21 @@
 			clock-frequency = <100000>;
 			status = "disabled";
 		};
+
+		smi0: mdio at 72000 {
+			compatible = "marvell,mdio-mv643xx";
+			reg = <0x72000 0x4000>;
+			interrupts = <46>;
+			status = "disabled";
+		};
+
+		smi1: mdio at 76000 {
+			compatible = "marvell,mdio-mv643xx";
+			reg = <0x76000 0x4000>;
+			interrupts = <47>;
+			shared_smi = <&smi0>;
+			status = "disabled";
+		};
+
 	};
 };
diff --git a/arch/arm/configs/csb1724_defconfig b/arch/arm/configs/csb1724_defconfig
index 927b269..fbea657 100644
--- a/arch/arm/configs/csb1724_defconfig
+++ b/arch/arm/configs/csb1724_defconfig
@@ -45,3 +45,48 @@ CONFIG_PROC_DEVICETREE=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_LOOP_MIN_COUNT=8
 CONFIG_DYNAMIC_DEBUG=y
+CONFIG_NET=y
+CONFIG_INET=y
+CONFIG_NETDEVICES=y
+CONFIG_MV643XX_ETH=y
+CONFIG_PACKET=y
+CONFIG_UNIX=y
+CONFIG_IPV6=n
+CONFIG_NET_VENDOR_3COM=n
+CONFIG_NET_VENDOR_ADAPTEC=n
+CONFIG_NET_VENDOR_ALTEON=n
+CONFIG_NET_VENDOR_AMD=n
+CONFIG_NET_VENDOR_ATHEROS=n
+CONFIG_NET_VENDOR_BROADCOM=n
+CONFIG_NET_VENDOR_BROCADE=n
+CONFIG_NET_VENDOR_CHELSIO=n
+CONFIG_NET_VENDOR_CIRRUS=n
+CONFIG_NET_VENDOR_CISCO=n
+CONFIG_NET_VENDOR_DEC=n
+CONFIG_NET_VENDOR_HP=n
+CONFIG_NET_VENDOR_DLINK=n
+CONFIG_NET_VENDOR_EMULEX=n
+CONFIG_NET_VENDOR_EXAR=n
+CONFIG_NET_VENDOR_FARADAY=n
+CONFIG_NET_VENDOR_INTEL=n
+CONFIG_NET_VENDOR_MELLANOX=n
+CONFIG_NET_VENDOR_MICREL=n
+CONFIG_NET_VENDOR_MYRI=n
+CONFIG_NET_VENDOR_NATSEMI=n
+CONFIG_NET_VENDOR_NVIDIA=n
+CONFIG_NET_VENDOR_OKI=n
+CONFIG_NET_PACKET_ENGINE=n
+CONFIG_NET_VENDOR_QLOGIC=n
+CONFIG_NET_VENDOR_REALTEK=n
+CONFIG_NET_VENDOR_RDC=n
+CONFIG_NET_VENDOR_SEEQ=n
+CONFIG_NET_VENDOR_SILAN=n
+CONFIG_NET_VENDOR_SIS=n
+CONFIG_NET_VENDOR_SMSC=n
+CONFIG_NET_VENDOR_STMICRO=n
+CONFIG_NET_VENDOR_SUN=n
+CONFIG_NET_VENDOR_TEHUTI=n
+CONFIG_NET_VENDOR_TI=n
+CONFIG_NET_VENDOR_VIA=n
+CONFIG_NET_VENDOR_WIZNET=n
+
diff --git a/arch/arm/mach-kirkwood/board-csb1724.c b/arch/arm/mach-kirkwood/board-csb1724.c
index 979112d..50f0c5b 100644
--- a/arch/arm/mach-kirkwood/board-csb1724.c
+++ b/arch/arm/mach-kirkwood/board-csb1724.c
@@ -13,6 +13,7 @@
 
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include "common.h"
 #include "mpp.h"
 
 static unsigned int csb1724_mpp_config[] __initdata = {
@@ -56,4 +57,6 @@ void __init csb1724_init(void)
 	 * Basic setup. Needs to be called early.
 	 */
 	kirkwood_mpp_conf(csb1724_mpp_config);
+	kirkwood_ge00_init(NULL);
+	kirkwood_ge01_init(NULL);
 }
-- 
1.7.9.5
