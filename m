From: amit.kucheria@canonical.com (Amit Kucheria)
Date: Fri,  4 Dec 2009 04:47:07 +0200
Subject: [RFC][PATCH 07/10] fec: Add LAN8700 phy support
In-Reply-To: <7a49f4c0ea2f5030068729978c2cb173a6e15857.1259893118.git.amit.kucheria@canonical.com>
References: <cover.1259893118.git.amit.kucheria@canonical.com>
	<e99e70e2a619693064130a747b6ee3a93273337b.1259893118.git.amit.kucheria@canonical.com>
	<6608c4dca645d87efce78ae0b7dbad265004f482.1259893118.git.amit.kucheria@canonical.com>
	<58eb7d14c6cf56cbc874657dff5789c47116b49e.1259893118.git.amit.kucheria@canonical.com>
	<a079a0627e77f2df590840e4798fc067f4436160.1259893118.git.amit.kucheria@canonical.com>
	<0559d42bc9f32e30264fea6ca6fa679121f6a241.1259893118.git.amit.kucheria@canonical.com>
	<7a49f4c0ea2f5030068729978c2cb173a6e15857.1259893118.git.amit.kucheria@canonical.com>
Message-ID: <a34d2aac8d5282bfbdf09dddc2da57c4ad7da355.1259893118.git.amit.kucheria@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The i.MX51 babbage board has a FEC ethernet controller with this phy.

Signed-off-by: Amit Kucheria <amit.kucheria@canonical.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: netdev at vger.kernel.org
---
 drivers/net/fec.c |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/drivers/net/fec.c b/drivers/net/fec.c
index 9a8743d..5d0d332 100644
--- a/drivers/net/fec.c
+++ b/drivers/net/fec.c
@@ -1128,6 +1128,26 @@ static phy_info_t phy_info_dp83848= {
 	},
 };
 
+static phy_info_t phy_info_lan8700 = {
+	0x0007C0C,
+	"LAN8700",
+	(const phy_cmd_t []) { /* config */
+		{ mk_mii_read(MII_REG_CR), mii_parse_cr },
+		{ mk_mii_read(MII_REG_ANAR), mii_parse_anar },
+		{ mk_mii_end, }
+	},
+	(const phy_cmd_t []) { /* startup */
+		{ mk_mii_write(MII_REG_CR, 0x1200), NULL }, /* autonegotiate */
+		{ mk_mii_read(MII_REG_SR), mii_parse_sr },
+		{ mk_mii_end, }
+	},
+	(const phy_cmd_t []) { /* act_int */
+		{ mk_mii_end, }
+	},
+	(const phy_cmd_t []) { /* shutdown */
+		{ mk_mii_end, }
+	},
+};
 /* ------------------------------------------------------------------------- */
 
 static phy_info_t const * const phy_info[] = {
@@ -1137,6 +1157,7 @@ static phy_info_t const * const phy_info[] = {
 	&phy_info_am79c874,
 	&phy_info_ks8721bl,
 	&phy_info_dp83848,
+	&phy_info_lan8700,
 	NULL
 };
 
-- 
1.6.3.3
