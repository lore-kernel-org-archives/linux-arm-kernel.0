From: yuvaraj.cd@gmail.com (Yuvaraj Kumar C D)
Date: Wed, 18 Dec 2013 16:09:30 +0530
Subject: [RFC 1/5] usb: ohci-exynos: enable async suspend/resume
Message-ID: <1387363174-25942-1-git-send-email-yuvaraj.cd@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andrew Bresticker <abrestic@chromium.org>

USB host controllers can take a significant amount of time to suspend
and resume, adding several hundred miliseconds to the kernel resume
time. Since the Exynos OHCI controller has no outside dependencies
(other than clocks, which are suspended late/resumed early), allow it to
suspend and resume asynchronously.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
Reviewed-by: Julius Werner <jwerner@chromium.org>
Signed-off-by: Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>
---
 drivers/usb/host/ohci-exynos.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/host/ohci-exynos.c b/drivers/usb/host/ohci-exynos.c
index 68588d8..faad2bdc 100644
--- a/drivers/usb/host/ohci-exynos.c
+++ b/drivers/usb/host/ohci-exynos.c
@@ -137,6 +137,8 @@ skip_phy:
 	if (exynos_ohci->otg)
 		exynos_ohci->otg->set_host(exynos_ohci->otg, &hcd->self);
 
+	device_enable_async_suspend(&pdev->dev);
+
 	platform_set_drvdata(pdev, hcd);
 
 	exynos_ohci_phy_enable(pdev);
-- 
1.7.9.5
