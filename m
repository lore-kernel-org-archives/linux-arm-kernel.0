From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Sat, 05 Jul 2014 11:38:38 +0100
Subject: [PATCH RFC 09/15] component: fix bug with legacy API
In-Reply-To: <20140705103724.GN21766@n2100.arm.linux.org.uk>
References: <20140705103724.GN21766@n2100.arm.linux.org.uk>
Message-ID: <E1X3NMc-0000AH-0q@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sachin Kamat reports that "component: add support for component match
array" broke Exynos DRM due to a NULL pointer deref.  Fix this.

Reported-by: Sachin Kamat <sachin.kamat@samsung.com>
Tested-by: Sachin Kamat <sachin.kamat@samsung.com>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/base/component.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/base/component.c b/drivers/base/component.c
index b4236daed4fa..f748430bb654 100644
--- a/drivers/base/component.c
+++ b/drivers/base/component.c
@@ -293,10 +293,12 @@ int component_master_add_with_match(struct device *dev,
 	if (ops->add_components && match)
 		return -EINVAL;
 
-	/* Reallocate the match array for its true size */
-	match = component_match_realloc(dev, match, match->num);
-	if (IS_ERR(match))
-		return PTR_ERR(match);
+	if (match) {
+		/* Reallocate the match array for its true size */
+		match = component_match_realloc(dev, match, match->num);
+		if (IS_ERR(match))
+			return PTR_ERR(match);
+	}
 
 	master = kzalloc(sizeof(*master), GFP_KERNEL);
 	if (!master)
-- 
1.8.3.1
