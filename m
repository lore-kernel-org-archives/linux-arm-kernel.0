From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 24 Feb 2014 15:53:55 -0500
Subject: [PATCH 4/4] ARM: keystone: Use dma-ranges for dma_pfn_offset
 configuration
In-Reply-To: <1393275235-1087-1-git-send-email-santosh.shilimkar@ti.com>
References: <1393275235-1087-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1393275235-1087-5-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Grygorii Strashko <grygorii.strashko@ti.com>

Keystone platforms have their physical memory mapped at an address
outside the 32-bit physical range.  A Keystone machine with 16G of RAM
would find its memory at 0x0800000000 - 0x0bffffffff.
The system interconnect allows to perform DMA transfers from first 2G of
physical memory (0x08 0000 0000 to 08 7FFF FFFF) which aliased in
hardware to the 32-bit addressable space (0x80000000 - 0xffffffff),
because DMA HW supports only 32-bits addressing.

Get DMA range configuration from DT and use it to configure per
device dma_pfn_offset. DMA addresses translation will be performed
as following:
 _dev->archdata.dma_pfn_offset = PFN_DOWN(<DMA addr> - <CPU addr>);
 DMA->PFN:
     __bus_to_pfn(addr) + dev->archdata.dma_pfn_offset
 PFN->DMA:
     __pfn_to_bus(pfn - dev->archdata.dma_pfn_offset)

Cc: Russell King <linux@arm.linux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Olof Johansson <olof@lixom.net>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-keystone/keystone.c |   76 +++++++++++++++++++++++++++++++++++--
 1 file changed, 73 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-keystone/keystone.c b/arch/arm/mach-keystone/keystone.c
index e735555..ebe0a66 100644
--- a/arch/arm/mach-keystone/keystone.c
+++ b/arch/arm/mach-keystone/keystone.c
@@ -33,6 +33,7 @@
 
 static void __iomem *keystone_rstctrl;
 static struct notifier_block platform_nb;
+static unsigned long keystone_dma_pfn_offset __read_mostly;
 
 static bool is_coherent(struct device *dev)
 {
@@ -48,15 +49,82 @@ static bool is_coherent(struct device *dev)
 	return false;
 }
 
+static unsigned long get_dma_pfn_offset(struct device *dev)
+{
+	struct device_node *node = of_node_get(dev->of_node);
+	const u32 *ranges = NULL;
+	int len, naddr, nsize, pna;
+	dma_addr_t dma_addr;
+	phys_addr_t cpu_addr, size;
+	unsigned long dma_pfn_offset = 0;
+
+	if (!node)
+		return 0;
+
+	while (1) {
+		naddr = of_n_addr_cells(node);
+		nsize = of_n_size_cells(node);
+		node = of_get_next_parent(node);
+		if (!node)
+			break;
+
+		ranges = of_get_property(node, "dma-ranges", &len);
+
+		/* Ignore empty ranges, they imply no translation required */
+		if (ranges && len > 0)
+			break;
+	}
+
+	if (!ranges) {
+		dev_dbg(dev, "no dma-ranges found\n");
+		goto out;
+	}
+
+	/*
+	 * dma-ranges format:
+	 * DMA addr	: naddr cells
+	 * CPU addr	: pna cells
+	 * size		: nsize cells
+	 */
+	len /= sizeof(u32);
+	pna = of_n_addr_cells(node);
+	dma_addr = of_read_number(ranges, nsize);
+	cpu_addr = of_translate_dma_address(dev->of_node, ranges);
+	size = of_read_number(ranges + naddr + pna, nsize);
+	dma_pfn_offset = PFN_DOWN(cpu_addr - dma_addr);
+
+	dev_dbg(dev, "%s: naddr-%u nsize-%u pna-%u len-%u\n",
+				node->name, naddr, nsize, pna, len);
+	dev_dbg(dev, "dma_addr-%08x cpu_addr-%pa size-%pa dma_pfn_offset-%08lx\n",
+				dma_addr, &cpu_addr, &size, dma_pfn_offset);
+
+out:
+	of_node_put(node);
+	return dma_pfn_offset;
+}
+
 static int keystone_platform_notifier(struct notifier_block *nb,
 				      unsigned long event, void *dev)
 {
+	struct device *_dev = dev;
+
 	if (event != BUS_NOTIFY_ADD_DEVICE)
 		return NOTIFY_DONE;
 
-	if (is_coherent(dev)) {
-		set_dma_ops(dev, &arm_coherent_dma_ops);
-		pr_info("\t\t%s: keystone device is coherent\n", dev_name(dev));
+	if (!_dev)
+		return NOTIFY_BAD;
+
+	if (!_dev->of_node)
+		_dev->archdata.dma_pfn_offset = keystone_dma_pfn_offset;
+	else
+		_dev->archdata.dma_pfn_offset = get_dma_pfn_offset(_dev);
+
+	dev_dbg(_dev, "set dma_pfn_offset %08lx\n",
+				_dev->archdata.dma_pfn_offset);
+
+	if (is_coherent(_dev)) {
+		set_dma_ops(_dev, &arm_coherent_dma_ops);
+		dev_info(_dev, "keystone device is coherent\n");
 	}
 
 	return NOTIFY_OK;
@@ -120,6 +188,8 @@ static void __init keystone_init_meminfo(void)
 
 	/* Populate the arch idmap hook */
 	arch_virt_to_idmap = keystone_virt_to_idmap;
+	keystone_dma_pfn_offset = PFN_DOWN(KEYSTONE_HIGH_PHYS_START -
+						KEYSTONE_LOW_PHYS_START);
 
 	platform_nb.notifier_call = keystone_platform_notifier;
 
-- 
1.7.9.5
