From: andre.przywara@arm.com (Andre Przywara)
Date: Tue,  9 Aug 2016 12:53:01 +0100
Subject: [RFC PATCH 3/5] arm64: dts: sunxi: add SCPI node to sun50i-a64.dtsi
In-Reply-To: <20160809115303.17032-1-andre.przywara@arm.com>
References: <20160809115303.17032-1-andre.przywara@arm.com>
Message-ID: <20160809115303.17032-4-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Support for variable frequency clocks is implemented in ARM Trusted
Firmware, which sits in SRAM and waits for SCPI requests.
Add the respective SMC mailbox node and a 512-byte chunk of SRAM to
allow SCPI calls to be handled by the firmware.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 70d0382..9fc540e 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -131,8 +131,34 @@
 			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
 	};
 
+	mailbox: mbox at 0 {
+		compatible = "arm,smc-mbox";
+		#mbox-cells = <1>;
+		identifiers = <0x82000001>;
+	};
+
+	sram: sram at 18000{
+		compatible = "mmio-sram";
+		reg = <0x10000 0x8000>;
+
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x10000 0x8000>;
+
+		cpu_scp_mem: scp-shmem at 7e00 {
+			compatible = "mmio-sram";
+			reg = <0x7e00 0x200>;
+		};
+	};
+
 	/include/ "sun50i-a64-clocks.dtsi"
 
+	scpi {
+		compatible = "arm,scpi";
+		mboxes = <&mailbox 0>;
+		shmem = <&cpu_scp_mem>;
+	};
+
 	soc {
 		compatible = "simple-bus";
 		#address-cells = <1>;
-- 
2.9.0
