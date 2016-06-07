From: lee.jones@linaro.org (Lee Jones)
Date: Tue,  7 Jun 2016 12:19:25 +0100
Subject: [PATCH 1/6] clk: st: clk-flexgen: Detect critical clocks
In-Reply-To: <20160607111930.10375-1-lee.jones@linaro.org>
References: <20160607111930.10375-1-lee.jones@linaro.org>
Message-ID: <20160607111930.10375-2-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Utilise the new Critical Clock infrastructure to mark clocks which
much not be disabled as CRITICAL.

While we're at it, reduce the coverage of the flex_flags variable,
since it's only really used in a single for() loop.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/clk/st/clk-flexgen.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/st/clk-flexgen.c b/drivers/clk/st/clk-flexgen.c
index 627267c..546bd79 100644
--- a/drivers/clk/st/clk-flexgen.c
+++ b/drivers/clk/st/clk-flexgen.c
@@ -267,7 +267,6 @@ static void __init st_of_flexgen_setup(struct device_node *np)
 	const char **parents;
 	int num_parents, i;
 	spinlock_t *rlock = NULL;
-	unsigned long flex_flags = 0;
 	int ret;
 
 	pnode = of_get_parent(np);
@@ -308,12 +307,15 @@ static void __init st_of_flexgen_setup(struct device_node *np)
 	for (i = 0; i < clk_data->clk_num; i++) {
 		struct clk *clk;
 		const char *clk_name;
+		unsigned long flex_flags = 0;
 
 		if (of_property_read_string_index(np, "clock-output-names",
 						  i, &clk_name)) {
 			break;
 		}
 
+		of_clk_detect_critical(np, i, &flex_flags);
+
 		/*
 		 * If we read an empty clock name then the output is unused
 		 */
-- 
2.8.3
