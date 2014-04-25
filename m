From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 25 Apr 2014 12:43:43 +0100
Subject: [PATCH 144/222] imx-drm: imx-drm-core: skip components whose parent
 device is disabled
In-Reply-To: <20140425112951.GK26756@n2100.arm.linux.org.uk>
References: <20140425112951.GK26756@n2100.arm.linux.org.uk>
Message-ID: <E1WdeXf-0007Mt-2B@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shawn Guo <shawn.guo@freescale.com>
To: linux-arm-kernel at lists.infradead.org

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
Acked-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/staging/imx-drm/imx-drm-core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/staging/imx-drm/imx-drm-core.c b/drivers/staging/imx-drm/imx-drm-core.c
index bc7f8bd227c7..c270c9ae6d27 100644
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
1.8.3.1
