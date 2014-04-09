From: gautam.vivek@samsung.com (Vivek Gautam)
Date: Wed,  9 Apr 2014 09:30:41 +0530
Subject: [PATCH 1/2] usb: ehci-exynos: Return immediately from suspend if
 ehci_suspend fails
Message-ID: <1397016042-4451-1-git-send-email-gautam.vivek@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Patch 'b8efdaf USB: EHCI: add check for wakeup/suspend race'
adds a check for possible race between suspend and wakeup interrupt,
and thereby it returns -EBUSY as error code if there's a wakeup
interrupt.
So the platform host controller should not proceed further with
its suspend callback, rather should return immediately to avoid
powering down the essential things, like phy.

Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Jingoo Han <jg1.han@samsung.com>
---

Based on 'usb-next' branch of Greg's usb tree.

 drivers/usb/host/ehci-exynos.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/ehci-exynos.c b/drivers/usb/host/ehci-exynos.c
index d1d8c47..a4550eb 100644
--- a/drivers/usb/host/ehci-exynos.c
+++ b/drivers/usb/host/ehci-exynos.c
@@ -212,6 +212,8 @@ static int exynos_ehci_suspend(struct device *dev)
 	int rc;
 
 	rc = ehci_suspend(hcd, do_wakeup);
+	if (rc)
+		return rc;
 
 	if (exynos_ehci->otg)
 		exynos_ehci->otg->set_host(exynos_ehci->otg, &hcd->self);
@@ -221,7 +223,7 @@ static int exynos_ehci_suspend(struct device *dev)
 
 	clk_disable_unprepare(exynos_ehci->clk);
 
-	return rc;
+	return 0;
 }
 
 static int exynos_ehci_resume(struct device *dev)
-- 
1.7.10.4
