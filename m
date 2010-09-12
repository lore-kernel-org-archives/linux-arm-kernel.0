From: simon@sequanux.org (Simon Guinot)
Date: Mon, 13 Sep 2010 00:30:24 +0200
Subject: [PATCH 1/4] phylib: fix PAL state machine restart on resume
In-Reply-To: <20100912213239.GA2614@kw.sim.vm.gnt>
References: <20100912213239.GA2614@kw.sim.vm.gnt>
Message-ID: <1284330624-19150-1-git-send-email-simon@sequanux.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Simon Guinot <sguinot@lacie.com>

On resume, before starting the PAL state machine, check if the
adjust_link() method is well supplied. If not, this would lead to a
NULL pointer dereference in the phy_state_machine() function.

This scenario can happen if the Ethernet driver call manually the PHY
functions instead of using the PAL state machine. The mv643xx_eth driver
is a such example.

Signed-off-by: Simon Guinot <sguinot@lacie.com>
---
 drivers/net/phy/mdio_bus.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
index 6a6b819..6c58da2 100644
--- a/drivers/net/phy/mdio_bus.c
+++ b/drivers/net/phy/mdio_bus.c
@@ -308,7 +308,7 @@ static int mdio_bus_suspend(struct device *dev)
 	 * may call phy routines that try to grab the same lock, and that may
 	 * lead to a deadlock.
 	 */
-	if (phydev->attached_dev)
+	if (phydev->attached_dev && phydev->adjust_link)
 		phy_stop_machine(phydev);
 
 	if (!mdio_bus_phy_may_suspend(phydev))
@@ -331,7 +331,7 @@ static int mdio_bus_resume(struct device *dev)
 		return ret;
 
 no_resume:
-	if (phydev->attached_dev)
+	if (phydev->attached_dev && phydev->adjust_link)
 		phy_start_machine(phydev, NULL);
 
 	return 0;
-- 
1.6.3.1
