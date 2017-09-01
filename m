From: leo.yan@linaro.org (Leo Yan)
Date: Fri,  1 Sep 2017 08:47:15 +0800
Subject: [PATCH 2/2] arm64: dts: hi6220: add coresight binding
In-Reply-To: <1504226835-2115-1-git-send-email-leo.yan@linaro.org>
References: <1504226835-2115-1-git-send-email-leo.yan@linaro.org>
Message-ID: <1504226835-2115-3-git-send-email-leo.yan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Li Pengcheng <lipengcheng8@huawei.com>

For detailed coresight topology, Hi6220 has 8xCA53 CPUs and each CPU
has one Embedded Trace Macrocell (ETM); the CPU trace data is output
to the cluster funnel. Due system has another CPU and one MCU, all of
them transfer the trace data through trace bus (ATB) to SoC funnel;
the SoC funnel is connected to Embedded Trace FIFO (ETF) with 8KB
buffer; an non-configurable replicator is used to output trace data
for two sinks, one is Embedded Trace Route (ETR) so trace data can be
saved into DRAM, another is Trace Port Interface Unit (TPIU) for
capturing trace data by external debugger.

According to the Hi6220 coresight topology, this patch is to add
coresight dt binding.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Guodong Xu <guodong.xu@linaro.org>
Cc: Zhangfei Gao <zhangfei.gao@linaro.org>
Cc: Haojian Zhuang <haojian.zhuang@linaro.org>
Signed-off-by: Li Pengcheng <lipengcheng8@huawei.com>
Signed-off-by: Li Zhong <lizhong11@hisilicon.com>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 .../arm64/boot/dts/hisilicon/hi6220-coresight.dtsi | 379 +++++++++++++++++++++
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi          |   2 +
 2 files changed, 381 insertions(+)
 create mode 100644 arch/arm64/boot/dts/hisilicon/hi6220-coresight.dtsi

