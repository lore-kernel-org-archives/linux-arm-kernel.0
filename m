From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 14 Apr 2014 10:02:26 +0800
Subject: [PATCH v2] staging: imx-drm-core: skip components whose parent device
 is disabled
Message-ID: <1397440946-2303-1-git-send-email-shawn.guo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In a board setup which disables LDB device node completely by changing
status to 'disabled', and only enables HDMI device, we're running into
the problem that imx-drm master never succeeds in binding, and hence
HDMI does not come up either.

&ldb {
	status = "disabled";

	lvds-channel at 1 {
		...
		status = "okay";
	};
};

The imx-drm-core should really skip the LVDS channels no matter what
lvds-channel's status is, if LDB device is disabled.  Let's consider
such setup a misconfiguration, give a warning in there and not add the
component.

Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
---
Changes since v1:
* Put a warning on such misconfiguration

 drivers/staging/imx-drm/imx-drm-core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/staging/imx-drm/imx-drm-core.c b/drivers/staging/imx-drm/imx-drm-core.c
index 4144a75..0da8a8a 100644
--- a/drivers/staging/imx-drm/imx-drm-core.c
+++ b/drivers/staging/imx-drm/imx-drm-core.c
@@ -675,6 +675,11 @@ static int imx_drm_platform_probe(struct platform_device *pdev)
 			if (!remote || !of_device_is_available(remote)) {
 				of_node_put(remote);
 				continue;
+			} else if (!of_device_is_available(remote->parent)) {
+				dev_warn(&pdev->dev, "parent device of %s is not available\n",
+					 remote->full_name);
+				of_node_put(remote);
+				continue;
 			}
 
 			ret = imx_drm_add_component(&pdev->dev, remote);
-- 
1.8.3.2
