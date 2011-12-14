From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Wed, 14 Dec 2011 17:03:19 +0200
Subject: [PATCH v7 07/14] arm/tegra: use PMC reset
In-Reply-To: <1323875032-18221-1-git-send-email-pdeschrijver@nvidia.com>
References: <1323875032-18221-1-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <1323875032-18221-8-git-send-email-pdeschrijver@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use PMC reset rather then CAR system reset as recommended by the hardware
team.

Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
---
 arch/arm/mach-tegra/common.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-tegra/common.c b/arch/arm/mach-tegra/common.c
index d779e71..8da1847 100644
--- a/arch/arm/mach-tegra/common.c
+++ b/arch/arm/mach-tegra/common.c
@@ -46,12 +46,11 @@ void __init tegra_dt_init_irq(void)
 
 void tegra_assert_system_reset(char mode, const char *cmd)
 {
-	void __iomem *reset = IO_ADDRESS(TEGRA_CLK_RESET_BASE + 0x04);
+	void __iomem *reset = IO_ADDRESS(TEGRA_PMC_BASE + 0);
 	u32 reg;
 
-	/* use *_related to avoid spinlock since caches are off */
 	reg = readl_relaxed(reset);
-	reg |= 0x04;
+	reg |= 0x10;
 	writel_relaxed(reg, reset);
 }
 
-- 
1.7.7.rc0.72.g4b5ea.dirty
