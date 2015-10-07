From: jeremy.linton@arm.com (Jeremy Linton)
Date: Wed,  7 Oct 2015 12:00:23 -0500
Subject: [PATCH 5/7] arm64: Make the kernel page dump utility aware of the
 CONT bit
In-Reply-To: <1444237225-13802-1-git-send-email-jeremy.linton@arm.com>
References: <1444237225-13802-1-git-send-email-jeremy.linton@arm.com>
Message-ID: <1444237225-13802-6-git-send-email-jeremy.linton@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The kernel page dump utility needs to be aware of the CONT bit before
it will break up pages ranges for display.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 arch/arm64/mm/dump.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/mm/dump.c b/arch/arm64/mm/dump.c
index f3d6221..5a22a11 100644
--- a/arch/arm64/mm/dump.c
+++ b/arch/arm64/mm/dump.c
@@ -67,6 +67,12 @@ static struct addr_marker address_markers[] = {
 	{ -1,			NULL },
 };
 
+/*
+ * The page dumper groups page table entries of the same type into a single
+ * description. It uses pg_state to track the range information while
+ * iterating over the pte entries. When the continuity is broken it then
+ * dumps out a description of the range.
+ */
 struct pg_state {
 	struct seq_file *seq;
 	const struct addr_marker *marker;
@@ -114,6 +120,16 @@ static const struct prot_bits pte_bits[] = {
 		.set	= "NG",
 		.clear	= "  ",
 	}, {
+		.mask	= PTE_CONT,
+		.val	= PTE_CONT,
+		.set	= "CON",
+		.clear	= "   ",
+	}, {
+		.mask	= PTE_TABLE_BIT,
+		.val	= PTE_TABLE_BIT,
+		.set	= "   ",
+		.clear	= "BLK",
+	}, {
 		.mask	= PTE_UXN,
 		.val	= PTE_UXN,
 		.set	= "UXN",
@@ -198,7 +214,7 @@ static void note_page(struct pg_state *st, unsigned long addr, unsigned level,
 		unsigned long delta;
 
 		if (st->current_prot) {
-			seq_printf(st->seq, "0x%16lx-0x%16lx   ",
+			seq_printf(st->seq, "0x%016lx-0x%016lx   ",
 				   st->start_address, addr);
 
 			delta = (addr - st->start_address) >> 10;
-- 
2.4.3
