From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Thu, 12 May 2016 20:16:26 +0800
Subject: [PATCH v3 1/2] arm64: mm: make pr_cont() per line in Virtual kernel
 memory layout
In-Reply-To: <1463055387-19289-1-git-send-email-wangkefeng.wang@huawei.com>
References: <1460948988-7477-1-git-send-email-wangkefeng.wang@huawei.com>
 <1463055387-19289-1-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <1463055387-19289-2-git-send-email-wangkefeng.wang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Each line with single pr_cont() in Virtual kernel memory layout,
or the dump of the kernel memory layout in dmesg is not aligned
when PRINTK_TIME enabled, due to the missing time stamps.

Tested-by: James Morse <james.morse@arm.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/arm64/mm/init.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index ea989d8..ce2e400 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -371,19 +371,18 @@ void __init mem_init(void)
 		MLM(MODULES_VADDR, MODULES_END));
 	pr_cont("    vmalloc : 0x%16lx - 0x%16lx   (%6ld GB)\n",
 		MLG(VMALLOC_START, VMALLOC_END));
-	pr_cont("      .text : 0x%p" " - 0x%p" "   (%6ld KB)\n"
-		"    .rodata : 0x%p" " - 0x%p" "   (%6ld KB)\n"
-		"      .init : 0x%p" " - 0x%p" "   (%6ld KB)\n"
-		"      .data : 0x%p" " - 0x%p" "   (%6ld KB)\n",
-		MLK_ROUNDUP(_text, __start_rodata),
-		MLK_ROUNDUP(__start_rodata, _etext),
-		MLK_ROUNDUP(__init_begin, __init_end),
+	pr_cont("      .text : 0x%p" " - 0x%p" "   (%6ld KB)\n",
+		MLK_ROUNDUP(_text, __start_rodata));
+	pr_cont("    .rodata : 0x%p" " - 0x%p" "   (%6ld KB)\n",
+		MLK_ROUNDUP(__start_rodata, _etext));
+	pr_cont("      .init : 0x%p" " - 0x%p" "   (%6ld KB)\n",
+		MLK_ROUNDUP(__init_begin, __init_end));
+	pr_cont("      .data : 0x%p" " - 0x%p" "   (%6ld KB)\n",
 		MLK_ROUNDUP(_sdata, _edata));
 #ifdef CONFIG_SPARSEMEM_VMEMMAP
-	pr_cont("    vmemmap : 0x%16lx - 0x%16lx   (%6ld GB maximum)\n"
-		"              0x%16lx - 0x%16lx   (%6ld MB actual)\n",
-		MLG(VMEMMAP_START,
-		    VMEMMAP_START + VMEMMAP_SIZE),
+	pr_cont("    vmemmap : 0x%16lx - 0x%16lx   (%6ld GB maximum)\n",
+		MLG(VMEMMAP_START, VMEMMAP_START + VMEMMAP_SIZE));
+	pr_cont("              0x%16lx - 0x%16lx   (%6ld MB actual)\n",
 		MLM((unsigned long)phys_to_page(memblock_start_of_DRAM()),
 		    (unsigned long)virt_to_page(high_memory)));
 #endif
-- 
2.6.0.GIT
