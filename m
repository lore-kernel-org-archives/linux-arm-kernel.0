From: michal.simek@xilinx.com (Michal Simek)
Date: Fri,  1 Nov 2013 14:42:40 +0100
Subject: [PATCH v2] ARM: mm: Fix ECC mem policy printk
Message-ID: <a485e15ece42ac9a9e1361ec849b4f1eb05748df.1383313334.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ECC policy can be applied to the whole system
when this bit is implemented by SoC vendor
(IMP - bit 9 - in L1 page table entry format).
When this bit is not implemented by SoC vendor
it doesn't mean that system has no other way
how to do ECC.
This patch ensures to show this message only when ECC
is requested via cmd line ecc=on and runs on
appropriate ARM core.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---
Changes in v2:
 - Show message all the time but show ECC enabled just for cases
   where IMP bit is used.

---
 arch/arm/mm/mmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index b1d17ee..324fc85 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -556,8 +556,8 @@ static void __init build_mem_type_table(void)
 		mem_types[MT_CACHECLEAN].prot_sect |= PMD_SECT_WB;
 		break;
 	}
-	printk("Memory policy: ECC %sabled, Data cache %s\n",
-		ecc_mask ? "en" : "dis", cp->policy);
+	pr_info("Memory policy: %sData cache %s\n",
+		ecc_mask ? "ECC enabled, " : "", cp->policy);

 	for (i = 0; i < ARRAY_SIZE(mem_types); i++) {
 		struct mem_type *t = &mem_types[i];
--
1.8.2.3

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131101/c55eab7e/attachment-0001.sig>
