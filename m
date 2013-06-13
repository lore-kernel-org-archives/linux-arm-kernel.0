From: manjunath.goudar@linaro.org (Manjunath Goudar)
Date: Thu, 13 Jun 2013 14:40:56 +0530
Subject: [PATCH 05/10] USB: OHCI: Properly handle ohci-exynos suspend
In-Reply-To: <1371114661-2207-1-git-send-email-manjunath.goudar@linaro.org>
References: <1371050918-29472-1-git-send-email-manjunath.goudar@linaro.org>
 <1371114661-2207-1-git-send-email-manjunath.goudar@linaro.org>
Message-ID: <1371114661-2207-6-git-send-email-manjunath.goudar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Suspend scenario in case of ohci-exynos glue was not
properly handled as it was not suspending generic part
of ohci controller.Calling explicitly the ohci_suspend()
routine in exynos_ohci_suspend() will ensure proper
handling of suspend scenario.

V2:
 -Incase ohci_suspend() fails, return right away without
  executing further.

Signed-off-by: Manjunath Goudar <manjunath.goudar@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg KH <greg@kroah.com>
Cc: linux-usb at vger.kernel.org
---
 drivers/usb/host/ohci-exynos.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/usb/host/ohci-exynos.c b/drivers/usb/host/ohci-exynos.c
index 6ff830c..8fecb6a 100644
--- a/drivers/usb/host/ohci-exynos.c
+++ b/drivers/usb/host/ohci-exynos.c
@@ -203,9 +203,17 @@ static int exynos_ohci_suspend(struct device *dev)
 	struct exynos_ohci_hcd *exynos_ohci = to_exynos_ohci(hcd);
 	struct ohci_hcd *ohci = hcd_to_ohci(hcd);
 	struct platform_device *pdev = to_platform_device(dev);
+	bool do_wakeup = device_may_wakeup(dev);
 	unsigned long flags;
 	int rc = 0;
 
+	rc = ohci_suspend(hcd, do_wakeup);
+	if (rc == 0 && do_wakeup && HCD_WAKEUP_PENDING(hcd)) {
+		ohci_resume(hcd, false);
+		rc = -EBUSY;
+	}
+	if (rc)
+		return rc;
 	/*
 	 * Root hub was already suspended. Disable irq emission and
 	 * mark HW unaccessible, bail out if RH has been resumed. Use
-- 
1.7.9.5
