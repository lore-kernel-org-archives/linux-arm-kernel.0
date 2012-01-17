From: will.deacon@arm.com (Will Deacon)
Date: Tue, 17 Jan 2012 12:09:55 +0000
Subject: [PATCH] ARM: gic: refactor irq_start assignment
Message-ID: <1326802195-11412-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The irq_start and hwirq_base assignment code is fairly hairy and ended
up being difficult to read following a conflict resolution for 3.2.

This patch rearranges the code slightly to make it easier to read.

Cc: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/common/gic.c |   13 ++++++-------
 1 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/arm/common/gic.c b/arch/arm/common/gic.c
index c47d619..ca6b5dd 100644
--- a/arch/arm/common/gic.c
+++ b/arch/arm/common/gic.c
@@ -694,13 +694,12 @@ void __init gic_init_bases(unsigned int gic_nr, int irq_start,
 	 * For primary GICs, skip over SGIs.
 	 * For secondary GICs, skip over PPIs, too.
 	 */
-	domain->hwirq_base = 32;
-	if (gic_nr == 0) {
-		if ((irq_start & 31) > 0) {
-			domain->hwirq_base = 16;
-			if (irq_start != -1)
-				irq_start = (irq_start & ~31) + 16;
-		}
+	if (gic_nr == 0 && (irq_start & 31) > 0) {
+		domain->hwirq_base = 16;
+		if (irq_start != -1)
+			irq_start = (irq_start & ~31) + 16;
+	} else {
+		domain->hwirq_base = 32;
 	}
 
 	/*
-- 
1.7.4.1
