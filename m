From: robin.murphy@arm.com (Robin Murphy)
Date: Mon,  5 Feb 2018 18:39:45 +0000
Subject: [PATCH 4/5] bus/arm-cci: Streamline devicetree handling a bit
In-Reply-To: <cover.1517855839.git.robin.murphy@arm.com>
References: <cover.1517855839.git.robin.murphy@arm.com>
Message-ID: <1f61837990c42120112501602b6a87766b80c347.1517855839.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rather than iterating over child nodes explicitly testing for
availability, we can just use the other helper which already subsumes
that check. Also, the availability check is already NULL-safe, so get
rid of a redundant check in cci_probe(), too.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/bus/arm-cci.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c
index bbc5bc5f172a..e9995e6a1b29 100644
--- a/drivers/bus/arm-cci.c
+++ b/drivers/bus/arm-cci.c
@@ -447,13 +447,10 @@ static int cci_probe_ports(struct device_node *np)
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
@@ -533,7 +530,7 @@ static int cci_probe(void)
 	struct resource res;
 
 	np = of_find_matching_node(NULL, arm_cci_matches);
-	if(!np || !of_device_is_available(np))
+	if (!of_device_is_available(np))
 		return -ENODEV;
 
 	ret = of_address_to_resource(np, 0, &res);
-- 
2.16.1.dirty
