From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 31 May 2016 14:49:02 +0100
Subject: [PATCH 2/2] arm64: mm: dump: log span level
In-Reply-To: <1464702542-24394-1-git-send-email-mark.rutland@arm.com>
References: <1464702542-24394-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1464702542-24394-3-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The page table dump code logs spans of entries at the same level
(pgd/pud/pmd/pte) which have the same attributes. While we log the
(decoded) attributes, we don't log the level, which leaves the output
ambiguous and/or confusing in some cases.

For example:

0xffff800800000000-0xffff800980000000           6G       RW NX SHD AF        BLK UXN MEM/NORMAL

If using 4K pages, this may describe a span of 6 1G block entries at the
PGD/PUD level, or 3072 2M block entries at the PMD level.

This patch adds the page table level to each output line, removing this
ambiguity. For the example above, this will produce:

0xffffffc800000000-0xffffffc980000000           6G PUD       RW NX SHD AF        BLK UXN MEM/NORMAL

When 3 level tables are in use, and we use the asm-generic/nopud.h
definitions, the dump code treats each entry in the PGD as a 1 element
table at the PUD level, and logs spans as being PUDs, which can be
confusing. To counteract this, the "PUD" mnemonic is replaced with "PGD"
when CONFIG_PGTABLE_LEVELS <= 3. Likewise for "PMD" when
CONFIG_PGTABLE_LEVELS <= 2.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Huang Shijie <shijie.huang@arm.com>
Cc: Laura Abbott <labbott@fedoraproject.org>
Cc: Steve Capper <steve.capper@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/mm/dump.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/mm/dump.c b/arch/arm64/mm/dump.c
index a56a7ad..f94b80e 100644
--- a/arch/arm64/mm/dump.c
+++ b/arch/arm64/mm/dump.c
@@ -146,6 +146,7 @@ static const struct prot_bits pte_bits[] = {
 
 struct pg_level {
 	const struct prot_bits *bits;
+	const char *name;
 	size_t num;
 	u64 mask;
 };
@@ -153,15 +154,19 @@ struct pg_level {
 static struct pg_level pg_level[] = {
 	{
 	}, { /* pgd */
+		.name	= "PGD",
 		.bits	= pte_bits,
 		.num	= ARRAY_SIZE(pte_bits),
 	}, { /* pud */
+		.name	= (CONFIG_PGTABLE_LEVELS > 3) ? "PUD" : "PGD",
 		.bits	= pte_bits,
 		.num	= ARRAY_SIZE(pte_bits),
 	}, { /* pmd */
+		.name	= (CONFIG_PGTABLE_LEVELS > 2) ? "PMD" : "PGD",
 		.bits	= pte_bits,
 		.num	= ARRAY_SIZE(pte_bits),
 	}, { /* pte */
+		.name	= "PTE",
 		.bits	= pte_bits,
 		.num	= ARRAY_SIZE(pte_bits),
 	},
@@ -210,7 +215,8 @@ static void note_page(struct pg_state *st, unsigned long addr, unsigned level,
 				delta >>= 10;
 				unit++;
 			}
-			seq_printf(st->seq, "%9lu%c", delta, *unit);
+			seq_printf(st->seq, "%9lu%c %s", delta, *unit,
+				   pg_level[st->level].name);
 			if (pg_level[st->level].bits)
 				dump_prot(st, pg_level[st->level].bits,
 					  pg_level[st->level].num);
-- 
1.9.1
