From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Fri, 8 Apr 2016 15:27:11 +0800
Subject: [PATCH 1/2] arm64: dts: Add initial dts for Hisilicon Hip06 D03 board
In-Reply-To: <1460100432-52722-1-git-send-email-wangkefeng.wang@huawei.com>
References: <1460100432-52722-1-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <1460100432-52722-2-git-send-email-wangkefeng.wang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Hip06 soc has same cpu topology compared with Hip05, four clusters
and each cluster has quard Cortex-A57, but with different IO part,
like HNS, SAS and PCI, they are all upgraded. There are also not same
in ITS, MBIGEN and SMMU, etc.

This patch adds the initial dts for hip06 d03 board.

Note, there is no serial, because the soc use LPC uart, the serial node
is not needed.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/arm64/boot/dts/hisilicon/Makefile      |   4 +-
 arch/arm64/boot/dts/hisilicon/hip06-d03.dts |  34 +++
 arch/arm64/boot/dts/hisilicon/hip06.dtsi    | 307 ++++++++++++++++++++++++++++
 3 files changed, 344 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/hisilicon/hip06-d03.dts
 create mode 100644 arch/arm64/boot/dts/hisilicon/hip06.dtsi

diff --git a/arch/arm64/boot/dts/hisilicon/Makefile b/arch/arm64/boot/dts/hisilicon/Makefile
index cd158b8..d5f43a0 100644
--- a/arch/arm64/boot/dts/hisilicon/Makefile
+++ b/arch/arm64/boot/dts/hisilicon/Makefile
@@ -1,4 +1,6 @@
-dtb-$(CONFIG_ARCH_HISI) += hi6220-hikey.dtb hip05-d02.dtb
+dtb-$(CONFIG_ARCH_HISI) += hi6220-hikey.dtb
+dtb-$(CONFIG_ARCH_HISI) += hip05-d02.dtb
+dtb-$(CONFIG_ARCH_HISI) += hip06-d03.dtb
 
 always		:= $(dtb-y)
 subdir-y	:= $(dts-dirs)
