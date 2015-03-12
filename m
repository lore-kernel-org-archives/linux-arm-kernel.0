From: fabrice.gasnier@st.com (Fabrice GASNIER)
Date: Thu, 12 Mar 2015 17:10:13 +0100
Subject: [PATCH v3] ARM: l2c: Fix prefetch settings dt parsing
Message-ID: <1426176613-24765-1-git-send-email-fabrice.gasnier@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allow device tree to override the L2C prefetch settings, even when
l2x0_cache_size_of_parse() fails to parse the cache geometry due to (eg)
missing "cache-size" or "cache-sets" properties.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Reviewed-by: Tomasz Figa <tomasz.figa@gmail.com>
---
V3: enhance commit message
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
