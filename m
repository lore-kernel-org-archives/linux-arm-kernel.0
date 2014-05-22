From: emilgoode@gmail.com (Emil Goode)
Date: Thu, 22 May 2014 15:14:42 +0200
Subject: [PATCH] ARM: imx: add missing kfree call in error paths
Message-ID: <1400764482-20147-1-git-send-email-emilgoode@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We forgot to free pdev->dev.dma_mask as it is not freed
by platform_device_put().

Signed-off-by: Emil Goode <emilgoode@gmail.com>
---
 arch/arm/mach-imx/mach-mx31_3ds.c    |    4 +++-
 arch/arm/mach-imx/mach-mx31moboard.c |    4 +++-
 arch/arm/mach-imx/mach-mx35_3ds.c    |    4 +++-
 arch/arm/mach-imx/mach-pcm037.c      |    4 +++-
 4 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-imx/mach-mx31_3ds.c b/arch/arm/mach-imx/mach-mx31_3ds.c
index 453f41a..8de1019 100644
--- a/arch/arm/mach-imx/mach-mx31_3ds.c
+++ b/arch/arm/mach-imx/mach-mx31_3ds.c
@@ -201,9 +201,11 @@ static int __init mx31_3ds_init_camera(void)
 		goto err;
 
 	ret = platform_device_add(pdev);
-	if (ret)
+	if (ret) {
 err:
+		kfree(pdev->dev.dma_mask);
 		platform_device_put(pdev);
+	}
 
 	return ret;
 }
diff --git a/arch/arm/mach-imx/mach-mx31moboard.c b/arch/arm/mach-imx/mach-mx31moboard.c
index 6bed570..f24a93c 100644
--- a/arch/arm/mach-imx/mach-mx31moboard.c
+++ b/arch/arm/mach-imx/mach-mx31moboard.c
@@ -494,9 +494,11 @@ static int __init mx31moboard_init_cam(void)
 		goto err;
 
 	ret = platform_device_add(pdev);
-	if (ret)
+	if (ret) {
 err:
+		kfree(pdev->dev.dma_mask);
 		platform_device_put(pdev);
+	}
 
 	return ret;
 
diff --git a/arch/arm/mach-imx/mach-mx35_3ds.c b/arch/arm/mach-imx/mach-mx35_3ds.c
index 72cd77d..ffdddb3 100644
--- a/arch/arm/mach-imx/mach-mx35_3ds.c
+++ b/arch/arm/mach-imx/mach-mx35_3ds.c
@@ -284,9 +284,11 @@ static int __init imx35_3ds_init_camera(void)
 		goto err;
 
 	ret = platform_device_add(pdev);
-	if (ret)
+	if (ret) {
 err:
+		kfree(pdev->dev.dma_mask);
 		platform_device_put(pdev);
+	}
 
 	return ret;
 }
diff --git a/arch/arm/mach-imx/mach-pcm037.c b/arch/arm/mach-imx/mach-pcm037.c
index 8eb1570..764a111 100644
--- a/arch/arm/mach-imx/mach-pcm037.c
+++ b/arch/arm/mach-imx/mach-pcm037.c
@@ -427,9 +427,11 @@ static int __init pcm037_init_camera(void)
 		goto err;
 
 	ret = platform_device_add(pdev);
-	if (ret)
+	if (ret) {
 err:
+		kfree(pdev->dev.dma_mask);
 		platform_device_put(pdev);
+	}
 
 	return ret;
 }
-- 
1.7.10.4
