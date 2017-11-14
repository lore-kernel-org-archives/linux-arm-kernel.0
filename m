From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Tue, 14 Nov 2017 09:06:48 +0300
Subject: [PATCH] ARM: OMAP2+: Missing error code in omap_device_build()
Message-ID: <20171114060648.frwveus2pjpx5idw@mwanda>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We need to set the error code if omap_device_alloc() fails.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/arch/arm/mach-omap2/omap_device.c b/arch/arm/mach-omap2/omap_device.c
index 184acd95c216..f0388058b7da 100644
--- a/arch/arm/mach-omap2/omap_device.c
+++ b/arch/arm/mach-omap2/omap_device.c
@@ -514,8 +514,10 @@ struct platform_device __init *omap_device_build(const char *pdev_name,
 		goto odbs_exit1;
 
 	od = omap_device_alloc(pdev, &oh, 1);
-	if (IS_ERR(od))
+	if (IS_ERR(od)) {
+		ret = PTR_ERR(od);
 		goto odbs_exit1;
+	}
 
 	ret = platform_device_add_data(pdev, pdata, pdata_len);
 	if (ret)
