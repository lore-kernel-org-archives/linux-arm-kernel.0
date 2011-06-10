From: robherring2@gmail.com (Rob Herring)
Date: Fri, 10 Jun 2011 15:48:40 -0500
Subject: [PATCH v4 1/4] dt: check root nodes for match on of_platform_populate
In-Reply-To: <1307738923-7564-1-git-send-email-robherring2@gmail.com>
References: <1307738923-7564-1-git-send-email-robherring2@gmail.com>
Message-ID: <1307738923-7564-2-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

of_platform_populate will create platform devices for the top-level nodes
if they have a compatible string, but regardless of a match or not.

Cc: Grant Likely <grant.likely@secretlab.ca>
Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 drivers/of/platform.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 9b785be..dc56a77 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -318,6 +318,8 @@ int of_platform_populate(struct device_node *root,
 		return -EINVAL;
 
 	for_each_child_of_node(root, child) {
+		if (!of_match_node(matches, child))
+			continue;
 		rc = of_platform_bus_create(child, matches, parent, true);
 		if (rc)
 			break;
-- 
1.7.4.1
