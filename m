From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Mon, 18 Apr 2016 11:09:48 +0800
Subject: [PATCH v2 3/3] arm64: mm: Restrictive printing for modules and PCI
 I/O in memory layout
In-Reply-To: <1460948988-7477-1-git-send-email-wangkefeng.wang@huawei.com>
References: <1460533772-13314-1-git-send-email-wangkefeng.wang@huawei.com>
 <1460948988-7477-1-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <1460948988-7477-4-git-send-email-wangkefeng.wang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The modules and PCI I/O informations in Virtual kernel memory layout
are inappropriate when corresponding config is not enabled, so don't
show them then.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/arm64/mm/init.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index c96fe51..e06a445 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -367,8 +367,10 @@ void __init mem_init(void)
 	pr_cont("    kasan   : 0x%16lx - 0x%16lx   (%6ld GB)\n",
 		MLG(KASAN_SHADOW_START, KASAN_SHADOW_END));
 #endif
+#ifdef CONFIG_MODULES
 	pr_cont("    modules : 0x%16lx - 0x%16lx   (%6ld MB)\n",
 		MLM(MODULES_VADDR, MODULES_END));
+#endif
 	pr_cont("    vmalloc : 0x%16lx - 0x%16lx   (%6ld GB)\n",
 		MLG(VMALLOC_START, VMALLOC_END));
 	pr_cont("      .text : 0x%p" " - 0x%p" "   (%6ld KB)\n",
@@ -390,8 +392,10 @@ void __init mem_init(void)
 #endif
 	pr_cont("    fixed   : 0x%16lx - 0x%16lx   (%6ld KB)\n",
 		MLK(FIXADDR_START, FIXADDR_TOP));
+#ifdef CONFIG_PCI
 	pr_cont("    PCI I/O : 0x%16lx - 0x%16lx   (%6ld MB)\n",
 		MLM(PCI_IO_START, PCI_IO_END));
+#endif
 	pr_cont("    memory  : 0x%16lx - 0x%16lx   (%6ld MB)\n",
 		MLM(__phys_to_virt(memblock_start_of_DRAM()),
 		    (unsigned long)high_memory));
-- 
2.6.0.GIT
