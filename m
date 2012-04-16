From: viresh.kumar@st.com (Viresh Kumar)
Date: Mon, 16 Apr 2012 14:22:34 +0530
Subject: [PATCH] pinctrl: pinconf: Fix compilation error if PINCONF is not
 selected
Message-ID: <a342987ffebf0ab79a789011e17081e0169bdf24.1334566321.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When we compile pinctrl layer for platforms without CONFIG_PINCONF, we get
following compilation errors:

drivers/built-in.o: In function `pinctrl_show':
linux-2.6/drivers/pinctrl/core.c:1116: undefined
reference to `pinconf_show_setting'
drivers/built-in.o: In function `pinctrl_maps_show':
linux-2.6/drivers/pinctrl/core.c:1071: undefined
reference to `pinconf_show_map'
drivers/built-in.o: In function `pinctrl_init_device_debugfs':
linux-2.6/drivers/pinctrl/core.c:1224: undefined
reference to `pinconf_init_device_debugfs'
make[1]: *** [.tmp_vmlinux1] Error 1

This patch fixes this.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 drivers/pinctrl/pinconf.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/pinctrl/pinconf.h b/drivers/pinctrl/pinconf.h
index 32b8354..e3ed8cb 100644
--- a/drivers/pinctrl/pinconf.h
+++ b/drivers/pinctrl/pinconf.h
@@ -58,7 +58,7 @@ static inline int pinconf_apply_setting(struct pinctrl_setting const *setting)
 
 #endif
 
-#if defined(CONFIG_PINMUX) && defined(CONFIG_DEBUG_FS)
+#if defined(CONFIG_PINCONF) && defined(CONFIG_DEBUG_FS)
 
 void pinconf_show_map(struct seq_file *s, struct pinctrl_map const *map);
 void pinconf_show_setting(struct seq_file *s,
-- 
1.7.9
