From: rogershimizu@gmail.com (Roger Shimizu)
Date: Sat,  6 Feb 2016 01:33:16 +0900
Subject: [PATCH 1/3] ARM: dts: orion5x: fix the missing mtd flash on
 linkstation lswtgl
In-Reply-To: <1454689998-9579-1-git-send-email-rogershimizu@gmail.com>
References: <1454689998-9579-1-git-send-email-rogershimizu@gmail.com>
Message-ID: <1454689998-9579-2-git-send-email-rogershimizu@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MTD flash stores u-boot and u-boot environment on linkstation lswtgl.
The latter one can be easily read/write by u-boot-tools package in Debian.

Signed-off-by: Roger Shimizu <rogershimizu@gmail.com>
---
 arch/arm/boot/dts/orion5x-linkstation-lswtgl.dts | 31 ++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm/boot/dts/orion5x-linkstation-lswtgl.dts b/arch/arm/boot/dts/orion5x-linkstation-lswtgl.dts
index 420788229e6f..aae8a7aceab7 100644
--- a/arch/arm/boot/dts/orion5x-linkstation-lswtgl.dts
+++ b/arch/arm/boot/dts/orion5x-linkstation-lswtgl.dts
@@ -228,6 +228,37 @@
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
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			header at 0 {
+				reg = <0 0x30000>;
+				read-only;
+			};
+
+			uboot at 30000 {
+				reg = <0x30000 0xF000>;
+				read-only;
+			};
+
+			uboot_env at 3F000 {
+				reg = <0x3F000 0x1000>;
+			};
+		};
+	};
+};
+
 &mdio {
 	status = "okay";
 
-- 
2.1.4
