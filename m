From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 10 Apr 2014 14:43:13 +0800
Subject: [PATCH] staging: imx-drm-core: skip components whose parent device is
 disabled
Message-ID: <1397112193-15817-1-git-send-email-shawn.guo@freescale.com>
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
lvds-channel's status is, if LDB device is disabled.  So let's give one
more check on parent device availability before add the component.

Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
---
 drivers/staging/imx-drm/imx-drm-core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/imx-drm/imx-drm-core.c b/drivers/staging/imx-drm/imx-drm-core.c
index 4144a75..e494ef9 100644
--- a/drivers/staging/imx-drm/imx-drm-core.c
+++ b/drivers/staging/imx-drm/imx-drm-core.c
@@ -672,7 +672,8 @@ static int imx_drm_platform_probe(struct platform_device *pdev)
 
 		for_each_child_of_node(port, ep) {
 			remote = of_graph_get_remote_port_parent(ep);
-			if (!remote || !of_device_is_available(remote)) {
+			if (!remote || !of_device_is_available(remote) ||
+			    !of_device_is_available(remote->parent)) {
 				of_node_put(remote);
 				continue;
 			}
-- 
1.8.3.2
