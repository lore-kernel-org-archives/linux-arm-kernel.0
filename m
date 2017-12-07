From: jbrunet@baylibre.com (Jerome Brunet)
Date: Thu,  7 Dec 2017 15:27:12 +0100
Subject: [PATCH net-next v2 5/8] net: phy: meson-gxl: detect LPA corruption
In-Reply-To: <20171207142715.32578-1-jbrunet@baylibre.com>
References: <20171207142715.32578-1-jbrunet@baylibre.com>
Message-ID: <20171207142715.32578-6-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The purpose of this change is to fix the incorrect detection of the link
partner (LP) advertised capabilities which sometimes happens with this PHY
(roughly 1 time in a dozen)

This issue may cause the link to be negotiated at 10Mbps/Full or
10Mbps/Half when 100MBps/Full is actually possible. In some case, the link
is even completely broken and no communication is possible.

To detect the corruption, we must look for a magic undocumented bit in the
WOL bank (hint given by the SoC vendor kernel) but this is not enough to
cover all cases. We also have to look at the LPA ack. If the LP supports
Aneg but did not ack our base code when aneg is completed, we assume
something went wrong.

The detection of a corrupted LPA triggers a restart of the aneg process.
This solves the problem but may take up to 6 retries to complete.

Fixes: 7334b3e47aee ("net: phy: Add Meson GXL Internal PHY driver")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---

I suppose this patch probably seems a bit hacky, especially the part
about the link partner acknowledge. I'm trying to figure out if the
value in MII_LPA makes sense but I don't have such a deep knowledge
of the ethernet spec.

To me, it does not makes sense for the LP to support ANEG (Bit 1 in
MII_EXPENSION), the aneg to have successfully complete and, at the
same time, LP does not ACK our base code word, which we should have
sent during this aneg.

If you think this may have unintended consequences or if you have
an idea to this differently, feel free to let me know.

 drivers/net/phy/meson-gxl.c | 59 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 58 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/meson-gxl.c b/drivers/net/phy/meson-gxl.c
index 2e8c40df33c2..726e0eeed475 100644
--- a/drivers/net/phy/meson-gxl.c
+++ b/drivers/net/phy/meson-gxl.c
@@ -35,11 +35,16 @@
 #define TSTWRITE	23
 
 #define BANK_ANALOG_DSP		0
+#define BANK_WOL		1
 #define BANK_BIST		3
 
 /* Analog/DSP Registers */
 #define A6_CONFIG_REG	0x17
 
+/* WOL Registers */
+#define LPI_STATUS	0xc
+#define  LPI_STATUS_RSV12	BIT(12)
+
 /* BIST Registers */
 #define FR_PLL_CONTROL	0x1b
 #define FR_PLL_DIV0	0x1c
@@ -145,6 +150,58 @@ static int meson_gxl_config_init(struct phy_device *phydev)
 	return genphy_config_init(phydev);
 }
 
+/* This specific function is provided to cope with the possible failures of
+ * this phy during aneg process. When aneg fails, the PHY reports that aneg
+ * is done but the value found in MII_LPA is wrong:
+ *  - Early failures: MII_LPA is just 0x0001. if MII_EXPANSION reports that
+ *    the link partner (LP) supports aneg but the LP never acked our base
+ *    code word, it is likely that we never sent it to begin with.
+ *  - Late failures: MII_LPA is filled with a value which seems to make sense
+ *    but it actually is not what the LP is advertising. It seems that we
+ *    can detect this using a magic bit in the WOL bank (reg 12 - bit 12).
+ *    If this particular bit is not set when aneg is reported being done,
+ *    it means MII_LPA is likely to be wrong.
+ *
+ * In both case, forcing a restart of the aneg process solve the problem.
+ * When this failure happens, the first retry is usually successful but,
+ * in some cases, it may take up to 6 retries to get a decent result
+ */
+int meson_gxl_read_status(struct phy_device *phydev)
+{
+	int ret, wol, lpa, exp;
+
+	if (phydev->autoneg == AUTONEG_ENABLE) {
+		ret = genphy_aneg_done(phydev);
+		if (ret < 0)
+			return ret;
+		else if (!ret)
+			goto read_status_continue;
+
+		/* Aneg is done, let's check everything is fine */
+		wol = meson_gxl_read_reg(phydev, BANK_WOL, LPI_STATUS);
+		if (wol < 0)
+			return wol;
+
+		lpa = phy_read(phydev, MII_LPA);
+		if (lpa < 0)
+			return lpa;
+
+		exp = phy_read(phydev, MII_EXPANSION);
+		if (exp < 0)
+			return exp;
+
+		if (!(wol & LPI_STATUS_RSV12) ||
+		    ((exp & EXPANSION_NWAY) && !(lpa & LPA_LPACK))) {
+			/* Looks like aneg failed after all */
+			phydev_dbg(phydev, "LPA corruption - aneg restart\n");
+			return genphy_restart_aneg(phydev);
+		}
+	}
+
+read_status_continue:
+	return genphy_read_status(phydev);
+}
+
 static struct phy_driver meson_gxl_phy[] = {
 	{
 		.phy_id		= 0x01814400,
@@ -155,7 +212,7 @@ static struct phy_driver meson_gxl_phy[] = {
 		.config_init	= meson_gxl_config_init,
 		.config_aneg	= genphy_config_aneg,
 		.aneg_done      = genphy_aneg_done,
-		.read_status	= genphy_read_status,
+		.read_status	= meson_gxl_read_status,
 		.suspend        = genphy_suspend,
 		.resume         = genphy_resume,
 	},
-- 
2.14.3
