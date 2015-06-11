From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 11 Jun 2015 13:52:11 +0200
Subject: [PATCH] ARM: mm: show prefetch state when either data or instr
 prefect is enabled
Message-ID: <1434023531-20052-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The l2c310_enable() function shows the state of prefetch configuration
only when both data *and* instruction prefetching is enabled, but the
message itself is able to cope with having either data or instruction
prefetch enabled, showing "ID prefetch enabled" when both are enabled,
"D prefetch enabled" when only data prefetch is enabled, and "I
prefetch enabled" when only instruction prefetch is enabled.

Therefore, this commit adjusts the code to display the prefetch
configuration when either data *or* instruction prefetching is
enabled. On my system with data prefetching enabled only, it shows:

  [    0.000000] L2C-310 D prefetch enabled, offset 1 lines

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mm/cache-l2x0.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index d6e43d8..6bdf3a5 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -656,7 +656,8 @@ static void __init l2c310_enable(void __iomem *base, u32 aux, unsigned num_lock)
 	/* Read back resulting AUX_CTRL value as it could have been altered. */
 	aux = readl_relaxed(base + L2X0_AUX_CTRL);
 
-	if (aux & (L310_AUX_CTRL_DATA_PREFETCH | L310_AUX_CTRL_INSTR_PREFETCH)) {
+	if ((aux & L310_AUX_CTRL_DATA_PREFETCH) ||
+	    (aux & L310_AUX_CTRL_INSTR_PREFETCH)) {
 		u32 prefetch = readl_relaxed(base + L310_PREFETCH_CTRL);
 
 		pr_info("L2C-310 %s%s prefetch enabled, offset %u lines\n",
-- 
2.1.0
