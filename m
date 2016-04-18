From: akshay.bhat@timesys.com (Akshay Bhat)
Date: Mon, 18 Apr 2016 17:19:44 -0400
Subject: [PATCH 2/3] ARM: dts: imx6q-b850v3: Update display clock source
In-Reply-To: <1461014385-26027-1-git-send-email-akshay.bhat@timesys.com>
References: <1461014385-26027-1-git-send-email-akshay.bhat@timesys.com>
Message-ID: <1461014385-26027-2-git-send-email-akshay.bhat@timesys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The default monitor that ships with B850v3 requires a 65MHz pixel clock.
65MHz can not be achieved using PLL3 (480MHz/7=68.5MHz). Hence set the
LDB_DIx clock source to PLL5. Since PLL5 is already in use by IPU1_DIx,
set the clock source for IPU1_DIx to PLL2_PFD2 to allow simultaneous
display on both LVDS and HDMI interface.

Signed-off-by: Akshay Bhat <akshay.bhat@timesys.com>
---
 arch/arm/boot/dts/imx6q-b850v3.dts | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-b850v3.dts b/arch/arm/boot/dts/imx6q-b850v3.dts
index dc4b06f..167f744 100644
--- a/arch/arm/boot/dts/imx6q-b850v3.dts
+++ b/arch/arm/boot/dts/imx6q-b850v3.dts
@@ -53,11 +53,18 @@
 	};
 };
 
-&ldb {
+&clks {
 	assigned-clocks = <&clks IMX6QDL_CLK_LDB_DI0_SEL>,
-			  <&clks IMX6QDL_CLK_LDB_DI1_SEL>;
-	assigned-clock-parents = <&clks IMX6QDL_CLK_PLL3_USB_OTG>,
-				 <&clks IMX6QDL_CLK_PLL3_USB_OTG>;
+			  <&clks IMX6QDL_CLK_LDB_DI1_SEL>,
+			  <&clks IMX6QDL_CLK_IPU1_DI0_PRE_SEL>,
+			  <&clks IMX6QDL_CLK_IPU1_DI1_PRE_SEL>;
+	assigned-clock-parents = <&clks IMX6QDL_CLK_PLL5_VIDEO_DIV>,
+				 <&clks IMX6QDL_CLK_PLL5_VIDEO_DIV>,
+				 <&clks IMX6QDL_CLK_PLL2_PFD2_396M>,
+				 <&clks IMX6QDL_CLK_PLL2_PFD2_396M>;
+};
+
+&ldb {
 	fsl,dual-channel;
 	status = "okay";
 
-- 
2.8.1
