From: gabriel.fernandez@st.com (Gabriel FERNANDEZ)
Date: Wed,  3 Sep 2014 17:37:15 +0200
Subject: [PATCH v2 6/8] phy: miphy28lp: Add SSC support for SATA
In-Reply-To: <1409758637-28654-1-git-send-email-gabriel.fernandez@linaro.org>
References: <1409758637-28654-1-git-send-email-gabriel.fernandez@linaro.org>
Message-ID: <1409758637-28654-7-git-send-email-gabriel.fernandez@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch to tune on/off the ssc on miphy sata setup.
User can now enable ssc via dt blob, it is useful to reduce
effects of EMI.

Signed-off-by: Giuseppe Condorelli <giuseppe.condorelli@st.com>
Signed-off-by: Gabriel Fernandez <gabriel.fernandez@linaro.org>
---
 .../devicetree/bindings/phy/phy-miphy28lp.txt      |  1 +
 drivers/phy/phy-miphy28lp.c                        | 35 ++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/phy-miphy28lp.txt b/Documentation/devicetree/bindings/phy/phy-miphy28lp.txt
index 5e307af..49bb7bb 100644
--- a/Documentation/devicetree/bindings/phy/phy-miphy28lp.txt
+++ b/Documentation/devicetree/bindings/phy/phy-miphy28lp.txt
@@ -39,6 +39,7 @@ Optional properties (port (child) node):
 			  register.
 - st,px_rx_pol_inv	: to invert polarity of RXn/RXp (respectively negative line and positive
 			  line).
+- st,scc-on		: enable ssc to reduce effects of EMI (only for sata or PCIe).
 
 example:
 
diff --git a/drivers/phy/phy-miphy28lp.c b/drivers/phy/phy-miphy28lp.c
index aa36cea..b36e737 100644
--- a/drivers/phy/phy-miphy28lp.c
+++ b/drivers/phy/phy-miphy28lp.c
@@ -140,6 +140,7 @@ struct miphy28lp_phy {
 	bool osc_force_ext;
 	bool osc_rdy;
 	bool px_rx_pol_inv;
+	bool ssc;
 
 	struct reset_control *miphy_rst;
 
@@ -604,6 +605,36 @@ static int miphy28lp_setup(struct miphy28lp_phy *miphy_phy, u32 miphy_val)
 	return miphy_osc_is_ready(miphy_phy);
 }
 
+static void miphy_sata_tune_ssc(struct miphy28lp_phy *miphy_phy)
+{
+	u8 val;
+
+	/* Compensate Tx impedance to avoid out of range values */
+	if (miphy_phy->ssc) {
+		/*
+		 * Enable the SSC on PLL for all banks
+		 * SSC Modulation @ 31 KHz and 4000 ppm modulation amp
+		 */
+
+		val = readb_relaxed(miphy_phy->base + 0x0c);
+		val |= 0x04;
+		writeb_relaxed(val, miphy_phy->base + 0x0c);
+		val = readb_relaxed(miphy_phy->base + 0x0a);
+		val |= 0x10;
+		writeb_relaxed(val, miphy_phy->base + 0x0a);
+
+		for (val = 0; val < 3; val++) {
+			writeb_relaxed(val, miphy_phy->base + 0x0f);
+			writeb_relaxed(0x3c, miphy_phy->base + 0xe4);
+			writeb_relaxed(0x6c, miphy_phy->base + 0xe5);
+			writeb_relaxed(0x81, miphy_phy->base + 0xe6);
+			writeb_relaxed(0x00, miphy_phy->base + 0xe3);
+			writeb_relaxed(0x02, miphy_phy->base + 0xe3);
+			writeb_relaxed(0x00, miphy_phy->base + 0xe3);
+		}
+	}
+}
+
 static int miphy28lp_init_sata(struct miphy28lp_phy *miphy_phy)
 {
 	struct miphy28lp_dev *miphy_dev = miphy_phy->phydev;
@@ -643,6 +674,8 @@ static int miphy28lp_init_sata(struct miphy28lp_phy *miphy_phy)
 		writeb_relaxed(val, miphy_phy->base + MIPHY_CONTROL);
 	}
 
+	miphy_sata_tune_ssc(miphy_phy);
+
 	return miphy_is_ready(miphy_phy);
 }
 
@@ -872,6 +905,8 @@ static int miphy28lp_of_probe(struct device_node *np,
 	miphy_phy->px_rx_pol_inv =
 		of_property_read_bool(np, "st,px_rx_pol_inv");
 
+	miphy_phy->ssc = of_property_read_bool(np, "st,ssc-on");
+
 	of_property_read_u32(np, "st,sata-gen", &miphy_phy->sata_gen);
 	if (!miphy_phy->sata_gen)
 		miphy_phy->sata_gen = SATA_GEN1;
-- 
1.9.1
