From: joshc@codeaurora.org (Josh Cartwright)
Date: Tue, 11 Feb 2014 10:23:59 -0600
Subject: [PATCH 1/8] bus: arm-cci: make use of of_find_matching_node_and_match
In-Reply-To: <1392135847-30791-1-git-send-email-joshc@codeaurora.org>
References: <1392135847-30791-1-git-send-email-joshc@codeaurora.org>
Message-ID: <1392135847-30791-2-git-send-email-joshc@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of the of_find_matching_node()/of_match_node() pair, which requires two
iterations through the match table, make use of of_find_matching_node_and_match(),
which only iterates through the table once.

This also has the side effect of fixing the following following error hit
during randconfig testing:

  drivers/bus/arm-cci.c: In function ?cci_probe?:
  drivers/bus/arm-cci.c:976:49: warning: dereferencing ?void *? pointer [enabled by default]
    cci_config = of_match_node(arm_cci_matches, np)->data;
                                                   ^
  drivers/bus/arm-cci.c:976:49: error: request for member ?data? in something not a structure or union

Signed-off-by: Josh Cartwright <joshc@codeaurora.org>
---
 drivers/bus/arm-cci.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c
index 962fd35..e249cdb2 100644
--- a/drivers/bus/arm-cci.c
+++ b/drivers/bus/arm-cci.c
@@ -962,6 +962,7 @@ static const struct of_device_id arm_cci_ctrl_if_matches[] = {
 
 static int cci_probe(void)
 {
+	const struct of_device_id *match;
 	struct cci_nb_ports const *cci_config;
 	int ret, i, nb_ace = 0, nb_ace_lite = 0;
 	struct device_node *np, *cp;
@@ -969,11 +970,11 @@ static int cci_probe(void)
 	const char *match_str;
 	bool is_ace;
 
-	np = of_find_matching_node(NULL, arm_cci_matches);
+	np = of_find_matching_node_and_match(NULL, arm_cci_matches, &match);
 	if (!np)
 		return -ENODEV;
 
-	cci_config = of_match_node(arm_cci_matches, np)->data;
+	cci_config = match->data;
 	if (!cci_config)
 		return -ENODEV;
 
-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
