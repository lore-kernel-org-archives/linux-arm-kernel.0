From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 19 Apr 2012 21:36:41 +0100
Subject: [PATCH 12/15] mfd/db8500-prcmu: Register as a platform driver instead
 of only probing
In-Reply-To: <1334867804-31942-1-git-send-email-lee.jones@linaro.org>
References: <1334867804-31942-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1334867804-31942-13-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pass the probe function as part of the platform_driver struct and
register using the more common platform_driver_register call. In
subsequent patches we'll also add DT support into the struct.

CC: Samuel Ortiz <sameo@linux.intel.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/db8500-prcmu.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/db8500-prcmu.c b/drivers/mfd/db8500-prcmu.c
index ebc1e86..839e70b 100644
--- a/drivers/mfd/db8500-prcmu.c
+++ b/drivers/mfd/db8500-prcmu.c
@@ -2957,7 +2957,7 @@ static struct mfd_cell db8500_prcmu_devs[] = {
  * prcmu_fw_init - arch init call for the Linux PRCMU fw init logic
  *
  */
-static int __init db8500_prcmu_probe(struct platform_device *pdev)
+static int __devinit db8500_prcmu_probe(struct platform_device *pdev)
 {
 	int err = 0;
 
@@ -2998,11 +2998,12 @@ static struct platform_driver db8500_prcmu_driver = {
 		.name = "db8500-prcmu",
 		.owner = THIS_MODULE,
 	},
+	.probe = db8500_prcmu_probe,
 };
 
 static int __init db8500_prcmu_init(void)
 {
-	return platform_driver_probe(&db8500_prcmu_driver, db8500_prcmu_probe);
+	return platform_driver_register(&db8500_prcmu_driver);
 }
 
 arch_initcall(db8500_prcmu_init);
-- 
1.7.9.1
