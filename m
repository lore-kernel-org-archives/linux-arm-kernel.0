From: rklein@nvidia.com (Rhyland Klein)
Date: Mon, 10 Jun 2013 17:26:39 -0400
Subject: [PATCH 1/4] power_supply: Add of_node_put to fix refcount
In-Reply-To: <1370899602-22123-1-git-send-email-rklein@nvidia.com>
References: <1370899602-22123-1-git-send-email-rklein@nvidia.com>
Message-ID: <1370899602-22123-2-git-send-email-rklein@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

of_parse_phandle increments the refcount for a dt node before returning
it. Add of_node_put where needed to properly decrement the refcount
when we are done using a given node.

Signed-off-by: Rhyland Klein <rklein@nvidia.com>
---
 drivers/power/power_supply_core.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/power/power_supply_core.c b/drivers/power/power_supply_core.c
index 1c517c3..3b2d5df 100644
--- a/drivers/power/power_supply_core.c
+++ b/drivers/power/power_supply_core.c
@@ -109,8 +109,10 @@ static int __power_supply_populate_supplied_from(struct device *dev,
 				psy->name, epsy->name);
 			psy->supplied_from[i-1] = (char *)epsy->name;
 			psy->num_supplies++;
+			of_node_put(np);
 			break;
 		}
+		of_node_put(np);
 	} while (np);
 
 	return 0;
@@ -193,8 +195,10 @@ static int power_supply_check_supplies(struct power_supply *psy)
 		ret = power_supply_find_supply_from_node(np);
 		if (ret) {
 			dev_dbg(psy->dev, "Failed to find supply, defer!\n");
+			of_node_put(np);
 			return -EPROBE_DEFER;
 		}
+		of_node_put(np);
 	} while (np);
 
 	/* All supplies found, allocate char ** array for filling */
-- 
1.7.9.5
