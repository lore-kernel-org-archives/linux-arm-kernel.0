From: lee.jones@linaro.org (Lee Jones)
Date: Fri,  3 May 2013 15:32:48 +0100
Subject: [PATCH 62/63] dmaengine: ste_dma40: Fetch the number of physical
 channels from DT
In-Reply-To: <1367591569-32197-1-git-send-email-lee.jones@linaro.org>
References: <1367591569-32197-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1367591569-32197-63-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some platforms insist on obscure physical channel availability. This
information is currently passed though platform data in internal BSP
kernels. Once those platforms land, they'll need to configure them
appropriately, so we may as well add the infrastructure.

Cc: Vinod Koul <vinod.koul@intel.com>
Cc: Dan Williams <djbw@fb.com>
Cc: Per Forlin <per.forlin@stericsson.com>
Cc: Rabin Vincent <rabin@rab.in>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/dma/ste_dma40.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index bd5b156..ee96acb 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -3468,7 +3468,7 @@ static int __init d40_of_probe(struct platform_device *pdev,
 			       struct device_node *np)
 {
 	struct stedma40_platform_data *pdata;
-	int num_memcpy = 0;
+	int num_phy = 0, num_memcpy = 0;
 	const const __be32 *list;
 
 	pdata = devm_kzalloc(&pdev->dev,
@@ -3477,6 +3477,11 @@ static int __init d40_of_probe(struct platform_device *pdev,
 	if (!pdata)
 		return -ENOMEM;
 
+	/* If absent this value will be obtained from h/w. */
+	of_property_read_u32(np, "dma-channels", &num_phy);
+	if (num_phy > 0)
+		pdata->num_of_phy_chans = num_phy;
+
 	list = of_get_property(np, "memcpy-channels", &num_memcpy);
 	num_memcpy /= sizeof(*list);
 
-- 
1.7.10.4
