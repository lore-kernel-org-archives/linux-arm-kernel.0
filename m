From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Tue, 12 Feb 2013 01:10:54 +0800
Subject: [PATCH v8 07/12] pinctrl: generic: dump pin configuration
In-Reply-To: <1360602659-4774-1-git-send-email-haojian.zhuang@linaro.org>
References: <1360602659-4774-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <1360602659-4774-8-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the support of dumping pin configuration.

Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
---
 drivers/pinctrl/pinconf-generic.c |   14 ++++++++++++++
 drivers/pinctrl/pinconf.h         |    8 ++++++++
 2 files changed, 22 insertions(+)

diff --git a/drivers/pinctrl/pinconf-generic.c b/drivers/pinctrl/pinconf-generic.c
index e5948f8..ef24230 100644
--- a/drivers/pinctrl/pinconf-generic.c
+++ b/drivers/pinctrl/pinconf-generic.c
@@ -12,6 +12,7 @@
 #define pr_fmt(fmt) "generic pinconfig core: " fmt
 
 #include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/init.h>
 #include <linux/device.h>
 #include <linux/slab.h>
@@ -120,4 +121,17 @@ void pinconf_generic_dump_group(struct pinctrl_dev *pctldev,
 	}
 }
 
+void pinconf_generic_dump_config(struct pinctrl_dev *pctldev,
+				 struct seq_file *s, unsigned long config)
+{
+	int i;
+
+	for(i = 0; i < ARRAY_SIZE(conf_items); i++) {
+		if (pinconf_to_config_param(config) != conf_items[i].param)
+			continue;
+		seq_printf(s, "%s: 0x%x", conf_items[i].display,
+			   pinconf_to_config_argument(config));
+	}
+}
+EXPORT_SYMBOL_GPL(pinconf_generic_dump_config);
 #endif
diff --git a/drivers/pinctrl/pinconf.h b/drivers/pinctrl/pinconf.h
index e3ed8cb..1f7113e 100644
--- a/drivers/pinctrl/pinconf.h
+++ b/drivers/pinctrl/pinconf.h
@@ -98,6 +98,8 @@ void pinconf_generic_dump_pin(struct pinctrl_dev *pctldev,
 void pinconf_generic_dump_group(struct pinctrl_dev *pctldev,
 			      struct seq_file *s, const char *gname);
 
+void pinconf_generic_dump_config(struct pinctrl_dev *pctldev,
+				 struct seq_file *s, unsigned long config);
 #else
 
 static inline void pinconf_generic_dump_pin(struct pinctrl_dev *pctldev,
@@ -114,4 +116,10 @@ static inline void pinconf_generic_dump_group(struct pinctrl_dev *pctldev,
 	return;
 }
 
+static inline void pinconf_generic_dump_config(struct pinctrl_dev *pctldev,
+					       struct seq_file *s,
+					       unsigned long config)
+{
+	return;
+}
 #endif
-- 
1.7.10.4
