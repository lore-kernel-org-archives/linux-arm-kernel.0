From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 28 Aug 2014 14:59:50 +0100
Subject: [PATCH] phy: miphy365x: Fix off-by-one error
Message-ID: <1409234390-20168-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We index the RX/TX speed select values in the following way:

  rx_tx_spd[miphy_phy->sata_gen];

However rx_tx_spd[] starts at index zero and the SATA_GENx's start
at one.  In this patch we pad out the first element in rx_tx_spd[]
in an attempt to realign the values.

Cc: Alexandre Torgue <alexandre.torgue@st.com>
Reported-by: Gabriel Fernandez <gabriel.fernandez@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/phy/phy-miphy365x.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/phy/phy-miphy365x.c b/drivers/phy/phy-miphy365x.c
index e111baf..e0fb7a1 100644
--- a/drivers/phy/phy-miphy365x.c
+++ b/drivers/phy/phy-miphy365x.c
@@ -163,6 +163,7 @@ enum miphy_sata_gen {
 };
 
 static u8 rx_tx_spd[] = {
+	0, /* GEN0 doesn't exist. */
 	TX_SPDSEL_GEN1_VAL | RX_SPDSEL_GEN1_VAL,
 	TX_SPDSEL_GEN2_VAL | RX_SPDSEL_GEN2_VAL,
 	TX_SPDSEL_GEN3_VAL | RX_SPDSEL_GEN3_VAL
-- 
1.9.1
