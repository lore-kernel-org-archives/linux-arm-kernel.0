From: gabriel.fernandez@st.com (Gabriel FERNANDEZ)
Date: Tue,  4 Nov 2014 11:51:23 +0100
Subject: [PATCH v5 7/8] phy: miphy28lp: Tune tx impedance across Soc cuts
In-Reply-To: <1415098284-11182-1-git-send-email-gabriel.fernandez@linaro.org>
References: <1415098284-11182-1-git-send-email-gabriel.fernandez@linaro.org>
Message-ID: <1415098284-11182-8-git-send-email-gabriel.fernandez@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch to compensate tx impedance (Sata, PCIe)
depending on Soc cuts the kernel is built for.

Signed-off-by: Giuseppe Condorelli <giuseppe.condorelli@st.com>
Signed-off-by: Gabriel Fernandez <gabriel.fernandez@linaro.org>
---
 Documentation/devicetree/bindings/phy/phy-miphy28lp.txt |  1 +
 drivers/phy/phy-miphy28lp.c                             | 16 ++++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/phy-miphy28lp.txt b/Documentation/devicetree/bindings/phy/phy-miphy28lp.txt
index 4a3b4af..46a135d 100644
--- a/Documentation/devicetree/bindings/phy/phy-miphy28lp.txt
+++ b/Documentation/devicetree/bindings/phy/phy-miphy28lp.txt
@@ -40,6 +40,7 @@ Optional properties (port (child) node):
 - st,px_rx_pol_inv	: to invert polarity of RXn/RXp (respectively negative line and positive
 			  line).
 - st,scc-on		: enable ssc to reduce effects of EMI (only for sata or PCIe).
+- st,tx-impedance-comp	: to compensate tx impedance avoiding out of range values.
 
 example:
 
diff --git a/drivers/phy/phy-miphy28lp.c b/drivers/phy/phy-miphy28lp.c
index d8ff895..87dcc9a 100644
--- a/drivers/phy/phy-miphy28lp.c
+++ b/drivers/phy/phy-miphy28lp.c
@@ -204,6 +204,7 @@ struct miphy28lp_phy {
 	bool osc_rdy;
 	bool px_rx_pol_inv;
 	bool ssc;
+	bool tx_impedance;
 
 	struct reset_control *miphy_rst;
 
@@ -632,6 +633,12 @@ static void miphy_pcie_tune_ssc(struct miphy28lp_phy *miphy_phy)
 	}
 }
 
+static inline void miphy_tune_tx_impedance(struct miphy28lp_phy *miphy_phy)
+{
+	/* Compensate Tx impedance to avoid out of range values */
+	writeb_relaxed(0x02, miphy_phy->base + MIPHY_COMP_POSTP);
+}
+
 static inline int miphy28lp_configure_sata(struct miphy28lp_phy *miphy_phy)
 {
 	void __iomem *base = miphy_phy->base;
@@ -670,6 +677,9 @@ static inline int miphy28lp_configure_sata(struct miphy28lp_phy *miphy_phy)
 	if (miphy_phy->ssc)
 		miphy_sata_tune_ssc(miphy_phy);
 
+	if (miphy_phy->tx_impedance)
+		miphy_tune_tx_impedance(miphy_phy);
+
 	return 0;
 }
 
@@ -703,6 +713,9 @@ static inline int miphy28lp_configure_pcie(struct miphy28lp_phy *miphy_phy)
 	if (miphy_phy->ssc)
 		miphy_pcie_tune_ssc(miphy_phy);
 
+	if (miphy_phy->tx_impedance)
+		miphy_tune_tx_impedance(miphy_phy);
+
 	return 0;
 }
 
@@ -1154,6 +1167,9 @@ static int miphy28lp_of_probe(struct device_node *np,
 
 	miphy_phy->ssc = of_property_read_bool(np, "st,ssc-on");
 
+	miphy_phy->tx_impedance =
+		of_property_read_bool(np, "st,tx-impedance-comp");
+
 	of_property_read_u32(np, "st,sata-gen", &miphy_phy->sata_gen);
 	if (!miphy_phy->sata_gen)
 		miphy_phy->sata_gen = SATA_GEN1;
-- 
1.9.1
