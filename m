From: gabriel.fernandez@st.com (Gabriel FERNANDEZ)
Date: Wed,  3 Sep 2014 17:37:16 +0200
Subject: [PATCH v2 7/8] phy: miphy28lp: Add SSC support for PCIE
In-Reply-To: <1409758637-28654-1-git-send-email-gabriel.fernandez@linaro.org>
References: <1409758637-28654-1-git-send-email-gabriel.fernandez@linaro.org>
Message-ID: <1409758637-28654-8-git-send-email-gabriel.fernandez@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SSC is the technique of modulating the operating frequency of a signal
slightly to spread its radiated emissions over a range of frequencies.
This reduction in the maximum emission for a given frequency helps meet
radiated emission requirements.
These settings are applicable for PCIE with Internal clock.

Signed-off-by: Harsh Gupta <harsh.gupta@st.com>
Signed-off-by: Gabriel Fernandez <gabriel.fernandez@linaro.orgm>
---
 drivers/phy/phy-miphy28lp.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/phy/phy-miphy28lp.c b/drivers/phy/phy-miphy28lp.c
index b36e737..976fdda 100644
--- a/drivers/phy/phy-miphy28lp.c
+++ b/drivers/phy/phy-miphy28lp.c
@@ -679,6 +679,36 @@ static int miphy28lp_init_sata(struct miphy28lp_phy *miphy_phy)
 	return miphy_is_ready(miphy_phy);
 }
 
+static void miphy_pcie_tune_ssc(struct miphy28lp_phy *miphy_phy)
+{
+	u8 val;
+
+	/* Compensate Tx impedance to avoid out of range values */
+	if (miphy_phy->ssc) {
+		/*
+		 * Enable the SSC on PLL for all banks
+		 * SSC Modulation @ 31 KHz and 4000 ppm modulation amp
+		 */
+		val = readb_relaxed(miphy_phy->base + 0x0c);
+		val |= 0x04;
+		writeb_relaxed(val, miphy_phy->base + 0x0c);
+		val = readb_relaxed(miphy_phy->base + 0x0a);
+		val |= 0x10;
+		writeb_relaxed(val, miphy_phy->base + 0x0a);
+
+		for (val = 0; val < 2; val++) {
+			writeb_relaxed(val, miphy_phy->base + 0x0f);
+			writeb_relaxed(0x69, miphy_phy->base + 0xe5);
+			writeb_relaxed(0x21, miphy_phy->base + 0xe6);
+			writeb_relaxed(0x3c, miphy_phy->base + 0xe4);
+			writeb_relaxed(0x21, miphy_phy->base + 0xe6);
+			writeb_relaxed(0x00, miphy_phy->base + 0xe3);
+			writeb_relaxed(0x02, miphy_phy->base + 0xe3);
+			writeb_relaxed(0x00, miphy_phy->base + 0xe3);
+		}
+	}
+}
+
 static int miphy28lp_init_pcie(struct miphy28lp_phy *miphy_phy)
 {
 	struct miphy28lp_dev *miphy_dev = miphy_phy->phydev;
@@ -710,6 +740,8 @@ static int miphy28lp_init_pcie(struct miphy28lp_phy *miphy_phy)
 	/* initialize miphy */
 	miphy28lp_configure_pcie(miphy_phy);
 
+	miphy_pcie_tune_ssc(miphy_phy);
+
 	/* Waiting for Compensation to complete */
 	do {
 		val = readb_relaxed(miphy_phy->base + MIPHY_COMP_FSM_6);
-- 
1.9.1
