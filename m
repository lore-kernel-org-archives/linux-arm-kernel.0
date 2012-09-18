From: pawel.moll@arm.com (Pawel Moll)
Date: Tue, 18 Sep 2012 15:17:43 +0100
Subject: [PATCH v2 01/13] input: ambakmi: (Un)prepare clocks when (dis)enabling
In-Reply-To: <1347977875-16855-1-git-send-email-pawel.moll@arm.com>
References: <1347977875-16855-1-git-send-email-pawel.moll@arm.com>
Message-ID: <1347977875-16855-2-git-send-email-pawel.moll@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Clocks must be prepared before enabling and unprepared
after disabling. Use appropriate functions to do this
in one go.

Signed-off-by: Pawel Moll <pawel.moll@arm.com>
---
 drivers/input/serio/ambakmi.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Hi Russell, Dmitry,

What would be your preference regarding merging this patch? Russell's patch
system? Dmitry's git tree? Or maybe you want me to add it to a pull request
for arm-soc guys?

Cheers!

Pawel

diff --git a/drivers/input/serio/ambakmi.c b/drivers/input/serio/ambakmi.c
index 2ffd110..2e77246 100644
--- a/drivers/input/serio/ambakmi.c
+++ b/drivers/input/serio/ambakmi.c
@@ -72,7 +72,7 @@ static int amba_kmi_open(struct serio *io)
 	unsigned int divisor;
 	int ret;
 
-	ret = clk_enable(kmi->clk);
+	ret = clk_prepare_enable(kmi->clk);
 	if (ret)
 		goto out;
 
@@ -92,7 +92,7 @@ static int amba_kmi_open(struct serio *io)
 	return 0;
 
  clk_disable:
-	clk_disable(kmi->clk);
+	clk_disable_unprepare(kmi->clk);
  out:
 	return ret;
 }
@@ -104,7 +104,7 @@ static void amba_kmi_close(struct serio *io)
 	writeb(0, KMICR);
 
 	free_irq(kmi->irq, kmi);
-	clk_disable(kmi->clk);
+	clk_disable_unprepare(kmi->clk);
 }
 
 static int __devinit amba_kmi_probe(struct amba_device *dev,
-- 
1.7.9.5
