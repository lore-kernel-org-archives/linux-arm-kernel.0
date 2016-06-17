From: jean-philippe.brucker@arm.com (Jean-Philippe Brucker)
Date: Fri, 17 Jun 2016 18:32:59 +0100
Subject: [PATCH 1/2] arm64: consolidate context ID for 8-bit ASIDs
Message-ID: <20160617173300.4767-1-jean-philippe.brucker@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When a CPU uses 8 bits of ASID, software should write the top 8 bits of
TTB registers and TLBI commands as 0. Currently, we put the generation
field right above the ASIDs, which leads to writing it into TTB and TLBIs.
Hardware is supposed to always ignore those bits, but we shouldn't rely on
that.

Always use bits [63:16] of context.id for the generation number, and keep
bits [15:8] as zero when using 8-bit ASIDs.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 arch/arm64/mm/context.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/mm/context.c b/arch/arm64/mm/context.c
index b7b3978..090bf88 100644
--- a/arch/arm64/mm/context.c
+++ b/arch/arm64/mm/context.c
@@ -38,8 +38,9 @@ static DEFINE_PER_CPU(u64, reserved_asids);
 static cpumask_t tlb_flush_pending;
 
 #define ASID_MASK		(~GENMASK(asid_bits - 1, 0))
-#define ASID_FIRST_VERSION	(1UL << asid_bits)
-#define NUM_USER_ASIDS		ASID_FIRST_VERSION
+#define GENERATION_SHIFT	16
+#define ASID_FIRST_VERSION	(1UL << GENERATION_SHIFT)
+#define NUM_USER_ASIDS		(1UL << asid_bits)
 
 /* Get the ASIDBits supported by the current CPU */
 static u32 get_cpu_asid_bits(void)
-- 
2.8.3
