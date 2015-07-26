From: vz@mleia.com (Vladimir Zapolskiy)
Date: Mon, 27 Jul 2015 00:18:53 +0300
Subject: [PATCH 8/8] misc: eeprom: sunxi_sid: clean up sid_read()
In-Reply-To: <1437945502-27944-1-git-send-email-vz@mleia.com>
References: <1437945502-27944-1-git-send-email-vz@mleia.com>
Message-ID: <1437945533-27996-8-git-send-email-vz@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The change removes redundant sysfs binary file boundary checks, since
this task is already done on caller side in fs/sysfs/file.c

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/misc/eeprom/sunxi_sid.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/misc/eeprom/sunxi_sid.c b/drivers/misc/eeprom/sunxi_sid.c
index 8385177..26ce99d 100644
--- a/drivers/misc/eeprom/sunxi_sid.c
+++ b/drivers/misc/eeprom/sunxi_sid.c
@@ -70,11 +70,6 @@ static ssize_t sid_read(struct file *fd, struct kobject *kobj,
 	pdev = to_platform_device(kobj_to_dev(kobj));
 	sid_data = platform_get_drvdata(pdev);
 
-	if (pos < 0 || pos >= sid_data->keysize)
-		return 0;
-	if (size > sid_data->keysize - pos)
-		size = sid_data->keysize - pos;
-
 	for (i = 0; i < size; i++)
 		buf[i] = sunxi_sid_read_byte(sid_data, pos + i);
 
-- 
2.1.4
