From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Sat, 18 Nov 2017 12:06:32 +0530
Subject: [PATCH 2/3] mfd: intel-lpss: Handle return value of platform_get_*
In-Reply-To: <1510986993-4936-1-git-send-email-arvind.yadav.cs@gmail.com>
References: <1510986993-4936-1-git-send-email-arvind.yadav.cs@gmail.com>
Message-ID: <1510986993-4936-3-git-send-email-arvind.yadav.cs@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

platform_get_irq() and platform_get_resource() can fail here and
we must check its return value.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/mfd/intel-lpss-acpi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mfd/intel-lpss-acpi.c b/drivers/mfd/intel-lpss-acpi.c
index 7911b0a..cb84de5 100644
--- a/drivers/mfd/intel-lpss-acpi.c
+++ b/drivers/mfd/intel-lpss-acpi.c
@@ -92,6 +92,8 @@ static int intel_lpss_acpi_probe(struct platform_device *pdev)
 
 	info->mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	info->irq = platform_get_irq(pdev, 0);
+	if (!info->mem || info->irq < 0)
+		return -ENOMEM;
 
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
-- 
2.7.4
