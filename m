From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 13 Apr 2012 16:42:03 -0600
Subject: [PATCH 2/5] ARM: tegra: reparent sclk to pll_c_out1
In-Reply-To: <1334356926-4275-1-git-send-email-swarren@wwwdotorg.org>
References: <1334356926-4275-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1334356926-4275-2-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

pll_p_out4 needs to be used for other purposes. Reparent sclk so that
it runs from pll_c. Change sclk's rate to 120MHz from 108MHz since this
is the lowest precise rate that can be achieved by dividing the pll_c
rate without reducing the sclk rate. (600/5=120, 600/5.5=109.0909...,
600/6=100).

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/mach-tegra/common.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-tegra/common.c b/arch/arm/mach-tegra/common.c
index 22df10f..e969004 100644
--- a/arch/arm/mach-tegra/common.c
+++ b/arch/arm/mach-tegra/common.c
@@ -83,8 +83,10 @@ static __initdata struct tegra_clk_init_table tegra20_clk_init_table[] = {
 	{ "pll_p_out2",	"pll_p",	48000000,	true },
 	{ "pll_p_out3",	"pll_p",	72000000,	true },
 	{ "pll_p_out4",	"pll_p",	108000000,	true },
-	{ "sclk",	"pll_p_out4",	108000000,	true },
-	{ "hclk",	"sclk",		108000000,	true },
+	{ "pll_c",	"clk_m",	600000000,	true },
+	{ "pll_c_out1",	"pll_c",	120000000,	true },
+	{ "sclk",	"pll_c_out1",	120000000,	true },
+	{ "hclk",	"sclk",		120000000,	true },
 	{ "pclk",	"hclk",		54000000,	true },
 	{ "csite",	NULL,		0,		true },
 	{ "emc",	NULL,		0,		true },
-- 
1.7.0.4
