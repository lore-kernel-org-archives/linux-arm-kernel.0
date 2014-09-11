From: b20788@freescale.com (Anson Huang)
Date: Thu, 11 Sep 2014 11:29:41 +0800
Subject: [PATCH V3 2/3] ARM: dts: imx6: make gpt per clock can be from OSC
In-Reply-To: <1410406182-21113-1-git-send-email-b20788@freescale.com>
References: <1410406182-21113-1-git-send-email-b20788@freescale.com>
Message-ID: <1410406182-21113-3-git-send-email-b20788@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Original gpt per clk parent is from ipg_per clk which
may be scaled when system enter low bus mode, as ipg
clk will be lower in low bus mode, to keep system clk
NOT drift, select gpt per clk parent from OSC which
is at fixed freq always.

On i.mx6qdl, add a osc_per clk source for i.mx6q
TO > 1.0 and all i.MX6dl SoC.

On i.mx6sx, just make gpt per clk from OSC.

Signed-off-by: Anson Huang <b20788@freescale.com>
---
 arch/arm/boot/dts/imx6qdl.dtsi |    5 +++--
 arch/arm/boot/dts/imx6sx.dtsi  |    2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 70d7207..8de2801 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -401,8 +401,9 @@
 				reg = <0x02098000 0x4000>;
 				interrupts = <0 55 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX6QDL_CLK_GPT_IPG>,
-					 <&clks IMX6QDL_CLK_GPT_IPG_PER>;
-				clock-names = "ipg", "per";
+					 <&clks IMX6QDL_CLK_GPT_IPG_PER>,
+					 <&clks IMX6QDL_CLK_GPT_3M>;
+				clock-names = "ipg", "per", "osc_per";
 			};
 
 			gpio1: gpio at 0209c000 {
diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index 63d9d82..b5d8252 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -421,7 +421,7 @@
 				reg = <0x02098000 0x4000>;
 				interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX6SX_CLK_GPT_BUS>,
-					 <&clks IMX6SX_CLK_GPT_SERIAL>;
+					 <&clks IMX6SX_CLK_GPT_3M>;
 				clock-names = "ipg", "per";
 			};
 
-- 
1.7.9.5
