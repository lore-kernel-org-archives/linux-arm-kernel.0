From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Sat, 18 Nov 2017 14:20:48 +0530
Subject: [PATCH 2/3 v2] mfd: intel-lpss: Handle return value of
 platform_get_irq
In-Reply-To: <4f12b680d2f0d7554e6a1812f15037185a5a9a2a.1510994294.git.arvind.yadav.cs@gmail.com>
References: <4f12b680d2f0d7554e6a1812f15037185a5a9a2a.1510994294.git.arvind.yadav.cs@gmail.com>
Message-ID: <4123c03394df1d0a1349a9eeebf74fcf760c79d5.1510994295.git.arvind.yadav.cs@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

platform_get_irq() can fail here and we must check its return value.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
changes in v2 :
              Add failure case '<= 0' instead of '< 0'. If IRQ0 is not valid.

 drivers/mfd/intel-lpss-acpi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mfd/intel-lpss-acpi.c b/drivers/mfd/intel-lpss-acpi.c
index 7911b0a..cb84de5 100644
--- a/drivers/mfd/intel-lpss-acpi.c
+++ b/drivers/mfd/intel-lpss-acpi.c
@@ -92,6 +92,8 @@ static int intel_lpss_acpi_probe(struct platform_device *pdev)
 
 	info->mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	info->irq = platform_get_irq(pdev, 0);
+	if (!info->mem || info->irq <= 0)
+		return -ENOMEM;
 
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
-- 
2.7.4
