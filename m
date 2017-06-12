From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Mon, 12 Jun 2017 16:45:14 +0530
Subject: [PATCH] usb: host: ehci-exynos: Handle return value of
 clk_prepare_enable
Message-ID: <3aa745c2cea5b8a91d10f898bc201121001a9a0b.1497265923.git.arvind.yadav.cs@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

clk_prepare_enable() can fail here and we must check its return value.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/usb/host/ehci-exynos.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/ehci-exynos.c b/drivers/usb/host/ehci-exynos.c
index 7a603f6..26b6411 100644
--- a/drivers/usb/host/ehci-exynos.c
+++ b/drivers/usb/host/ehci-exynos.c
@@ -279,7 +279,9 @@ static int exynos_ehci_resume(struct device *dev)
 	struct exynos_ehci_hcd *exynos_ehci = to_exynos_ehci(hcd);
 	int ret;
 
-	clk_prepare_enable(exynos_ehci->clk);
+	ret = clk_prepare_enable(exynos_ehci->clk);
+	if (ret)
+		return ret;
 
 	ret = exynos_ehci_phy_enable(dev);
 	if (ret) {
-- 
1.9.1
