From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon, 04 Jan 2016 20:23:37 +0100
Subject: [Regression] No display on i.MX53 after update to 4.4-rc4
In-Reply-To: <5674149C.90206@parkeon.com>
References: <5674149C.90206@parkeon.com>
Message-ID: <1451935417.3884.49.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Martin,

Am Freitag, den 18.12.2015, 15:13 +0100 schrieb Martin Fuzzey:
> Hi Philipp,
> 
> after updating my kernel to include:
> 
>      gpu: ipu-v3: Assign of_node of child platform devices to 
> corresponding ports  [304e6be652e2ef2190adf9c23a2a1e5f9f39800d]
> 
> the display initialisation fails with:
> 
>      "imx-ipuv3 18000000.ipu: missing port at 0 node in /soc/ipu at 18000000"
> 
> Indeed the in tree imx53.dtsi file does not contain that node.
> 
> Does the node need to be added (even if the camera is not being used) or 
> should ipu_add_client_devices() not bail out if one node is missing?

The ports are marked as optional in the binding docs, so the driver
should not bail out if they are not present. How about this patch:

-----8<-----
>From d82649ac3bde511eb5977beb1080f0c6c78e391a Mon Sep 17 00:00:00 2001
From: Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH] gpu: ipu-v3: Do not bail out on missing optional port nodes

The port nodes are documented as optional, treat them accordingly.

Reported-by: Martin Fuzzey <mfuzzey@parkeon.com>
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Fixes: 304e6be652e2 ("gpu: ipu-v3: Assign of_node of child platform devices to corresponding ports")
---
 drivers/gpu/ipu-v3/ipu-common.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/ipu-v3/ipu-common.c b/drivers/gpu/ipu-v3/ipu-common.c
index 8ba367b..2093de2 100644
--- a/drivers/gpu/ipu-v3/ipu-common.c
+++ b/drivers/gpu/ipu-v3/ipu-common.c
@@ -1094,10 +1094,11 @@ static int ipu_add_client_devices(struct ipu_soc *ipu, unsigned long ipu_base)
 		/* Associate subdevice with the corresponding port node */
 		pdev->dev.of_node = of_graph_get_port_by_id(dev->of_node, i);
 		if (i < 4 && !pdev->dev.of_node) {
-			dev_err(dev, "missing port@%d node in %s\n", i,
-				dev->of_node->full_name);
-			ret = -ENODEV;
-			goto err_register;
+			dev_info(dev,
+				 "no port@%d node in %s, not using %s%d\n",
+				 i, dev->of_node->full_name,
+				 (i / 2) ? "DI" : "CSI", i % 2);
+			continue;
 		}
 
 		ret = platform_device_add_data(pdev, &reg->pdata,
----->8-----

regards
Philipp
