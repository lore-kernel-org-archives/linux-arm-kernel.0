From: m-karicheri2@ti.com (Murali Karicheri)
Date: Thu, 2 Jun 2016 09:54:40 -0400
Subject: [PATCH 1/2] ARM: dts: keystone: fix to PCI bindings
Message-ID: <1464875681-14543-1-git-send-email-m-karicheri2@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PCI DT bindings contain a bogus entry for IO space which is not
supported on Keystone. The current bogus entry has an invalid size
and throws following error during boot.

[0.420713] keystone-pcie 21021000.pcie: error -22: failed to map
           resource [io  0x0000-0x400000003fff]

So remove it from the dts. While at it also add a bus-range
value that eliminates following log at boot up.

[0.420659] No bus range found for /soc/pcie at 21020000, using [bus 00-ff]

Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
---
 - applies to master v4.7-rcx at kernel.org git repo
 arch/arm/boot/dts/keystone-k2e.dtsi | 5 +++--
 arch/arm/boot/dts/keystone.dtsi     | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/keystone-k2e.dtsi b/arch/arm/boot/dts/keystone-k2e.dtsi
index 96b349f..5374c9a 100644
--- a/arch/arm/boot/dts/keystone-k2e.dtsi
+++ b/arch/arm/boot/dts/keystone-k2e.dtsi
@@ -96,12 +96,13 @@
 			#address-cells = <3>;
 			#size-cells = <2>;
 			reg =  <0x21021000 0x2000>, <0x21020000 0x1000>, <0x02620128 4>;
-			ranges = <0x81000000 0 0 0x23260000 0x4000 0x4000
-				0x82000000 0 0x60000000 0x60000000 0 0x10000000>;
+			ranges = <0x82000000 0 0x60000000 0x60000000
+				  0 0x10000000>;
 
 			status = "disabled";
 			device_type = "pci";
 			num-lanes = <2>;
+			bus-range = <0x00 0xff>;
 
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 7>;
diff --git a/arch/arm/boot/dts/keystone.dtsi b/arch/arm/boot/dts/keystone.dtsi
index e34b226..f627a1c 100644
--- a/arch/arm/boot/dts/keystone.dtsi
+++ b/arch/arm/boot/dts/keystone.dtsi
@@ -294,12 +294,13 @@
 			#address-cells = <3>;
 			#size-cells = <2>;
 			reg =  <0x21801000 0x2000>, <0x21800000 0x1000>, <0x02620128 4>;
-			ranges = <0x81000000 0 0 0x23250000 0 0x4000
-				0x82000000 0 0x50000000 0x50000000 0 0x10000000>;
+			ranges = <0x82000000 0 0x50000000 0x50000000
+				  0 0x10000000>;
 
 			status = "disabled";
 			device_type = "pci";
 			num-lanes = <2>;
+			bus-range = <0x00 0xff>;
 
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 7>;
-- 
1.9.1
