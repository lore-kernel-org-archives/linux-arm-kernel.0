From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 17 Jan 2017 12:15:13 +0000
Subject: [PATCH v4 4/4] arm64: dts: juno: add missing CoreSight STM component
In-Reply-To: <1484655313-9025-1-git-send-email-sudeep.holla@arm.com>
References: <1484655313-9025-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <1484655313-9025-5-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mike Leach <mike.leach@linaro.org>

This patch adds the missing CoreSight STM component definition to the
device tree of all the juno variants(r0,r1,r2)

STM component is connected to different funnels depending on Juno
platform variant.

Reviewed-and-Tested-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Mike Leach <mike.leach@linaro.org>
[sudeep.holla at arm.com: minor changelog update and reorganising the STM
	node back into juno-base.dtsi to avoid duplication]
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/arm64/boot/dts/arm/juno-base.dtsi | 15 +++++++++++++++
 arch/arm64/boot/dts/arm/juno-r1.dts    |  4 ++++
 arch/arm64/boot/dts/arm/juno-r2.dts    |  4 ++++
 arch/arm64/boot/dts/arm/juno.dts       | 16 ++++++++++++++++
 4 files changed, 39 insertions(+)

diff --git a/arch/arm64/boot/dts/arm/juno-base.dtsi b/arch/arm64/boot/dts/arm/juno-base.dtsi
index faedf357db3b..58c1773c3aa4 100644
--- a/arch/arm64/boot/dts/arm/juno-base.dtsi
+++ b/arch/arm64/boot/dts/arm/juno-base.dtsi
@@ -185,6 +185,21 @@
 		};
 	};

+	stm at 20100000 {
+		compatible = "arm,coresight-stm", "arm,primecell";
+		reg = <0 0x20100000 0 0x1000>,
+		      <0 0x28000000 0 0x180000>;
+		reg-names = "stm-base", "stm-stimulus-base";
+
+		clocks = <&soc_smc50mhz>;
+		clock-names = "apb_pclk";
+		power-domains = <&scpi_devpd 0>;
+		port {
+			stm_out_port: endpoint {
+			};
+		};
+	};
+
 	etm0: etm at 22040000 {
 		compatible = "arm,coresight-etm4x", "arm,primecell";
 		reg = <0 0x22040000 0 0x1000>;
diff --git a/arch/arm64/boot/dts/arm/juno-r1.dts b/arch/arm64/boot/dts/arm/juno-r1.dts
index aef138aa5765..0033c59a64b5 100644
--- a/arch/arm64/boot/dts/arm/juno-r1.dts
+++ b/arch/arm64/boot/dts/arm/juno-r1.dts
@@ -235,3 +235,7 @@
 &replicator_in_port0 {
 	remote-endpoint = <&csys2_funnel_out_port>;
 };
+
+&stm_out_port {
+	remote-endpoint = <&csys1_funnel_in_port0>;
+};
diff --git a/arch/arm64/boot/dts/arm/juno-r2.dts b/arch/arm64/boot/dts/arm/juno-r2.dts
index 827da7c92607..218d0e4736a8 100644
--- a/arch/arm64/boot/dts/arm/juno-r2.dts
+++ b/arch/arm64/boot/dts/arm/juno-r2.dts
@@ -235,3 +235,7 @@
 &replicator_in_port0 {
 	remote-endpoint = <&csys2_funnel_out_port>;
 };
+
+&stm_out_port {
+	remote-endpoint = <&csys1_funnel_in_port0>;
+};
diff --git a/arch/arm64/boot/dts/arm/juno.dts b/arch/arm64/boot/dts/arm/juno.dts
index 66fa4388d181..bb2820ef3d5b 100644
--- a/arch/arm64/boot/dts/arm/juno.dts
+++ b/arch/arm64/boot/dts/arm/juno.dts
@@ -210,3 +210,19 @@
 &replicator_in_port0 {
 	remote-endpoint = <&etf0_out_port>;
 };
+
+&stm_out_port {
+	remote-endpoint = <&main_funnel_in_port2>;
+};
+
+&main_funnel {
+	ports {
+		port at 3 {
+			reg = <2>;
+			main_funnel_in_port2: endpoint {
+				slave-mode;
+				remote-endpoint = <&stm_out_port>;
+			};
+		};
+	};
+};
--
2.7.4
