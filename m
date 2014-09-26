From: gabriel.fernandez@st.com (Gabriel FERNANDEZ)
Date: Fri, 26 Sep 2014 10:54:15 +0200
Subject: [PATCH v3 6/8] phy: miphy28lp: Add SSC support for PCIE
In-Reply-To: <1411721657-9924-1-git-send-email-gabriel.fernandez@linaro.org>
References: <1411721657-9924-1-git-send-email-gabriel.fernandez@linaro.org>
Message-ID: <1411721657-9924-7-git-send-email-gabriel.fernandez@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SSC is the technique of modulating the operating frequency of a signal
slightly to spread its radiated emissions over a range of frequencies.
This reduction in the maximum emission for a given frequency helps meet
radiated emission requirements.
These settings are applicable for PCIE with Internal clock.

Signed-off-by: Harsh Gupta <harsh.gupta@st.com>
Signed-off-by: Gabriel Fernandez <gabriel.fernandez@linaro.org>
---
 drivers/phy/phy-miphy28lp.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/phy/phy-miphy28lp.c b/drivers/phy/phy-miphy28lp.c
index 7285543..b6574e8 100644
--- a/drivers/phy/phy-miphy28lp.c
+++ b/drivers/phy/phy-miphy28lp.c
@@ -579,6 +579,35 @@ static void miphy_sata_tune_ssc(struct miphy28lp_phy *miphy_phy)
 	}
 }
 
+static void miphy_pcie_tune_ssc(struct miphy28lp_phy *miphy_phy)
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
+	for (val = 0; val < 2; val++) {
+		writeb_relaxed(val, miphy_phy->base + MIPHY_CONF);
+		writeb_relaxed(0x69, miphy_phy->base + MIPHY_PLL_SBR_3);
+		writeb_relaxed(0x21, miphy_phy->base + MIPHY_PLL_SBR_4);
+		writeb_relaxed(0x3c, miphy_phy->base + MIPHY_PLL_SBR_2);
+		writeb_relaxed(0x21, miphy_phy->base + MIPHY_PLL_SBR_4);
+		writeb_relaxed(0x00, miphy_phy->base + MIPHY_PLL_SBR_1);
+		writeb_relaxed(0x02, miphy_phy->base + MIPHY_PLL_SBR_1);
+		writeb_relaxed(0x00, miphy_phy->base + MIPHY_PLL_SBR_1);
+	}
+}
+
 static inline int miphy28lp_configure_sata(struct miphy28lp_phy *miphy_phy)
 {
 	void __iomem *base = miphy_phy->base;
@@ -647,6 +676,9 @@ static inline int miphy28lp_configure_pcie(struct miphy28lp_phy *miphy_phy)
 	if (err)
 		return err;
 
+	if (miphy_phy->ssc)
+		miphy_pcie_tune_ssc(miphy_phy);
+
 	return 0;
 }
 
-- 
1.9.1
