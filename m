From: michal.simek@xilinx.com (Michal Simek)
Date: Wed, 30 Oct 2013 13:46:18 +0100
Subject: [PATCH] ARM: mm: Fix ECC mem policy printk
Message-ID: <8986e8f1a3761e45a7927bdb0e54393c9155e6bf.1383137171.git.michal.simek@xilinx.com>
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
Russell, Will: We discussed this at KS that will be good
to rephrase it or have different logic around this.
I am not sure if we can also test that this bit is
implemented by particular SoC or not.

Maybe logic should be that if SoC uses this bit
that message is shown in origin format to declare
that ECC is enabled or disabled.
When SoC doesn't implement it then do not show this message.

---
 arch/arm/mm/mmu.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index b1d17ee..1b88ce3 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -556,8 +556,9 @@ static void __init build_mem_type_table(void)
 		mem_types[MT_CACHECLEAN].prot_sect |= PMD_SECT_WB;
 		break;
 	}
-	printk("Memory policy: ECC %sabled, Data cache %s\n",
-		ecc_mask ? "en" : "dis", cp->policy);
+	if (ecc_mask)
+		pr_info("Memory policy: ECC enabled, Data cache %s\n",
+			cp->policy);

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131030/a4e0a6ef/attachment-0001.sig>
