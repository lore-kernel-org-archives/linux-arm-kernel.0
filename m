From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 31 May 2017 15:41:47 +0200
Subject: [PATCH v2 03/11] clk: mvebu: cp110: make failure labels more
 meaningful
In-Reply-To: <cover.d3a417499f4e5f039deaa27832bf6eccdd090a6f.1496237893.git-series.gregory.clement@free-electrons.com>
References: <cover.d3a417499f4e5f039deaa27832bf6eccdd090a6f.1496237893.git-series.gregory.clement@free-electrons.com>
Message-ID: <a74d055e9c5e20cd563d6d13da4b3733411dceeb.1496237893.git-series.gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In preparation to the addition of a new clock, rename the goto labels
used to handle the failure cases using a name related to the failure
cause. This will allow to insert additional failing cases without
renaming all the labels.

Reviewed-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 drivers/clk/mvebu/cp110-system-controller.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/clk/mvebu/cp110-system-controller.c b/drivers/clk/mvebu/cp110-system-controller.c
index 8f315c74997e..2a75397f9304 100644
--- a/drivers/clk/mvebu/cp110-system-controller.c
+++ b/drivers/clk/mvebu/cp110-system-controller.c
@@ -221,7 +221,7 @@ static int cp110_syscon_clk_probe(struct platform_device *pdev)
 					1000 * 1000 * 1000);
 	if (IS_ERR(hw)) {
 		ret = PTR_ERR(hw);
-		goto fail0;
+		goto fail_apll;
 	}
 
 	cp110_clks[CP110_CORE_APLL] = hw;
@@ -232,7 +232,7 @@ static int cp110_syscon_clk_probe(struct platform_device *pdev)
 	hw = clk_hw_register_fixed_factor(NULL, ppv2_name, apll_name, 0, 1, 3);
 	if (IS_ERR(hw)) {
 		ret = PTR_ERR(hw);
-		goto fail1;
+		goto fail_ppv2;
 	}
 
 	cp110_clks[CP110_CORE_PPV2] = hw;
@@ -243,7 +243,7 @@ static int cp110_syscon_clk_probe(struct platform_device *pdev)
 	hw = clk_hw_register_fixed_factor(NULL, eip_name, apll_name, 0, 1, 2);
 	if (IS_ERR(hw)) {
 		ret = PTR_ERR(hw);
-		goto fail2;
+		goto fail_eip;
 	}
 
 	cp110_clks[CP110_CORE_EIP] = hw;
@@ -254,7 +254,7 @@ static int cp110_syscon_clk_probe(struct platform_device *pdev)
 	hw = clk_hw_register_fixed_factor(NULL, core_name, eip_name, 0, 1, 2);
 	if (IS_ERR(hw)) {
 		ret = PTR_ERR(hw);
-		goto fail3;
+		goto fail_core;
 	}
 
 	cp110_clks[CP110_CORE_CORE] = hw;
@@ -270,7 +270,7 @@ static int cp110_syscon_clk_probe(struct platform_device *pdev)
 						   core_name, 0, 1, 1);
 	if (IS_ERR(hw)) {
 		ret = PTR_ERR(hw);
-		goto fail4;
+		goto fail_nand;
 	}
 
 	cp110_clks[CP110_CORE_NAND] = hw;
@@ -366,15 +366,15 @@ static int cp110_syscon_clk_probe(struct platform_device *pdev)
 	}
 
 	clk_hw_unregister_fixed_factor(cp110_clks[CP110_CORE_NAND]);
-fail4:
+fail_nand:
 	clk_hw_unregister_fixed_factor(cp110_clks[CP110_CORE_CORE]);
-fail3:
+fail_core:
 	clk_hw_unregister_fixed_factor(cp110_clks[CP110_CORE_EIP]);
-fail2:
+fail_eip:
 	clk_hw_unregister_fixed_factor(cp110_clks[CP110_CORE_PPV2]);
-fail1:
+fail_ppv2:
 	clk_hw_unregister_fixed_rate(cp110_clks[CP110_CORE_APLL]);
-fail0:
+fail_apll:
 	return ret;
 }
 
-- 
git-series 0.9.1
