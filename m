From: fabrice.gasnier@st.com (Fabrice GASNIER)
Date: Tue, 10 Mar 2015 09:59:01 +0100
Subject: [PATCH v2] ARM: l2c: Fix prefetch settings dt parsing
Message-ID: <1425977941-31278-1-git-send-email-fabrice.gasnier@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allow prefetch settings overriding by device tree, in case
l2x0_cache_size_of_parse() returns value, prefetch tuning
properties are silently ignored. E.g. arm,double-linefill* and
arm,prefetch*.
This happens for example, when "cache-size" or "cache-sets"
properties haven't been filled in l2c dt node.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Reviewed-by: Tomasz Figa <tomasz.figa@gmail.com>
---
V2: fix typo in commit message
s/prefect/prefetch/ and s/of tree/device tree/
---
 arch/arm/mm/cache-l2x0.c | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index c6c7696..8f15f70 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -1131,23 +1131,22 @@ static void __init l2c310_of_parse(const struct device_node *np,
 	}
 
 	ret = l2x0_cache_size_of_parse(np, aux_val, aux_mask, &assoc, SZ_512K);
-	if (ret)
-		return;
-
-	switch (assoc) {
-	case 16:
-		*aux_val &= ~L2X0_AUX_CTRL_ASSOC_MASK;
-		*aux_val |= L310_AUX_CTRL_ASSOCIATIVITY_16;
-		*aux_mask &= ~L2X0_AUX_CTRL_ASSOC_MASK;
-		break;
-	case 8:
-		*aux_val &= ~L2X0_AUX_CTRL_ASSOC_MASK;
-		*aux_mask &= ~L2X0_AUX_CTRL_ASSOC_MASK;
-		break;
-	default:
-		pr_err("L2C-310 OF cache associativity %d invalid, only 8 or 16 permitted\n",
-		       assoc);
-		break;
+	if (!ret) {
+		switch (assoc) {
+		case 16:
+			*aux_val &= ~L2X0_AUX_CTRL_ASSOC_MASK;
+			*aux_val |= L310_AUX_CTRL_ASSOCIATIVITY_16;
+			*aux_mask &= ~L2X0_AUX_CTRL_ASSOC_MASK;
+			break;
+		case 8:
+			*aux_val &= ~L2X0_AUX_CTRL_ASSOC_MASK;
+			*aux_mask &= ~L2X0_AUX_CTRL_ASSOC_MASK;
+			break;
+		default:
+			pr_err("L2C-310 OF cache associativity %d invalid, only 8 or 16 permitted\n",
+			       assoc);
+			break;
+		}
 	}
 
 	prefetch = l2x0_saved_regs.prefetch_ctrl;
-- 
1.9.1
