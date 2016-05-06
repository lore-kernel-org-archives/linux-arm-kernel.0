From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 6 May 2016 15:28:01 -0700
Subject: [PATCH v5 0/5] clk: mvebu: clock drivers for Marvell Armada 7K/8K
In-Reply-To: <1460648013-31320-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1460648013-31320-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20160506222801.GD3492@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/14, Thomas Petazzoni wrote:
> Hello,
> 
> Here is the fifth version of the clock drivers for Armada 7K/8K. The
> first two patches have already been applied by Stephen Boyd, but I'm
> still including them for completeness.
> 
> Changes since v4:
> 
>  - Remove the gatable-clock-indices from the CP110 driver, use "none"
>    when a given bit does not provide a clock. Suggested by Rob
>    Herring.
> 
>  - Update the gatable clock tree with the latest technical information
>    received.
> 
>  - Turn the clock drivers into proper platform drivers. Suggested by
>    Stephen Boyd.
> 
>  - Remove useless headers include from the clock drivers. Suggested by
>    Stephen Boyd.
> 
>  - Add proper handling in the clock driver ->probe() function.
> 

Applied the last three with this squashed in to shut up
checkpatch.

---8<---
diff --git a/drivers/clk/mvebu/ap806-system-controller.c b/drivers/clk/mvebu/ap806-system-controller.c
index ac9201c7c730..02023baf86c9 100644
--- a/drivers/clk/mvebu/ap806-system-controller.c
+++ b/drivers/clk/mvebu/ap806-system-controller.c
@@ -23,7 +23,7 @@
 #define AP806_SAR_REG			0x400
 #define AP806_SAR_CLKFREQ_MODE_MASK	0x1f
 
-#define AP806_CLK_NUM 			4
+#define AP806_CLK_NUM			4
 
 static struct clk *ap806_clks[AP806_CLK_NUM];
 
@@ -54,7 +54,7 @@ static int ap806_syscon_clk_probe(struct platform_device *pdev)
 	}
 
 	freq_mode = reg & AP806_SAR_CLKFREQ_MODE_MASK;
