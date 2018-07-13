From: alexander.sverdlin@nokia.com (Alexander Sverdlin)
Date: Fri, 13 Jul 2018 17:20:17 +0200
Subject: [PATCH] i2c: davinci: Avoid zero value of CLKH
Message-ID: <20180713152017.2207-1-alexander.sverdlin@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If CLKH is set to 0 I2C clock is not generated at all, so avoid this value
and stretch the clock in this case.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
---
 drivers/i2c/busses/i2c-davinci.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
index 75d6ab177055..7379043711df 100644
--- a/drivers/i2c/busses/i2c-davinci.c
+++ b/drivers/i2c/busses/i2c-davinci.c
@@ -237,12 +237,16 @@ static void i2c_davinci_calc_clk_dividers(struct davinci_i2c_dev *dev)
 	/*
 	 * It's not always possible to have 1 to 2 ratio when d=7, so fall back
 	 * to minimal possible clkh in this case.
+	 *
+	 * Note:
+	 * CLKH is not allowed to be 0, in this case I2C clock is not generated
+	 * at all
 	 */
-	if (clk >= clkl + d) {
+	if (clk > clkl + d) {
 		clkh = clk - clkl - d;
 		clkl -= d;
 	} else {
-		clkh = 0;
+		clkh = 1;
 		clkl = clk - (d << 1);
 	}
 
-- 
2.18.0
