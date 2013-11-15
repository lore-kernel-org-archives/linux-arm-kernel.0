From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 15 Nov 2013 13:54:04 -0700
Subject: [PATCH 09/31] drm/tegra: use reset framework
In-Reply-To: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>
References: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1384548866-13141-10-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Tegra's clock driver now provides an implementation of the common
reset API (include/linux/reset.h). Use this instead of the old Tegra-
specific API; that will soon be removed.

Cc: treding at nvidia.com
Cc: pdeschrijver at nvidia.com
Cc: linux-tegra at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: Terje Bergstr?m <tbergstrom@nvidia.com>
Cc: David Airlie <airlied@linux.ie>
Cc: dri-devel at lists.freedesktop.org
Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
This patch is part of a series with strong internal depdendencies. I'm
looking for an ack so that I can take the entire series through the Tegra
and arm-soc trees. The series will be part of a stable branch that can be
merged into other subsystems if needed to avoid/resolve dependencies.
---
 drivers/gpu/drm/tegra/Kconfig |  1 +
 drivers/gpu/drm/tegra/dc.c    |  9 ++++++++-
 drivers/gpu/drm/tegra/drm.h   |  3 +++
 drivers/gpu/drm/tegra/gr3d.c  | 16 ++++++++++++++++
 drivers/gpu/drm/tegra/hdmi.c  | 14 +++++++++++---
 5 files changed, 39 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/tegra/Kconfig b/drivers/gpu/drm/tegra/Kconfig
index 8961ba6a34b8..8db9b3bce001 100644
--- a/drivers/gpu/drm/tegra/Kconfig
+++ b/drivers/gpu/drm/tegra/Kconfig
@@ -2,6 +2,7 @@ config DRM_TEGRA
 	bool "NVIDIA Tegra DRM"
 	depends on ARCH_TEGRA || ARCH_MULTIPLATFORM
 	depends on DRM
+	depends on RESET_CONTROLLER
 	select TEGRA_HOST1X
 	select DRM_KMS_HELPER
 	select DRM_KMS_FB_HELPER
diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
index ae1cb31ead7e..c3be92879bea 100644
--- a/drivers/gpu/drm/tegra/dc.c
+++ b/drivers/gpu/drm/tegra/dc.c
@@ -10,6 +10,7 @@
 #include <linux/clk.h>
 #include <linux/clk/tegra.h>
 #include <linux/debugfs.h>
+#include <linux/reset.h>
 
 #include "dc.h"
 #include "drm.h"
@@ -712,7 +713,7 @@ static void tegra_crtc_prepare(struct drm_crtc *crtc)
 	unsigned long value;
 
 	/* hardware initialization */
-	tegra_periph_reset_deassert(dc->clk);
+	reset_control_deassert(dc->rst);
 	usleep_range(10000, 20000);
 
 	if (dc->pipe)
@@ -1187,6 +1188,12 @@ static int tegra_dc_probe(struct platform_device *pdev)
 		return PTR_ERR(dc->clk);
 	}
 
+	dc->rst = devm_reset_control_get(&pdev->dev, "dc");
+	if (IS_ERR(dc->rst)) {
+		dev_err(&pdev->dev, "failed to get reset\n");
+		return PTR_ERR(dc->rst);
+	}
+
 	err = clk_prepare_enable(dc->clk);
 	if (err < 0)
 		return err;
diff --git a/drivers/gpu/drm/tegra/drm.h b/drivers/gpu/drm/tegra/drm.h
index fdfe259ed7f8..f717c18b28c2 100644
--- a/drivers/gpu/drm/tegra/drm.h
+++ b/drivers/gpu/drm/tegra/drm.h
@@ -19,6 +19,8 @@
 #include <drm/drm_fb_helper.h>
 #include <drm/drm_fixed.h>
 
