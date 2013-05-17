From: weiyj.lk@gmail.com (Wei Yongjun)
Date: Fri, 17 May 2013 16:26:00 +0800
Subject: [PATCH] ARM: etm: add missing misc_deregister() on probe error and
 remove
Message-ID: <CAPgLHd_ScFPt5iYoFv++Bn-0cbwBXRX4YXJWqyyNzhQQkTsHXQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Add the missing misc_deregister() on probe error and remove.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 arch/arm/kernel/etm.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kernel/etm.c b/arch/arm/kernel/etm.c
index 8ff0ecd..d0b7426 100644
--- a/arch/arm/kernel/etm.c
+++ b/arch/arm/kernel/etm.c
@@ -365,7 +365,8 @@ static int etb_probe(struct amba_device *dev, const struct amba_id *id)
 	t->emu_clk = clk_get(&dev->dev, "emu_src_ck");
 	if (IS_ERR(t->emu_clk)) {
 		dev_dbg(&dev->dev, "Failed to obtain emu_src_ck.\n");
-		return -EFAULT;
+		ret = PTR_ERR(t->emu_clk);
+		goto out_dereg;
 	}
 
 	clk_enable(t->emu_clk);
@@ -384,6 +385,8 @@ static int etb_probe(struct amba_device *dev, const struct amba_id *id)
 out:
 	return ret;
 
+out_dereg:
+	misc_deregister(&etb_miscdev);
 out_unmap:
 	amba_set_drvdata(dev, NULL);
 	iounmap(t->etb_regs);
@@ -398,6 +401,7 @@ static int etb_remove(struct amba_device *dev)
 {
 	struct tracectx *t = amba_get_drvdata(dev);
 
+	misc_deregister(&etb_miscdev);
 	amba_set_drvdata(dev, NULL);
 
 	iounmap(t->etb_regs);
