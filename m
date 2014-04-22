From: ssl@chromium.org (Sheng-Liang Song)
Date: Tue, 22 Apr 2014 09:59:30 -0700
Subject: [PATCH] Input: atkbd - fix keyboard LG Electronics
Message-ID: <1398185970-16331-1-git-send-email-ssl@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After issuing ATKBD_CMD_RESET_DIS, LG Keyboard stop working.
The workaround is to issue ATKBD_CMD_RESET_DEF after ATKBD_CMD_RESET_DIS.

In order to keep the minimum changes to the current atkbd driver,
I add logic to apply the patch if and only if the device is LG LW25-B7HV or P1-J273B.
---
 drivers/input/keyboard/atkbd.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
index 2626773..75e68f2 100644
--- a/drivers/input/keyboard/atkbd.c
+++ b/drivers/input/keyboard/atkbd.c
@@ -242,6 +242,7 @@ struct atkbd {
 static void (*atkbd_platform_fixup)(struct atkbd *, const void *data);
 static void *atkbd_platform_fixup_data;
 static unsigned int (*atkbd_platform_scancode_fixup)(struct atkbd *, unsigned int);
+static void (*atkbd_deactivate_fixup)(struct atkbd *atkbd);
 
 static ssize_t atkbd_attr_show_helper(struct device *dev, char *buf,
 				ssize_t (*handler)(struct atkbd *, char *));
@@ -698,6 +699,10 @@ static int atkbd_activate(struct atkbd *atkbd)
  * atkbd_deactivate() resets and disables the keyboard from sending
  * keystrokes.
  */
+static void atkbd_deactivate_rst_fixup(struct atkbd *atkbd)
+{
+	ps2_command(&atkbd->ps2dev, NULL, ATKBD_CMD_RESET_DEF);
+}
 
 static void atkbd_deactivate(struct atkbd *atkbd)
 {
@@ -707,6 +712,9 @@ static void atkbd_deactivate(struct atkbd *atkbd)
 		dev_err(&ps2dev->serio->dev,
 			"Failed to deactivate keyboard on %s\n",
 			ps2dev->serio->phys);
+
+	if (atkbd_deactivate_fixup)
+		atkbd_deactivate_fixup(atkbd);
 }
 
 /*
@@ -1638,6 +1646,12 @@ static int __init atkbd_setup_scancode_fixup(const struct dmi_system_id *id)
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
@@ -1775,6 +1789,22 @@ static const struct dmi_system_id atkbd_dmi_quirk_table[] __initconst = {
 		.callback = atkbd_setup_scancode_fixup,
 		.driver_data = atkbd_oqo_01plus_scancode_fixup,
 	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LG Electronics"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "LW25-B7HV"),
+		},
+		.callback = atkbd_setup_deactivate,
+		.driver_data = atkbd_deactivate_rst_fixup,
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LG Electronics"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "P1-J273B"),
+		},
+		.callback = atkbd_setup_deactivate,
+		.driver_data = atkbd_deactivate_rst_fixup,
+	},
 	{ }
 };
 
-- 
1.9.1.423.g4596e3a
