From: swarren@nvidia.com (Stephen Warren)
Date: Tue, 22 Nov 2011 18:21:09 -0700
Subject: [PATCH 01/17] arm/tegra: board-dt: audio: Enable clocks, fix AUXDATA
In-Reply-To: <1322011285-4002-1-git-send-email-swarren@nvidia.com>
References: <1322011285-4002-1-git-send-email-swarren@nvidia.com>
Message-ID: <1322011285-4002-2-git-send-email-swarren@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Certain clocks are required for core audio functionality. Set up the
appropriate parenting relationships, and enable clocks that must be
on permanently.

Fix the address of the I2S2 controller in the AUXDATA table.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/mach-tegra/board-dt.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-tegra/board-dt.c b/arch/arm/mach-tegra/board-dt.c
index efb308e..343469c 100644
--- a/arch/arm/mach-tegra/board-dt.c
+++ b/arch/arm/mach-tegra/board-dt.c
@@ -62,7 +62,7 @@ struct of_dev_auxdata tegra20_auxdata_lookup[] __initdata = {
 	OF_DEV_AUXDATA("nvidia,tegra20-i2c", TEGRA_I2C3_BASE, "tegra-i2c.2", NULL),
 	OF_DEV_AUXDATA("nvidia,tegra20-i2c", TEGRA_DVC_BASE, "tegra-i2c.3", NULL),
 	OF_DEV_AUXDATA("nvidia,tegra20-i2s", TEGRA_I2S1_BASE, "tegra-i2s.0", NULL),
-	OF_DEV_AUXDATA("nvidia,tegra20-i2s", TEGRA_I2S1_BASE, "tegra-i2s.1", NULL),
+	OF_DEV_AUXDATA("nvidia,tegra20-i2s", TEGRA_I2S2_BASE, "tegra-i2s.1", NULL),
 	OF_DEV_AUXDATA("nvidia,tegra20-das", TEGRA_APB_MISC_DAS_BASE, "tegra-das", NULL),
 	OF_DEV_AUXDATA("nvidia,tegra20-ehci", TEGRA_USB_BASE, "tegra-ehci.0",
 		       &tegra_ehci1_device.dev.platform_data),
@@ -79,6 +79,11 @@ static __initdata struct tegra_clk_init_table tegra_dt_clk_init_table[] = {
 	{ "usbd",	"clk_m",	12000000,	false },
 	{ "usb2",	"clk_m",	12000000,	false },
 	{ "usb3",	"clk_m",	12000000,	false },
+	{ "pll_a",      "pll_p_out1",   56448000,       true },
+	{ "pll_a_out0", "pll_a",        11289600,       true },
+	{ "cdev1",      NULL,           0,              true },
+	{ "i2s1",       "pll_a_out0",   11289600,       false},
+	{ "i2s2",       "pll_a_out0",   11289600,       false},
 	{ NULL,		NULL,		0,		0},
 };
 
-- 
1.7.0.4
