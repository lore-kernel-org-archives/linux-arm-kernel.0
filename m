From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon, 19 Sep 2016 02:59:19 +0900
Subject: [PATCH v4] ARM: w90x900: let clk_disable() return immediately if clk
 is NULL
Message-ID: <1474221559-21269-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In many of clk_disable() implementations, it is a no-op for a NULL
pointer input, but this is one of the exceptions.

Making it treewide consistent will allow clock consumers to call
clk_disable() without NULL pointer check.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Acked-by: Wan Zongshun <mcuos.com@gmail.com>
---

Changes in v4:
  - Split into per-arch patches

Changes in v3:
  - Return only when clk is NULL.  Do not take care of error pointer.

Changes in v2:
  - Rebase on Linux 4.6-rc1

 arch/arm/mach-w90x900/clock.c | 3 +++
 1 file changed, 3 insertions(+)

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
-- 
1.9.1
