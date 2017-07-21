From: marc_gonzalez@sigmadesigns.com (Marc Gonzalez)
Date: Fri, 21 Jul 2017 13:25:05 +0200
Subject: [PATCH v2 1/4] net: phy: at803x: Document RGMII RX and TX clock delay
 issues
In-Reply-To: <2617d673-ef81-5e7f-4730-ed3aa3f1c2c6@sigmadesigns.com>
References: <2617d673-ef81-5e7f-4730-ed3aa3f1c2c6@sigmadesigns.com>
Message-ID: <051653a2-946f-6a0b-4cff-b403d1197038@sigmadesigns.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current code supports enabling RGMII RX and TX clock delays.
The unstated assumption is that these settings are disabled by
default at reset, which is not the case.

RX clock delay is enabled at reset. And TX clock delay "survives"
across SW resets. Thus, if the bootloader enables TX clock delay,
it will remain enabled at reset in Linux.

Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
---
 drivers/net/phy/at803x.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
index c1e52b9dc58d..7a0954513b91 100644
--- a/drivers/net/phy/at803x.c
+++ b/drivers/net/phy/at803x.c
@@ -283,6 +283,12 @@ static int at803x_config_init(struct phy_device *phydev)
 	if (ret < 0)
 		return ret;
 
+	/*
+	 * NB: This code assumes that RGMII RX clock delay is disabled
+	 * at reset, but actually, RX clock delay is enabled@reset.
+	 * Disabling the delay if it has not been explicitly requested
+	 * breaks boards that rely on the enabled-by-default behavior.
+	 */
 	if (phydev->interface == PHY_INTERFACE_MODE_RGMII_RXID ||
 			phydev->interface == PHY_INTERFACE_MODE_RGMII_ID) {
 		ret = at803x_enable_rx_delay(phydev);
@@ -290,6 +296,12 @@ static int at803x_config_init(struct phy_device *phydev)
 			return ret;
 	}
 
+	/*
+	 * NB: This code assumes that RGMII TX clock delay is disabled
+	 * at reset, but actually, TX clock delay "survives" across SW
+	 * resets. If the bootloader enables TX clock delay, Linux is
+	 * stuck with that setting.
+	 */
 	if (phydev->interface == PHY_INTERFACE_MODE_RGMII_TXID ||
 			phydev->interface == PHY_INTERFACE_MODE_RGMII_ID) {
 		ret = at803x_enable_tx_delay(phydev);
-- 
2.11.0
