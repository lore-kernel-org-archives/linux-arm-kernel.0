From: rogershimizu@gmail.com (Roger Shimizu)
Date: Thu, 28 Jan 2016 00:10:05 +0900
Subject: [PATCH] ARM: dts: orion5x: add mtd flash support to linkstation lswtgl
Message-ID: <1453907405-30434-1-git-send-email-rogershimizu@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MTD flash stores u-boot and u-boot environment on linkstation lswtgl.
The latter one can be easily read/write by u-boot-tools package in Debian.

Signed-off-by: Roger Shimizu <rogershimizu@gmail.com>
---
 arch/arm/boot/dts/orion5x-linkstation-lswtgl.dts | 30 ++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/boot/dts/orion5x-linkstation-lswtgl.dts b/arch/arm/boot/dts/orion5x-linkstation-lswtgl.dts
index 420788229e6f..16eabc524b27 100644
--- a/arch/arm/boot/dts/orion5x-linkstation-lswtgl.dts
+++ b/arch/arm/boot/dts/orion5x-linkstation-lswtgl.dts
@@ -228,6 +228,36 @@
 	};
 };
 
+&devbus_bootcs {
+	status = "okay";
+	devbus,keep-config;
+
+	flash at 0 {
+		compatible = "jedec-flash";
+		reg = <0 0x40000>;
+		bank-width = <1>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		partition at 0 {
+			label = "header";
+			reg = <0 0x30000>;
+			read-only;
+		};
+
+		partition at 30000 {
+			label = "uboot";
+			reg = <0x30000 0xF000>;
+			read-only;
+		};
+
+		partition at 3F000 {
+			label = "uboot_env";
+			reg = <0x3F000 0x1000>;
+		};
+	};
+};
+
 &mdio {
 	status = "okay";
 
-- 
2.1.4