diff --git a/arch/arm64/boot/dts/hisilicon/hi6220-coresight.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220-coresight.dtsi
new file mode 100644
index 0000000..31e4e95
--- /dev/null
+++ b/arch/arm64/boot/dts/hisilicon/hi6220-coresight.dtsi
@@ -0,0 +1,379 @@
+/*
+ * dtsi file for Hisilicon Hi6220 coresight
+ *
+ * Copyright (C) 2017 Hisilicon Ltd.
+ *
+ * Author: Pengcheng Li <lipengcheng8@huawei.com>
+ *         Leo Yan <leo.yan@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * publishhed by the Free Software Foundation.
+ *
+ */
+
+/ {
+	soc {
+		funnel at f6401000 {
+			compatible = "arm,coresight-funnel", "arm,primecell";
+			reg = <0 0xf6401000 0 0x1000>;
+			clocks = <&acpu_sctrl HI6220_ACPU_SFT_AT_S>;
+			clock-names = "apb_pclk";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port at 0 {
+					reg = <0>;
+					soc_funnel_out: endpoint {
+						remote-endpoint =
+							<&etf_in>;
+					};
+				};
+
+				port at 1 {
+					reg = <0>;
+					soc_funnel_in: endpoint {
+						slave-mode;
+						remote-endpoint =
+							<&acpu_funnel_out>;
+					};
+				};
+			};
+		};
+
+		etf at f6402000 {
+			compatible = "arm,coresight-tmc", "arm,primecell";
+			reg = <0 0xf6402000 0 0x1000>;
+			clocks = <&acpu_sctrl HI6220_ACPU_SFT_AT_S>;
+			clock-names = "apb_pclk";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port at 0 {
+					reg = <0>;
+					etf_in: endpoint {
+						slave-mode;
+						remote-endpoint =
+							<&soc_funnel_out>;
+					};
+				};
+
+				port at 1 {
+					reg = <0>;
+					etf_out: endpoint {
+						remote-endpoint =
+							<&replicator_in>;
+					};
+				};
+			};
+		};
+
+		replicator {
+			compatible = "arm,coresight-replicator";
+			clocks = <&acpu_sctrl HI6220_ACPU_SFT_AT_S>;
+			clock-names = "apb_pclk";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port at 0 {
+					reg = <0>;
+					replicator_in: endpoint {
+						slave-mode;
+						remote-endpoint =
+							<&etf_out>;
+					};
+				};
+
+				port at 1 {
+					reg = <0>;
+					replicator_out0: endpoint {
+						remote-endpoint =
+							<&etr_in>;
+					};
+				};
+
+				port at 2 {
+					reg = <1>;
+					replicator_out1: endpoint {
+						remote-endpoint =
+							<&tpiu_in>;
+					};
+				};
+			};
+		};
+
+		etr at f6404000 {
+			compatible = "arm,coresight-tmc", "arm,primecell";
+			reg = <0 0xf6404000 0 0x1000>;
+			clocks = <&acpu_sctrl HI6220_ACPU_SFT_AT_S>;
+			clock-names = "apb_pclk";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port at 0 {
+					etr_in: endpoint {
+						slave-mode;
+						remote-endpoint =
+							<&replicator_out0>;
+					};
+				};
+			};
+		};
+
+		tpiu at f6405000 {
+			compatible = "arm,coresight-tpiu", "arm,primecell";
+			reg = <0 0xf6405000 0 0x1000>;
+			clocks = <&acpu_sctrl HI6220_ACPU_SFT_AT_S>;
+			clock-names = "apb_pclk";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port at 0 {
+					tpiu_in: endpoint {
+						slave-mode;
+						remote-endpoint =
+							<&replicator_out1>;
+					};
+				};
+			};
+		};
+
+		funnel at f6501000 {
+			compatible = "arm,coresight-funnel", "arm,primecell";
+			reg = <0 0xf6501000 0 0x1000>;
+			clocks = <&acpu_sctrl HI6220_ACPU_SFT_AT_S>;
+			clock-names = "apb_pclk";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port at 0 {
+					reg = <0>;
+					acpu_funnel_out: endpoint {
+						remote-endpoint =
+							<&soc_funnel_in>;
+					};
+				};
+
+				port at 1 {
+					reg = <0>;
+					acpu_funnel_in0: endpoint {
+						slave-mode;
+						remote-endpoint =
+							<&etm0_out>;
+					};
+				};
+
+				port at 2 {
+					reg = <1>;
+					acpu_funnel_in1: endpoint {
+						slave-mode;
+						remote-endpoint =
+							<&etm1_out>;
+					};
+				};
+
+				port at 3 {
+					reg = <2>;
+					acpu_funnel_in2: endpoint {
+						slave-mode;
+						remote-endpoint =
+							<&etm2_out>;
+					};
+				};
+
+				port at 4 {
+					reg = <3>;
+					acpu_funnel_in3: endpoint {
+						slave-mode;
+						remote-endpoint =
+							<&etm3_out>;
+					};
+				};
+
+				port at 5 {
+					reg = <4>;
+					acpu_funnel_in4: endpoint {
+						slave-mode;
+						remote-endpoint =
+							<&etm4_out>;
+					};
+				};
+
+				port at 6 {
+					reg = <5>;
+					acpu_funnel_in5: endpoint {
+						slave-mode;
+						remote-endpoint =
+							<&etm5_out>;
+					};
+				};
+
+				port at 7 {
+					reg = <6>;
+					acpu_funnel_in6: endpoint {
+						slave-mode;
+						remote-endpoint =
+							<&etm6_out>;
+					};
+				};
+
+				port at 8 {
+					reg = <7>;
+					acpu_funnel_in7: endpoint {
+						slave-mode;
+						remote-endpoint =
+							<&etm7_out>;
+					};
+				};
+			};
+		};
+
+		etm at f659c000 {
+			compatible = "arm,coresight-etm4x", "arm,primecell";
+			reg = <0 0xf659c000 0 0x1000>;
+
+			clocks = <&acpu_sctrl HI6220_ACPU_SFT_AT_S>;
+			clock-names = "apb_pclk";
+
+			cpu = <&cpu0>;
+
+			port {
+				etm0_out: endpoint {
+					remote-endpoint =
+						<&acpu_funnel_in0>;
+				};
+			};
+		};
+
+		etm at f659d000 {
+			compatible = "arm,coresight-etm4x", "arm,primecell";
+			reg = <0 0xf659d000 0 0x1000>;
+
+			clocks = <&acpu_sctrl HI6220_ACPU_SFT_AT_S>;
+			clock-names = "apb_pclk";
+
+			cpu = <&cpu1>;
+
+			port {
+				etm1_out: endpoint {
+					remote-endpoint =
+						<&acpu_funnel_in1>;
+				};
+			};
+		};
+
+		etm at f659e000 {
+			compatible = "arm,coresight-etm4x", "arm,primecell";
+			reg = <0 0xf659e000 0 0x1000>;
+
+			clocks = <&acpu_sctrl HI6220_ACPU_SFT_AT_S>;
+			clock-names = "apb_pclk";
+
+			cpu = <&cpu2>;
+
+			port {
+				etm2_out: endpoint {
+					remote-endpoint =
+						<&acpu_funnel_in2>;
+				};
+			};
+		};
+
+		etm at f659f000 {
+			compatible = "arm,coresight-etm4x", "arm,primecell";
+			reg = <0 0xf659f000 0 0x1000>;
+
+			clocks = <&acpu_sctrl HI6220_ACPU_SFT_AT_S>;
+			clock-names = "apb_pclk";
+
+			cpu = <&cpu3>;
+
+			port {
+				etm3_out: endpoint {
+					remote-endpoint =
+						<&acpu_funnel_in3>;
+				};
+			};
+		};
+
+		etm at f65dc000 {
+			compatible = "arm,coresight-etm4x", "arm,primecell";
+			reg = <0 0xf65dc000 0 0x1000>;
+
+			clocks = <&acpu_sctrl HI6220_ACPU_SFT_AT_S>;
+			clock-names = "apb_pclk";
+
+			cpu = <&cpu4>;
+
+			port {
+				etm4_out: endpoint {
+					remote-endpoint =
+						<&acpu_funnel_in4>;
+				};
+			};
+		};
+
+		etm at f65dd000 {
+			compatible = "arm,coresight-etm4x", "arm,primecell";
+			reg = <0 0xf65dd000 0 0x1000>;
+
+			clocks = <&acpu_sctrl HI6220_ACPU_SFT_AT_S>;
+			clock-names = "apb_pclk";
+
+			cpu = <&cpu5>;
+
+			port {
+				etm5_out: endpoint {
+					remote-endpoint =
+						<&acpu_funnel_in5>;
+				};
+			};
+		};
+
+		etm at f65de000 {
+			compatible = "arm,coresight-etm4x", "arm,primecell";
+			reg = <0 0xf65de000 0 0x1000>;
+
+			clocks = <&acpu_sctrl HI6220_ACPU_SFT_AT_S>;
+			clock-names = "apb_pclk";
+
+			cpu = <&cpu6>;
+
+			port {
+				etm6_out: endpoint {
+					remote-endpoint =
+						<&acpu_funnel_in6>;
+				};
+			};
+		};
+
+		etm at f65df000 {
+			compatible = "arm,coresight-etm4x", "arm,primecell";
+			reg = <0 0xf65df000 0 0x1000>;
+
+			clocks = <&acpu_sctrl HI6220_ACPU_SFT_AT_S>;
+			clock-names = "apb_pclk";
+
+			cpu = <&cpu7>;
+
+			port {
+				etm7_out: endpoint {
+					remote-endpoint =
+						<&acpu_funnel_in7>;
+				};
+			};
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
index 02a3aa4..b3b21d7 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
@@ -986,3 +986,5 @@
 		};
 	};
 };
+
+#include "hi6220-coresight.dtsi"
-- 
2.7.4
