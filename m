From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 28 Mar 2017 18:17:02 +0900
Subject: [PATCH v5 1/3] ARM: mmp: let clk_disable() return immediately if clk
 is NULL
In-Reply-To: <1490692624-11931-1-git-send-email-yamada.masahiro@socionext.com>
References: <1490692624-11931-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1490692624-11931-2-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In many of clk_disable() implementations, it is a no-op for a NULL
pointer input, but this is one of the exceptions.

Making it treewide consistent will allow clock consumers to call
clk_disable() without NULL pointer check.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v5:
  - None

Changes in v4:
  - Split into per-arch patches

Changes in v3:
  - Return only when clk is NULL.  Do not take care of error pointer.

Changes in v2:
  - Rebase on Linux 4.6-rc1

 arch/arm/mach-mmp/clock.c | 3 +++
 1 file changed, 3 insertions(+)

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
-- 
2.7.4
