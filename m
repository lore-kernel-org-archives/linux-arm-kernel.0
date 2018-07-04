From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed,  4 Jul 2018 20:33:22 +0200
Subject: [PATCH net-next 3/5 v2] net: gemini: Allow multiple ports to
 instantiate
In-Reply-To: <20180704183324.10605-1-linus.walleij@linaro.org>
References: <20180704183324.10605-1-linus.walleij@linaro.org>
Message-ID: <20180704183324.10605-3-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The code was not tested with two ports actually in use at
the same time. (I blame this on lack of actual hardware using
that feature.) Now after locating a system using both ports,
add necessary fix to make both ports come up.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- No changes, just resending with the rest.
---
 drivers/net/ethernet/cortina/gemini.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index f219208d2351..6b5aa5704c4f 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -1789,7 +1789,10 @@ static int gmac_open(struct net_device *netdev)
 	phy_start(netdev->phydev);
 
 	err = geth_resize_freeq(port);
-	if (err) {
+	/* It's fine if it's just busy, the other port has set up
+	 * the freeq in that case.
+	 */
+	if (err && (err != -EBUSY)) {
 		netdev_err(netdev, "could not resize freeq\n");
 		goto err_stop_phy;
 	}
-- 
2.17.1
