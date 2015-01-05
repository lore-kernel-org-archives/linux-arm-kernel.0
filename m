From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 05 Jan 2015 10:52:41 +0100
Subject: [PATCH 2/2] clk: exynos-audss: Fix memory leak on driver unbind or
 probe failure
In-Reply-To: <1420451561-12360-1-git-send-email-k.kozlowski@samsung.com>
References: <1420451561-12360-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1420451561-12360-2-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The memory allocated by basic clock divider/gate/mux (struct clk_gate,
clk_divider and clk_mux) was leaking. During driver unbind or probe
failure the driver only unregistered the clocks.

Use clk_unregister_{gate,divider,mux} to release all resources.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/clk/samsung/clk-exynos-audss.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos-audss.c b/drivers/clk/samsung/clk-exynos-audss.c
index f2c2ccce49bb..454b02ae486a 100644
--- a/drivers/clk/samsung/clk-exynos-audss.c
+++ b/drivers/clk/samsung/clk-exynos-audss.c
@@ -82,6 +82,26 @@ static const struct of_device_id exynos_audss_clk_of_match[] = {
 	{},
 };
 
+static void exynos_audss_clk_teardown(void)
+{
+	int i;
+
+	for (i = EXYNOS_MOUT_AUDSS; i < EXYNOS_DOUT_SRP; i++) {
+		if (!IS_ERR(clk_table[i]))
+			clk_unregister_mux(clk_table[i]);
+	}
+
+	for (; i < EXYNOS_SRP_CLK; i++) {
+		if (!IS_ERR(clk_table[i]))
+			clk_unregister_divider(clk_table[i]);
+	}
+
+	for (; i < clk_data.clk_num; i++) {
+		if (!IS_ERR(clk_table[i]))
+			clk_unregister_gate(clk_table[i]);
+	}
+}
+
 /* register exynos_audss clocks */
 static int exynos_audss_clk_probe(struct platform_device *pdev)
 {
@@ -219,10 +239,7 @@ static int exynos_audss_clk_probe(struct platform_device *pdev)
 	return 0;
 
 unregister:
-	for (i = 0; i < clk_data.clk_num; i++) {
-		if (!IS_ERR(clk_table[i]))
-			clk_unregister(clk_table[i]);
-	}
+	exynos_audss_clk_teardown();
 
 	if (!IS_ERR(epll))
 		clk_disable_unprepare(epll);
@@ -232,18 +249,13 @@ unregister:
 
 static int exynos_audss_clk_remove(struct platform_device *pdev)
 {
-	int i;
-
 #ifdef CONFIG_PM_SLEEP
 	unregister_syscore_ops(&exynos_audss_clk_syscore_ops);
 #endif
 
 	of_clk_del_provider(pdev->dev.of_node);
 
-	for (i = 0; i < clk_data.clk_num; i++) {
-		if (!IS_ERR(clk_table[i]))
-			clk_unregister(clk_table[i]);
-	}
+	exynos_audss_clk_teardown();
 
 	if (!IS_ERR(epll))
 		clk_disable_unprepare(epll);
-- 
1.9.1
