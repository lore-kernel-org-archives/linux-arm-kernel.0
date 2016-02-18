From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Thu, 18 Feb 2016 15:19:11 -0300
Subject: [PATCH 3/3] thermal: exynos: Defer probe if vtmu is present but not
 registered
In-Reply-To: <1455819551-4666-1-git-send-email-javier@osg.samsung.com>
References: <1455819551-4666-1-git-send-email-javier@osg.samsung.com>
Message-ID: <1455819551-4666-4-git-send-email-javier@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The driver doesn't check if the regulator_get_optional return value is
-EPROBE_DEFER so it will wrongly assume that the regulator couldn't be
found just because the regulator driver wasn't registered yet, i.e:

exynos-tmu 10060000.tmu: Regulator node (vtmu) not found

In this case the return value should be propagated to allow the driver
probe function to be deferred until the regulator driver is registered.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

---

 drivers/thermal/samsung/exynos_tmu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index f4f36bba7be9..f3ce94ec73b5 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -1318,6 +1318,8 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 			return ret;
 		}
 	} else {
+		if (PTR_ERR(data->regulator) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
 		dev_info(&pdev->dev, "Regulator node (vtmu) not found\n");
 	}
 
-- 
2.5.0
