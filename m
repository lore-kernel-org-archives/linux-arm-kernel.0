From: michal.simek@xilinx.com (Michal Simek)
Date: Fri, 31 Jan 2014 15:18:11 +0100
Subject: [PATCH 02/10] watchdog: xilinx: Move control_status_reg to functions
In-Reply-To: <ed4cb31c9a549343e6b492cf62fc962d39034bd0.1391177880.git.michal.simek@xilinx.com>
References: <ed4cb31c9a549343e6b492cf62fc962d39034bd0.1391177880.git.michal.simek@xilinx.com>
Message-ID: <ca50a63f8e204043247268217f7981102da1e530.1391177880.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

control_status_reg is temp variables and should be
used locally by specific function.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 drivers/watchdog/of_xilinx_wdt.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/of_xilinx_wdt.c b/drivers/watchdog/of_xilinx_wdt.c
index 8c2814e..aca9bab 100644
--- a/drivers/watchdog/of_xilinx_wdt.c
+++ b/drivers/watchdog/of_xilinx_wdt.c
@@ -52,13 +52,14 @@ struct xwdt_device {
 static struct xwdt_device xdev;

 static  u32 timeout;
-static  u32 control_status_reg;
 static  u8  no_timeout;

 static  DEFINE_SPINLOCK(spinlock);

 static int xilinx_wdt_start(struct watchdog_device *wdd)
 {
+	u32 control_status_reg;
+
 	spin_lock(&spinlock);

 	/* Clean previous status and enable the watchdog timer */
@@ -77,6 +78,8 @@ static int xilinx_wdt_start(struct watchdog_device *wdd)

 static int xilinx_wdt_stop(struct watchdog_device *wdd)
 {
+	u32 control_status_reg;
+
 	spin_lock(&spinlock);

 	control_status_reg = ioread32(xdev.base + XWT_TWCSR0_OFFSET);
@@ -94,6 +97,8 @@ static int xilinx_wdt_stop(struct watchdog_device *wdd)

 static int xilinx_wdt_keepalive(struct watchdog_device *wdd)
 {
+	u32 control_status_reg;
+
 	spin_lock(&spinlock);

 	control_status_reg = ioread32(xdev.base + XWT_TWCSR0_OFFSET);
--
1.8.2.3

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140131/b7281859/attachment.sig>
