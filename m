From: gabriel.fernandez@st.com (Gabriel FERNANDEZ)
Date: Fri, 26 Sep 2014 10:54:14 +0200
Subject: [PATCH v3 5/8] phy: miphy28lp: Add SSC support for SATA
In-Reply-To: <1411721657-9924-1-git-send-email-gabriel.fernandez@linaro.org>
References: <1411721657-9924-1-git-send-email-gabriel.fernandez@linaro.org>
Message-ID: <1411721657-9924-6-git-send-email-gabriel.fernandez@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch to tune on/off the ssc on miphy sata setup.
User can now enable ssc via dt blob, it is useful to reduce
effects of EMI.

Signed-off-by: Giuseppe Condorelli <giuseppe.condorelli@st.com>
Signed-off-by: Gabriel Fernandez <gabriel.fernandez@linaro.org>
---
 .../devicetree/bindings/phy/phy-miphy28lp.txt      |  1 +
 drivers/phy/phy-miphy28lp.c                        | 34 ++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/phy-miphy28lp.txt b/Documentation/devicetree/bindings/phy/phy-miphy28lp.txt
index 1ad4433..daa8310 100644
--- a/Documentation/devicetree/bindings/phy/phy-miphy28lp.txt
+++ b/Documentation/devicetree/bindings/phy/phy-miphy28lp.txt
@@ -39,6 +39,7 @@ Optional properties (port (child) node):
 			  register.
 - st,px_rx_pol_inv	: to invert polarity of RXn/RXp (respectively negative line and positive
 			  line).
+- st,scc-on		: enable ssc to reduce effects of EMI (only for sata or PCIe).
 
 example:
 
diff --git a/drivers/phy/phy-miphy28lp.c b/drivers/phy/phy-miphy28lp.c
index 1a468d1..7285543 100644
--- a/drivers/phy/phy-miphy28lp.c
+++ b/drivers/phy/phy-miphy28lp.c
@@ -200,6 +200,7 @@ struct miphy28lp_phy {
 	bool osc_force_ext;
 	bool osc_rdy;
 	bool px_rx_pol_inv;
+	bool ssc;
 
 	struct reset_control *miphy_rst;
 
@@ -550,6 +551,34 @@ static inline void miphy28_usb3_miphy_reset(struct miphy28lp_phy *miphy_phy)
 	writeb_relaxed(0x00, base + MIPHY_CONF);
 }
 
+static void miphy_sata_tune_ssc(struct miphy28lp_phy *miphy_phy)
+{
+	u8 val;
+
+	/* Compensate Tx impedance to avoid out of range values */
+	/*
+	 * Enable the SSC on PLL for all banks
+	 * SSC Modulation @ 31 KHz and 4000 ppm modulation amp
+	 */
+	val = readb_relaxed(miphy_phy->base + MIPHY_BOUNDARY_2);
+	val |= SSC_EN_SW;
+	writeb_relaxed(val, miphy_phy->base + MIPHY_BOUNDARY_2);
+
+	val = readb_relaxed(miphy_phy->base + MIPHY_BOUNDARY_SEL);
+	val |= SSC_SEL;
+	writeb_relaxed(val, miphy_phy->base + MIPHY_BOUNDARY_SEL);
+
+	for (val = 0; val < 3; val++) {
+		writeb_relaxed(val, miphy_phy->base + MIPHY_CONF);
+		writeb_relaxed(0x3c, miphy_phy->base + MIPHY_PLL_SBR_2);
+		writeb_relaxed(0x6c, miphy_phy->base + MIPHY_PLL_SBR_3);
+		writeb_relaxed(0x81, miphy_phy->base + MIPHY_PLL_SBR_4);
+		writeb_relaxed(0x00, miphy_phy->base + MIPHY_PLL_SBR_1);
+		writeb_relaxed(0x02, miphy_phy->base + MIPHY_PLL_SBR_1);
+		writeb_relaxed(0x00, miphy_phy->base + MIPHY_PLL_SBR_1);
+	}
+}
+
 static inline int miphy28lp_configure_sata(struct miphy28lp_phy *miphy_phy)
 {
 	void __iomem *base = miphy_phy->base;
@@ -585,6 +614,9 @@ static inline int miphy28lp_configure_sata(struct miphy28lp_phy *miphy_phy)
 		writeb_relaxed(val, miphy_phy->base + MIPHY_CONTROL);
 	}
 
+	if (miphy_phy->ssc)
+		miphy_sata_tune_ssc(miphy_phy);
+
 	return 0;
 }
 
@@ -1051,6 +1083,8 @@ static int miphy28lp_of_probe(struct device_node *np,
 	miphy_phy->px_rx_pol_inv =
 		of_property_read_bool(np, "st,px_rx_pol_inv");
 
+	miphy_phy->ssc = of_property_read_bool(np, "st,ssc-on");
+
 	of_property_read_u32(np, "st,sata-gen", &miphy_phy->sata_gen);
 	if (!miphy_phy->sata_gen)
 		miphy_phy->sata_gen = SATA_GEN1;
-- 
1.9.1