diff --git a/arch/arm64/boot/dts/hisilicon/hip06-d03.dts b/arch/arm64/boot/dts/hisilicon/hip06-d03.dts
new file mode 100644
index 0000000..f3e5323
--- /dev/null
+++ b/arch/arm64/boot/dts/hisilicon/hip06-d03.dts
@@ -0,0 +1,34 @@
+/**
+ * dts file for Hisilicon D03 Development Board
+ *
+ * Copyright (C) 2016 Hisilicon Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * publishhed by the Free Software Foundation.
+ *
+ */
+
+/dts-v1/;
+
+#include "hip06.dtsi"
+
+/ {
+	model = "Hisilicon Hip06 D03 Development Board";
+	compatible = "hisilicon,hip06-d03";
+
+	memory at 00000000 {
+		device_type = "memory";
+		reg = <0x0 0x00000000 0x0 0x40000000>;
+	};
+
+	chosen { };
+};
+
+&usb_ohci {
+	status = "ok";
+};
+
+&usb_ehci {
+	status = "ok";
+};
diff --git a/arch/arm64/boot/dts/hisilicon/hip06.dtsi b/arch/arm64/boot/dts/hisilicon/hip06.dtsi
new file mode 100644
index 0000000..5927bc4
--- /dev/null
+++ b/arch/arm64/boot/dts/hisilicon/hip06.dtsi
@@ -0,0 +1,307 @@
+/**
+ * dts file for Hisilicon D03 Development Board
+ *
+ * Copyright (C) 2016 Hisilicon Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * publishhed by the Free Software Foundation.
+ *
+ */
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/ {
+	compatible = "hisilicon,hip06-d03";
+	interrupt-parent = <&gic>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	psci {
+		compatible = "arm,psci-0.2";
+		method = "smc";
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu-map {
+			cluster0 {
+				core0 {
+					cpu = <&cpu0>;
+				};
+				core1 {
+					cpu = <&cpu1>;
+				};
+				core2 {
+					cpu = <&cpu2>;
+				};
+				core3 {
+					cpu = <&cpu3>;
+				};
+			};
+			cluster1 {
+				core0 {
+					cpu = <&cpu4>;
+				};
+				core1 {
+					cpu = <&cpu5>;
+				};
+				core2 {
+					cpu = <&cpu6>;
+				};
+				core3 {
+					cpu = <&cpu7>;
+				};
+			};
+			cluster2 {
+				core0 {
+					cpu = <&cpu8>;
+				};
+				core1 {
+					cpu = <&cpu9>;
+				};
+				core2 {
+					cpu = <&cpu10>;
+				};
+				core3 {
+					cpu = <&cpu11>;
+				};
+			};
+			cluster3 {
+				core0 {
+					cpu = <&cpu12>;
+				};
+				core1 {
+					cpu = <&cpu13>;
+				};
+				core2 {
+					cpu = <&cpu14>;
+				};
+				core3 {
+					cpu = <&cpu15>;
+				};
+			};
+		};
+
+		cpu0: cpu at 10000 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a57", "arm,armv8";
+			reg = <0x10000>;
+			enable-method = "psci";
+			next-level-cache = <&cluster0_l2>;
+		};
+
+		cpu1: cpu at 10001 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a57", "arm,armv8";
+			reg = <0x10001>;
+			enable-method = "psci";
+			next-level-cache = <&cluster0_l2>;
+		};
+
+		cpu2: cpu at 10002 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a57", "arm,armv8";
+			reg = <0x10002>;
+			enable-method = "psci";
+			next-level-cache = <&cluster0_l2>;
+		};
+
+		cpu3: cpu at 10003 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a57", "arm,armv8";
+			reg = <0x10003>;
+			enable-method = "psci";
+			next-level-cache = <&cluster0_l2>;
+		};
+
+		cpu4: cpu at 10100 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a57", "arm,armv8";
+			reg = <0x10100>;
+			enable-method = "psci";
+			next-level-cache = <&cluster1_l2>;
+		};
+
+		cpu5: cpu at 10101 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a57", "arm,armv8";
+			reg = <0x10101>;
+			enable-method = "psci";
+			next-level-cache = <&cluster1_l2>;
+		};
+
+		cpu6: cpu at 10102 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a57", "arm,armv8";
+			reg = <0x10102>;
+			enable-method = "psci";
+			next-level-cache = <&cluster1_l2>;
+		};
+
+		cpu7: cpu at 10103 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a57", "arm,armv8";
+			reg = <0x10103>;
+			enable-method = "psci";
+			next-level-cache = <&cluster1_l2>;
+		};
+
+		cpu8: cpu at 10200 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a57", "arm,armv8";
+			reg = <0x10200>;
+			enable-method = "psci";
+			next-level-cache = <&cluster2_l2>;
+		};
+
+		cpu9: cpu at 10201 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a57", "arm,armv8";
+			reg = <0x10201>;
+			enable-method = "psci";
+			next-level-cache = <&cluster2_l2>;
+		};
+
+		cpu10: cpu at 10202 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a57", "arm,armv8";
+			reg = <0x10202>;
+			enable-method = "psci";
+			next-level-cache = <&cluster2_l2>;
+		};
+
+		cpu11: cpu at 10203 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a57", "arm,armv8";
+			reg = <0x10203>;
+			enable-method = "psci";
+			next-level-cache = <&cluster2_l2>;
+		};
+
+		cpu12: cpu at 10300 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a57", "arm,armv8";
+			reg = <0x10300>;
+			enable-method = "psci";
+			next-level-cache = <&cluster3_l2>;
+		};
+
+		cpu13: cpu at 10301 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a57", "arm,armv8";
+			reg = <0x10301>;
+			enable-method = "psci";
+			next-level-cache = <&cluster3_l2>;
+		};
+
+		cpu14: cpu at 10302 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a57", "arm,armv8";
+			reg = <0x10302>;
+			enable-method = "psci";
+			next-level-cache = <&cluster3_l2>;
+		};
+
+		cpu15: cpu at 10303 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a57", "arm,armv8";
+			reg = <0x10303>;
+			enable-method = "psci";
+			next-level-cache = <&cluster3_l2>;
+		};
+
+		cluster0_l2: l2-cache0 {
+			compatible = "cache";
+		};
+
+		cluster1_l2: l2-cache1 {
+			compatible = "cache";
+		};
+
+		cluster2_l2: l2-cache2 {
+			compatible = "cache";
+		};
+
+		cluster3_l2: l2-cache3 {
+			compatible = "cache";
+		};
+	};
+
+	gic: interrupt-controller at 4d000000 {
+		compatible = "arm,gic-v3";
+		#interrupt-cells = <3>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+		interrupt-controller;
+		#redistributor-regions = <1>;
+		redistributor-stride = <0x0 0x30000>;
+		reg = <0x0 0x4d000000 0 0x10000>,	/* GICD */
+		      <0x0 0x4d100000 0 0x300000>,	/* GICR */
+		      <0x0 0xfe000000 0 0x10000>,	/* GICC */
+		      <0x0 0xfe010000 0 0x10000>,       /* GICH */
+		      <0x0 0xfe020000 0 0x10000>;       /* GICV */
+		interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
+
+		its_dsa: interrupt-controller at c6000000 {
+			compatible = "arm,gic-v3-its";
+			msi-controller;
+			#msi-cells = <1>;
+			reg = <0x0 0xc6000000 0x0 0x40000>;
+		};
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
+	};
+
+	pmu {
+		compatible = "arm,cortex-a57-pmu";
+		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	mbigen_pcie at a0080000 {
+		compatible = "hisilicon,mbigen-v2";
+		reg = <0x0 0xa0080000 0x0 0x10000>;
+
+		mbigen_usb: intc_usb {
+			msi-parent = <&its_dsa 0x40080>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			num-pins = <2>;
+		};
+	};
+
+	soc {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		usb_ohci: ohci at a7030000 {
+			compatible = "generic-ohci";
+			reg = <0x0 0xa7030000 0x0 0x10000>;
+			interrupt-parent = <&mbigen_usb>;
+			interrupts = <64 4>;
+			dma-coherent;
+			status = "disabled";
+		};
+
+		usb_ehci: ehci at a7020000 {
+			compatible = "generic-ehci";
+			reg = <0x0 0xa7020000 0x0 0x10000>;
+			interrupt-parent = <&mbigen_usb>;
+			interrupts = <65 4>;
+			dma-coherent;
+			status = "disabled";
+		};
+	};
+
+};
-- 
1.7.12.4
