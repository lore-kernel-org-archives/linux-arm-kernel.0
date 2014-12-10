From: Ying.Liu@freescale.com (Liu Ying)
Date: Wed, 10 Dec 2014 16:37:17 +0800
Subject: [PATCH RFC 04/15] drm/dsi: Do not add DSI devices for the child nodes
 with input-port property
In-Reply-To: <1418200648-32656-1-git-send-email-Ying.Liu@freescale.com>
References: <1418200648-32656-1-git-send-email-Ying.Liu@freescale.com>
Message-ID: <1418200648-32656-5-git-send-email-Ying.Liu@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The MIPI DSI bus driver would try to add a DSI device for a host's every
child node which contains the reg property.  Unfortunately, the existing
i.MX6Q/SDL MIPI DSI host device tree node's child nodes contain the reg
property, but the child nodes are ports pointing to dedicated CRTCs.
So, this patch phases out the child nodes with input-port property before
adding DSI devices for them and updates the MIPI DSI bus OF binding
documentation.

Signed-off-by: Liu Ying <Ying.Liu@freescale.com>
---
 Documentation/devicetree/bindings/mipi/dsi/mipi-dsi-bus.txt | 4 ++++
 drivers/gpu/drm/drm_mipi_dsi.c                              | 5 +++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mipi/dsi/mipi-dsi-bus.txt b/Documentation/devicetree/bindings/mipi/dsi/mipi-dsi-bus.txt
index 973c272..1a1d3c1 100644
--- a/Documentation/devicetree/bindings/mipi/dsi/mipi-dsi-bus.txt
+++ b/Documentation/devicetree/bindings/mipi/dsi/mipi-dsi-bus.txt
@@ -36,6 +36,10 @@ Peripherals are represented as child nodes of the DSI host's node. Properties
 described here apply to all DSI peripherals, but individual bindings may want
 to define additional, device-specific properties.
 
+Please, do not add the input-port property to the child nodes which represent
+peripherals. Otherwise, the peripherals would be omitted by the MIPI DSI bus
+driver.
+
 Required properties:
 - reg: The virtual channel number of a DSI peripheral. Must be in the range
   from 0 to 3.
diff --git a/drivers/gpu/drm/drm_mipi_dsi.c b/drivers/gpu/drm/drm_mipi_dsi.c
index c0644bb..9adacfe 100644
--- a/drivers/gpu/drm/drm_mipi_dsi.c
+++ b/drivers/gpu/drm/drm_mipi_dsi.c
@@ -176,8 +176,9 @@ int mipi_dsi_host_register(struct mipi_dsi_host *host)
 	struct device_node *node;
 
 	for_each_available_child_of_node(host->dev->of_node, node) {
-		/* skip nodes without reg property */
-		if (!of_find_property(node, "reg", NULL))
+		/* skip nodes without reg property or with input-port property */
+		if (!of_find_property(node, "reg", NULL) ||
+		     of_find_property(node, "input-port", NULL))
 			continue;
 		of_mipi_dsi_device_add(host, node);
 	}
-- 
2.1.0
