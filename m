From: robherring2@gmail.com (Rob Herring)
Date: Tue, 19 Mar 2013 21:27:06 -0500
Subject: [PATCH] ARM: cache-l2x0: fix masking of RTL revision numbering
Message-ID: <1363746426-14921-1-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Commit b8db6b8 (ARM: 7547/4: cache-l2x0: add support for Aurora L2 cache
ctrl) moved the masking of the part ID which caused the RTL version to be
lost. This breaks commit 74ddcdb (ARM: 7608/1: l2x0: Only set .set_debug
on PL310 r3p0 and earlier) which uses the RTL version to apply a
work-around. This also caused the printed cache ID to be missing the
version information.

The cache-id-part DT property does not set the RTL bits so masking them
should have no effect.

Reported-by: Paolo Pisati <paolo.pisati@canonical.com>
Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Yehuda Yitschak <yehuday@marvell.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mm/cache-l2x0.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index c2f3739..d457653 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -299,7 +299,7 @@ static void l2x0_unlock(u32 cache_id)
 	int lockregs;
 	int i;
 
-	switch (cache_id) {
+	switch (cache_id & L2X0_CACHE_ID_PART_MASK) {
 	case L2X0_CACHE_ID_PART_L310:
 		lockregs = 8;
 		break;
@@ -333,15 +333,14 @@ void __init l2x0_init(void __iomem *base, u32 aux_val, u32 aux_mask)
 	if (cache_id_part_number_from_dt)
 		cache_id = cache_id_part_number_from_dt;
 	else
-		cache_id = readl_relaxed(l2x0_base + L2X0_CACHE_ID)
-			& L2X0_CACHE_ID_PART_MASK;
+		cache_id = readl_relaxed(l2x0_base + L2X0_CACHE_ID);
 	aux = readl_relaxed(l2x0_base + L2X0_AUX_CTRL);
 
 	aux &= aux_mask;
 	aux |= aux_val;
 
 	/* Determine the number of ways */
-	switch (cache_id) {
+	switch (cache_id & L2X0_CACHE_ID_PART_MASK) {
 	case L2X0_CACHE_ID_PART_L310:
 		if (aux & (1 << 16))
 			ways = 16;
-- 
1.7.10.4
