From: zyw@rock-chips.com (zyw at rock-chips.com)
Date: Mon, 20 Oct 2014 20:43:31 -0700
Subject: [PATCH v3 2/6] pinctrl: rockchip: save and restore gpio6_c6 pinmux in
 suspend/resume
In-Reply-To: <1413862894-2623-1-git-send-email-zyw@rock-chips.com>
References: <1413862894-2623-1-git-send-email-zyw@rock-chips.com>
Message-ID: <1413863011-2736-1-git-send-email-zyw@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chris Zhong <zyw@rock-chips.com>

Save and restore the gpio6_c6 pinmux setting, since Maskrom of RK3288
would modify it to sdmmc0_det, so it need to be restored to the correct
setting after resume from Maskrom.

Signed-off-by: Chris Zhong <zyw@rock-chips.com>
---

Changes in v3: None
Changes in v2: None

 drivers/pinctrl/pinctrl-rockchip.c |   30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-rockchip.c b/drivers/pinctrl/pinctrl-rockchip.c
index d384d99..85134e4 100644
--- a/drivers/pinctrl/pinctrl-rockchip.c
+++ b/drivers/pinctrl/pinctrl-rockchip.c
@@ -1796,26 +1796,54 @@ static struct rockchip_pin_ctrl *rockchip_pinctrl_get_soc_data(
 }
 
 #ifdef CONFIG_PM
+
+#define RK3288_GRF_GPIO6C_IOMUX		0x64
+#define GPIO6C6_SEL_WRITE_ENABLE	BIT(28)
+
+static u32 rk3288_grf_gpio6c_iomux;
+
 static int rockchip_pinctrl_suspend(struct platform_device *pdev,
 				    pm_message_t state)
 {
 	struct rockchip_pinctrl *info;
+	int ret;
 
 	info = platform_get_drvdata(pdev);
 	if (!info)
 		return -EINVAL;
 
-	return pinctrl_force_sleep(info->pctl_dev);
+	ret = pinctrl_force_sleep(info->pctl_dev);
+	if (ret)
+		return ret;
+
+	/*
+	 * RK3288 GPIO6_C6 mux would be modified by Maskrom when resume, so save
+	 * the setting here, and restore it at resume.
+	 */
+	if (info->ctrl->type == RK3288) {
+		ret = regmap_read(info->regmap_base, RK3288_GRF_GPIO6C_IOMUX,
+				  &rk3288_grf_gpio6c_iomux);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
 }
 
 static int rockchip_pinctrl_resume(struct platform_device *pdev)
 {
 	struct rockchip_pinctrl *info;
+	int ret;
 
 	info = platform_get_drvdata(pdev);
 	if (!info)
 		return -EINVAL;
 
+	ret = regmap_write(info->regmap_base, RK3288_GRF_GPIO6C_IOMUX,
+			   rk3288_grf_gpio6c_iomux | GPIO6C6_SEL_WRITE_ENABLE);
+	if (ret)
+		return ret;
+
 	return pinctrl_force_default(info->pctl_dev);
 }
 #endif
-- 
1.7.9.5
