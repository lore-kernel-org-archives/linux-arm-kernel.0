From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 15 Aug 2013 21:43:29 +0200
Subject: [PATCH] pinctrl: add includes and ifdefs for non-DT builds
Message-ID: <1376595809-7053-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit e81c8f18afc4fdd6e34d8c83814b8b5134dbb30f
"pinctrl: pinconf-generic: add generic APIs for mapping pinctrl node"
Added function prototypes with implicit dependencies
on other header files causing build warnings like this:

In file included from
arch/arm/mach-ux500/board-mop500-pins.c:12:0:
include/linux/pinctrl/pinconf-generic.h:142:3:
warning: 'struct device_node' declared inside parameter list [enabled
by default]
   unsigned *reserved_maps, unsigned *num_maps);
   ^
include/linux/pinctrl/pinconf-generic.h:142:3:
warning: its scope is only this definition or declaration, which is
probably not what you want [enabled by default]
include/linux/pinctrl/pinconf-generic.h:142:3:
warning: 'struct pinctrl_dev' declared inside parameter list [enabled
by default]
include/linux/pinctrl/pinconf-generic.h:145:3:
warning: 'struct device_node' declared inside parameter list [enabled
by default]
   unsigned *num_maps);
   ^
Let's just add ifdefs for non-DT systems (the actual code is
already ifdefed) and #include <linux/device.h> to get the
most important structs and forward-declare the pinctrl
core structs.

Reported-by: Olof Johansson <olof@lixom.net>
Cc: Laxman Dewangan <ldewangan@nvidia.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 include/linux/pinctrl/pinconf-generic.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/pinctrl/pinconf-generic.h b/include/linux/pinctrl/pinconf-generic.h
index a472b93..83f5179 100644
--- a/include/linux/pinctrl/pinconf-generic.h
+++ b/include/linux/pinctrl/pinconf-generic.h
@@ -137,12 +137,21 @@ static inline unsigned long pinconf_to_config_packed(enum pin_config_param param
 	return PIN_CONF_PACKED(param, argument);
 }
 
+#ifdef CONFIG_OF
+
+#include <linux/device.h>
+struct pinctrl_dev;
+struct pinctrl_map;
+
 int pinconf_generic_dt_subnode_to_map(struct pinctrl_dev *pctldev,
 		struct device_node *np, struct pinctrl_map **map,
 		unsigned *reserved_maps, unsigned *num_maps);
 int pinconf_generic_dt_node_to_map(struct pinctrl_dev *pctldev,
 		struct device_node *np_config, struct pinctrl_map **map,
 		unsigned *num_maps);
+
+#endif
+
 #endif /* CONFIG_GENERIC_PINCONF */
 
 #endif /* __LINUX_PINCTRL_PINCONF_GENERIC_H */
-- 
1.8.1.4
