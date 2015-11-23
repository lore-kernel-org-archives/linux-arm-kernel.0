From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Mon, 23 Nov 2015 16:02:43 +0000
Subject: [PATCH 2/4] component: move check for unbound master into
 try_to_bring_up_masters()
In-Reply-To: <20151123160210.GR8644@n2100.arm.linux.org.uk>
References: <20151123160210.GR8644@n2100.arm.linux.org.uk>
Message-ID: <E1a0tZj-0006EX-1P@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Clean up the code a little; we don't need to check that the master is
unbound for every invocation of try_to_bring_up_master(), so let's move
it to where it's really needed - try_to_bring_up_masters(), where we may
encounter already bound masters.

Reviewed-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/base/component.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/base/component.c b/drivers/base/component.c
index 2ca22738ae92..cd70b68d9780 100644
--- a/drivers/base/component.c
+++ b/drivers/base/component.c
@@ -150,13 +150,6 @@ static int try_to_bring_up_master(struct master *master,
 {
 	int ret;
 
-	if (master->bound)
-		return 0;
-
-	/*
-	 * Search the list of components, looking for components that
-	 * belong to this master, and attach them to the master.
-	 */
 	if (find_components(master)) {
 		/* Failed to find all components */
 		ret = 0;
@@ -196,9 +189,11 @@ static int try_to_bring_up_masters(struct component *component)
 	int ret = 0;
 
 	list_for_each_entry(m, &masters, node) {
-		ret = try_to_bring_up_master(m, component);
-		if (ret != 0)
-			break;
+		if (!m->bound) {
+			ret = try_to_bring_up_master(m, component);
+			if (ret != 0)
+				break;
+		}
 	}
 
 	return ret;
-- 
2.1.0
