From: vkoul@kernel.org (Vinod Koul)
Date: Fri,  9 Nov 2018 15:14:03 +0530
Subject: [PATCH v5 04/18] arm64: dts: qcom: qcs404: Add RPM GLINK related nodes
In-Reply-To: <20181109094417.12109-1-vkoul@kernel.org>
References: <20181109094417.12109-1-vkoul@kernel.org>
Message-ID: <20181109094417.12109-5-vkoul@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bjorn Andersson <bjorn.andersson@linaro.org>

Add RPM GLINK node and the RPM message ram, hwspinlock, APCS apps global
and smem nodes it depends on.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 arch/arm64/boot/dts/qcom/qcs404.dtsi | 44 ++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
index d40f3923ed69..6bc0925acda9 100644
--- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
@@ -114,12 +114,45 @@
 		};
 	};
 
+	rpm-glink {
+		compatible = "qcom,glink-rpm";
+
+		interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
+		qcom,rpm-msg-ram = <&rpm_msg_ram>;
+		mboxes = <&apcs_glb 0>;
+
+		rpm_requests: glink-channel {
+			compatible = "qcom,rpm-qcs404";
+			qcom,glink-channels = "rpm_requests";
+		};
+	};
+
+	smem {
+		compatible = "qcom,smem";
+
+		memory-region = <&smem_region>;
+		qcom,rpm-msg-ram = <&rpm_msg_ram>;
+
+		hwlocks = <&tcsr_mutex 3>;
+	};
+
+	tcsr_mutex: hwlock {
+		compatible = "qcom,tcsr-mutex";
+		syscon = <&tcsr_mutex_regs 0 0x1000>;
+		#hwlock-cells = <1>;
+	};
+
 	soc: soc at 0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges = <0 0 0 0xffffffff>;
 		compatible = "simple-bus";
 
+		rpm_msg_ram: memory at 60000 {
+			compatible = "qcom,rpm-msg-ram";
+			reg = <0x00060000 0x6000>;
+		};
+
 		gcc: clock-controller at 1800000 {
 			compatible = "qcom,gcc-qcs404";
 			reg = <0x01800000 0x80000>;
@@ -129,6 +162,11 @@
 			assigned-clock-rates = <19200000>;
 		};
 
+		tcsr_mutex_regs: syscon at 1905000 {
+			compatible = "syscon";
+			reg = <0x01905000 0x20000>;
+		};
+
 		blsp1_uart2: serial at 78b1000 {
 			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
 			reg = <0x078b1000 0x200>;
@@ -146,6 +184,12 @@
 			      <0x0b002000 0x1000>;
 		};
 
+		apcs_glb: mailbox at b011000 {
+			compatible = "qcom,qcs404-apcs-apps-global", "syscon";
+			reg = <0x0b011000 0x1000>;
+			#mbox-cells = <1>;
+		};
+
 		timer at b120000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
-- 
2.14.4
