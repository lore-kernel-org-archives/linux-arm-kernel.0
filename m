From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed,  4 Jul 2018 20:33:20 +0200
Subject: [PATCH net-next 1/5 v2] net: gemini: Look up L3 maxlen from table
Message-ID: <20180704183324.10605-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The code to calculate the hardware register enumerator
for the maximum L3 length isn't entirely simple to read.
Use the existing defines and rewrite the function into a
table look-up.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- No changes, just resending with the rest.
---
 drivers/net/ethernet/cortina/gemini.c | 61 ++++++++++++++++++++-------
 1 file changed, 46 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index 6d7404f66f84..8fc31723f700 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -401,26 +401,57 @@ static int gmac_setup_phy(struct net_device *netdev)
 	return 0;
 }
 
-static int gmac_pick_rx_max_len(int max_l3_len)
-{
-	/* index = CONFIG_MAXLEN_XXX values */
-	static const int max_len[8] = {
-		1536, 1518, 1522, 1542,
-		9212, 10236, 1518, 1518
-	};
-	int i, n = 5;
+/* The maximum frame length is not logically enumerated in the
+ * hardware, so we do a table lookup to find the applicable max
+ * frame length.
+ */
+struct gmac_max_framelen {
+	unsigned int max_l3_len;
+	u8 val;
+};
 
-	max_l3_len += ETH_HLEN + VLAN_HLEN;
+static const struct gmac_max_framelen gmac_maxlens[] = {
+	{
+		.max_l3_len = 1518,
+		.val = CONFIG0_MAXLEN_1518,
+	},
+	{
+		.max_l3_len = 1522,
+		.val = CONFIG0_MAXLEN_1522,
+	},
+	{
+		.max_l3_len = 1536,
+		.val = CONFIG0_MAXLEN_1536,
+	},
+	{
+		.max_l3_len = 1542,
+		.val = CONFIG0_MAXLEN_1542,
+	},
+	{
+		.max_l3_len = 9212,
+		.val = CONFIG0_MAXLEN_9k,
+	},
+	{
+		.max_l3_len = 10236,
+		.val = CONFIG0_MAXLEN_10k,
+	},
+};
+
+static int gmac_pick_rx_max_len(unsigned int max_l3_len)
+{
+	const struct gmac_max_framelen *maxlen;
+	int maxtot;
+	int i;
 
-	if (max_l3_len > max_len[n])
-		return -1;
+	maxtot = max_l3_len + ETH_HLEN + VLAN_HLEN;
 
-	for (i = 0; i < 5; i++) {
-		if (max_len[i] >= max_l3_len && max_len[i] < max_len[n])
-			n = i;
+	for (i = 0; i < ARRAY_SIZE(gmac_maxlens); i++) {
+		maxlen = &gmac_maxlens[i];
+		if (maxtot <= maxlen->max_l3_len)
+			return maxlen->val;
 	}
 
-	return n;
+	return -1;
 }
 
 static int gmac_init(struct net_device *netdev)
-- 
2.17.1
