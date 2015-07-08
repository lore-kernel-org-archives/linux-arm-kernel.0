From: vladimir_zapolskiy@mentor.com (Vladimir Zapolskiy)
Date: Wed, 8 Jul 2015 15:59:24 +0300
Subject: [PATCH 02/10] drm: dw_hdmi: use of_get_i2c_adapter_by_node interface
In-Reply-To: <1436360095-9065-1-git-send-email-vladimir_zapolskiy@mentor.com>
References: <1436360095-9065-1-git-send-email-vladimir_zapolskiy@mentor.com>
Message-ID: <1436360364-9229-1-git-send-email-vladimir_zapolskiy@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This change is needed to properly lock I2C bus driver, which serves DDC.

The change fixes an overflow over zero of I2C bus driver user counter:

    root at mx6q:~# lsmod | grep i2c
    i2c_imx                10213  0
    root at mx6q:~# lsmod | grep dw_hdmi_imx
    dw_hdmi_imx             3631  0
    dw_hdmi                11846  1 dw_hdmi_imx
    imxdrm                  8674  3 dw_hdmi_imx,imx_ipuv3_crtc,imx_ldb
    drm_kms_helper        113765  5 dw_hdmi,imxdrm,imx_ipuv3_crtc,imx_ldb
    root at mx6q:~# rmmod dw_hdmi_imx
    root at mx6q:~# lsmod | grep i2c
    i2c_imx                10213  -1

                                 ^^^^^

    root at mx6q:~# rmmod i2c_imx
    rmmod: ERROR: Module i2c_imx is in use

Note that prior to this change put_device() coupled with
of_find_i2c_adapter_by_node() was missing on error path of
dw_hdmi_bind(), added i2c_put_adapter() there along with the change.

Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
---
 drivers/gpu/drm/bridge/dw_hdmi.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/bridge/dw_hdmi.c b/drivers/gpu/drm/bridge/dw_hdmi.c
index 816d104..e86776c 100644
--- a/drivers/gpu/drm/bridge/dw_hdmi.c
+++ b/drivers/gpu/drm/bridge/dw_hdmi.c
@@ -1591,7 +1591,7 @@ int dw_hdmi_bind(struct device *dev, struct device *master,
 
 	ddc_node = of_parse_phandle(np, "ddc-i2c-bus", 0);
 	if (ddc_node) {
-		hdmi->ddc = of_find_i2c_adapter_by_node(ddc_node);
+		hdmi->ddc = of_get_i2c_adapter_by_node(ddc_node);
 		of_node_put(ddc_node);
 		if (!hdmi->ddc) {
 			dev_dbg(hdmi->dev, "failed to read ddc node\n");
@@ -1603,20 +1603,22 @@ int dw_hdmi_bind(struct device *dev, struct device *master,
 	}
 
 	hdmi->regs = devm_ioremap_resource(dev, iores);
-	if (IS_ERR(hdmi->regs))
-		return PTR_ERR(hdmi->regs);
+	if (IS_ERR(hdmi->regs)) {
+		ret = PTR_ERR(hdmi->regs);
+		goto err_res;
+	}
 
 	hdmi->isfr_clk = devm_clk_get(hdmi->dev, "isfr");
 	if (IS_ERR(hdmi->isfr_clk)) {
 		ret = PTR_ERR(hdmi->isfr_clk);
 		dev_err(hdmi->dev, "Unable to get HDMI isfr clk: %d\n", ret);
-		return ret;
+		goto err_res;
 	}
 
 	ret = clk_prepare_enable(hdmi->isfr_clk);
 	if (ret) {
 		dev_err(hdmi->dev, "Cannot enable HDMI isfr clock: %d\n", ret);
-		return ret;
+		goto err_res;
 	}
 
 	hdmi->iahb_clk = devm_clk_get(hdmi->dev, "iahb");
@@ -1682,6 +1684,8 @@ err_iahb:
 	clk_disable_unprepare(hdmi->iahb_clk);
 err_isfr:
 	clk_disable_unprepare(hdmi->isfr_clk);
+err_res:
+	i2c_put_adapter(hdmi->ddc);
 
 	return ret;
 }
-- 
2.1.4
