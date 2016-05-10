From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 10 May 2016 14:27:20 +0900
Subject: [PATCH] mfd: core: check existence of enable/disable callbacks
Message-ID: <1462858040-13174-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Child devices may not know if their MFD cells have enable/disable
callbacks.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/mfd/mfd-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
index 88bd1b1..95dbf3a 100644
--- a/drivers/mfd/mfd-core.c
+++ b/drivers/mfd/mfd-core.c
@@ -33,7 +33,7 @@ int mfd_cell_enable(struct platform_device *pdev)
 	int err = 0;
 
 	/* only call enable hook if the cell wasn't previously enabled */
-	if (atomic_inc_return(cell->usage_count) == 1)
+	if (atomic_inc_return(cell->usage_count) == 1 && cell->enable)
 		err = cell->enable(pdev);
 
 	/* if the enable hook failed, decrement counter to allow retries */
@@ -50,7 +50,7 @@ int mfd_cell_disable(struct platform_device *pdev)
 	int err = 0;
 
 	/* only disable if no other clients are using it */
-	if (atomic_dec_return(cell->usage_count) == 0)
+	if (atomic_dec_return(cell->usage_count) == 0 && cell->disable)
 		err = cell->disable(pdev);
 
 	/* if the disable hook failed, increment to allow retries */
-- 
1.9.1
