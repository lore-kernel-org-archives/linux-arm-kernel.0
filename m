From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 21 Jun 2017 10:45:40 -0700
Subject: [PATCH v8] clk: Add Gemini SoC clock controller
In-Reply-To: <20170621075952.26387-1-linus.walleij@linaro.org>
References: <20170621075952.26387-1-linus.walleij@linaro.org>
Message-ID: <20170621174540.GB4493@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/21, Linus Walleij wrote:
> The Cortina Systems Gemini (SL3516/CS3516) has an on-chip clock
> controller that derive all clocks from a single crystal, using some
> documented and some undocumented PLLs, half dividers, counters and
> gates. This is a best attempt to construct a clock driver for the
> clocks so at least we can gate off unused hardware and driver the
> PCI bus clock.
> 
> Acked-by: Philipp Zabel <p.zabel@pengutronix.de>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---

Applied to clk-next + this fixup

---8<---
diff --git a/drivers/clk/clk-gemini.c b/drivers/clk/clk-gemini.c
index 3ddd2faec674..b82db96ce0c7 100644
--- a/drivers/clk/clk-gemini.c
+++ b/drivers/clk/clk-gemini.c
@@ -279,13 +279,9 @@ static int gemini_clk_probe(struct platform_device *pdev)
 
 	/* Remap the system controller for the exclusive register */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res)
-		return -ENODEV;
 	base = devm_ioremap_resource(dev, res);
-	if (!base) {
-		dev_err(dev, "no memory base\n");
-		return -ENODEV;
-	}
+	if (IS_ERR(base))
+		return PTR_ERR(base);
 
 	map = syscon_node_to_regmap(np);
 	if (IS_ERR(map)) {

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
