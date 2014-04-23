From: ssl@chromium.org (Sheng-Liang Song)
Date: Tue, 22 Apr 2014 18:51:22 -0700
Subject: [PATCH] Input: atkbd - fix keyboard LG Electronics
Message-ID: <1398217882-29778-1-git-send-email-ssl@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After issuing ATKBD_CMD_RESET_DIS, LG Keyboard stop working.
The workaround is to remove ATKBD_CMD_RESET_DIS for LG Keyboards.

In order to keep the minimum changes to the current atkbd driver,
I add logic to apply the patch if and only if the device is LG LW25-B7HV or P1-J273B.
---
 drivers/input/keyboard/atkbd.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
index 2626773..9f82533 100644
--- a/drivers/input/keyboard/atkbd.c
+++ b/drivers/input/keyboard/atkbd.c
@@ -243,6 +243,8 @@ static void (*atkbd_platform_fixup)(struct atkbd *, const void *data);
 static void *atkbd_platform_fixup_data;
 static unsigned int (*atkbd_platform_scancode_fixup)(struct atkbd *, unsigned int);
 
+static void *atkbd_deactivate_fixup;
+
 static ssize_t atkbd_attr_show_helper(struct device *dev, char *buf,
 				ssize_t (*handler)(struct atkbd *, char *));
 static ssize_t atkbd_attr_set_helper(struct device *dev, const char *buf, size_t count,
@@ -698,11 +700,13 @@ static int atkbd_activate(struct atkbd *atkbd)
  * atkbd_deactivate() resets and disables the keyboard from sending
  * keystrokes.
  */
-
 static void atkbd_deactivate(struct atkbd *atkbd)
 {
 	struct ps2dev *ps2dev = &atkbd->ps2dev;
 
+	if (atkbd_deactivate_fixup)
+		return;
+
 	if (ps2_command(ps2dev, NULL, ATKBD_CMD_RESET_DIS))
 		dev_err(&ps2dev->serio->dev,
 			"Failed to deactivate keyboard on %s\n",
@@ -1638,6 +1642,12 @@ static int __init atkbd_setup_scancode_fixup(const struct dmi_system_id *id)
 	return 1;
 }
 
+static int __init atkbd_setup_deactivate(const struct dmi_system_id *id)
+{
+	atkbd_deactivate_fixup = id->driver_data;
+	return 1;
+}
+
 static const struct dmi_system_id atkbd_dmi_quirk_table[] __initconst = {
 	{
 		.matches = {
@@ -1775,6 +1785,22 @@ static const struct dmi_system_id atkbd_dmi_quirk_table[] __initconst = {
 		.callback = atkbd_setup_scancode_fixup,
 		.driver_data = atkbd_oqo_01plus_scancode_fixup,
 	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LG Electronics"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "LW25-B7HV"),
+		},
+		.callback = atkbd_setup_deactivate,
+		.driver_data = (void*) 1,
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LG Electronics"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "P1-J273B"),
+		},
+		.callback = atkbd_setup_deactivate,
+		.driver_data = (void*) 1,
+	},
 	{ }
 };
 
-- 
1.9.1.423.g4596e3a
