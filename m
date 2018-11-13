From: manu@freebsd.org (Emmanuel Vadot)
Date: Tue, 13 Nov 2018 14:48:07 +0100
Subject: [PATCH] arm64: dts: marvell: armada_8k: reserve memory for ATF
Message-ID: <20181113134807.53292-1-manu@freebsd.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Like 4436a371 for 37xx, reserve the PSCI area memory region so kernels
can call the code there.
Region address is taken from the ATF code [1] and is 2MiB aligned.

[1] plat/marvell/a8k/common/include/platform_def.h

Signed-off-by: Emmanuel Vadot <manu@freebsd.org>
---
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
index 073610ac0a53..d8a79bb69de1 100644
--- a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
@@ -23,6 +23,21 @@
 		spi0 = &spi0;
 	};
 
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		/*
+		 * The PSCI firmware region depicted below is the default one
+		 * and should be updated by the bootloader.
+		 */
+		psci-area at 4000000 {
+			reg = <0 0x4000000 0 0x200000>;
+			no-map;
+		};
+	};
+
 	psci {
 		compatible = "arm,psci-0.2";
 		method = "smc";
-- 
2.19.0
