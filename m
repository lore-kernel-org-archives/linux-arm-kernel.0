From: Anson.Huang@nxp.com (Anson Huang)
Date: Sun, 18 Mar 2018 11:23:21 +0800
Subject: [PATCH V2 2/2] regulator: pfuze100: update voltage setting for
 pfuze3000 sw1a
In-Reply-To: <1521343401-3109-1-git-send-email-Anson.Huang@nxp.com>
References: <1521343401-3109-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <1521343401-3109-2-git-send-email-Anson.Huang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

pfuze3000 datasheet(Rev.9.0) from:

https://www.nxp.com/docs/en/data-sheet/PF3000.pdf

updates sw1a's voltage range, the settings for 1.450V and 1.475V
are replaced with 1.8V and 3.3V:

5b'11110 1.450 (SW1B), 1.8 (SW1A/SW1AB)
5b'11111 1.475 (SW1B), 3.3 (SW1A/SW1AB)

the voltage calculation using steps is NOT available for sw1a now,
use voltage table instead.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Signed-off-by: Robin Gong <yibin.gong@nxp.com>
---
changes since V1:
	update the latest datasheet link and add version into commit message.
 drivers/regulator/pfuze100-regulator.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/pfuze100-regulator.c b/drivers/regulator/pfuze100-regulator.c
index 63922a2..680f076 100644
--- a/drivers/regulator/pfuze100-regulator.c
+++ b/drivers/regulator/pfuze100-regulator.c
@@ -86,6 +86,13 @@ static const int pfuze100_coin[] = {
 	2500000, 2700000, 2800000, 2900000, 3000000, 3100000, 3200000, 3300000,
 };
 
+static const int pfuze3000_sw1a[] = {
+	700000, 725000, 750000, 775000, 800000, 825000, 850000, 875000,
+	900000, 925000, 950000, 975000, 1000000, 1025000, 1050000, 1075000,
+	1100000, 1125000, 1150000, 1175000, 1200000, 1225000, 1250000, 1275000,
+	1300000, 1325000, 1350000, 1375000, 1400000, 1425000, 1800000, 3300000,
+};
+
 static const int pfuze3000_sw2lo[] = {
 	1500000, 1550000, 1600000, 1650000, 1700000, 1750000, 1800000, 1850000,
 };
@@ -343,7 +350,7 @@ static struct pfuze_regulator pfuze200_regulators[] = {
 };
 
 static struct pfuze_regulator pfuze3000_regulators[] = {
-	PFUZE100_SW_REG(PFUZE3000, SW1A, PFUZE100_SW1ABVOL, 700000, 1475000, 25000),
+	PFUZE100_SWB_REG(PFUZE3000, SW1A, PFUZE100_SW1ABVOL, 0x1f, pfuze3000_sw1a),
 	PFUZE100_SW_REG(PFUZE3000, SW1B, PFUZE100_SW1CVOL, 700000, 1475000, 25000),
 	PFUZE100_SWB_REG(PFUZE3000, SW2, PFUZE100_SW2VOL, 0x7, pfuze3000_sw2lo),
 	PFUZE3000_SW3_REG(PFUZE3000, SW3, PFUZE100_SW3AVOL, 900000, 1650000, 50000),
-- 
2.7.4
