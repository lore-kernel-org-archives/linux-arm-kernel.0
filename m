From: linus.walleij@stericsson.com (Linus Walleij)
Date: Mon, 27 May 2013 15:55:20 +0200
Subject: [PATCH] pinctrl: pinconf: take the right mutex
Message-ID: <1369662920-31339-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

The pinconf_dgb_config_print() takes the per-pincontroller
mutex, when what it wants to take is actually the pin maps
mutex.

Reported-by: James Hogan <james.hogan@imgtec.com>
Cc: Patrice Chotard <patrice.chotard@st.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/pinconf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/pinconf.c b/drivers/pinctrl/pinconf.c
index c67c37e..694c3ac 100644
--- a/drivers/pinctrl/pinconf.c
+++ b/drivers/pinctrl/pinconf.c
@@ -610,7 +610,7 @@ static int pinconf_dbg_config_print(struct seq_file *s, void *d)
 	bool found = false;
 	unsigned long config;
 
-	mutex_lock(&pctldev->mutex);
+	mutex_lock(&pinctrl_maps_mutex);
 
 	/* Parse the pinctrl map and look for the elected pin/state */
 	for_each_maps(maps_node, i, map) {
@@ -659,7 +659,7 @@ static int pinconf_dbg_config_print(struct seq_file *s, void *d)
 		confops->pin_config_config_dbg_show(pctldev, s, config);
 
 exit:
-	mutex_unlock(&pctldev->mutex);
+	mutex_unlock(&pinctrl_maps_mutex);
 
 	return 0;
 }
-- 
1.7.11.3
