From: arve@android.com (=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=)
Date: Mon, 14 Feb 2011 22:11:09 -0800
Subject: [PATCH 1/8] ARM: etm: Don't require clock control
In-Reply-To: <1296701663-12168-1-git-send-email-arve@android.com>
References: <1296701663-12168-1-git-send-email-arve@android.com>
Message-ID: <1297750276-12475-1-git-send-email-arve@android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If clk_get fail, assume the etb does not need a separate clock.

Signed-off-by: Arve Hj?nnev?g <arve@android.com>
---
 arch/arm/kernel/etm.c |   15 ++++++++-------
 1 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/arm/kernel/etm.c b/arch/arm/kernel/etm.c
index 11db628..d4ec368 100644
--- a/arch/arm/kernel/etm.c
+++ b/arch/arm/kernel/etm.c
@@ -361,13 +361,12 @@ static int __init etb_probe(struct amba_device *dev, struct amba_id *id)
 	if (ret)
 		goto out_unmap;
 
+	/* Get optional clock. Currently used to select clock source on omap3 */
 	t->emu_clk = clk_get(&dev->dev, "emu_src_ck");
-	if (IS_ERR(t->emu_clk)) {
+	if (IS_ERR(t->emu_clk))
 		dev_dbg(&dev->dev, "Failed to obtain emu_src_ck.\n");
-		return -EFAULT;
-	}
-
-	clk_enable(t->emu_clk);
+	else
+		clk_enable(t->emu_clk);
 
 	etb_unlock(t);
 	t->etb_bufsz = etb_readl(t, ETBR_DEPTH);
@@ -402,8 +401,10 @@ static int etb_remove(struct amba_device *dev)
 	iounmap(t->etb_regs);
 	t->etb_regs = NULL;
 
-	clk_disable(t->emu_clk);
-	clk_put(t->emu_clk);
+	if (!IS_ERR(t->emu_clk)) {
+		clk_disable(t->emu_clk);
+		clk_put(t->emu_clk);
+	}
 
 	amba_release_regions(dev);
 
-- 
1.7.3.1
