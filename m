From: robherring2@gmail.com (Rob Herring)
Date: Sun, 21 Jul 2013 14:53:37 -0500
Subject: [PATCH] ARM: highbank: Only touch common coherency control register
 fields
Message-ID: <1374436417-29761-1-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Midway adds new register fields to the coherency control registers, so
writing absolute values will break on Midway. Change the register
accesses to only modify the necessary and common fields in order to
support both Midway and Highbank.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/mach-highbank/highbank.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-highbank/highbank.c b/arch/arm/mach-highbank/highbank.c
index dc5d6be..8881579 100644
--- a/arch/arm/mach-highbank/highbank.c
+++ b/arch/arm/mach-highbank/highbank.c
@@ -115,6 +115,7 @@ static int highbank_platform_notifier(struct notifier_block *nb,
 {
 	struct resource *res;
 	int reg = -1;
+	u32 val;
 	struct device *dev = __dev;
 
 	if (event != BUS_NOTIFY_ADD_DEVICE)
@@ -141,10 +142,10 @@ static int highbank_platform_notifier(struct notifier_block *nb,
 		return NOTIFY_DONE;
 
 	if (of_property_read_bool(dev->of_node, "dma-coherent")) {
-		writel(0xff31, sregs_base + reg);
+		val = readl(sregs_base + reg);
+		writel(val | 0xff01, sregs_base + reg);
 		set_dma_ops(dev, &arm_coherent_dma_ops);
-	} else
-		writel(0, sregs_base + reg);
+	}
 
 	return NOTIFY_OK;
 }
-- 
1.8.1.2
