From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Mon, 17 Sep 2012 12:51:39 +0200
Subject: [PATCH 2/7] ARM: samsung: Change __s5p_mipi_phy_control() function
 signature
In-Reply-To: <1347879100-30150-1-git-send-email-s.nawrocki@samsung.com>
References: <1347878888-30001-1-git-send-email-s.nawrocki@samsung.com>
 <1347879100-30150-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <1347879100-30150-2-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace pdev argument __s5p_mipi_phy_control() helper with plain int
so MIPI-CSIS hardware instance index can be passed directly making
the function usable on platforms instantiated from device tree.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/plat-samsung/setup-mipiphy.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/arch/arm/plat-samsung/setup-mipiphy.c b/arch/arm/plat-samsung/setup-mipiphy.c
index 683c466..1474593 100644
--- a/arch/arm/plat-samsung/setup-mipiphy.c
+++ b/arch/arm/plat-samsung/setup-mipiphy.c
@@ -14,24 +14,18 @@
 #include <linux/spinlock.h>
 #include <mach/regs-clock.h>
 
-static int __s5p_mipi_phy_control(struct platform_device *pdev,
-				  bool on, u32 reset)
+static int __s5p_mipi_phy_control(int id, bool on, u32 reset)
 {
 	static DEFINE_SPINLOCK(lock);
 	void __iomem *addr;
 	unsigned long flags;
-	int pid;
 	u32 cfg;
 
-	if (!pdev)
+	id = max(0, id);
+	if (id > 1)
 		return -EINVAL;
 
-	pid = (pdev->id == -1) ? 0 : pdev->id;
-
-	if (pid != 0 && pid != 1)
-		return -EINVAL;
-
-	addr = S5P_MIPI_DPHY_CONTROL(pid);
+	addr = S5P_MIPI_DPHY_CONTROL(id);
 
 	spin_lock_irqsave(&lock, flags);
 
@@ -52,12 +46,12 @@ static int __s5p_mipi_phy_control(struct platform_device *pdev,
 	return 0;
 }
 
-int s5p_csis_phy_enable(struct platform_device *pdev, bool on)
+int s5p_csis_phy_enable(int id, bool on)
 {
-	return __s5p_mipi_phy_control(pdev, on, S5P_MIPI_DPHY_SRESETN);
+	return __s5p_mipi_phy_control(id, on, S5P_MIPI_DPHY_SRESETN);
 }
 
 int s5p_dsim_phy_enable(struct platform_device *pdev, bool on)
 {
-	return __s5p_mipi_phy_control(pdev, on, S5P_MIPI_DPHY_MRESETN);
+	return __s5p_mipi_phy_control(pdev->id, on, S5P_MIPI_DPHY_MRESETN);
 }
-- 
1.7.11.3
