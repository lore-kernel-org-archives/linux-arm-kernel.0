From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Thu, 18 Oct 2012 17:07:01 +0800
Subject: [PATCH 07/10] pinctrl: remove mutex lock in groups show
In-Reply-To: <1350551224-12857-1-git-send-email-haojian.zhuang@gmail.com>
References: <1350551224-12857-1-git-send-email-haojian.zhuang@gmail.com>
Message-ID: <1350551224-12857-7-git-send-email-haojian.zhuang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mutex is locked duplicatly by pinconf_groups_show() and
pin_config_group_get(). It results dead lock. So avoid to lock mutex
in pinconf_groups_show().

Signed-off-by: Haojian Zhuang <haojian.zhuang@gmail.com>
---
 drivers/pinctrl/pinconf.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/pinconf.c b/drivers/pinctrl/pinconf.c
index 43f474c..baee2cc 100644
--- a/drivers/pinctrl/pinconf.c
+++ b/drivers/pinctrl/pinconf.c
@@ -537,8 +537,6 @@ static int pinconf_groups_show(struct seq_file *s, void *what)
 	seq_puts(s, "Pin config settings per pin group\n");
 	seq_puts(s, "Format: group (name): configs\n");
 
-	mutex_lock(&pinctrl_mutex);
-
 	while (selector < ngroups) {
 		const char *gname = pctlops->get_group_name(pctldev, selector);
 
@@ -549,8 +547,6 @@ static int pinconf_groups_show(struct seq_file *s, void *what)
 		selector++;
 	}
 
-	mutex_unlock(&pinctrl_mutex);
-
 	return 0;
 }
 
-- 
1.7.0.4
