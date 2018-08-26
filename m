From: hejianet@gmail.com (Jia He)
Date: Sun, 26 Aug 2018 17:00:51 +0800
Subject: [PATCH] irqchip/gic-v3-its: add allocation max order limitation for
 lpi_id_bits
Message-ID: <1535274051-2418-1-git-send-email-jia.he@hxt-semitech.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is a WARN_ON when my QDF2400 server boots up (pagesize is 4k)
============begin===============
[    0.000000] GICv3: GIC: Using split EOI/Deactivate mode
[    0.000000] GICv3: Distributor has no Range Selector support
[    0.000000] GICv3: VLPI support, no direct LPI support
[    0.000000] ACPI: SRAT not present
[    0.000000] ITS [mem 0xff7efe0000-0xff7effffff]
[    0.000000] ITS at 0x000000ff7efe0000: Using ITS number 0
[    0.000000] GIC: enabling workaround for ITS: QDF2400 erratum 0065
[    0.000000] ITS at 0x000000ff7efe0000: allocated 524288 Devices
@179f000000 (indirect, esz 8, psz 64K, shr 1)
[    0.000000] ITS at 0x000000ff7efe0000: allocated 8192 Interrupt
Collections @179f930000 (flat, esz 8, psz 64K, shr 1)
[    0.000000] ITS at 0x000000ff7efe0000: allocated 65536 Virtual CPUs
@179f980000 (flat, esz 8, psz 64K, shr 1)
[    0.000000] WARNING: CPU: 0 PID: 0 at mm/page_alloc.c:4066
__alloc_pages_nodemask+0x2d8/0x1188
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.18.0+ #66
[    0.000000] pstate: 20000085 (nzCv daIf -PAN -UAO)
[    0.000000] pc : __alloc_pages_nodemask+0x2d8/0x1188
[    0.000000] lr : __alloc_pages_nodemask+0x134/0x1188
[    0.000000] sp : ffff0000091b3a30
[    0.000000] x29: ffff0000091b3a30 x28: 0000000000000000
[    0.000000] x27: ffff00000a045000 x26: 0000000000000000
[    0.000000] x25: 0000000000000000 x24: ffff0000091c1000
[    0.000000] x23: ffff0000091b3b98 x22: 000000000000000c
[    0.000000] x21: ffff0000082dc130 x20: 0000000000000001
[    0.000000] x19: 0000000000000000 x18: 000000000000003f
[    0.000000] x17: 0000000000000000 x16: 0000000000000000
[    0.000000] x15: ffffffffffffffff x14: 202c74616c662820
[    0.000000] x13: ffff000009c5f9e0 x12: 0000000000000077
[    0.000000] x11: 0000000000000078 x10: 0000000097110f47
[    0.000000] x9 : 0000000000000000 x8 : 00000000009fff3f
[    0.000000] x7 : 000000000000002b x6 : 000000000000000c
[    0.000000] x5 : 0000000000000001 x4 : 0000000000000000
[    0.000000] x3 : ffff000008fd1000 x2 : ffff000008fd1000
[    0.000000] x1 : ffff0000091c1000 x0 : 0000000000000000
[    0.000000] Call trace:
[    0.000000]  __alloc_pages_nodemask+0x2d8/0x1188
[    0.000000]  alloc_pages_current+0x8c/0xd8
[    0.000000]  its_allocate_prop_table+0x5c/0xb8
[    0.000000]  its_init+0x220/0x3c0
[    0.000000]  gic_init_bases+0x250/0x380
[    0.000000]  gic_acpi_init+0x16c/0x2a4
[    0.000000]  acpi_match_madt+0x50/0x88
[    0.000000]  acpi_table_parse_entries_array+0x180/0x204
[    0.000000]  acpi_table_parse_entries+0x60/0x84
[    0.000000]  acpi_table_parse_madt+0x40/0x4c
[    0.000000]  __acpi_probe_device_table+0x94/0xe8
[    0.000000]  irqchip_init+0x38/0x40
[    0.000000]  init_IRQ+0x70/0x9c
[    0.000000]  start_kernel+0x310/0x4c0
[    0.000000] irq event stamp: 0
[    0.000000] hardirqs last  enabled at (0): [<0000000000000000>]
(null)
[    0.000000] hardirqs last disabled at (0): [<0000000000000000>]
(null)
[    0.000000] softirqs last  enabled at (0): [<0000000000000000>]
(null)
[    0.000000] softirqs last disabled at (0): [<0000000000000000>]
(null)
[    0.000000] ---[ end trace 943781056d97862b ]---
============end============

In its_alloc_lpi_tables, lpi_id_bits is 24, without this patch,
its_allocate_prop_table will try to allocate 16M(order 12 if
pagesize=4k). Thus it causes the WARN_ON.

This patch fixes it by limiting the lpi_id_bits.

Signed-off-by: Jia He <jia.he@hxt-semitech.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 316a575..79e6993 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1624,8 +1624,11 @@ static void its_free_prop_table(struct page *prop_page)
 static int __init its_alloc_lpi_tables(void)
 {
 	phys_addr_t paddr;
+	u32 max_bits;	 /*max order limitation in alloc_page*/
 
-	lpi_id_bits = GICD_TYPER_ID_BITS(gic_rdists->gicd_typer);
+	max_bits = PAGE_SHIFT + MAX_ORDER - 1;
+	lpi_id_bits = min_t(u32, max_bits,
+			GICD_TYPER_ID_BITS(gic_rdists->gicd_typer));
 	gic_rdists->prop_page = its_allocate_prop_table(GFP_NOWAIT);
 	if (!gic_rdists->prop_page) {
 		pr_err("Failed to allocate PROPBASE\n");
-- 
1.8.3.1
