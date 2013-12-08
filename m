From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Sun,  8 Dec 2013 15:40:31 +0100
Subject: [PATCH v1 6/6] net: phy: suspend phydev when going to HALTED
In-Reply-To: <1386513631-11284-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1386171888-28190-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1386513631-11284-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1386513631-11284-7-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When phydev is going to HALTED state, we can try to suspend it to
safe more power. phy_suspend helper will check if PHY can be suspended,
so just call it when entering HALTED state.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Acked-by: Mugunthan V N <mugunthanvnm@ti.com>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
---
Cc: David Miller <davem@davemloft.net>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Mugunthan V N <mugunthanvnm@ti.com>
Cc: netdev at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 drivers/net/phy/phy.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index 36c6994..6429942 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -740,7 +740,7 @@ void phy_state_machine(struct work_struct *work)
 	struct delayed_work *dwork = to_delayed_work(work);
 	struct phy_device *phydev =
 			container_of(dwork, struct phy_device, state_queue);
-	int needs_aneg = 0;
+	int needs_aneg = 0, do_suspend = 0;
 	int err = 0;
 
 	mutex_lock(&phydev->lock);
@@ -855,6 +855,7 @@ void phy_state_machine(struct work_struct *work)
 				phydev->link = 0;
 				netif_carrier_off(phydev->attached_dev);
 				phydev->adjust_link(phydev->attached_dev);
+				do_suspend = 1;
 			}
 			break;
 		case PHY_RESUMING:
@@ -913,6 +914,9 @@ void phy_state_machine(struct work_struct *work)
 	if (needs_aneg)
 		err = phy_start_aneg(phydev);
 
+	if (do_suspend)
+		phy_suspend(phydev);
+
 	if (err < 0)
 		phy_error(phydev);
 
-- 
1.8.4.rc3
