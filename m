From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 24 Jul 2012 16:50:14 -0600
Subject: [PATCH] ARM: tegra: fix U16 divider range check
Message-ID: <1343170214-28262-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

A U16 divider can divide a clock by 1..64K. However, the range-check
in clk_div16_get_divider() limited the range to 1..256. Fix this. NVIDIA's
downstream kernels already have the fixed range-check.

In practice this is a problem on Whistler's I2C bus, which uses a bus
clock rate of 100KHz (rather than the more common 400KHz on Tegra boards),
which requires a HW module clock of 8*100KHz. The parent clock is 216MHz,
leading to a desired divider of 270. Prior to conversion to the common
clock framework, this range error was somehow ignored/irrelevant and
caused no problems. However, the common clock framework evidently has
more rigorous error-checking, so this failure causes the I2C bus to fail
to operate correctly.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/mach-tegra/tegra2_clocks.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-tegra/tegra2_clocks.c b/arch/arm/mach-tegra/tegra2_clocks.c
index a703844..83ccb85 100644
--- a/arch/arm/mach-tegra/tegra2_clocks.c
+++ b/arch/arm/mach-tegra/tegra2_clocks.c
@@ -223,7 +223,7 @@ static int clk_div16_get_divider(unsigned long parent_rate, unsigned long rate)
 	if (divider_u16 - 1 < 0)
 		return 0;
 
-	if (divider_u16 - 1 > 255)
+	if (divider_u16 - 1 > 0xFFFF)
 		return -EINVAL;
 
 	return divider_u16 - 1;
-- 
1.7.0.4
