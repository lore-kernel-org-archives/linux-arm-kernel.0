From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 22 Jul 2014 12:11:24 +0100
Subject: [PATCH 18/19] mfd: kempld-core: Correct a variety of checkpatch
 warnings
In-Reply-To: <1406027485-15657-1-git-send-email-lee.jones@linaro.org>
References: <1406027485-15657-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1406027485-15657-19-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

WARNING: line over 80 characters
+module_param_string(force_device_id, force_device_id, sizeof(force_device_id), 0);

WARNING: msleep < 20ms can sleep for up to 20ms; see Documentation/timers/timers-howto.txt
+               msleep(1);

WARNING: __initdata should be placed after kempld_dmi_table[]
+static struct dmi_system_id __initdata kempld_dmi_table[] = {

WARNING: line over 80 characters
+               for (id = kempld_dmi_table; id->matches[0].slot != DMI_NONE; id++)

total: 0 errors, 4 warnings, 771 lines checked

This is part of an effort to clean-up the MFD subsystem.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/kempld-core.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/kempld-core.c b/drivers/mfd/kempld-core.c
index f7ff018..bd26961 100644
--- a/drivers/mfd/kempld-core.c
+++ b/drivers/mfd/kempld-core.c
@@ -24,7 +24,8 @@
 
 #define MAX_ID_LEN 4
 static char force_device_id[MAX_ID_LEN + 1] = "";
-module_param_string(force_device_id, force_device_id, sizeof(force_device_id), 0);
+module_param_string(force_device_id, force_device_id,
+		    sizeof(force_device_id), 0);
 MODULE_PARM_DESC(force_device_id, "Override detected product");
 
 /*
@@ -36,7 +37,7 @@ static void kempld_get_hardware_mutex(struct kempld_device_data *pld)
 {
 	/* The mutex bit will read 1 until access has been granted */
 	while (ioread8(pld->io_index) & KEMPLD_MUTEX_KEY)
-		msleep(1);
+		usleep_range(1000, 3000);
 }
 
 static void kempld_release_hardware_mutex(struct kempld_device_data *pld)
@@ -499,7 +500,7 @@ static struct platform_driver kempld_driver = {
 	.remove		= kempld_remove,
 };
 
-static struct dmi_system_id __initdata kempld_dmi_table[] = {
+static struct dmi_system_id kempld_dmi_table[] __initdata = {
 	{
 		.ident = "BHL6",
 		.matches = {
@@ -736,7 +737,8 @@ static int __init kempld_init(void)
 	int ret;
 
 	if (force_device_id[0]) {
-		for (id = kempld_dmi_table; id->matches[0].slot != DMI_NONE; id++)
+		for (id = kempld_dmi_table;
+		     id->matches[0].slot != DMI_NONE; id++)
 			if (strstr(id->ident, force_device_id))
 				if (id->callback && id->callback(id))
 					break;
-- 
1.8.3.2
