From: manuel.schoelling@gmx.de (=?UTF-8?q?Manuel=20Sch=C3=B6lling?=)
Date: Sun, 22 Jun 2014 13:24:54 +0200
Subject: [PATCH v2] xilinx: Fix compiler warning
In-Reply-To: <53A6BAC5.80206@cogentembedded.com>
References: <53A6BAC5.80206@cogentembedded.com>
Message-ID: <1403436294-21301-1-git-send-email-manuel.schoelling@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The time comparsion functions require arguments of type unsigned long
instead of (signed) long.

Signed-off-by: Manuel Sch?lling <manuel.schoelling@gmx.de>
---
 drivers/net/ethernet/xilinx/ll_temac_main.c       |    2 +-
 drivers/net/ethernet/xilinx/xilinx_axienet_mdio.c |    2 +-
 drivers/net/ethernet/xilinx/xilinx_emaclite.c     |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/ll_temac_main.c b/drivers/net/ethernet/xilinx/ll_temac_main.c
index 4ef818a..8a6e5c2 100644
--- a/drivers/net/ethernet/xilinx/ll_temac_main.c
+++ b/drivers/net/ethernet/xilinx/ll_temac_main.c
@@ -72,7 +72,7 @@ void temac_iow(struct temac_local *lp, int offset, u32 value)
 
 int temac_indirect_busywait(struct temac_local *lp)
 {
-	long end = jiffies + 2;
+	unsigned long end = jiffies + 2;
 
 	while (!(temac_ior(lp, XTE_RDY0_OFFSET) & XTE_RDY0_HARD_ACS_RDY_MASK)) {
 		if (time_before_eq(end, jiffies)) {
diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_mdio.c b/drivers/net/ethernet/xilinx/xilinx_axienet_mdio.c
index d4abf47..3b67d60 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_mdio.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_mdio.c
@@ -19,7 +19,7 @@
 /* Wait till MDIO interface is ready to accept a new transaction.*/
 int axienet_mdio_wait_until_ready(struct axienet_local *lp)
 {
-	long end = jiffies + 2;
+	unsigned long end = jiffies + 2;
 	while (!(axienet_ior(lp, XAE_MDIO_MCR_OFFSET) &
 		 XAE_MDIO_MCR_READY_MASK)) {
 		if (time_before_eq(end, jiffies)) {
diff --git a/drivers/net/ethernet/xilinx/xilinx_emaclite.c b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
index 8c4aed3..782bb93 100644
--- a/drivers/net/ethernet/xilinx/xilinx_emaclite.c
+++ b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
@@ -695,7 +695,7 @@ static irqreturn_t xemaclite_interrupt(int irq, void *dev_id)
 
 static int xemaclite_mdio_wait(struct net_local *lp)
 {
-	long end = jiffies + 2;
+	unsigned long end = jiffies + 2;
 
 	/* wait for the MDIO interface to not be busy or timeout
 	   after some time.
-- 
1.7.10.4
