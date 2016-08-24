From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Thu, 25 Aug 2016 02:26:53 +0900
Subject: [PATCH v3] clk: let clk_disable() return immediately if clk is NULL
Message-ID: <1472059613-30551-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Many of clk_disable() implementations just return for NULL pointer,
but this check is missing from some.  Let's make it tree-wide
consistent.  It will allow clock consumers to call clk_disable()
without NULL pointer check.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Acked-by: Greg Ungerer <gerg@uclinux.org>
Acked-by: Wan Zongshun <mcuos.com@gmail.com>
---

I came back after a long pause.
You can see the discussion about the previous version:
https://www.linux-mips.org/archives/linux-mips/2016-04/msg00063.html


Changes in v3:
  - Return only when clk is NULL.  Do not take care of error pointer.

Changes in v2:
  - Rebase on Linux 4.6-rc1

 arch/arm/mach-mmp/clock.c        | 3 +++
 arch/arm/mach-w90x900/clock.c    | 3 +++
 arch/blackfin/mach-bf609/clock.c | 3 +++
 arch/m68k/coldfire/clk.c         | 4 ++++
 arch/mips/bcm63xx/clk.c          | 3 +++
 5 files changed, 16 insertions(+)

diff --git a/arch/arm/mach-mmp/clock.c b/arch/arm/mach-mmp/clock.c
index ac6633d..28fe64c 100644
--- a/arch/arm/mach-mmp/clock.c
+++ b/arch/arm/mach-mmp/clock.c
@@ -67,6 +67,9 @@ void clk_disable(struct clk *clk)
 {
 	unsigned long flags;
 
+	if (!clk)
+		return;
+
 	WARN_ON(clk->enabled == 0);
 
 	spin_lock_irqsave(&clocks_lock, flags);
diff --git a/arch/arm/mach-w90x900/clock.c b/arch/arm/mach-w90x900/clock.c
index 2c371ff..ac6fd1a 100644
--- a/arch/arm/mach-w90x900/clock.c
+++ b/arch/arm/mach-w90x900/clock.c
@@ -46,6 +46,9 @@ void clk_disable(struct clk *clk)
 {
 	unsigned long flags;
 
+	if (!clk)
+		return;
+
 	WARN_ON(clk->enabled == 0);
 
 	spin_lock_irqsave(&clocks_lock, flags);
diff --git a/arch/blackfin/mach-bf609/clock.c b/arch/blackfin/mach-bf609/clock.c
index 3783058..392a59b 100644
--- a/arch/blackfin/mach-bf609/clock.c
+++ b/arch/blackfin/mach-bf609/clock.c
@@ -97,6 +97,9 @@ EXPORT_SYMBOL(clk_enable);
 
 void clk_disable(struct clk *clk)
 {
+	if (!clk)
+		return;
+
 	if (clk->ops && clk->ops->disable)
 		clk->ops->disable(clk);
 }
diff --git a/arch/m68k/coldfire/clk.c b/arch/m68k/coldfire/clk.c
index fddfdcc..1e3c7e9 100644
--- a/arch/m68k/coldfire/clk.c
+++ b/arch/m68k/coldfire/clk.c
@@ -101,6 +101,10 @@ EXPORT_SYMBOL(clk_enable);
 void clk_disable(struct clk *clk)
 {
 	unsigned long flags;
+
+	if (!clk)
+		return;
+
 	spin_lock_irqsave(&clk_lock, flags);
 	if ((--clk->enabled == 0) && clk->clk_ops)
 		clk->clk_ops->disable(clk);
diff --git a/arch/mips/bcm63xx/clk.c b/arch/mips/bcm63xx/clk.c
index 6375652..b49fc9c 100644
--- a/arch/mips/bcm63xx/clk.c
+++ b/arch/mips/bcm63xx/clk.c
@@ -326,6 +326,9 @@ EXPORT_SYMBOL(clk_enable);
 
 void clk_disable(struct clk *clk)
 {
+	if (!clk)
+		return;
+
 	mutex_lock(&clocks_mutex);
 	clk_disable_unlocked(clk);
 	mutex_unlock(&clocks_mutex);
-- 
1.9.1
