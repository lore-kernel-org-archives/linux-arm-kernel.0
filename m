From: Hiroshi.DOYU@nokia.com (Hiroshi DOYU)
Date: Mon, 28 Sep 2009 09:21:26 -0700
Subject: [PATCH] omap: Fix wrong condition check in while loop for mailbox and iommu2
Message-ID: <mailman.44.1254155959.2253.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It's worked fine so far since reset is done for the first time.

Reported-by: Juha Leppanen <juha_motorsportcom@luukku.com>
Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Signed-off-by: Juha Leppanen <juha_motorsportcom@luukku.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/iommu2.c b/arch/arm/mach-omap2/iommu2.c
index 2d9b5cc..4a0e1cd 100644
--- a/arch/arm/mach-omap2/iommu2.c
+++ b/arch/arm/mach-omap2/iommu2.c
@@ -79,7 +79,7 @@ static int omap2_iommu_enable(struct iommu *obj)
 		l = iommu_read_reg(obj, MMU_SYSSTATUS);
 		if (l & MMU_SYS_RESETDONE)
 			break;
-	} while (time_after(jiffies, timeout));
+	} while (!time_after(jiffies, timeout));
 
 	if (!(l & MMU_SYS_RESETDONE)) {
 		dev_err(obj->dev, "can't take mmu out of reset\n");
diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
index f3fefca..c035ad3 100644
--- a/arch/arm/mach-omap2/mailbox.c
+++ b/arch/arm/mach-omap2/mailbox.c
@@ -93,7 +93,7 @@ static int omap2_mbox_startup(struct omap_mbox *mbox)
 		l = mbox_read_reg(MAILBOX_SYSSTATUS);
 		if (l & RESETDONE)
 			break;
-	} while (time_after(jiffies, timeout));
+	} while (!time_after(jiffies, timeout));
 
 	if (!(l & RESETDONE)) {
 		pr_err("Can't take mmu out of reset\n");

--Pd0ReVV5GZGQvF3a--
