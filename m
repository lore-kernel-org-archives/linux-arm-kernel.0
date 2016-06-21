From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Tue, 21 Jun 2016 11:20:27 +0100
Subject: [[PATCH v2] 06/11] ARM: Samsung: fixup usage of __raw IO
In-Reply-To: <1466504432-24187-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1466504432-24187-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <1466504432-24187-7-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the use of __raw accesors in pm-common.c to use the _relaxed
variants to deal with any issues due to endian related fetches.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
---
 arch/arm/plat-samsung/pm-common.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/plat-samsung/pm-common.c b/arch/arm/plat-samsung/pm-common.c
index 515cd53..6534c3f 100644
--- a/arch/arm/plat-samsung/pm-common.c
+++ b/arch/arm/plat-samsung/pm-common.c
@@ -31,7 +31,7 @@
 void s3c_pm_do_save(struct sleep_save *ptr, int count)
 {
 	for (; count > 0; count--, ptr++) {
-		ptr->val = __raw_readl(ptr->reg);
+		ptr->val = readl_relaxed(ptr->reg);
 		S3C_PMDBG("saved %p value %08lx\n", ptr->reg, ptr->val);
 	}
 }
@@ -51,9 +51,9 @@ void s3c_pm_do_restore(const struct sleep_save *ptr, int count)
 {
 	for (; count > 0; count--, ptr++) {
 		pr_debug("restore %p (restore %08lx, was %08x)\n",
-				ptr->reg, ptr->val, __raw_readl(ptr->reg));
+				ptr->reg, ptr->val, readl_relaxed(ptr->reg));
 
-		__raw_writel(ptr->val, ptr->reg);
+		writel_relaxed(ptr->val, ptr->reg);
 	}
 }
 
@@ -71,5 +71,5 @@ void s3c_pm_do_restore(const struct sleep_save *ptr, int count)
 void s3c_pm_do_restore_core(const struct sleep_save *ptr, int count)
 {
 	for (; count > 0; count--, ptr++)
-		__raw_writel(ptr->val, ptr->reg);
+		writel_relaxed(ptr->val, ptr->reg);
 }
-- 
2.8.1
