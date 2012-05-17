From: Barry.Song@csr.com (Barry Song)
Date: Thu, 17 May 2012 11:28:55 +0800
Subject: [PATCH] ARM: PRIMA2: fix irq domain size and IRQ mask of internal
 interrupt controller
Message-ID: <1337225335-14133-1-git-send-email-Barry.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Barry Song <Baohua.Song@csr.com>

the old codes will cause 3.4 kernel warning as irq domain size is wrong:
------------[ cut here ]------------
WARNING: at kernel/irq/irqdomain.c:74 irq_domain_legacy_revmap+0x24/0x48()
Modules linked in:
[<c0013f50>] (unwind_backtrace+0x0/0xf8) from [<c001e7d8>] (warn_slowpath_common+0x54/0x64)
[<c001e7d8>] (warn_slowpath_common+0x54/0x64) from [<c001e804>] (warn_slowpath_null+0x1c/0x24)
[<c001e804>] (warn_slowpath_null+0x1c/0x24) from [<c005c3c4>] (irq_domain_legacy_revmap+0x24/0x48)
[<c005c3c4>] (irq_domain_legacy_revmap+0x24/0x48) from [<c005c704>] (irq_create_mapping+0x20/0x120)
[<c005c704>] (irq_create_mapping+0x20/0x120) from [<c005c880>] (irq_create_of_mapping+0x7c/0xf0)
[<c005c880>] (irq_create_of_mapping+0x7c/0xf0) from [<c01a6c48>] (irq_of_parse_and_map+0x2c/0x34)
[<c01a6c48>] (irq_of_parse_and_map+0x2c/0x34) from [<c01a6c68>] (of_irq_to_resource+0x18/0x74)
[<c01a6c68>] (of_irq_to_resource+0x18/0x74) from [<c01a6ce8>] (of_irq_count+0x24/0x34)
[<c01a6ce8>] (of_irq_count+0x24/0x34) from [<c01a7220>] (of_device_alloc+0x58/0x158)
[<c01a7220>] (of_device_alloc+0x58/0x158) from [<c01a735c>] (of_platform_device_create_pdata+0x3c/0x80)
[<c01a735c>] (of_platform_device_create_pdata+0x3c/0x80) from [<c01a7468>] (of_platform_bus_create+0xc8/0x190)
[<c01a7468>] (of_platform_bus_create+0xc8/0x190) from [<c01a74cc>] (of_platform_bus_create+0x12c/0x190)
---[ end trace 1b75b31a2719ed32 ]---

Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 arch/arm/mach-prima2/irq.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-prima2/irq.c b/arch/arm/mach-prima2/irq.c
index 37c2de9..a7b9415 100644
--- a/arch/arm/mach-prima2/irq.c
+++ b/arch/arm/mach-prima2/irq.c
@@ -42,7 +42,8 @@ sirfsoc_alloc_gc(void __iomem *base, unsigned int irq_start, unsigned int num)
 static __init void sirfsoc_irq_init(void)
 {
 	sirfsoc_alloc_gc(sirfsoc_intc_base, 0, 32);
-	sirfsoc_alloc_gc(sirfsoc_intc_base + 4, 32, SIRFSOC_INTENAL_IRQ_END - 32);
+	sirfsoc_alloc_gc(sirfsoc_intc_base + 4, 32,
+			SIRFSOC_INTENAL_IRQ_END + 1 - 32);
 
 	writel_relaxed(0, sirfsoc_intc_base + SIRFSOC_INT_RISC_LEVEL0);
 	writel_relaxed(0, sirfsoc_intc_base + SIRFSOC_INT_RISC_LEVEL1);
@@ -68,7 +69,8 @@ void __init sirfsoc_of_irq_init(void)
 	if (!sirfsoc_intc_base)
 		panic("unable to map intc cpu registers\n");
 
-	irq_domain_add_legacy(np, 32, 0, 0, &irq_domain_simple_ops, NULL);
+	irq_domain_add_legacy(np, SIRFSOC_INTENAL_IRQ_END + 1, 0, 0,
+		&irq_domain_simple_ops, NULL);
 
 	of_node_put(np);
 
-- 
1.7.1



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
