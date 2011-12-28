From: olof@lixom.net (Olof Johansson)
Date: Tue, 27 Dec 2011 22:19:30 -0800
Subject: [PATCH v2 2/2] Input: tegra-kbc - add default chromeos map
In-Reply-To: <1325053170-6984-1-git-send-email-olof@lixom.net>
References: <1325053170-6984-1-git-send-email-olof@lixom.net>
Message-ID: <1325053170-6984-3-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds a simple way to specify the ChromeOS-specific keyboard map
instead of the "standard" map that is used on other Tegra devices such
as Harmony-with-keyboard and Seaboard.

I expect the number of different keyboard layouts to be quite limited,
and not many should be added over time. So instead of encoding the layout
in the device tree, with all the can of worms that entails w.r.t. agreeing
on a suitable binding, just add a property to specify that this is the
map to be used, and include it in the driver.

If, over time, the number of mappings increase, the binding can be
updated to include a custom map as a new property, without having to
worry about backwards compatibility on existing devices.

Signed-off-by: Olof Johansson <olof@lixom.net>
---
 .../devicetree/bindings/input/tegra-kbc.txt        |    3 +
 drivers/input/keyboard/tegra-kbc.c                 |  103 ++++++++++++++++++++
 2 files changed, 106 insertions(+), 0 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/tegra-kbc.txt b/Documentation/devicetree/bindings/input/tegra-kbc.txt
index a7c1d40..c9ad6ea 100644
--- a/Documentation/devicetree/bindings/input/tegra-kbc.txt
+++ b/Documentation/devicetree/bindings/input/tegra-kbc.txt
@@ -8,6 +8,8 @@ Optional properties:
 - repeat-delay: delay in milliseconds before repeat starts
 - ghost-filter : enable ghost filtering for this device
 - wakeup-source : configure keyboard as a wakeup source for suspend/resume
+- chromeos-layout : use the standard ChromeOS layout instead of default PC-style
+  		    keyboard if this property is present.
 
 Example:
 
@@ -15,4 +17,5 @@ keyboard: keyboard {
 	compatible = "nvidia,tegra20-kbc";
 	reg = <0x7000e200 0x100>;
 	ghost-filter;
+	chromeos-layout;
 };
diff --git a/drivers/input/keyboard/tegra-kbc.c b/drivers/input/keyboard/tegra-kbc.c
index 4ce6cc8..0f0c5de 100644
--- a/drivers/input/keyboard/tegra-kbc.c
+++ b/drivers/input/keyboard/tegra-kbc.c
@@ -223,6 +223,106 @@ static const struct matrix_keymap_data default_keymap_data __devinitdata = {
 	.keymap_size	= ARRAY_SIZE(default_keymap),
 };
 
