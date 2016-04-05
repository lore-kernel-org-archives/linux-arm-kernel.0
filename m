From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue,  5 Apr 2016 10:51:23 +0900
Subject: [PATCH v2] clk: let clk_disable() return immediately if clk is NULL
 or error
Message-ID: <1459821083-28116-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The clk_disable() in the common clock framework (drivers/clk/clk.c)
returns immediately if a given clk is NULL or an error pointer.  It
allows clock consumers to call clk_disable() without IS_ERR_OR_NULL
checking if drivers are only used with the common clock framework.

Unfortunately, NULL/error checking is missing from some of non-common
clk_disable() implementations.  This prevents us from completely
dropping NULL/error checking from callers.  Let's make it tree-wide
consistent by adding IS_ERR_OR_NULL(clk) to all callees.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Acked-by: Greg Ungerer <gerg@uclinux.org>
Acked-by: Wan Zongshun <mcuos.com@gmail.com>
---

Stephen,

This patch has been unapplied for a long time.

Please let me know if there is something wrong with this patch.

Thanks,


Changes in v2:
  - Rebase on Linux 4.6-rc1

 arch/arm/mach-ep93xx/clock.c     |  2 +-
 arch/arm/mach-mmp/clock.c        |  3 +++
 arch/arm/mach-sa1100/clock.c     | 15 ++++++++-------
 arch/arm/mach-w90x900/clock.c    |  3 +++
 arch/blackfin/mach-bf609/clock.c |  3 +++
 arch/m68k/coldfire/clk.c         |  4 ++++
 arch/mips/bcm63xx/clk.c          |  3 +++
 arch/mips/lantiq/clk.c           |  3 +++
 drivers/sh/clk/core.c            |  2 +-
 9 files changed, 29 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-ep93xx/clock.c b/arch/arm/mach-ep93xx/clock.c
index 39ef3b6..4e11f7d 100644
--- a/arch/arm/mach-ep93xx/clock.c
+++ b/arch/arm/mach-ep93xx/clock.c
@@ -293,7 +293,7 @@ void clk_disable(struct clk *clk)
 {
 	unsigned long flags;
 
-	if (!clk)
+	if (IS_ERR_OR_NULL(clk))
 		return;
 
 	spin_lock_irqsave(&clk_lock, flags);
diff --git a/arch/arm/mach-mmp/clock.c b/arch/arm/mach-mmp/clock.c
index ac6633d..39ad3896 100644
--- a/arch/arm/mach-mmp/clock.c
+++ b/arch/arm/mach-mmp/clock.c
@@ -67,6 +67,9 @@ void clk_disable(struct clk *clk)
 {
 	unsigned long flags;
 
+	if (IS_ERR_OR_NULL(clk))
+		return;
+
 	WARN_ON(clk->enabled == 0);
 
 	spin_lock_irqsave(&clocks_lock, flags);
diff --git a/arch/arm/mach-sa1100/clock.c b/arch/arm/mach-sa1100/clock.c
index cbf53bb..ea103fd 100644
--- a/arch/arm/mach-sa1100/clock.c
+++ b/arch/arm/mach-sa1100/clock.c
@@ -85,13 +85,14 @@ void clk_disable(struct clk *clk)
 {
 	unsigned long flags;
 
-	if (clk) {
-		WARN_ON(clk->enabled == 0);
-		spin_lock_irqsave(&clocks_lock, flags);
-		if (--clk->enabled == 0)
-			clk->ops->disable(clk);
-		spin_unlock_irqrestore(&clocks_lock, flags);
-	}
+	if (IS_ERR_OR_NULL(clk))
+		return;
+
+	WARN_ON(clk->enabled == 0);
+	spin_lock_irqsave(&clocks_lock, flags);
+	if (--clk->enabled == 0)
+		clk->ops->disable(clk);
+	spin_unlock_irqrestore(&clocks_lock, flags);
 }
 EXPORT_SYMBOL(clk_disable);
 
diff --git a/arch/arm/mach-w90x900/clock.c b/arch/arm/mach-w90x900/clock.c
index 2c371ff..90ec250 100644
--- a/arch/arm/mach-w90x900/clock.c
+++ b/arch/arm/mach-w90x900/clock.c
@@ -46,6 +46,9 @@ void clk_disable(struct clk *clk)
 {
 	unsigned long flags;
 
+	if (IS_ERR_OR_NULL(clk))
+		return;
+
 	WARN_ON(clk->enabled == 0);
 
 	spin_lock_irqsave(&clocks_lock, flags);
diff --git a/arch/blackfin/mach-bf609/clock.c b/arch/blackfin/mach-bf609/clock.c
index 3783058..fed8015 100644
--- a/arch/blackfin/mach-bf609/clock.c
+++ b/arch/blackfin/mach-bf609/clock.c
@@ -97,6 +97,9 @@ EXPORT_SYMBOL(clk_enable);
 
 void clk_disable(struct clk *clk)
 {
+	if (IS_ERR_OR_NULL(clk))
+		return;
+
 	if (clk->ops && clk->ops->disable)
 		clk->ops->disable(clk);
 }
diff --git a/arch/m68k/coldfire/clk.c b/arch/m68k/coldfire/clk.c
index fddfdcc..eb0e8c1 100644
--- a/arch/m68k/coldfire/clk.c
+++ b/arch/m68k/coldfire/clk.c
@@ -101,6 +101,10 @@ EXPORT_SYMBOL(clk_enable);
 void clk_disable(struct clk *clk)
 {
 	unsigned long flags;
+
+	if (IS_ERR_OR_NULL(clk))
+		return;
+
 	spin_lock_irqsave(&clk_lock, flags);
 	if ((--clk->enabled == 0) && clk->clk_ops)
 		clk->clk_ops->disable(clk);
diff --git a/arch/mips/bcm63xx/clk.c b/arch/mips/bcm63xx/clk.c
index 6375652..d6a39bf 100644
--- a/arch/mips/bcm63xx/clk.c
+++ b/arch/mips/bcm63xx/clk.c
@@ -326,6 +326,9 @@ EXPORT_SYMBOL(clk_enable);
 
 void clk_disable(struct clk *clk)
 {
+	if (IS_ERR_OR_NULL(clk))
+		return;
+
 	mutex_lock(&clocks_mutex);
 	clk_disable_unlocked(clk);
 	mutex_unlock(&clocks_mutex);
diff --git a/arch/mips/lantiq/clk.c b/arch/mips/lantiq/clk.c
index a0706fd..c8d87b1 100644
--- a/arch/mips/lantiq/clk.c
+++ b/arch/mips/lantiq/clk.c
@@ -130,6 +130,9 @@ EXPORT_SYMBOL(clk_enable);
 
 void clk_disable(struct clk *clk)
 {
+	if (IS_ERR_OR_NULL(clk))
+		return;
+
 	if (unlikely(!clk_good(clk)))
 		return;
 
diff --git a/drivers/sh/clk/core.c b/drivers/sh/clk/core.c
index 92863e3..9978fa4 100644
--- a/drivers/sh/clk/core.c
+++ b/drivers/sh/clk/core.c
@@ -252,7 +252,7 @@ void clk_disable(struct clk *clk)
 {
 	unsigned long flags;
 
-	if (!clk)
+	if (IS_ERR_OR_NULL(clk))
 		return;
 
 	spin_lock_irqsave(&clock_lock, flags);
-- 
1.9.1
