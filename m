From: pawel.moll@arm.com (Pawel Moll)
Date: Mon,  3 Sep 2012 17:25:21 +0100
Subject: [PATCH 01/11] input: ambakmi: Add missing clk_[un]prepare() calls
In-Reply-To: <1346689531-7212-1-git-send-email-pawel.moll@arm.com>
References: <1346689531-7212-1-git-send-email-pawel.moll@arm.com>
Message-ID: <1346689531-7212-2-git-send-email-pawel.moll@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Clocks must be prepared before enabling and unprepared
after disabling. Without that clk_enable() fails with
warning.

Signed-off-by: Pawel Moll <pawel.moll@arm.com>
---
 drivers/input/serio/ambakmi.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/input/serio/ambakmi.c b/drivers/input/serio/ambakmi.c
index 2ffd110..ab2d25b 100644
--- a/drivers/input/serio/ambakmi.c
+++ b/drivers/input/serio/ambakmi.c
@@ -72,10 +72,14 @@ static int amba_kmi_open(struct serio *io)
 	unsigned int divisor;
 	int ret;
 
-	ret = clk_enable(kmi->clk);
+	ret = clk_prepare(kmi->clk);
 	if (ret)
 		goto out;
 
+	ret = clk_enable(kmi->clk);
+	if (ret)
+		goto clk_unprepare;
+
 	divisor = clk_get_rate(kmi->clk) / 8000000 - 1;
 	writeb(divisor, KMICLKDIV);
 	writeb(KMICR_EN, KMICR);
@@ -93,6 +97,8 @@ static int amba_kmi_open(struct serio *io)
 
  clk_disable:
 	clk_disable(kmi->clk);
+ clk_unprepare:
+	clk_unprepare(kmi->clk);
  out:
 	return ret;
 }
@@ -105,6 +111,7 @@ static void amba_kmi_close(struct serio *io)
 
 	free_irq(kmi->irq, kmi);
 	clk_disable(kmi->clk);
+	clk_unprepare(kmi->clk);
 }
 
 static int __devinit amba_kmi_probe(struct amba_device *dev,
-- 
1.7.9.5