+static const u32 cros_kbd_keymap[] __devinitdata = {
+	KEY(0, 2, KEY_LEFTCTRL),
+	KEY(0, 4, KEY_RIGHTCTRL),
+
+	KEY(1, 0, KEY_LEFTMETA),
+	KEY(1, 1, KEY_ESC),
+	KEY(1, 2, KEY_TAB),
+	KEY(1, 3, KEY_GRAVE),
+	KEY(1, 4, KEY_A),
+	KEY(1, 5, KEY_Z),
+	KEY(1, 6, KEY_1),
+	KEY(1, 7, KEY_Q),
+
+	KEY(2, 0, KEY_F1),
+	KEY(2, 1, KEY_F4),
+	KEY(2, 2, KEY_F3),
+	KEY(2, 3, KEY_F2),
+	KEY(2, 4, KEY_D),
+	KEY(2, 5, KEY_C),
+	KEY(2, 6, KEY_3),
+	KEY(2, 7, KEY_E),
+
+	KEY(4, 0, KEY_B),
+	KEY(4, 1, KEY_G),
+	KEY(4, 2, KEY_T),
+	KEY(4, 3, KEY_5),
+	KEY(4, 4, KEY_F),
+	KEY(4, 5, KEY_V),
+	KEY(4, 6, KEY_4),
+	KEY(4, 7, KEY_R),
+
+	KEY(5, 0, KEY_F10),
+	KEY(5, 1, KEY_F7),
+	KEY(5, 2, KEY_F6),
+	KEY(5, 3, KEY_F5),
+	KEY(5, 4, KEY_S),
+	KEY(5, 5, KEY_X),
+	KEY(5, 6, KEY_2),
+	KEY(5, 7, KEY_W),
+
+	KEY(6, 0, KEY_RO),
+	KEY(6, 2, KEY_RIGHTBRACE),
+	KEY(6, 4, KEY_K),
+	KEY(6, 5, KEY_COMMA),
+	KEY(6, 6, KEY_8),
+	KEY(6, 7, KEY_I),
+
+	KEY(8, 0, KEY_N),
+	KEY(8, 1, KEY_H),
+	KEY(8, 2, KEY_Y),
+	KEY(8, 3, KEY_6),
+	KEY(8, 4, KEY_J),
+	KEY(8, 5, KEY_M),
+	KEY(8, 6, KEY_7),
+	KEY(8, 7, KEY_U),
+
+	KEY(9, 2, KEY_102ND),
+	KEY(9, 5, KEY_LEFTSHIFT),
+	KEY(9, 7, KEY_RIGHTSHIFT),
+
+	KEY(10, 0, KEY_EQUAL),
+	KEY(10, 1, KEY_APOSTROPHE),
+	KEY(10, 2, KEY_LEFTBRACE),
+	KEY(10, 3, KEY_MINUS),
+	KEY(10, 4, KEY_SEMICOLON),
+	KEY(10, 5, KEY_SLASH),
+	KEY(10, 6, KEY_0),
+	KEY(10, 7, KEY_P),
+
+	KEY(11, 1, KEY_F9),
+	KEY(11, 2, KEY_F8),
+	KEY(11, 4, KEY_L),
+	KEY(11, 5, KEY_DOT),
+	KEY(11, 6, KEY_9),
+	KEY(11, 7, KEY_O),
+
+	KEY(13, 0, KEY_RIGHTALT),
+	KEY(13, 2, KEY_YEN),
+	KEY(13, 4, KEY_BACKSLASH),
+
+	KEY(13, 6, KEY_LEFTALT),
+
+	KEY(14, 1, KEY_BACKSPACE),
+	KEY(14, 3, KEY_BACKSLASH),
+	KEY(14, 4, KEY_ENTER),
+	KEY(14, 5, KEY_SPACE),
+	KEY(14, 6, KEY_DOWN),
+	KEY(14, 7, KEY_UP),
+
+	KEY(15, 1, KEY_MUHENKAN),
+	KEY(15, 3, KEY_HENKAN),
+	KEY(15, 6, KEY_RIGHT),
+	KEY(15, 7, KEY_LEFT),
+};
+
+static const struct matrix_keymap_data cros_keymap_data __devinitdata = {
+	.keymap		= cros_kbd_keymap,
+	.keymap_size	= ARRAY_SIZE(cros_kbd_keymap),
+};
+
 static void tegra_kbc_report_released_keys(struct input_dev *input,
 					   unsigned short old_keycodes[],
 					   unsigned int old_num_keys,
@@ -603,6 +703,9 @@ static struct tegra_kbc_platform_data * __devinit tegra_kbc_dt_parse_pdata(
 	if (of_find_property(np, "wakeup-source", NULL))
 		pdata->wakeup = true;
 
+	if (of_find_property(np, "chromeos-layout", NULL))
+		pdata->keymap_data = &cros_keymap_data;
+
 	/* All currently known keymaps with device tree support use the same
 	 * pin_cfg, so set it up here.
 	 */
-- 
1.7.8.GIT
