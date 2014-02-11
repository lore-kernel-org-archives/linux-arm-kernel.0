From: joshc@codeaurora.org (Josh Cartwright)
Date: Tue, 11 Feb 2014 10:24:03 -0600
Subject: [PATCH 5/8] ARM: prima2: make use of of_find_matching_node_and_match
In-Reply-To: <1392135847-30791-1-git-send-email-joshc@codeaurora.org>
References: <1392135847-30791-1-git-send-email-joshc@codeaurora.org>
Message-ID: <1392135847-30791-6-git-send-email-joshc@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of the of_find_matching_node()/of_match_node() pair, which requires two
iterations through the match table, make use of of_find_matching_node_and_match(),
which only iterates through the table once.

While we're here, mark the prima2_l2x0 table const.

Signed-off-by: Josh Cartwright <joshc@codeaurora.org>
---
 arch/arm/mach-prima2/l2x0.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-prima2/l2x0.c b/arch/arm/mach-prima2/l2x0.c
index cbcbe9c..982b0b6 100644
--- a/arch/arm/mach-prima2/l2x0.c
+++ b/arch/arm/mach-prima2/l2x0.c
@@ -28,7 +28,7 @@ static struct l2x0_aux marco_l2x0_aux __initconst = {
 	.mask = L2X0_AUX_CTRL_MASK,
 };
 
-static struct of_device_id sirf_l2x0_ids[] __initconst = {
+static const struct of_device_id sirf_l2x0_ids[] __initconst = {
 	{ .compatible = "sirf,prima2-pl310-cache", .data = &prima2_l2x0_aux, },
 	{ .compatible = "sirf,marco-pl310-cache", .data = &marco_l2x0_aux, },
 	{},
@@ -36,12 +36,13 @@ static struct of_device_id sirf_l2x0_ids[] __initconst = {
 
 static int __init sirfsoc_l2x0_init(void)
 {
+	const struct of_device_id *match;
 	struct device_node *np;
 	const struct l2x0_aux *aux;
 
-	np = of_find_matching_node(NULL, sirf_l2x0_ids);
+	np = of_find_matching_node_and_match(NULL, sirf_l2x0_ids, &match);
 	if (np) {
-		aux = of_match_node(sirf_l2x0_ids, np)->data;
+		aux = match->data;
 		return l2x0_of_init(aux->val, aux->mask);
 	}
 
-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
