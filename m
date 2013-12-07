From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Sat,  7 Dec 2013 14:08:54 +0100
Subject: [PATCH 3/3] pinctrl: at91: implement at91_pinconf_dbg_show
In-Reply-To: <1386421734-10240-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1386421734-10240-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1386421734-10240-3-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This allows to get the pin configuration by using debugfs. On my system:
 # cat /sys/kernel/debug/pinctrl/pinctrl.3/pinconf-pins

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/pinctrl/pinctrl-at91.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
index b0b78f3468ae..bcfc8a2eebca 100644
--- a/drivers/pinctrl/pinctrl-at91.c
+++ b/drivers/pinctrl/pinctrl-at91.c
@@ -784,10 +784,35 @@ static int at91_pinconf_set(struct pinctrl_dev *pctldev,
 	return 0;
 }
 
+#define DBG_SHOW_FLAG(flag) do {		\
+	if (config & flag) {			\
+		if (num_conf)			\
+			seq_puts(s, "|");	\
+		seq_puts(s, #flag);		\
+		num_conf++;			\
+	}					\
+} while (0)
+
 static void at91_pinconf_dbg_show(struct pinctrl_dev *pctldev,
 				   struct seq_file *s, unsigned pin_id)
 {
+	unsigned long config;
+	int ret, val, num_conf = 0;
+
+	ret = at91_pinconf_get(pctldev, pin_id, &config);
+
+	DBG_SHOW_FLAG(MULTI_DRIVE);
+	DBG_SHOW_FLAG(PULL_UP);
+	DBG_SHOW_FLAG(PULL_DOWN);
+	DBG_SHOW_FLAG(DIS_SCHMIT);
+	DBG_SHOW_FLAG(DEGLITCH);
+	DBG_SHOW_FLAG(DEBOUNCE);
+	if (config & DEBOUNCE) {
+		val = config >> DEBOUNCE_VAL_SHIFT;
+		seq_printf(s, "(%d)", val);
+	}
 
+	return;
 }
 
 static void at91_pinconf_group_dbg_show(struct pinctrl_dev *pctldev,
-- 
1.8.3.2
