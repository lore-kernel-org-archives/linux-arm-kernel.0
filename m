From: vipin.kumar@st.com (Vipin Kumar)
Date: Tue, 9 Oct 2012 16:14:44 +0530
Subject: [PATCH 02/11] fsmc/nand: Rearrange the fsmc_nand_data structure and
 update comments
In-Reply-To: <cover.1349778820.git.vipin.kumar@st.com>
References: <cover.1349778820.git.vipin.kumar@st.com>
Message-ID: <2aa2a9c00bcfa62605edfab8fb4c29448612ced3.1349778820.git.vipin.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Vipin Kumar <vipin.kumar@st.com>
---
 drivers/mtd/nand/fsmc_nand.c | 51 ++++++++++++++++++++++++++------------------
 1 file changed, 30 insertions(+), 21 deletions(-)

diff --git a/drivers/mtd/nand/fsmc_nand.c b/drivers/mtd/nand/fsmc_nand.c
index e96d7d1..bd89580 100644
--- a/drivers/mtd/nand/fsmc_nand.c
+++ b/drivers/mtd/nand/fsmc_nand.c
@@ -278,52 +278,61 @@ static struct fsmc_eccplace fsmc_ecc4_sp_place = {
  * struct fsmc_nand_data - structure for FSMC NAND device state
  *
  * @pid:		Part ID on the AMBA PrimeCell format
- * @mtd:		MTD info for a NAND flash.
- * @nand:		Chip related info for a NAND flash.
- * @partitions:		Partition info for a NAND Flash.
- * @nr_partitions:	Total number of partition of a NAND flash.
- *
- * @ecc_place:		ECC placing locations in oobfree type format.
- * @bank:		Bank number for probed device.
- * @clk:		Clock structure for FSMC.
+ * @mtd:		MTD info for a NAND flash
+ * @nand:		Chip related info for a NAND flash
+ * @dev:		Device structure pointer
+ * @clk:		Clock structure for FSMC
+ * @ecc_place:		ECC placing locations in oobfree type format
+ * @bank:		Bank number for probed device
  *
  * @read_dma_chan:	DMA channel for read access
  * @write_dma_chan:	DMA channel for write access to NAND
  * @dma_access_complete: Completion structure
  *
- * @data_pa:		NAND Physical port for Data.
- * @data_va:		NAND port for Data.
- * @cmd_va:		NAND port for Command.
- * @addr_va:		NAND port for Address.
- * @regs_va:		FSMC regs base address.
+ * @dev_timings:	Timings to be programmed in controller
+ * @partitions:		Partition info for a NAND Flash
+ * @nr_partitions:	Total number of partition of a NAND flash
+ * @mode:		Defines the NAND device access mode
+ *			Can be one of:
+ *			- DMA access
+ *			- Word access (CPU)
+ *			- None (Use driver default ie bus width specific
+ *			  CPU access)
+ * @select_chip:	Select a particular bank
+ *
+ * @data_pa:		NAND Physical port for Data
+ * @data_va:		NAND port for Data
+ * @cmd_va:		NAND port for Command
+ * @addr_va:		NAND port for Address
+ * @regs_va:		FSMC regs base address
  */
 struct fsmc_nand_data {
 	u32			pid;
 	struct mtd_info		mtd;
 	struct nand_chip	nand;
-	struct mtd_partition	*partitions;
-	unsigned int		nr_partitions;
-
-	struct fsmc_eccplace	*ecc_place;
-	unsigned int		bank;
 	struct device		*dev;
-	enum access_mode	mode;
 	struct clk		*clk;
+	struct fsmc_eccplace	*ecc_place;
+	unsigned int		bank;
 
 	/* DMA related objects */
 	struct dma_chan		*read_dma_chan;
 	struct dma_chan		*write_dma_chan;
 	struct completion	dma_access_complete;
 
+	/* Recieved from plat data */
 	struct fsmc_nand_timings *dev_timings;
+	struct mtd_partition	*partitions;
+	unsigned int		nr_partitions;
+	enum access_mode	mode;
+	void			(*select_chip)(uint32_t bank, uint32_t busw);
 
+	/* Virtual/Physical addresses for CPU/DMA access */
 	dma_addr_t		data_pa;
 	void __iomem		*data_va;
 	void __iomem		*cmd_va;
 	void __iomem		*addr_va;
 	void __iomem		*regs_va;
-
-	void			(*select_chip)(uint32_t bank, uint32_t busw);
 };
 
 /* Assert CS signal based on chipnr */
-- 
1.7.11.4
