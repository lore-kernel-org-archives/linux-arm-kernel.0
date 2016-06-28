From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Tue, 28 Jun 2016 13:21:08 +0200
Subject: [PATCH] PM / devfreq: exynos-ppmu: fix error path in
 exynos_ppmu_probe()
Message-ID: <1467112869-30488-1-git-send-email-b.zolnierkie@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

iounmap() needs to be called in case of memory allocation
(for devfreq-event devices) failure.  Fix it.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/devfreq/event/exynos-ppmu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/devfreq/event/exynos-ppmu.c b/drivers/devfreq/event/exynos-ppmu.c
index f312485..845bf25 100644
--- a/drivers/devfreq/event/exynos-ppmu.c
+++ b/drivers/devfreq/event/exynos-ppmu.c
@@ -482,7 +482,8 @@ static int exynos_ppmu_probe(struct platform_device *pdev)
 	if (!info->edev) {
 		dev_err(&pdev->dev,
 			"failed to allocate memory devfreq-event devices\n");
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto err;
 	}
 	edev = info->edev;
 	platform_set_drvdata(pdev, info);
-- 
1.9.1
