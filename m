From: swarren@nvidia.com (Stephen Warren)
Date: Fri, 16 Dec 2011 15:12:30 -0700
Subject: [PATCH 7/9] arm/tegra: Fix mistake in Trimslice's pinmux
In-Reply-To: <1324073552-15542-1-git-send-email-swarren@nvidia.com>
References: <1324073552-15542-1-git-send-email-swarren@nvidia.com>
Message-ID: <1324073552-15542-8-git-send-email-swarren@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pin group PTA does not support function RSVD3. However, the current
pinmux driver doesn't check this when setting RSVD functions, and ends
up writing 3 to the HW register. 3 is actually represented by function
GMI, so update the pinmux table to request that instead in order to
obtain the same register programming without requesting invalid
configurations.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/mach-tegra/board-trimslice-pinmux.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-tegra/board-trimslice-pinmux.c b/arch/arm/mach-tegra/board-trimslice-pinmux.c
index 7ab719d..5daa6e8 100644
--- a/arch/arm/mach-tegra/board-trimslice-pinmux.c
+++ b/arch/arm/mach-tegra/board-trimslice-pinmux.c
@@ -105,7 +105,7 @@ static __initdata struct tegra_pingroup_config trimslice_pinmux[] = {
 	{TEGRA_PINGROUP_LVS,   TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_UP,     TEGRA_TRI_NORMAL},
 	{TEGRA_PINGROUP_OWC,   TEGRA_MUX_RSVD2,         TEGRA_PUPD_PULL_UP,     TEGRA_TRI_TRISTATE},
 	{TEGRA_PINGROUP_PMC,   TEGRA_MUX_PWR_ON,        TEGRA_PUPD_NORMAL,      TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_PTA,   TEGRA_MUX_RSVD3,         TEGRA_PUPD_NORMAL,      TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_PTA,   TEGRA_MUX_GMI,           TEGRA_PUPD_NORMAL,      TEGRA_TRI_TRISTATE},
 	{TEGRA_PINGROUP_RM,    TEGRA_MUX_I2C,           TEGRA_PUPD_PULL_UP,     TEGRA_TRI_NORMAL},
 	{TEGRA_PINGROUP_SDB,   TEGRA_MUX_PWM,           TEGRA_PUPD_NORMAL,      TEGRA_TRI_NORMAL},
 	{TEGRA_PINGROUP_SDC,   TEGRA_MUX_PWM,           TEGRA_PUPD_PULL_UP,     TEGRA_TRI_NORMAL},
-- 
1.7.0.4
