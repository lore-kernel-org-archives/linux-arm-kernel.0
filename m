From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed,  6 Mar 2013 17:16:25 -0700
Subject: [PATCH] ARM: tegra: fix ignored return value of regulator_enable
Message-ID: <1362615385-13418-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

This fixes:

arch/arm/mach-tegra/board-harmony-pcie.c: In function ?harmony_pcie_init?:
arch/arm/mach-tegra/board-harmony-pcie.c:65:18: warning: ignoring return
    value of ?regulator_enable?, declared with attribute
    warn_unused_result [-Wunused-result]

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/mach-tegra/board-harmony-pcie.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-tegra/board-harmony-pcie.c b/arch/arm/mach-tegra/board-harmony-pcie.c
index 3cdc1bb..d195db0 100644
--- a/arch/arm/mach-tegra/board-harmony-pcie.c
+++ b/arch/arm/mach-tegra/board-harmony-pcie.c
@@ -62,7 +62,11 @@ int __init harmony_pcie_init(void)
 		goto err_reg;
 	}
 
-	regulator_enable(regulator);
+	err = regulator_enable(regulator);
+	if (err) {
+		pr_err("%s: regulator_enable failed: %d\n", __func__, err);
+		goto err_en;
+	}
 
 	err = tegra_pcie_init(true, true);
 	if (err) {
@@ -74,6 +78,7 @@ int __init harmony_pcie_init(void)
 
 err_pcie:
 	regulator_disable(regulator);
+err_en:
 	regulator_put(regulator);
 err_reg:
 	gpio_free(en_vdd_1v05);
-- 
1.7.10.4
