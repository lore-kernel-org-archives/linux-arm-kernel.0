From: appana.durga.rao@xilinx.com (Kedareswara rao Appana)
Date: Thu, 22 Oct 2015 10:16:02 +0530
Subject: [PATCH 1/2] can: xilinx: use readl/writel instead of ioread/iowrite
Message-ID: <1445489163-11045-1-git-send-email-appanad@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The driver only supports memory-mapped I/O [by ioremap()],
so readl/writel is actually the right thing to do, IMO.
During the validation of this driver or IP on ARM 64-bit processor
while sending lot of packets observed that the tx packet drop with iowrite
Putting the barriers for each tx fifo register write fixes this issue
Instead of barriers using writel also fixed this issue.

Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>
---
 drivers/net/can/xilinx_can.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
index 6114214..055d6f3 100644
--- a/drivers/net/can/xilinx_can.c
+++ b/drivers/net/can/xilinx_can.c
@@ -170,7 +170,7 @@ static const struct can_bittiming_const xcan_bittiming_const = {
 static void xcan_write_reg_le(const struct xcan_priv *priv, enum xcan_reg reg,
 			u32 val)
 {
-	iowrite32(val, priv->reg_base + reg);
+	writel(val, priv->reg_base + reg);
 }
 
 /**
@@ -183,7 +183,7 @@ static void xcan_write_reg_le(const struct xcan_priv *priv, enum xcan_reg reg,
  */
 static u32 xcan_read_reg_le(const struct xcan_priv *priv, enum xcan_reg reg)
 {
-	return ioread32(priv->reg_base + reg);
+	return readl(priv->reg_base + reg);
 }
 
 /**
-- 
2.1.2
