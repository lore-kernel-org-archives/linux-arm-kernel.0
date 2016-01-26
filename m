From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 26 Jan 2016 22:49:12 +0100
Subject: [PATCH] pinctrl: mvebu: fix num_settings in mpp group assignment
In-Reply-To: <20160126182251.GF15550@darkstar.musicnaut.iki.fi>
References: <20160126182251.GF15550@darkstar.musicnaut.iki.fi>
Message-ID: <1453844952-28292-1-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When assigning mpp settings from static mpp modes to mpp groups,
we do not want any groups that have no setting for a specific Kirkwood
variant. However, when there is at least a single setting, we need to
assign the number of all settings in this mode to grp->num_settings
as we are reusing the static modes table.

Fixes: 0581b16b1840 ("pinctrl: mvebu: complain about missing group after checking variant")
Reported-by: Aaro Koskinen <aaro.koskinen@iki.fi>
Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Aaro,

thanks for reporting the issue. It really looks like we should rework
the mpp mode/setting/group assignment one day. Please apply this fix
and report back with a Tested-by if it works.

Sebastian
---
 drivers/pinctrl/mvebu/pinctrl-mvebu.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/pinctrl/mvebu/pinctrl-mvebu.c b/drivers/pinctrl/mvebu/pinctrl-mvebu.c
index e4d473811bb3..4a3c7fe533b5 100644
--- a/drivers/pinctrl/mvebu/pinctrl-mvebu.c
+++ b/drivers/pinctrl/mvebu/pinctrl-mvebu.c
@@ -663,11 +663,11 @@ int mvebu_pinctrl_probe(struct platform_device *pdev)
 	/* assign mpp modes to groups */
 	for (n = 0; n < soc->nmodes; n++) {
 		struct mvebu_mpp_mode *mode = &soc->modes[n];
-		struct mvebu_mpp_ctrl_setting *set = &mode->settings[0];
+		struct mvebu_mpp_ctrl_setting *set;
 		struct mvebu_pinctrl_group *grp;
 		unsigned num_settings;
 
-		for (num_settings = 0; ; set++) {
+		for (num_settings = 0, set = &mode->settings[0]; ; set++) {
 			if (!set->name)
 				break;
 
@@ -676,6 +676,21 @@ int mvebu_pinctrl_probe(struct platform_device *pdev)
 				continue;
 
 			num_settings++;
+		}
+
+		/* skip modes with no settings for this variant */
+		if (!num_settings)
+			continue;
+
+		for (num_settings = 0, set = &mode->settings[0]; ; set++) {
+			if (!set->name)
+				break;
+
+			num_settings++;
+
+			/* skip unsupported settings for this variant */
+			if (pctl->variant && !(pctl->variant & set->variant))
+				continue;
 
 			/* find gpio/gpo/gpi settings */
 			if (strcmp(set->name, "gpio") == 0)
@@ -687,10 +702,6 @@ int mvebu_pinctrl_probe(struct platform_device *pdev)
 				set->flags = MVEBU_SETTING_GPI;
 		}
 
-		/* skip modes with no settings for this variant */
-		if (!num_settings)
-			continue;
-
 		grp = mvebu_pinctrl_find_group_by_pid(pctl, mode->pid);
 		if (!grp) {
 			dev_warn(&pdev->dev, "unknown pinctrl group %d\n",
-- 
2.1.4
