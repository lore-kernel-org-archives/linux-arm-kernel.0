From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 25 Jan 2012 14:38:54 +0000
Subject: [PATCH 26/33] MFD: mcp-sa11x0: complain if mcp clock is left enabled
In-Reply-To: <20120125143000.GF1068@n2100.arm.linux.org.uk>
References: <20120125143000.GF1068@n2100.arm.linux.org.uk>
Message-ID: <E1Rq3zy-0000ZV-1e@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Issue a warning if the mcp clock was left enabled by some driver when
we're suspending or tearing down the core driver for the device.  This
is an aid for debugging missing disable calls.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mfd/mcp-sa11x0.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/mfd/mcp-sa11x0.c b/drivers/mfd/mcp-sa11x0.c
index 960ebc7..c381436 100644
--- a/drivers/mfd/mcp-sa11x0.c
+++ b/drivers/mfd/mcp-sa11x0.c
@@ -252,6 +252,10 @@ static int mcp_sa11x0_remove(struct platform_device *dev)
 	struct mcp_sa11x0 *m = priv(mcp);
 	struct resource *mem0, *mem1;
 
+	if (m->mccr0 & MCCR0_MCE)
+		dev_warn(&dev->dev,
+			 "device left active (missing disable call?)\n");
+
 	mem0 = platform_get_resource(dev, IORESOURCE_MEM, 0);
 	mem1 = platform_get_resource(dev, IORESOURCE_MEM, 1);
 
@@ -271,6 +275,9 @@ static int mcp_sa11x0_suspend(struct device *dev)
 {
 	struct mcp_sa11x0 *m = priv(dev_get_drvdata(dev));
 
+	if (m->mccr0 & MCCR0_MCE)
+		dev_warn(dev, "device left active (missing disable call?)\n");
+
 	writel(m->mccr0 & ~MCCR0_MCE, MCCR0(m));
 
 	return 0;
-- 
1.7.4.4
