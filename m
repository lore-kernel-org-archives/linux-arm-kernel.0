From: gabriel.fernandez@st.com (Gabriel FERNANDEZ)
Date: Wed,  3 Sep 2014 17:37:17 +0200
Subject: [PATCH v2 8/8] phy: miphy28lp: Tune tx impedance across Soc cuts
In-Reply-To: <1409758637-28654-1-git-send-email-gabriel.fernandez@linaro.org>
References: <1409758637-28654-1-git-send-email-gabriel.fernandez@linaro.org>
Message-ID: <1409758637-28654-9-git-send-email-gabriel.fernandez@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch to compensate tx impedance (Sata, PCIe)
depending on Soc cuts the kernel is built for.

Signed-off-by: Giuseppe Condorelli <giuseppe.condorelli@st.com>
Signed-off-by: Gabriel Fernandez <gabriel.fernandez@linaro.org>
---
 .../devicetree/bindings/phy/phy-miphy28lp.txt      |  1 +
 drivers/phy/phy-miphy28lp.c                        | 24 ++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/phy-miphy28lp.txt b/Documentation/devicetree/bindings/phy/phy-miphy28lp.txt
index 49bb7bb..de25e8f 100644
--- a/Documentation/devicetree/bindings/phy/phy-miphy28lp.txt
+++ b/Documentation/devicetree/bindings/phy/phy-miphy28lp.txt
@@ -40,6 +40,7 @@ Optional properties (port (child) node):
 - st,px_rx_pol_inv	: to invert polarity of RXn/RXp (respectively negative line and positive
 			  line).
 - st,scc-on		: enable ssc to reduce effects of EMI (only for sata or PCIe).
+- st,tx-impedance-comp	: to compensate tx impedance avoiding out of range values.
 
 example:
 
diff --git a/drivers/phy/phy-miphy28lp.c b/drivers/phy/phy-miphy28lp.c
index 976fdda..148dd9c 100644
--- a/drivers/phy/phy-miphy28lp.c
+++ b/drivers/phy/phy-miphy28lp.c
@@ -141,6 +141,7 @@ struct miphy28lp_phy {
 	bool osc_rdy;
 	bool px_rx_pol_inv;
 	bool ssc;
+	bool tx_impedance;
 
 	struct reset_control *miphy_rst;
 
@@ -296,6 +297,10 @@ static inline void miphy28lp_configure_sata(struct miphy28lp_phy *miphy_phy)
 	writeb_relaxed(0x40, base + MIPHY_COMP_FSM_1);
 	writeb_relaxed(0x00, base + MIPHY_RESET);
 	writeb_relaxed(0x40, base + MIPHY_PLL_COMMON_MISC_2);
+
+	/* TX compensation offset to re-center TX impedance */
+	writeb_relaxed(0x00, base + MIPHY_COMP_POSTP);
+
 }
 
 static inline void miphy28lp_configure_pcie(struct miphy28lp_phy *miphy_phy)
@@ -385,6 +390,10 @@ static inline void miphy28lp_configure_pcie(struct miphy28lp_phy *miphy_phy)
 	writeb_relaxed(0x00, base + MIPHY_RESET);
 	writeb_relaxed(0x40, base + MIPHY_PLL_COMMON_MISC_2);
 	writeb_relaxed(0x02, base + MIPHY_PLL_SBR_1);
+
+	/* TX compensation offset to re-center TX impedance */
+	writeb_relaxed(0x00, base + MIPHY_COMP_POSTP);
+
 }
 
 static inline void miphy28lp_configure_usb3(struct miphy28lp_phy *miphy_phy)
@@ -605,6 +614,14 @@ static int miphy28lp_setup(struct miphy28lp_phy *miphy_phy, u32 miphy_val)
 	return miphy_osc_is_ready(miphy_phy);
 }
 
+static void miphy_tune_tx_impedance(struct miphy28lp_phy *miphy_phy)
+{
+	/* Compensate Tx impedance to avoid out of range values */
+	if (miphy_phy->tx_impedance)
+		writeb_relaxed(0x02, miphy_phy->base + 0x42);
+
+}
+
 static void miphy_sata_tune_ssc(struct miphy28lp_phy *miphy_phy)
 {
 	u8 val;
@@ -676,6 +693,8 @@ static int miphy28lp_init_sata(struct miphy28lp_phy *miphy_phy)
 
 	miphy_sata_tune_ssc(miphy_phy);
 
+	miphy_tune_tx_impedance(miphy_phy);
+
 	return miphy_is_ready(miphy_phy);
 }
 
@@ -750,6 +769,8 @@ static int miphy28lp_init_pcie(struct miphy28lp_phy *miphy_phy)
 		cpu_relax();
 	} while (!(val & MIPHY_COMP_DONE));
 
+	miphy_tune_tx_impedance(miphy_phy);
+
 	/* PIPE Wrapper Configuration */
 	writeb_relaxed(0x68, miphy_phy->pipebase + 0x104); /* Rise_0 */
 	writeb_relaxed(0x61, miphy_phy->pipebase + 0x105); /* Rise_1 */
@@ -939,6 +960,9 @@ static int miphy28lp_of_probe(struct device_node *np,
 
 	miphy_phy->ssc = of_property_read_bool(np, "st,ssc-on");
 
+	miphy_phy->tx_impedance =
+		of_property_read_bool(np, "st,tx-impedance-comp");
+
 	of_property_read_u32(np, "st,sata-gen", &miphy_phy->sata_gen);
 	if (!miphy_phy->sata_gen)
 		miphy_phy->sata_gen = SATA_GEN1;
-- 
1.9.1
