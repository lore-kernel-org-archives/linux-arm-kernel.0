From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 25 Nov 2013 11:49:47 -0700
Subject: [PATCH] ARM: tegra: Provide dummy powergate implementation
Message-ID: <1385405387-27265-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <thierry.reding@gmail.com>

In order to support increased build test coverage for drivers, implement
dummies for the powergate implementation. This will allow the drivers to
be built without requiring support for Tegra to be selected.

This patch solves the following build errors, which can be triggered in
v3.13-rc1 by selecting DRM_TEGRA without ARCH_TEGRA:

drivers/built-in.o: In function `gr3d_remove':
drivers/gpu/drm/tegra/gr3d.c:321: undefined reference to `tegra_powergate_power_off'
drivers/gpu/drm/tegra/gr3d.c:325: undefined reference to `tegra_powergate_power_off'
drivers/built-in.o: In function `gr3d_probe':
drivers/gpu/drm/tegra/gr3d.c:266: undefined reference to `tegra_powergate_sequence_power_up'
drivers/gpu/drm/tegra/gr3d.c:273: undefined reference to `tegra_powergate_sequence_power_up'

Signed-off-by: Thierry Reding <treding@nvidia.com>
[swarren, updated commit description]
Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
This is a fix for 3.13.

 include/linux/tegra-powergate.h | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/include/linux/tegra-powergate.h b/include/linux/tegra-powergate.h
index c98cfa406952..fd4498329c7c 100644
--- a/include/linux/tegra-powergate.h
+++ b/include/linux/tegra-powergate.h
@@ -45,6 +45,7 @@ struct clk;
 
 #define TEGRA_POWERGATE_3D0	TEGRA_POWERGATE_3D
 
+#ifdef CONFIG_ARCH_TEGRA
 int tegra_powergate_is_powered(int id);
 int tegra_powergate_power_on(int id);
 int tegra_powergate_power_off(int id);
@@ -52,5 +53,31 @@ int tegra_powergate_remove_clamping(int id);
 
 /* Must be called with clk disabled, and returns with clk enabled */
 int tegra_powergate_sequence_power_up(int id, struct clk *clk);
+#else
+static inline int tegra_powergate_is_powered(int id)
+{
+	return -ENOSYS;
+}
+
+static inline int tegra_powergate_power_on(int id)
+{
+	return -ENOSYS;
+}
+
+static inline int tegra_powergate_power_off(int id)
+{
+	return -ENOSYS;
+}
+
+static inline int tegra_powergate_remove_clamping(int id)
+{
+	return -ENOSYS;
+}
+
+static inline int tegra_powergate_sequence_power_up(int id, struct clk *clk)
+{
+	return -ENOSYS;
+}
+#endif
 
 #endif /* _MACH_TEGRA_POWERGATE_H_ */
-- 
1.8.1.5
