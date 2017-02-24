From: john@metanate.com (John Keeping)
Date: Fri, 24 Feb 2017 12:54:59 +0000
Subject: [PATCH v4 16/23] drm/rockchip: dw-mipi-dsi: properly configure PHY
 timing
In-Reply-To: <20170224125506.21533-1-john@metanate.com>
References: <20170224125506.21533-1-john@metanate.com>
Message-ID: <20170224125506.21533-17-john@metanate.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These values are specified as constant time periods but the PHY
configuration is in terms of the current lane byte clock so using
constant values guarantees that the timings will be outside the
specification with some display configurations.

Derive the necessary configuration from the byte clock in order to
ensure that the PHY configuration is correct.

Signed-off-by: John Keeping <john@metanate.com>
---
v4:
- Simplify ns2bc and ns2ui calculations as suggested by Sean Paul
v3:
- Wrap some long lines
Unchanged in v2
---
 drivers/gpu/drm/rockchip/dw-mipi-dsi.c | 35 ++++++++++++++++++++++++++++++----
 1 file changed, 31 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
index 4fee5176c606..9b6a60deb69e 100644
--- a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
+++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
@@ -383,6 +383,22 @@ static void dw_mipi_dsi_phy_write(struct dw_mipi_dsi *dsi, u8 test_code,
 	dsi_write(dsi, DSI_PHY_TST_CTRL0, PHY_TESTCLK | PHY_UNTESTCLR);
 }
 
+/**
+ * ns2bc - Nanoseconds to byte clock cycles
+ */
+static inline unsigned int ns2bc(struct dw_mipi_dsi *dsi, int ns)
+{
+	return DIV_ROUND_UP(ns * dsi->lane_mbps / 8, 1000);
+}
+
+/**
+ * ns2ui - Nanoseconds to UI time periods
+ */
+static inline unsigned int ns2ui(struct dw_mipi_dsi *dsi, int ns)
+{
+	return DIV_ROUND_UP(ns * dsi->lane_mbps, 1000);
+}
+
 static int dw_mipi_dsi_phy_init(struct dw_mipi_dsi *dsi)
 {
 	int ret, testdin, vco, val;
@@ -434,10 +450,21 @@ static int dw_mipi_dsi_phy_init(struct dw_mipi_dsi *dsi)
 					 SETRD_MAX | POWER_MANAGE |
 					 TER_RESISTORS_ON);
 
-
-	dw_mipi_dsi_phy_write(dsi, 0x70, TLP_PROGRAM_EN | 0xf);
-	dw_mipi_dsi_phy_write(dsi, 0x71, THS_PRE_PROGRAM_EN | 0x55);
-	dw_mipi_dsi_phy_write(dsi, 0x72, THS_ZERO_PROGRAM_EN | 0xa);
+	dw_mipi_dsi_phy_write(dsi, 0x60, TLP_PROGRAM_EN | ns2bc(dsi, 500));
+	dw_mipi_dsi_phy_write(dsi, 0x61, THS_PRE_PROGRAM_EN | ns2ui(dsi, 40));
+	dw_mipi_dsi_phy_write(dsi, 0x62, THS_ZERO_PROGRAM_EN | ns2bc(dsi, 300));
+	dw_mipi_dsi_phy_write(dsi, 0x63, THS_PRE_PROGRAM_EN | ns2ui(dsi, 100));
+	dw_mipi_dsi_phy_write(dsi, 0x64, BIT(5) | ns2bc(dsi, 100));
+	dw_mipi_dsi_phy_write(dsi, 0x65, BIT(5) | (ns2bc(dsi, 60) + 7));
+
+	dw_mipi_dsi_phy_write(dsi, 0x70, TLP_PROGRAM_EN | ns2bc(dsi, 500));
+	dw_mipi_dsi_phy_write(dsi, 0x71,
+			      THS_PRE_PROGRAM_EN | (ns2ui(dsi, 50) + 5));
+	dw_mipi_dsi_phy_write(dsi, 0x72,
+			      THS_ZERO_PROGRAM_EN | (ns2bc(dsi, 140) + 2));
+	dw_mipi_dsi_phy_write(dsi, 0x73,
+			      THS_PRE_PROGRAM_EN | (ns2ui(dsi, 60) + 8));
+	dw_mipi_dsi_phy_write(dsi, 0x74, BIT(5) | ns2bc(dsi, 100));
 
 	dsi_write(dsi, DSI_PHY_RSTZ, PHY_ENFORCEPLL | PHY_ENABLECLK |
 				     PHY_UNRSTZ | PHY_UNSHUTDOWNZ);
-- 
2.12.0.rc0.230.gf625d4cdb9.dirty
