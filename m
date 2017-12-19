From: jun.gao@mediatek.com (Jun Gao)
Date: Tue, 19 Dec 2017 14:51:03 +0800
Subject: [PATCH 3/3] i2c: mediatek: Enable i2c module clock before i2c
 registers access.
In-Reply-To: <1513666263-6443-1-git-send-email-jun.gao@mediatek.com>
References: <1513666263-6443-1-git-send-email-jun.gao@mediatek.com>
Message-ID: <1513666263-6443-4-git-send-email-jun.gao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jun Gao <jun.gao@mediatek.com>

Make sure i2c module clock has been enabled before i2c registers
access.

Signed-off-by: Jun Gao <jun.gao@mediatek.com>
---
 drivers/i2c/busses/i2c-mt65xx.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/i2c/busses/i2c-mt65xx.c b/drivers/i2c/busses/i2c-mt65xx.c
index 58d6401..cf23a74 100644
--- a/drivers/i2c/busses/i2c-mt65xx.c
+++ b/drivers/i2c/busses/i2c-mt65xx.c
@@ -861,10 +861,19 @@ static int mtk_i2c_remove(struct platform_device *pdev)
 #ifdef CONFIG_PM_SLEEP
 static int mtk_i2c_resume(struct device *dev)
 {
+	int ret;
 	struct mtk_i2c *i2c = dev_get_drvdata(dev);
 
+	ret = mtk_i2c_clock_enable(i2c);
+	if (ret) {
+		dev_err(dev, "clock enable failed!\n");
+		return ret;
+	}
+
 	mtk_i2c_init_hw(i2c);
 
+	mtk_i2c_clock_disable(i2c);
+
 	return 0;
 }
 #endif
-- 
1.8.1.1
