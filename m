From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 15 Sep 2016 17:45:57 +0200
Subject: [PATCH] clk: zx: fix pointer case warnings
Message-ID: <20160915154618.3007024-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The zx296718 clock driver has a creative way of assigning the register
values for each clock, by initializing an __iomem pointer to an
offset and then later adding the base (from ioremap) on top
with a cast to u64. This fail on all 32-bit architectures during
compile testing:

drivers/clk/zte/clk-zx296718.c: In function 'top_clocks_init':
drivers/clk/zte/clk-zx296718.c:554:35: error: cast from pointer to integer of different size [-Werror=pointer-to-int-cast]
   zx296718_pll_clk[i].reg_base += (u64)reg_base;
drivers/clk/zte/clk-zx296718.c:579:29: error: cast from pointer to integer of different size [-Werror=pointer-to-int-cast]
drivers/clk/zte/clk-zx296718.c:592:31: error: cast from pointer to integer of different size [-Werror=pointer-to-int-cast]

It would be nice to avoid all the casts, but I decided to simply
shut up the warnings by changing the type from u64 to uintptr_t,
which does the right thing in practice.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: ca0233285a93 ("clk: zx: register ZX296718 clocks")
---
 drivers/clk/zte/clk-zx296718.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/clk/zte/clk-zx296718.c b/drivers/clk/zte/clk-zx296718.c
index 025e324fab5c..b34402d0cd69 100644
--- a/drivers/clk/zte/clk-zx296718.c
+++ b/drivers/clk/zte/clk-zx296718.c
@@ -551,7 +551,7 @@ static int __init top_clocks_init(struct device_node *np)
 	}
 
 	for (i = 0; i < ARRAY_SIZE(zx296718_pll_clk); i++) {
-		zx296718_pll_clk[i].reg_base += (u64)reg_base;
+		zx296718_pll_clk[i].reg_base += (uintptr_t)reg_base;
 		ret = clk_hw_register(NULL, &zx296718_pll_clk[i].hw);
 		if (ret) {
 			pr_warn("top clk %s init error!\n",
@@ -576,7 +576,7 @@ static int __init top_clocks_init(struct device_node *np)
 			top_hw_onecell_data.hws[top_mux_clk[i].id] =
 					&top_mux_clk[i].mux.hw;
 
-		top_mux_clk[i].mux.reg += (u64)reg_base;
+		top_mux_clk[i].mux.reg += (uintptr_t)reg_base;
 		ret = clk_hw_register(NULL, &top_mux_clk[i].mux.hw);
 		if (ret) {
 			pr_warn("top clk %s init error!\n",
@@ -589,7 +589,7 @@ static int __init top_clocks_init(struct device_node *np)
 			top_hw_onecell_data.hws[top_gate_clk[i].id] =
 					&top_gate_clk[i].gate.hw;
 
-		top_gate_clk[i].gate.reg += (u64)reg_base;
+		top_gate_clk[i].gate.reg += (uintptr_t)reg_base;
 		ret = clk_hw_register(NULL, &top_gate_clk[i].gate.hw);
 		if (ret) {
 			pr_warn("top clk %s init error!\n",
@@ -602,7 +602,7 @@ static int __init top_clocks_init(struct device_node *np)
 			top_hw_onecell_data.hws[top_div_clk[i].id] =
 					&top_div_clk[i].div.hw;
 
-		top_div_clk[i].div.reg += (u64)reg_base;
+		top_div_clk[i].div.reg += (uintptr_t)reg_base;
 		ret = clk_hw_register(NULL, &top_div_clk[i].div.hw);
 		if (ret) {
 			pr_warn("top clk %s init error!\n",
@@ -742,7 +742,7 @@ static int __init lsp0_clocks_init(struct device_node *np)
 			lsp0_hw_onecell_data.hws[lsp0_mux_clk[i].id] =
 					&lsp0_mux_clk[i].mux.hw;
 
-		lsp0_mux_clk[i].mux.reg += (u64)reg_base;
+		lsp0_mux_clk[i].mux.reg += (uintptr_t)reg_base;
 		ret = clk_hw_register(NULL, &lsp0_mux_clk[i].mux.hw);
 		if (ret) {
 			pr_warn("lsp0 clk %s init error!\n",
@@ -755,7 +755,7 @@ static int __init lsp0_clocks_init(struct device_node *np)
 			lsp0_hw_onecell_data.hws[lsp0_gate_clk[i].id] =
 					&lsp0_gate_clk[i].gate.hw;
 
-		lsp0_gate_clk[i].gate.reg += (u64)reg_base;
+		lsp0_gate_clk[i].gate.reg += (uintptr_t)reg_base;
 		ret = clk_hw_register(NULL, &lsp0_gate_clk[i].gate.hw);
 		if (ret) {
 			pr_warn("lsp0 clk %s init error!\n",
@@ -768,7 +768,7 @@ static int __init lsp0_clocks_init(struct device_node *np)
 			lsp0_hw_onecell_data.hws[lsp0_div_clk[i].id] =
 					&lsp0_div_clk[i].div.hw;
 
-		lsp0_div_clk[i].div.reg += (u64)reg_base;
+		lsp0_div_clk[i].div.reg += (uintptr_t)reg_base;
 		ret = clk_hw_register(NULL, &lsp0_div_clk[i].div.hw);
 		if (ret) {
 			pr_warn("lsp0 clk %s init error!\n",
@@ -847,7 +847,7 @@ static int __init lsp1_clocks_init(struct device_node *np)
 			lsp1_hw_onecell_data.hws[lsp1_mux_clk[i].id] =
 					&lsp0_mux_clk[i].mux.hw;
 
-		lsp1_mux_clk[i].mux.reg += (u64)reg_base;
+		lsp1_mux_clk[i].mux.reg += (uintptr_t)reg_base;
 		ret = clk_hw_register(NULL, &lsp1_mux_clk[i].mux.hw);
 		if (ret) {
 			pr_warn("lsp1 clk %s init error!\n",
@@ -860,7 +860,7 @@ static int __init lsp1_clocks_init(struct device_node *np)
 			lsp1_hw_onecell_data.hws[lsp1_gate_clk[i].id] =
 					&lsp1_gate_clk[i].gate.hw;
 
-		lsp1_gate_clk[i].gate.reg += (u64)reg_base;
+		lsp1_gate_clk[i].gate.reg += (uintptr_t)reg_base;
 		ret = clk_hw_register(NULL, &lsp1_gate_clk[i].gate.hw);
 		if (ret) {
 			pr_warn("lsp1 clk %s init error!\n",
@@ -873,7 +873,7 @@ static int __init lsp1_clocks_init(struct device_node *np)
 			lsp1_hw_onecell_data.hws[lsp1_div_clk[i].id] =
 					&lsp1_div_clk[i].div.hw;
 
-		lsp1_div_clk[i].div.reg += (u64)reg_base;
+		lsp1_div_clk[i].div.reg += (uintptr_t)reg_base;
 		ret = clk_hw_register(NULL, &lsp1_div_clk[i].div.hw);
 		if (ret) {
 			pr_warn("lsp1 clk %s init error!\n",
-- 
2.9.0
