From: aisheng.dong@nxp.com (A.s. Dong)
Date: Sat, 10 Nov 2018 15:20:01 +0000
Subject: [PATCH V6 4/6] dt-bindings: clock: add imx8qxp lpcg clock binding
In-Reply-To: <1541862894-8209-1-git-send-email-aisheng.dong@nxp.com>
References: <1541862894-8209-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <1541862894-8209-5-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Low-Power Clock Gate (LPCG) modules contain a local programming
model to control the clock gates for the peripherals. An LPCG module
is used to locally gate the clocks for the associated peripheral.

Note:
This level of clock gating is provided after the clocks are generated
by the SCU resources and clock controls. Thus even if the clock is
enabled by these control bits, it might still not be running based
on the base resource.

Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree at vger.kernel.org
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 .../devicetree/bindings/clock/imx8qxp-lpcg.txt     |  51 +++++++
 include/dt-bindings/clock/imx8qxp-clock.h          | 153 +++++++++++++++++++++
 2 files changed, 204 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/imx8qxp-lpcg.txt

diff --git a/Documentation/devicetree/bindings/clock/imx8qxp-lpcg.txt b/Documentation/devicetree/bindings/clock/imx8qxp-lpcg.txt
new file mode 100644
index 0000000..965cfa4
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/imx8qxp-lpcg.txt
@@ -0,0 +1,51 @@
+* NXP i.MX8QXP LPCG (Low-Power Clock Gating) Clock bindings
+
+The Low-Power Clock Gate (LPCG) modules contain a local programming
+model to control the clock gates for the peripherals. An LPCG module
+is used to locally gate the clocks for the associated peripheral.
+
+Note:
+This level of clock gating is provided after the clocks are generated
+by the SCU resources and clock controls. Thus even if the clock is
+enabled by these control bits, it might still not be running based
+on the base resource.
+
+Required properties:
+- compatible:	Should be one of:
+		  "fsl,imx8qxp-lpcg-adma",
+		  "fsl,imx8qxp-lpcg-conn",
+		  "fsl,imx8qxp-lpcg-dc",
+		  "fsl,imx8qxp-lpcg-dsp",
+		  "fsl,imx8qxp-lpcg-gpu",
+		  "fsl,imx8qxp-lpcg-hsio",
+		  "fsl,imx8qxp-lpcg-img",
+		  "fsl,imx8qxp-lpcg-lsio",
+		  "fsl,imx8qxp-lpcg-vpu"
+- reg:		Address and length of the register set
+- #clock-cells:	Should be <1>
+
+The clock consumer should specify the desired clock by having the clock
+ID in its "clocks" phandle cell.
+See the full list of clock IDs from:
+include/dt-bindings/clock/imx8qxp-clock.h
+
+Examples:
+
+#include <dt-bindings/clock/imx8qxp-clock.h>
+
+conn_lpcg: clock-controller at 5b200000 {
+	compatible = "fsl,imx8qxp-lpcg-conn";
+	reg = <0x5b200000 0xb0000>;
+	#clock-cells = <1>;
+};
+
+usdhc1: mmc at 5b010000 {
+	compatible = "fsl,imx8qxp-usdhc", "fsl,imx7d-usdhc";
+	interrupt-parent = <&gic>;
+	interrupts = <GIC_SPI 232 IRQ_TYPE_LEVEL_HIGH>;
+	reg = <0x5b010000 0x10000>;
+	clocks = <&conn_lpcg IMX8QXP_CONN_LPCG_SDHC0_IPG_CLK>,
+		 <&conn_lpcg IMX8QXP_CONN_LPCG_SDHC0_PER_CLK>,
+		 <&conn_lpcg IMX8QXP_CONN_LPCG_SDHC0_HCLK>;
+	clock-names = "ipg", "per", "ahb";
+};
diff --git a/include/dt-bindings/clock/imx8qxp-clock.h b/include/dt-bindings/clock/imx8qxp-clock.h
index d72a39c..6fec368 100644
--- a/include/dt-bindings/clock/imx8qxp-clock.h
+++ b/include/dt-bindings/clock/imx8qxp-clock.h
@@ -133,4 +133,157 @@
 
 #define IMX8QXP_SCU_CLK_END				190
 
