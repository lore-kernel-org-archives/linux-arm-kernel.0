From: robin.murphy@arm.com (Robin Murphy)
Date: Thu, 15 Feb 2018 18:51:44 +0000
Subject: [PATCH v2 4/6] bus/arm-cci: Streamline devicetree handling a bit
In-Reply-To: <cover.1518717258.git.robin.murphy@arm.com>
References: <cover.1518717258.git.robin.murphy@arm.com>
Message-ID: <bf43fe45395e0bc704f8f8d0c4b694117c583374.1518717258.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rather than iterating over child nodes explicitly testing for
availability, we can just use the other helper which already subsumes
that check. Also, the availability check is already NULL-safe, so get
rid of a redundant check in cci_probe(), too.

Acked-by: Punit Agrawal <punit.agrawal@arm.com>
Acked-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/bus/arm-cci.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c
index 503c1789dd02..23dc0b890d0c 100644
--- a/drivers/bus/arm-cci.c
+++ b/drivers/bus/arm-cci.c
@@ -448,13 +448,10 @@ static int cci_probe_ports(struct device_node *np)
 	if (!ports)
 		return -ENOMEM;
 
-	for_each_child_of_node(np, cp) {
+	for_each_available_child_of_node(np, cp) {
 		if (!of_match_node(arm_cci_ctrl_if_matches, cp))
 			continue;
 
-		if (!of_device_is_available(cp))
-			continue;
-
 		i = nb_ace + nb_ace_lite;
 
 		if (i >= nb_cci_ports)
@@ -534,7 +531,7 @@ static int cci_probe(void)
 	struct resource res;
 
 	np = of_find_matching_node(NULL, arm_cci_matches);
-	if(!np || !of_device_is_available(np))
+	if (!of_device_is_available(np))
 		return -ENODEV;
 
 	ret = of_address_to_resource(np, 0, &res);
-- 
2.16.1.dirty
