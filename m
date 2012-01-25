From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 25 Jan 2012 14:34:49 +0000
Subject: [PATCH 14/33] MFD: mcp-sa11x0: use _noirq resume methods
In-Reply-To: <20120125143000.GF1068@n2100.arm.linux.org.uk>
References: <20120125143000.GF1068@n2100.arm.linux.org.uk>
Message-ID: <E1Rq3w1-0000Yd-Sz@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The genirq code requires early access to interrupt controllers.  In
order to allow this, we need to resume the MCP via the _noirq methods
instead of the standard methods.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mfd/mcp-sa11x0.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/drivers/mfd/mcp-sa11x0.c b/drivers/mfd/mcp-sa11x0.c
index 46167f6..420710b 100644
--- a/drivers/mfd/mcp-sa11x0.c
+++ b/drivers/mfd/mcp-sa11x0.c
@@ -289,7 +289,14 @@ static int mcp_sa11x0_resume(struct device *dev)
 #endif
 
 static const struct dev_pm_ops mcp_sa11x0_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(mcp_sa11x0_suspend, mcp_sa11x0_resume)
+#ifdef CONFIG_PM_SLEEP
+	.suspend = mcp_sa11x0_suspend,
+	.freeze = mcp_sa11x0_suspend,
+	.poweroff = mcp_sa11x0_suspend,
+	.resume_noirq = mcp_sa11x0_resume,
+	.thaw_noirq = mcp_sa11x0_resume,
+	.restore_noirq = mcp_sa11x0_resume,
+#endif
 };
 
 static struct platform_driver mcp_sa11x0_driver = {
-- 
1.7.4.4
