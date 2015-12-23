From: Suravee.Suthikulpanit@amd.com (Suravee Suthikulpanit)
Date: Tue, 22 Dec 2015 16:24:23 -0800
Subject: [PATCH] gicv2m: Miscellaneous fixes for V2m resources and SPI ranges
Message-ID: <1450830263-28914-1-git-send-email-Suravee.Suthikulpanit@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch contain fixes for v2m resources and SPI ranges:

  * Fix off-by-one error when set up v2m resource end range in
    gicv2m_acpi_init().

  * Fix the off-by-one print error for SPI range.

  * Use %pR to properly print resource range information.

Both ACPI and DT should now print:

  GICv2m: range[mem 0xe1180000-0xe1180fff], SPI[64:319]

Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
---

 Hi Marc,

 Sorry for this minor last minute fixup. This should go on top
 of the V7 of the GICv2m ACPI patch series. Although, this is
 not urgent.

 Thanks,
 Suravee

 drivers/irqchip/irq-gic-v2m.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v2m.c b/drivers/irqchip/irq-gic-v2m.c
index 7e2975d..5f346ea 100644
--- a/drivers/irqchip/irq-gic-v2m.c
+++ b/drivers/irqchip/irq-gic-v2m.c
@@ -365,9 +365,8 @@ static int __init gicv2m_init_one(struct fwnode_handle *fwnode,
 
 	list_add_tail(&v2m->entry, &v2m_nodes);
 
-	pr_info("range[%#lx:%#lx], SPI[%d:%d]\n",
-		(unsigned long)res->start, (unsigned long)res->end,
-		v2m->spi_start, (v2m->spi_start + v2m->nr_spis));
+	pr_info("range%pR, SPI[%d:%d]\n", res,
+		v2m->spi_start, (v2m->spi_start + v2m->nr_spis - 1));
 	return 0;
 
 err_iounmap:
@@ -456,7 +455,8 @@ acpi_parse_madt_msi(struct acpi_subtable_header *header,
 		return -EINVAL;
 
 	res.start = m->base_address;
-	res.end = m->base_address + SZ_4K;
+	res.end = m->base_address + SZ_4K - 1;
+	res.flags = IORESOURCE_MEM;
 
 	if (m->flags & ACPI_MADT_OVERRIDE_SPI_VALUES) {
 		spi_start = m->spi_base;
-- 
2.1.0
