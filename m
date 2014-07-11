From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 11 Jul 2014 14:16:09 +0200
Subject: [PATCH 10/12] ARM: tegra: Always lock the CPU reset vector
In-Reply-To: <1405080971-7609-1-git-send-email-thierry.reding@gmail.com>
References: <1405080971-7609-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <1405080971-7609-11-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

Currently the reset vector is not locked on Tegra20 because the hardware
doesn't support it. However in order not to depend on the chip ID, which
becomes available only later in the boot process, we set the bit anyway.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm/mach-tegra/reset.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-tegra/reset.c b/arch/arm/mach-tegra/reset.c
index e997b2573893..96cafc426cdb 100644
--- a/arch/arm/mach-tegra/reset.c
+++ b/arch/arm/mach-tegra/reset.c
@@ -53,12 +53,10 @@ static void __init tegra_cpu_reset_handler_set(const u32 reset_address)
 	 * Prevent further modifications to the physical reset vector.
 	 *  NOTE: Has no effect on chips prior to Tegra30.
 	 */
-	if (tegra_get_chip_id() != TEGRA20) {
-		reg = readl(sb_ctrl);
-		reg |= 2;
-		writel(reg, sb_ctrl);
-		wmb();
-	}
+	reg = readl(sb_ctrl);
+	reg |= 2;
+	writel(reg, sb_ctrl);
+	wmb();
 }
 
 static void __init tegra_cpu_reset_handler_enable(void)
-- 
2.0.1
