From: aaro.koskinen@nokia.com (Aaro Koskinen)
Date: Thu, 24 Mar 2011 18:35:32 +0200
Subject: [PATCH 3/6] arm: mach-omap2: smartreflex: request the memory region
In-Reply-To: <1300984535-10530-1-git-send-email-aaro.koskinen@nokia.com>
References: <1300984535-10530-1-git-send-email-aaro.koskinen@nokia.com>
Message-ID: <1300984535-10530-3-git-send-email-aaro.koskinen@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We are releasing the memory region, but never actually request it.

Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
---
 arch/arm/mach-omap2/smartreflex.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index 6dfc8db..81bd5ed 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -847,6 +847,14 @@ static int __init omap_sr_probe(struct platform_device *pdev)
 		goto err_free_devinfo;
 	}
 
+	mem = request_mem_region(mem->start, resource_size(mem),
+					dev_name(&pdev->dev));
+	if (!mem) {
+		dev_err(&pdev->dev, "%s: no mem region\n", __func__);
+		ret = -EBUSY;
+		goto err_free_devinfo;
+	}
+
 	irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
 
 	pm_runtime_enable(&pdev->dev);
-- 
1.5.6.5
