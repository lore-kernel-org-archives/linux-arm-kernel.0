From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Wed, 09 Mar 2011 16:44:48 +0100
Subject: [PATCH v2] ARM: S5P: Extend MIPI-CSIS platform_data with the PHY
	control callback
In-Reply-To: <1299179061-30959-3-git-send-email-s.nawrocki@samsung.com>
References: <1299179061-30959-3-git-send-email-s.nawrocki@samsung.com>
Message-ID: <1299685488-15258-1-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Extend MIPI-CSIS driver's platform data structure with a callback
for D-PHY enable and reset control. Also add a flag indicating
whether the external MIPI-CSI (VDD18_MIPI) power supply should
be managed in the driver through the "vdd" power supply. On some
boards this regulator may be a fixed voltage regulator without
an inhibit function.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
Hello,

in this version I have updated the platform data structure with
an additional flag indicating whether the driver should attempt to
control the external mipi-csis (VDD18_MIPI) voltage regulator or not.
This might be needed on systems where MIPI VDD power supply cannot be 
separately switched on/off.

SN

---
 arch/arm/plat-s5p/include/plat/mipi_csis.h |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-s5p/include/plat/mipi_csis.h b/arch/arm/plat-s5p/include/plat/mipi_csis.h
index eb3beab..bb4f396 100644
--- a/arch/arm/plat-s5p/include/plat/mipi_csis.h
+++ b/arch/arm/plat-s5p/include/plat/mipi_csis.h
@@ -11,18 +11,33 @@
 #ifndef PLAT_S5P_MIPI_CSIS_H_
 #define PLAT_S5P_MIPI_CSIS_H_ __FILE__
 
+struct platform_device;
+
 /**
  * struct s5p_platform_mipi_csis - platform data for S5P MIPI-CSIS driver
  * @clk_rate: bus clock frequency
  * @lanes: number of data lanes used
  * @alignment: data alignment in bits
  * @hs_settle: HS-RX settle time
+ * @fixed_phy_vdd: set to 0 if the driver should be managing external
+ *		   D-PHY power supply through the "vdd" regulator supply
+ * @phy_enable: pointer to a callback controlling D-PHY enable/reset
  */
 struct s5p_platform_mipi_csis {
 	unsigned long clk_rate;
 	u8 lanes;
 	u8 alignment;
 	u8 hs_settle;
+	unsigned fixed_phy_vdd:1;
+	int (*phy_enable)(struct platform_device *pdev, bool on);
 };
 
+/**
+ * s5p_csis_phy_enable - global MIPI-CSI receiver D-PHY control
+ * @pdev: MIPI-CSIS platform device
+ * @on: true to enable D-PHY and deassert its reset
+ *	false to disable D-PHY
+ */
+int s5p_csis_phy_enable(struct platform_device *pdev, bool on);
+
 #endif /* PLAT_S5P_MIPI_CSIS_H_ */
-- 
1.7.4.1