+/* LPCG clocks */
+
+/* LSIO SS LPCG */
+#define IMX8QXP_LSIO_LPCG_PWM0_IPG_CLK			0
+#define IMX8QXP_LSIO_LPCG_PWM0_IPG_S_CLK		1
+#define IMX8QXP_LSIO_LPCG_PWM0_IPG_HF_CLK		2
+#define IMX8QXP_LSIO_LPCG_PWM0_IPG_SLV_CLK		3
+#define IMX8QXP_LSIO_LPCG_PWM0_IPG_MSTR_CLK		4
+#define IMX8QXP_LSIO_LPCG_PWM1_IPG_CLK			5
+#define IMX8QXP_LSIO_LPCG_PWM1_IPG_S_CLK		6
+#define IMX8QXP_LSIO_LPCG_PWM1_IPG_HF_CLK		7
+#define IMX8QXP_LSIO_LPCG_PWM1_IPG_SLV_CLK		8
+#define IMX8QXP_LSIO_LPCG_PWM1_IPG_MSTR_CLK		9
+#define IMX8QXP_LSIO_LPCG_PWM2_IPG_CLK			10
+#define IMX8QXP_LSIO_LPCG_PWM2_IPG_S_CLK		11
+#define IMX8QXP_LSIO_LPCG_PWM2_IPG_HF_CLK		12
+#define IMX8QXP_LSIO_LPCG_PWM2_IPG_SLV_CLK		13
+#define IMX8QXP_LSIO_LPCG_PWM2_IPG_MSTR_CLK		14
+#define IMX8QXP_LSIO_LPCG_PWM3_IPG_CLK			15
+#define IMX8QXP_LSIO_LPCG_PWM3_IPG_S_CLK		16
+#define IMX8QXP_LSIO_LPCG_PWM3_IPG_HF_CLK		17
+#define IMX8QXP_LSIO_LPCG_PWM3_IPG_SLV_CLK		18
+#define IMX8QXP_LSIO_LPCG_PWM3_IPG_MSTR_CLK		19
+#define IMX8QXP_LSIO_LPCG_PWM4_IPG_CLK			20
+#define IMX8QXP_LSIO_LPCG_PWM4_IPG_S_CLK		21
+#define IMX8QXP_LSIO_LPCG_PWM4_IPG_HF_CLK		22
+#define IMX8QXP_LSIO_LPCG_PWM4_IPG_SLV_CLK		23
+#define IMX8QXP_LSIO_LPCG_PWM4_IPG_MSTR_CLK		24
+#define IMX8QXP_LSIO_LPCG_PWM5_IPG_CLK			25
+#define IMX8QXP_LSIO_LPCG_PWM5_IPG_S_CLK		26
+#define IMX8QXP_LSIO_LPCG_PWM5_IPG_HF_CLK		27
+#define IMX8QXP_LSIO_LPCG_PWM5_IPG_SLV_CLK		28
+#define IMX8QXP_LSIO_LPCG_PWM5_IPG_MSTR_CLK		29
+#define IMX8QXP_LSIO_LPCG_PWM6_IPG_CLK			30
+#define IMX8QXP_LSIO_LPCG_PWM6_IPG_S_CLK		31
+#define IMX8QXP_LSIO_LPCG_PWM6_IPG_HF_CLK		32
+#define IMX8QXP_LSIO_LPCG_PWM6_IPG_SLV_CLK		33
+#define IMX8QXP_LSIO_LPCG_PWM6_IPG_MSTR_CLK		34
+#define IMX8QXP_LSIO_LPCG_PWM7_IPG_CLK			35
+#define IMX8QXP_LSIO_LPCG_PWM7_IPG_S_CLK		36
+#define IMX8QXP_LSIO_LPCG_PWM7_IPG_HF_CLK		37
+#define IMX8QXP_LSIO_LPCG_PWM7_IPG_SLV_CLK		38
+#define IMX8QXP_LSIO_LPCG_PWM7_IPG_MSTR_CLK		39
+#define IMX8QXP_LSIO_LPCG_GPT0_IPG_CLK			40
+#define IMX8QXP_LSIO_LPCG_GPT0_IPG_S_CLK		41
+#define IMX8QXP_LSIO_LPCG_GPT0_IPG_HF_CLK		42
+#define IMX8QXP_LSIO_LPCG_GPT0_IPG_SLV_CLK		43
+#define IMX8QXP_LSIO_LPCG_GPT0_IPG_MSTR_CLK		44
+#define IMX8QXP_LSIO_LPCG_GPT1_IPG_CLK			45
+#define IMX8QXP_LSIO_LPCG_GPT1_IPG_S_CLK		46
+#define IMX8QXP_LSIO_LPCG_GPT1_IPG_HF_CLK		47
+#define IMX8QXP_LSIO_LPCG_GPT1_IPG_SLV_CLK		48
+#define IMX8QXP_LSIO_LPCG_GPT1_IPG_MSTR_CLK		49
+#define IMX8QXP_LSIO_LPCG_GPT2_IPG_CLK			50
+#define IMX8QXP_LSIO_LPCG_GPT2_IPG_S_CLK		51
+#define IMX8QXP_LSIO_LPCG_GPT2_IPG_HF_CLK		52
+#define IMX8QXP_LSIO_LPCG_GPT2_IPG_SLV_CLK		53
+#define IMX8QXP_LSIO_LPCG_GPT2_IPG_MSTR_CLK		54
+#define IMX8QXP_LSIO_LPCG_GPT3_IPG_CLK			55
+#define IMX8QXP_LSIO_LPCG_GPT3_IPG_S_CLK		56
+#define IMX8QXP_LSIO_LPCG_GPT3_IPG_HF_CLK		57
+#define IMX8QXP_LSIO_LPCG_GPT3_IPG_SLV_CLK		58
+#define IMX8QXP_LSIO_LPCG_GPT3_IPG_MSTR_CLK		59
+#define IMX8QXP_LSIO_LPCG_GPT4_IPG_CLK			60
+#define IMX8QXP_LSIO_LPCG_GPT4_IPG_S_CLK		61
+#define IMX8QXP_LSIO_LPCG_GPT4_IPG_HF_CLK		62
+#define IMX8QXP_LSIO_LPCG_GPT4_IPG_SLV_CLK		63
+#define IMX8QXP_LSIO_LPCG_GPT4_IPG_MSTR_CLK		64
+#define IMX8QXP_LSIO_LPCG_FSPI0_HCLK			65
+#define IMX8QXP_LSIO_LPCG_FSPI0_IPG_CLK			66
+#define IMX8QXP_LSIO_LPCG_FSPI0_IPG_S_CLK		67
+#define IMX8QXP_LSIO_LPCG_FSPI0_IPG_SFCK		68
+#define IMX8QXP_LSIO_LPCG_FSPI1_HCLK			69
+#define IMX8QXP_LSIO_LPCG_FSPI1_IPG_CLK			70
+#define IMX8QXP_LSIO_LPCG_FSPI1_IPG_S_CLK		71
+#define IMX8QXP_LSIO_LPCG_FSPI1_IPG_SFCK		72
+
+#define IMX8QXP_LSIO_LPCG_CLK_END			73
+
+/* Connectivity SS LPCG */
+#define IMX8QXP_CONN_LPCG_SDHC0_IPG_CLK			0
+#define IMX8QXP_CONN_LPCG_SDHC0_PER_CLK			1
+#define IMX8QXP_CONN_LPCG_SDHC0_HCLK			2
+#define IMX8QXP_CONN_LPCG_SDHC1_IPG_CLK			3
+#define IMX8QXP_CONN_LPCG_SDHC1_PER_CLK			4
+#define IMX8QXP_CONN_LPCG_SDHC1_HCLK			5
+#define IMX8QXP_CONN_LPCG_SDHC2_IPG_CLK			6
+#define IMX8QXP_CONN_LPCG_SDHC2_PER_CLK			7
+#define IMX8QXP_CONN_LPCG_SDHC2_HCLK			8
+#define IMX8QXP_CONN_LPCG_GPMI_APB_CLK			9
+#define IMX8QXP_CONN_LPCG_GPMI_BCH_APB_CLK		10
+#define IMX8QXP_CONN_LPCG_GPMI_BCH_IO_CLK		11
+#define IMX8QXP_CONN_LPCG_GPMI_BCH_CLK			12
+#define IMX8QXP_CONN_LPCG_APBHDMA_CLK			13
+#define IMX8QXP_CONN_LPCG_ENET0_ROOT_CLK		14
+#define IMX8QXP_CONN_LPCG_ENET0_TX_CLK			15
+#define IMX8QXP_CONN_LPCG_ENET0_AHB_CLK			16
+#define IMX8QXP_CONN_LPCG_ENET0_IPG_S_CLK		17
+#define IMX8QXP_CONN_LPCG_ENET0_IPG_CLK			18
+
+#define IMX8QXP_CONN_LPCG_ENET1_ROOT_CLK		19
+#define IMX8QXP_CONN_LPCG_ENET1_TX_CLK			20
+#define IMX8QXP_CONN_LPCG_ENET1_AHB_CLK			21
+#define IMX8QXP_CONN_LPCG_ENET1_IPG_S_CLK		22
+#define IMX8QXP_CONN_LPCG_ENET1_IPG_CLK			23
+
+#define IMX8QXP_CONN_LPCG_CLK_END			24
+
+/* ADMA SS LPCG */
+#define IMX8QXP_ADMA_LPCG_UART0_IPG_CLK			0
+#define IMX8QXP_ADMA_LPCG_UART0_BAUD_CLK		1
+#define IMX8QXP_ADMA_LPCG_UART1_IPG_CLK			2
+#define IMX8QXP_ADMA_LPCG_UART1_BAUD_CLK		3
+#define IMX8QXP_ADMA_LPCG_UART2_IPG_CLK			4
+#define IMX8QXP_ADMA_LPCG_UART2_BAUD_CLK		5
+#define IMX8QXP_ADMA_LPCG_UART3_IPG_CLK			6
+#define IMX8QXP_ADMA_LPCG_UART3_BAUD_CLK		7
+#define IMX8QXP_ADMA_LPCG_SPI0_IPG_CLK			8
+#define IMX8QXP_ADMA_LPCG_SPI1_IPG_CLK			9
+#define IMX8QXP_ADMA_LPCG_SPI2_IPG_CLK			10
+#define IMX8QXP_ADMA_LPCG_SPI3_IPG_CLK			11
+#define IMX8QXP_ADMA_LPCG_SPI0_CLK			12
+#define IMX8QXP_ADMA_LPCG_SPI1_CLK			13
+#define IMX8QXP_ADMA_LPCG_SPI2_CLK			14
+#define IMX8QXP_ADMA_LPCG_SPI3_CLK			15
+#define IMX8QXP_ADMA_LPCG_CAN0_IPG_CLK			16
+#define IMX8QXP_ADMA_LPCG_CAN0_IPG_PE_CLK		17
+#define IMX8QXP_ADMA_LPCG_CAN0_IPG_CHI_CLK		18
+#define IMX8QXP_ADMA_LPCG_CAN1_IPG_CLK			19
+#define IMX8QXP_ADMA_LPCG_CAN1_IPG_PE_CLK		20
+#define IMX8QXP_ADMA_LPCG_CAN1_IPG_CHI_CLK		21
+#define IMX8QXP_ADMA_LPCG_CAN2_IPG_CLK			22
+#define IMX8QXP_ADMA_LPCG_CAN2_IPG_PE_CLK		23
+#define IMX8QXP_ADMA_LPCG_CAN2_IPG_CHI_CLK		24
+#define IMX8QXP_ADMA_LPCG_I2C0_CLK			25
+#define IMX8QXP_ADMA_LPCG_I2C1_CLK			26
+#define IMX8QXP_ADMA_LPCG_I2C2_CLK			27
+#define IMX8QXP_ADMA_LPCG_I2C3_CLK			28
+#define IMX8QXP_ADMA_LPCG_I2C0_IPG_CLK			29
+#define IMX8QXP_ADMA_LPCG_I2C1_IPG_CLK			30
+#define IMX8QXP_ADMA_LPCG_I2C2_IPG_CLK			31
+#define IMX8QXP_ADMA_LPCG_I2C3_IPG_CLK			32
+#define IMX8QXP_ADMA_LPCG_FTM0_CLK			33
+#define IMX8QXP_ADMA_LPCG_FTM1_CLK			34
+#define IMX8QXP_ADMA_LPCG_FTM0_IPG_CLK			35
+#define IMX8QXP_ADMA_LPCG_FTM1_IPG_CLK			36
+#define IMX8QXP_ADMA_LPCG_PWM_HI_CLK			37
+#define IMX8QXP_ADMA_LPCG_PWM_IPG_CLK			38
+#define IMX8QXP_ADMA_LPCG_LCD_PIX_CLK			39
+#define IMX8QXP_ADMA_LPCG_LCD_APB_CLK			40
+
+#define IMX8QXP_ADMA_LPCG_CLK_END			41
+
 #endif /* __DT_BINDINGS_CLOCK_IMX8QXP_H */
-- 
2.7.4
