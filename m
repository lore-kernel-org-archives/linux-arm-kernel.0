From: tthayer@opensource.altera.com (tthayer at opensource.altera.com)
Date: Thu, 4 Jun 2015 09:28:45 -0500
Subject: [PATCHv2 1/4] edac, altera: Generalize driver to use DT Memory size
In-Reply-To: <1433428128-7292-1-git-send-email-tthayer@opensource.altera.com>
References: <1433428128-7292-1-git-send-email-tthayer@opensource.altera.com>
Message-ID: <1433428128-7292-2-git-send-email-tthayer@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thor Thayer <tthayer@opensource.altera.com>

The Arria10 SOC uses a completely different SDRAM controller from the
earlier CycloneV and ArriaV SoCs. The memory size is calculated in
the bootloader and passed via the device tree. Using this device
tree size is more generic than using the register fields to
calculate the memory size for different SDRAM controllers.

Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
---
v2: Use edac_dbg() for memory size print. Use loop for DT memory.
---
 drivers/edac/altera_edac.c |   55 ++++++++++++++++++++------------------------
 1 file changed, 25 insertions(+), 30 deletions(-)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index 806b63b..a9e7c69 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -219,36 +219,31 @@ static void altr_sdr_mc_create_debugfs_nodes(struct mem_ctl_info *mci)
 {}
 #endif
 
-/* Get total memory size in bytes */
-static u32 altr_sdram_get_total_mem_size(struct regmap *mc_vbase)
+/* Get total memory size from Open Firmware DTB */
+static unsigned long get_total_mem(void)
 {
-	u32 size, read_reg, row, bank, col, cs, width;
-
-	if (regmap_read(mc_vbase, DRAMADDRW_OFST, &read_reg) < 0)
-		return 0;
-
-	if (regmap_read(mc_vbase, DRAMIFWIDTH_OFST, &width) < 0)
-		return 0;
-
-	col = (read_reg & DRAMADDRW_COLBIT_MASK) >>
-		DRAMADDRW_COLBIT_SHIFT;
-	row = (read_reg & DRAMADDRW_ROWBIT_MASK) >>
-		DRAMADDRW_ROWBIT_SHIFT;
-	bank = (read_reg & DRAMADDRW_BANKBIT_MASK) >>
-		DRAMADDRW_BANKBIT_SHIFT;
-	cs = (read_reg & DRAMADDRW_CSBIT_MASK) >>
-		DRAMADDRW_CSBIT_SHIFT;
-
-	/* Correct for ECC as its not addressible */
-	if (width == DRAMIFWIDTH_32B_ECC)
-		width = 32;
-	if (width == DRAMIFWIDTH_16B_ECC)
-		width = 16;
-
-	/* calculate the SDRAM size base on this info */
-	size = 1 << (row + bank + col);
-	size = size * cs * (width / 8);
-	return size;
+	struct device_node *np = NULL;
+	const unsigned int *reg, *reg_end;
+	int len, sw, aw;
+	unsigned long start, size, total_mem = 0;
+
+	for_each_node_by_type(np, "memory") {
+		aw = of_n_addr_cells(np);
+		sw = of_n_size_cells(np);
+		reg = (const unsigned int *)of_get_property(np, "reg", &len);
+		reg_end = reg + (len / sizeof(u32));
+
+		total_mem = 0;
+		do {
+			start = of_read_number(reg, aw);
+			reg += aw;
+			size = of_read_number(reg, sw);
+			reg += sw;
+			total_mem += size;
+		} while (reg < reg_end);
+	}
+	edac_dbg(0, "total_mem 0x%lx\n", total_mem);
+	return total_mem;
 }
 
 static int altr_sdram_probe(struct platform_device *pdev)
@@ -280,7 +275,7 @@ static int altr_sdram_probe(struct platform_device *pdev)
 	}
 
 	/* Grab memory size from device tree. */
-	mem_size = altr_sdram_get_total_mem_size(mc_vbase);
+	mem_size = get_total_mem();
 	if (!mem_size) {
 		edac_printk(KERN_ERR, EDAC_MC,
 			    "Unable to calculate memory size\n");
-- 
1.7.9.5
