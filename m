From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 28 Jul 2013 13:13:00 +0100
Subject: [PATCH v2] pinctrl: shut up a couple of pinctrl warnings
In-Reply-To: <20130727103811.GD24642@n2100.arm.linux.org.uk>
References: <20130727103811.GD24642@n2100.arm.linux.org.uk>
Message-ID: <20130728121300.GF24642@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

So, I notice that we get a couple of warnings from the pinctrl code:

drivers/pinctrl/pinconf.c: In function 'pinconf_dbg_config_print':
drivers/pinctrl/pinconf.c:433:36: warning: 'configs' may be used uninitialized in this function
drivers/pinctrl/pinconf.c: In function 'pinconf_dbg_config_write':
drivers/pinctrl/pinconf.c:511:36: warning: 'configs' may be used uninitialized in this function

While the compiler might not be able to work out that "configs" is
safe, the code doesn't lend itself very well to identifying that
fact when reading it either.  This can be trivially solved by a slight
restructuring of the code - which also reduces the LOC.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
So last nights build test found a silly in the last patch, so that's fixed
in this version.

 drivers/pinctrl/pinconf.c |   29 +++++++++++------------------
 1 files changed, 11 insertions(+), 18 deletions(-)

diff --git a/drivers/pinctrl/pinconf.c b/drivers/pinctrl/pinconf.c
index e875f21..d16ef87 100644
--- a/drivers/pinctrl/pinconf.c
+++ b/drivers/pinctrl/pinconf.c
@@ -428,12 +428,11 @@ static int pinconf_dbg_config_print(struct seq_file *s, void *d)
 {
 	struct pinctrl_maps *maps_node;
 	const struct pinctrl_map *map;
-	struct pinctrl_dev *pctldev = NULL;
+	const struct pinctrl_map *found = NULL;
+	struct pinctrl_dev *pctldev;
 	const struct pinconf_ops *confops = NULL;
-	const struct pinctrl_map_configs *configs;
 	struct dbg_cfg *dbg = &pinconf_dbg_conf;
 	int i, j;
-	bool found = false;
 	unsigned long config;
 
 	mutex_lock(&pinctrl_maps_mutex);
@@ -450,14 +449,8 @@ static int pinconf_dbg_config_print(struct seq_file *s, void *d)
 		for (j = 0; j < map->data.configs.num_configs; j++) {
 			if (!strcmp(map->data.configs.group_or_pin,
 					dbg->pin_name)) {
-				/*
-				 * We found the right pin / state, read the
-				 * config and he pctldev for later use
-				 */
-				configs = &map->data.configs;
-				pctldev = get_pinctrl_dev_from_devname
-					(map->ctrl_dev_name);
-				found = true;
+				/* We found the right pin / state */
+				found = map;
 				break;
 			}
 		}
@@ -473,7 +466,8 @@ static int pinconf_dbg_config_print(struct seq_file *s, void *d)
 		goto exit;
 	}
 
-	config = *(configs->configs);
+	pctldev = get_pinctrl_dev_from_devname(found->ctrl_dev_name);
+	config = *found->data.configs.configs;
 	seq_printf(s, "Dev %s has config of %s in state %s: 0x%08lX\n",
 			dbg->dev_name, dbg->pin_name,
 			dbg->state_name, config);
@@ -505,12 +499,12 @@ static int pinconf_dbg_config_write(struct file *file,
 {
 	struct pinctrl_maps *maps_node;
 	const struct pinctrl_map *map;
-	struct pinctrl_dev *pctldev = NULL;
+	const struct pinctrl_map *found = NULL;
+	struct pinctrl_dev *pctldev;
 	const struct pinconf_ops *confops = NULL;
 	struct dbg_cfg *dbg = &pinconf_dbg_conf;
 	const struct pinctrl_map_configs *configs;
 	char config[MAX_NAME_LEN+1];
-	bool found = false;
 	char buf[128];
 	char *b = &buf[0];
 	int buf_size;
@@ -588,10 +582,7 @@ static int pinconf_dbg_config_write(struct file *file,
 
 		/*  we found the right pin / state, so overwrite config */
 		if (!strcmp(map->data.configs.group_or_pin, dbg->pin_name)) {
-			found = true;
-			pctldev = get_pinctrl_dev_from_devname(
-					map->ctrl_dev_name);
-			configs = &map->data.configs;
+			found = map;
 			break;
 		}
 	}
@@ -601,10 +592,12 @@ static int pinconf_dbg_config_write(struct file *file,
 		goto exit;
 	}
 
+	pctldev = get_pinctrl_dev_from_devname(found->ctrl_dev_name);
 	if (pctldev)
 		confops = pctldev->desc->confops;
 
 	if (confops && confops->pin_config_dbg_parse_modify) {
+		configs = &found->data.configs;
 		for (i = 0; i < configs->num_configs; i++) {
 			confops->pin_config_dbg_parse_modify(pctldev,
 						     config,