+struct reset_control;
+
 struct tegra_fb {
 	struct drm_framebuffer base;
 	struct tegra_bo **planes;
@@ -93,6 +95,7 @@ struct tegra_dc {
 	int pipe;
 
 	struct clk *clk;
+	struct reset_control *rst;
 	void __iomem *regs;
 	int irq;
 
diff --git a/drivers/gpu/drm/tegra/gr3d.c b/drivers/gpu/drm/tegra/gr3d.c
index 4cec8f526af7..f629e38b00e4 100644
--- a/drivers/gpu/drm/tegra/gr3d.c
+++ b/drivers/gpu/drm/tegra/gr3d.c
@@ -11,6 +11,7 @@
 #include <linux/host1x.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/reset.h>
 #include <linux/tegra-powergate.h>
 
 #include "drm.h"
@@ -22,6 +23,8 @@ struct gr3d {
 	struct host1x_channel *channel;
 	struct clk *clk_secondary;
 	struct clk *clk;
+	struct reset_control *rst_secondary;
+	struct reset_control *rst;
 
 	DECLARE_BITMAP(addr_regs, GR3D_NUM_REGS);
 };
@@ -255,12 +258,25 @@ static int gr3d_probe(struct platform_device *pdev)
 		return PTR_ERR(gr3d->clk);
 	}
 
+	gr3d->rst = devm_reset_control_get(&pdev->dev, "3d");
+	if (IS_ERR(gr3d->rst)) {
+		dev_err(&pdev->dev, "cannot get reset\n");
+		return PTR_ERR(gr3d->rst);
+	}
+
 	if (of_device_is_compatible(np, "nvidia,tegra30-gr3d")) {
 		gr3d->clk_secondary = devm_clk_get(&pdev->dev, "3d2");
 		if (IS_ERR(gr3d->clk)) {
 			dev_err(&pdev->dev, "cannot get secondary clock\n");
 			return PTR_ERR(gr3d->clk);
 		}
+
+		gr3d->rst_secondary = devm_reset_control_get(&pdev->dev,
+								"3d2");
+		if (IS_ERR(gr3d->rst_secondary)) {
+			dev_err(&pdev->dev, "cannot get secondary reset\n");
+			return PTR_ERR(gr3d->rst_secondary);
+		}
 	}
 
 	err = tegra_powergate_sequence_power_up(TEGRA_POWERGATE_3D, gr3d->clk);
diff --git a/drivers/gpu/drm/tegra/hdmi.c b/drivers/gpu/drm/tegra/hdmi.c
index 0cd9bc2056e8..f3aad49633d6 100644
--- a/drivers/gpu/drm/tegra/hdmi.c
+++ b/drivers/gpu/drm/tegra/hdmi.c
@@ -12,6 +12,7 @@
 #include <linux/debugfs.h>
 #include <linux/hdmi.h>
 #include <linux/regulator/consumer.h>
+#include <linux/reset.h>
 
 #include "hdmi.h"
 #include "drm.h"
@@ -49,6 +50,7 @@ struct tegra_hdmi {
 
 	struct clk *clk_parent;
 	struct clk *clk;
+	struct reset_control *rst;
 
 	const struct tegra_hdmi_config *config;
 
@@ -731,9 +733,9 @@ static int tegra_output_hdmi_enable(struct tegra_output *output)
 		return err;
 	}
 
-	tegra_periph_reset_assert(hdmi->clk);
+	reset_control_assert(hdmi->rst);
 	usleep_range(1000, 2000);
-	tegra_periph_reset_deassert(hdmi->clk);
+	reset_control_deassert(hdmi->rst);
 
 	tegra_dc_writel(dc, VSYNC_H_POSITION(1),
 			DC_DISP_DISP_TIMING_OPTIONS);
@@ -912,7 +914,7 @@ static int tegra_output_hdmi_disable(struct tegra_output *output)
 {
 	struct tegra_hdmi *hdmi = to_hdmi(output);
 
-	tegra_periph_reset_assert(hdmi->clk);
+	reset_control_assert(hdmi->rst);
 	clk_disable(hdmi->clk);
 	regulator_disable(hdmi->pll);
 
@@ -1338,6 +1340,12 @@ static int tegra_hdmi_probe(struct platform_device *pdev)
 		return PTR_ERR(hdmi->clk);
 	}
 
+	hdmi->rst = devm_reset_control_get(&pdev->dev, "hdmi");
+	if (IS_ERR(hdmi->rst)) {
+		dev_err(&pdev->dev, "failed to get reset\n");
+		return PTR_ERR(hdmi->rst);
+	}
+
 	err = clk_prepare(hdmi->clk);
 	if (err < 0)
 		return err;
-- 
1.8.1.5
