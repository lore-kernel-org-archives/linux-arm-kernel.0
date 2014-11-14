From: dtor@chromium.org (Dmitry Torokhov)
Date: Fri, 14 Nov 2014 14:09:50 -0800
Subject: [PATCH] [media] exynos4-is: fix error handling of irq_of_parse_and_map
Message-ID: <20141114220950.GA34576@dtor-ws>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Return value of irq_of_parse_and_map() is unsigned int, with 0
indicating failure, so testing for negative result never works.

Signed-off-by: Dmitry Torokhov <dtor@chromium.org>
---

Not tested, found by casual code inspection.

 drivers/media/platform/exynos4-is/fimc-is.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/exynos4-is/fimc-is.c b/drivers/media/platform/exynos4-is/fimc-is.c
index 94c6b47..0fdca86 100644
--- a/drivers/media/platform/exynos4-is/fimc-is.c
+++ b/drivers/media/platform/exynos4-is/fimc-is.c
@@ -814,9 +814,9 @@ static int fimc_is_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	is->irq = irq_of_parse_and_map(dev->of_node, 0);
-	if (is->irq < 0) {
+	if (!is->irq) {
 		dev_err(dev, "no irq found\n");
-		return is->irq;
+		return -EINVAL;
 	}
 
 	ret = fimc_is_get_clocks(is);
-- 
2.1.0.rc2.206.gedb03e5


-- 
Dmitry
