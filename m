From: pawel.moll@arm.com (Pawel Moll)
Date: Wed,  3 Apr 2013 13:26:27 +0100
Subject: [PATCH] mfd: vexpress: Give the "leds-gpio" device a real parent
Message-ID: <1364991987-6598-1-git-send-email-pawel.moll@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The registration of the "leds-gpio" device was using
"vexpress_sysreg_dev" as a parent before it was actually
set to something different than NULL.

Trivial fix by reordering the code.

Reported-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Pawel Moll <pawel.moll@arm.com>
---
 drivers/mfd/vexpress-sysreg.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/vexpress-sysreg.c b/drivers/mfd/vexpress-sysreg.c
index bf75e96..96a020b 100644
--- a/drivers/mfd/vexpress-sysreg.c
+++ b/drivers/mfd/vexpress-sysreg.c
@@ -490,12 +490,12 @@ static int vexpress_sysreg_probe(struct platform_device *pdev)
 		return err;
 	}
 
+	vexpress_sysreg_dev = &pdev->dev;
+
 	platform_device_register_data(vexpress_sysreg_dev, "leds-gpio",
 			PLATFORM_DEVID_AUTO, &vexpress_sysreg_leds_pdata,
 			sizeof(vexpress_sysreg_leds_pdata));
 
-	vexpress_sysreg_dev = &pdev->dev;
-
 	device_create_file(vexpress_sysreg_dev, &dev_attr_sys_id);
 
 	return 0;
-- 
1.7.10.4