-	switch(freq_mode) {
+	switch (freq_mode) {
 	case 0x0 ... 0x5:
 		cpuclk_freq = 2000;
 		break;
@@ -100,8 +100,8 @@ static int ap806_syscon_clk_probe(struct platform_device *pdev)
 	/* Fixed clock is always 1200 Mhz */
 	of_property_read_string_index(np, "clock-output-names",
 				      2, &fixedclk_name);
-	ap806_clks[2] = clk_register_fixed_rate(&pdev->dev, fixedclk_name, NULL, 0,
-						1200 * 1000 * 1000);
+	ap806_clks[2] = clk_register_fixed_rate(&pdev->dev, fixedclk_name, NULL,
+						0, 1200 * 1000 * 1000);
 	if (IS_ERR(ap806_clks[2])) {
 		ret = PTR_ERR(ap806_clks[2]);
 		goto fail2;
@@ -147,8 +147,8 @@ static int ap806_syscon_clk_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id ap806_syscon_of_match[] = {
-        { .compatible = "marvell,ap806-system-controller", },
-        {},
+	{ .compatible = "marvell,ap806-system-controller", },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, armada8k_pcie_of_match);
 
diff --git a/drivers/clk/mvebu/cp110-system-controller.c b/drivers/clk/mvebu/cp110-system-controller.c
index f45e7cabd811..f1f41443e466 100644
--- a/drivers/clk/mvebu/cp110-system-controller.c
+++ b/drivers/clk/mvebu/cp110-system-controller.c
@@ -109,6 +109,7 @@ static int cp110_gate_enable(struct clk_hw *hw)
 static void cp110_gate_disable(struct clk_hw *hw)
 {
 	struct cp110_gate_clk *gate = to_cp110_gate_clk(hw);
+
 	regmap_update_bits(gate->regmap, CP110_PM_CLOCK_GATING_REG,
 			   BIT(gate->bit_idx), 0);
 }
@@ -129,7 +130,8 @@ static const struct clk_ops cp110_gate_ops = {
 	.is_enabled = cp110_gate_is_enabled,
 };
 
-static struct clk *cp110_register_gate(const char *name, const char *parent_name,
+static struct clk *cp110_register_gate(const char *name,
+				       const char *parent_name,
 				       struct regmap *regmap, u8 bit_idx)
 {
 	struct cp110_gate_clk *gate;
@@ -205,10 +207,10 @@ static int cp110_syscon_clk_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-        /* Register the APLL which is the root of the clk tree */
+	/* Register the APLL which is the root of the clk tree */
 	of_property_read_string_index(np, "core-clock-output-names",
                                       CP110_CORE_APLL, &apll_name);
-        clk = clk_register_fixed_rate(NULL, apll_name, NULL, 0,
+	clk = clk_register_fixed_rate(NULL, apll_name, NULL, 0,
 				      1000 * 1000 * 1000);
 	if (IS_ERR(clk)) {
 		ret = PTR_ERR(clk);
@@ -217,7 +219,7 @@ static int cp110_syscon_clk_probe(struct platform_device *pdev)
 
 	cp110_clks[CP110_CORE_APLL] = clk;
 
-        /* PPv2 is APLL/3 */
+	/* PPv2 is APLL/3 */
 	of_property_read_string_index(np, "core-clock-output-names",
 				      CP110_CORE_PPV2, &ppv2_name);
 	clk = clk_register_fixed_factor(NULL, ppv2_name, apll_name, 0, 1, 3);
@@ -228,7 +230,7 @@ static int cp110_syscon_clk_probe(struct platform_device *pdev)
 
 	cp110_clks[CP110_CORE_PPV2] = clk;
 
-        /* EIP clock is APLL/2 */
+	/* EIP clock is APLL/2 */
 	of_property_read_string_index(np, "core-clock-output-names",
 				      CP110_CORE_EIP, &eip_name);
 	clk = clk_register_fixed_factor(NULL, eip_name, apll_name, 0, 1, 2);
@@ -239,7 +241,7 @@ static int cp110_syscon_clk_probe(struct platform_device *pdev)
 
 	cp110_clks[CP110_CORE_EIP] = clk;
 
-        /* Core clock is EIP/2 */
+	/* Core clock is EIP/2 */
 	of_property_read_string_index(np, "core-clock-output-names",
 				      CP110_CORE_CORE, &core_name);
 	clk = clk_register_fixed_factor(NULL, core_name, eip_name, 0, 1, 2);
@@ -270,7 +272,8 @@ static int cp110_syscon_clk_probe(struct platform_device *pdev)
 		const char *parent, *name;
 		int ret;
 
-		ret = of_property_read_string_index(np, "gate-clock-output-names",
+		ret = of_property_read_string_index(np,
+						    "gate-clock-output-names",
 						    i, &name);
 		/* Reached the end of the list? */
 		if (ret < 0)
@@ -279,13 +282,14 @@ static int cp110_syscon_clk_probe(struct platform_device *pdev)
 		if (!strcmp(name, "none"))
 			continue;
 
-		switch(i) {
+		switch (i) {
 		case CP110_GATE_AUDIO:
 		case CP110_GATE_COMM_UNIT:
 		case CP110_GATE_EIP150:
 		case CP110_GATE_EIP197:
 		case CP110_GATE_SLOW_IO:
-			of_property_read_string_index(np, "gate-clock-output-names",
+			of_property_read_string_index(np,
+						      "gate-clock-output-names",
 						      CP110_GATE_MAIN, &parent);
 			break;
 		case CP110_GATE_NAND:
@@ -295,7 +299,8 @@ static int cp110_syscon_clk_probe(struct platform_device *pdev)
 			parent = ppv2_name;
 			break;
 		case CP110_GATE_SDIO:
-			of_property_read_string_index(np, "gate-clock-output-names",
+			of_property_read_string_index(np,
+						      "gate-clock-output-names",
 						      CP110_GATE_SDMMC, &parent);
 			break;
 		case CP110_GATE_XOR1:
@@ -303,14 +308,16 @@ static int cp110_syscon_clk_probe(struct platform_device *pdev)
 		case CP110_GATE_PCIE_X1_0:
 		case CP110_GATE_PCIE_X1_1:
 		case CP110_GATE_PCIE_X4:
-			of_property_read_string_index(np, "gate-clock-output-names",
+			of_property_read_string_index(np,
+						      "gate-clock-output-names",
 						      CP110_GATE_PCIE_XOR, &parent);
 			break;
 		case CP110_GATE_SATA:
 		case CP110_GATE_USB3H0:
 		case CP110_GATE_USB3H1:
 		case CP110_GATE_USB3DEV:
-			of_property_read_string_index(np, "gate-clock-output-names",
+			of_property_read_string_index(np,
+						      "gate-clock-output-names",
 						      CP110_GATE_SATA_USB, &parent);
 			break;
 		default:
@@ -378,8 +385,8 @@ static int cp110_syscon_clk_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id cp110_syscon_of_match[] = {
-        { .compatible = "marvell,cp110-system-controller0", },
-        {},
+	{ .compatible = "marvell,cp110-system-controller0", },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, armada8k_pcie_of_match);
 
-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
