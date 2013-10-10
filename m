From: michal.simek@xilinx.com (Michal Simek)
Date: Thu, 10 Oct 2013 12:12:08 +0200
Subject: [PATCH] ARM: mm: Fix ECC mem policy printk
Message-ID: <ef807d1f329e54c42fdaca8d97cf58ac7c4dc1ed.1381399914.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ECC policy is just connected to L1 cache
(IMP - bit 9 - in L1 page table entry format)
and has no connection to other ECC capable devices
in the system. That's why declaring connection with
L1 cache make sense.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---
IRC printk without KERN_ facility level is just INFO.
Please correct me if I am wrong.

---
 arch/arm/mm/mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index b1d17ee..e9899dc 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -556,7 +556,7 @@ static void __init build_mem_type_table(void)
 		mem_types[MT_CACHECLEAN].prot_sect |= PMD_SECT_WB;
 		break;
 	}
-	printk("Memory policy: ECC %sabled, Data cache %s\n",
+	pr_info("Memory policy: L1 ECC %sabled, Data cache %s\n",
 		ecc_mask ? "en" : "dis", cp->policy);

 	for (i = 0; i < ARRAY_SIZE(mem_types); i++) {
--
1.8.2.3

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131010/ea034d98/attachment.sig>
