From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 15 Feb 2013 12:56:37 +0000
Subject: [PATCH 06/35] mfd: ab8500-core: Sysfs chip id modification
In-Reply-To: <1360933026-30325-1-git-send-email-lee.jones@linaro.org>
References: <1360933026-30325-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1360933026-30325-7-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcus Cooper <marcus.xm.cooper@stericsson.com>

On newer variants of the ab a version and revision value can be
read. This modification merges these two values to create a
chip id.

Signed-off-by: Marcus Cooper <marcus.xm.cooper@stericsson.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Reviewed-by: Mattias WALLIN <mattias.wallin@stericsson.com>
Tested-by: Jonas ABERG <jonas.aberg@stericsson.com>
---
 drivers/mfd/ab8500-core.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/ab8500-core.c b/drivers/mfd/ab8500-core.c
index 7c20728..678afd0 100644
--- a/drivers/mfd/ab8500-core.c
+++ b/drivers/mfd/ab8500-core.c
@@ -1095,9 +1095,15 @@ static ssize_t show_chip_id(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
 	struct ab8500 *ab8500;
+	int chip_id = -EINVAL;
 
 	ab8500 = dev_get_drvdata(dev);
-	return sprintf(buf, "%#x\n", ab8500 ? ab8500->chip_id : -EINVAL);
+	if(ab8500) {
+		chip_id = ab8500->chip_id;
+		if((is_ab8505(ab8500) || is_ab9540(ab8500)) && ab8500->version != 0xFF)
+			chip_id = (ab8500->version << 8) | chip_id;
+	}
+	return sprintf(buf, "%#x\n", chip_id);
 }
 
 /*
-- 
1.7.10.4
