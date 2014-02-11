From: joshc@codeaurora.org (Josh Cartwright)
Date: Tue, 11 Feb 2014 10:24:00 -0600
Subject: [PATCH 2/8] bus: mvebu-mbus: make use of
 of_find_matching_node_and_match
In-Reply-To: <1392135847-30791-1-git-send-email-joshc@codeaurora.org>
References: <1392135847-30791-1-git-send-email-joshc@codeaurora.org>
Message-ID: <1392135847-30791-3-git-send-email-joshc@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of the of_find_matching_node()/of_match_node() pair, which requires two
iterations through the match table, make use of of_find_matching_node_and_match(),
which only iterates through the table once.

Signed-off-by: Josh Cartwright <joshc@codeaurora.org>
---
 drivers/bus/mvebu-mbus.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/bus/mvebu-mbus.c b/drivers/bus/mvebu-mbus.c
index 725c461..31f2c80 100644
--- a/drivers/bus/mvebu-mbus.c
+++ b/drivers/bus/mvebu-mbus.c
@@ -890,13 +890,12 @@ int __init mvebu_mbus_dt_init(void)
 	const __be32 *prop;
 	int ret;
 
-	np = of_find_matching_node(NULL, of_mvebu_mbus_ids);
+	np = of_find_matching_node_and_match(NULL, of_mvebu_mbus_ids, &of_id);
 	if (!np) {
 		pr_err("could not find a matching SoC family\n");
 		return -ENODEV;
 	}
 
-	of_id = of_match_node(of_mvebu_mbus_ids, np);
 	mbus_state.soc = of_id->data;
 
 	prop = of_get_property(np, "controller", NULL);
-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
