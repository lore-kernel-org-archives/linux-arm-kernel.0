From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Fri, 18 Jan 2013 15:31:16 +0800
Subject: [PATCH v7 12/15] pinctrl: generic: dump pin configuration
In-Reply-To: <1358494279-16503-1-git-send-email-haojian.zhuang@linaro.org>
References: <1358494279-16503-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <1358494279-16503-13-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the support of dumping pin configuration.

Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
---
 drivers/pinctrl/pinconf-generic.c |   12 ++++++++++++
 drivers/pinctrl/pinconf.h         |    8 ++++++++
 2 files changed, 20 insertions(+)

diff --git a/drivers/pinctrl/pinconf-generic.c b/drivers/pinctrl/pinconf-generic.c
index 678db63..9bb6d47 100644
--- a/drivers/pinctrl/pinconf-generic.c
+++ b/drivers/pinctrl/pinconf-generic.c
@@ -119,4 +119,16 @@ void pinconf_generic_dump_group(struct pinctrl_dev *pctldev,
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
 #endif
diff --git a/drivers/pinctrl/pinconf.h b/drivers/pinctrl/pinconf.h
index e3ed8cb..8023421 100644
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
 
+static void pinconf_generic_dump_config(struct pinctrl_dev *pctldev,
+					struct seq_file *s,
+					unsigned long config)
+{
+	return;
+}
 #endif
-- 
1.7.10.4
