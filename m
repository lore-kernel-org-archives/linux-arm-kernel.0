From: linus.walleij@stericsson.com (Linus Walleij)
Date: Mon, 15 Aug 2011 11:55:04 +0200
Subject: [PATCH] amba: consolidate PrimeCell magic
Message-ID: <1313402104-27024-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

Since two drivers use the PrimeCell scheme without using the
amba_bus driver logic, let's break the magic lookups out as
static inlines in the <linux/amba/bus.h> header so we get
some consolidation anyway.

Cc: Boojin Kim <boojin.kim@samsung.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Viresh Kumar <viresh.kumar@st.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Samsung folks: I cannot find a defconfig that actually compiles
this driver in, can you help me testing it so I didn't break
anything, and Ack if it looks OK? Thanks.
---
 arch/arm/common/pl330.c      |   42 ++++++++++++------------------------------
 drivers/amba/bus.c           |   19 +++----------------
 drivers/dma/ste_dma40.c      |   14 ++++----------
 drivers/mtd/nand/fsmc_nand.c |   10 +++-------
 include/linux/amba/bus.h     |   26 ++++++++++++++++++++++++++
 5 files changed, 48 insertions(+), 63 deletions(-)

diff --git a/arch/arm/common/pl330.c b/arch/arm/common/pl330.c
index 97912fa..2b3b8b3 100644
--- a/arch/arm/common/pl330.c
+++ b/arch/arm/common/pl330.c
@@ -27,6 +27,7 @@
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/dma-mapping.h>
+#include <linux/amba/bus.h>
 
 #include <asm/hardware/pl330.h>
 
@@ -111,8 +112,8 @@
 #define CR4		0xe10
 #define CRD		0xe14
 
-#define PERIPH_ID	0xfe0
-#define PCELL_ID	0xff0
+/* Used as end offset to retrieve PrimeCell ID registers */
+#define PCELL_SIZE	0x1000
 
 #define CR0_PERIPH_REQ_SET	(1 << 0)
 #define CR0_BOOT_EN_SET		(1 << 1)
@@ -143,12 +144,6 @@
 #define CRD_DATA_BUFF_MASK	0x3ff
 
 #define	PART		0x330
-#define DESIGNER	0x41
-#define REVISION	0x0
-#define INTEG_CFG	0x0
-#define PERIPH_ID_VAL	((PART << 0) | (DESIGNER << 12))
-
-#define PCELL_ID_VAL	0xb105f00d
 
 #define PL330_STATE_STOPPED		(1 << 0)
 #define PL330_STATE_EXECUTING		(1 << 1)
@@ -372,19 +367,6 @@ static inline bool _manager_ns(struct pl330_thread *thrd)
 	return (pl330->pinfo->pcfg.mode & DMAC_MODE_NS) ? true : false;
 }
 
-static inline u32 get_id(struct pl330_info *pi, u32 off)
-{
-	void __iomem *regs = pi->base;
-	u32 id = 0;
-
-	id |= (readb(regs + off + 0x0) << 0);
-	id |= (readb(regs + off + 0x4) << 8);
-	id |= (readb(regs + off + 0x8) << 16);
-	id |= (readb(regs + off + 0xc) << 24);
-
-	return id;
-}
-
 static inline u32 _emit_ADDH(unsigned dry_run, u8 buf[],
 		enum pl330_dst da, u16 val)
 {
@@ -1747,8 +1729,8 @@ static void read_dmac_config(struct pl330_info *pi)
 
 	pi->pcfg.irq_ns = readl(regs + CR3);
 
-	pi->pcfg.periph_id = get_id(pi, PERIPH_ID);
-	pi->pcfg.pcell_id = get_id(pi, PCELL_ID);
+	pi->pcfg.periph_id = amba_get_pid(pi->base, PCELL_SIZE);
+	pi->pcfg.pcell_id = amba_get_cid(pi->base, PCELL_SIZE);
 }
 
 static inline void _reset_thread(struct pl330_thread *thrd)
@@ -1838,8 +1820,8 @@ static int dmac_alloc_resources(struct pl330_dmac *pl330)
 int pl330_add(struct pl330_info *pi)
 {
 	struct pl330_dmac *pl330;
-	void __iomem *regs;
 	int i, ret;
+	u32 cid, pid;
 
 	if (!pi || !pi->dev)
 		return -EINVAL;
@@ -1855,13 +1837,13 @@ int pl330_add(struct pl330_info *pi)
 	if (pi->dmac_reset)
 		pi->dmac_reset(pi);
 
-	regs = pi->base;
-
 	/* Check if we can handle this DMAC */
-	if ((get_id(pi, PERIPH_ID) & 0xfffff) != PERIPH_ID_VAL
-	   || get_id(pi, PCELL_ID) != PCELL_ID_VAL) {
-		dev_err(pi->dev, "PERIPH_ID 0x%x, PCELL_ID 0x%x !\n",
-			get_id(pi, PERIPH_ID), get_id(pi, PCELL_ID));
+	cid = amba_get_cid(pi->base, PCELL_SIZE);
+	pid = amba_get_pid(pi->base, PCELL_SIZE);
+	if (cid != AMBA_CID ||
+	    amba_manf(pid) != AMBA_VENDOR_ARM ||
+	    amba_part(pid) != PART) {
+		dev_err(pi->dev, "PID: 0x%x, CID: 0x%x !\n", pid, cid);
 		return -EINVAL;
 	}
 
diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index d74926e..7412671 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -579,7 +579,7 @@ int amba_device_register(struct amba_device *dev, struct resource *parent)
 {
 	u32 size;
 	void __iomem *tmp;
-	int i, ret;
+	int ret;
 
 	device_initialize(&dev->dev);
 
@@ -620,24 +620,11 @@ int amba_device_register(struct amba_device *dev, struct resource *parent)
 
 	ret = amba_get_enable_pclk(dev);
 	if (ret == 0) {
-		u32 pid, cid;
-
-		/*
-		 * Read pid and cid based on size of resource
-		 * they are located at end of region
-		 */
-		for (pid = 0, i = 0; i < 4; i++)
-			pid |= (readl(tmp + size - 0x20 + 4 * i) & 255) <<
-				(i * 8);
-		for (cid = 0, i = 0; i < 4; i++)
-			cid |= (readl(tmp + size - 0x10 + 4 * i) & 255) <<
-				(i * 8);
+		if (amba_get_cid(tmp, size) == AMBA_CID)
+			dev->periphid = amba_get_pid(tmp, size);
 
 		amba_put_disable_pclk(dev);
 
-		if (cid == AMBA_CID)
-			dev->periphid = pid;
-
 		if (!dev->periphid)
 			ret = -ENODEV;
 	}
diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index cd3a7c7..6e11cef 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -2569,7 +2569,6 @@ static struct d40_base * __init d40_hw_detect_init(struct platform_device *pdev)
 	int num_phy_chans;
 	int i;
 	u32 pid;
-	u32 cid;
 	u8 rev;
 
 	clk = clk_get(&pdev->dev, NULL);
@@ -2594,18 +2593,13 @@ static struct d40_base * __init d40_hw_detect_init(struct platform_device *pdev)
 	if (!virtbase)
 		goto failure;
 
-	/* This is just a regular AMBA PrimeCell ID actually */
-	for (pid = 0, i = 0; i < 4; i++)
-		pid |= (readl(virtbase + resource_size(res) - 0x20 + 4 * i)
-			& 255) << (i * 8);
-	for (cid = 0, i = 0; i < 4; i++)
-		cid |= (readl(virtbase + resource_size(res) - 0x10 + 4 * i)
-			& 255) << (i * 8);
-
-	if (cid != AMBA_CID) {
+	/* Device ID use the AMBA PrimeCell scheme */
+	if (amba_get_cid(virtbase, resource_size(res)) != AMBA_CID) {
 		d40_err(&pdev->dev, "Unknown hardware! No PrimeCell ID\n");
 		goto failure;
 	}
+
+	pid = amba_get_pid(virtbase, resource_size(res));
 	if (AMBA_MANF_BITS(pid) != AMBA_VENDOR_ST) {
 		d40_err(&pdev->dev, "Unknown designer! Got %x wanted %x\n",
 			AMBA_MANF_BITS(pid),
diff --git a/drivers/mtd/nand/fsmc_nand.c b/drivers/mtd/nand/fsmc_nand.c
index e9b275a..836de62 100644
--- a/drivers/mtd/nand/fsmc_nand.c
+++ b/drivers/mtd/nand/fsmc_nand.c
@@ -541,8 +541,6 @@ static int __init fsmc_nand_probe(struct platform_device *pdev)
 	struct fsmc_regs *regs;
 	struct resource *res;
 	int ret = 0;
-	u32 pid;
-	int i;
 
 	if (!pdata) {
 		dev_err(&pdev->dev, "platform data is NULL\n");
@@ -636,13 +634,11 @@ static int __init fsmc_nand_probe(struct platform_device *pdev)
 	 * This device ID is actually a common AMBA ID as used on the
 	 * AMBA PrimeCell bus. However it is not a PrimeCell.
 	 */
-	for (pid = 0, i = 0; i < 4; i++)
-		pid |= (readl(host->regs_va + resource_size(res) - 0x20 + 4 * i) & 255) << (i * 8);
-	host->pid = pid;
+	host->pid = amba_get_pid(host->regs_va, resource_size(res));
 	dev_info(&pdev->dev, "FSMC device partno %03x, manufacturer %02x, "
 		 "revision %02x, config %02x\n",
-		 AMBA_PART_BITS(pid), AMBA_MANF_BITS(pid),
-		 AMBA_REV_BITS(pid), AMBA_CONFIG_BITS(pid));
+		 AMBA_PART_BITS(host->pid), AMBA_MANF_BITS(host->pid),
+		 AMBA_REV_BITS(host->pid), AMBA_CONFIG_BITS(host->pid));
 
 	host->bank = pdata->bank;
 	host->select_chip = pdata->select_bank;
diff --git a/include/linux/amba/bus.h b/include/linux/amba/bus.h
index fcbbe71..008cfcf 100644
--- a/include/linux/amba/bus.h
+++ b/include/linux/amba/bus.h
@@ -19,6 +19,7 @@
 #include <linux/err.h>
 #include <linux/resource.h>
 #include <linux/regulator/consumer.h>
+#include <linux/io.h>
 
 #define AMBA_NR_IRQS	2
 #define AMBA_CID	0xb105f00d
@@ -94,4 +95,29 @@ void amba_release_regions(struct amba_device *);
 #define amba_manf(d)	AMBA_MANF_BITS((d)->periphid)
 #define amba_part(d)	AMBA_PART_BITS((d)->periphid)
 
+/*
+ * Inlines to extract the PID and CID for a certain PrimeCell. These are at
+ * offset -0x20 and -0x10 from the end of the I/O region respectively.
+ */
+static inline u32 amba_get_magic(void __iomem *base, u32 size, u8 offset)
+{
+	u32 magic;
+	int i;
+
+	for (magic = 0, i = 0; i < 4; i++)
+		magic |= (readl(base + size - offset + 4 * i) & 255)
+			<< (i * 8);
+	return magic;
+}
+
+static inline u32 amba_get_pid(void __iomem *base, u32 size)
+{
+	return amba_get_magic(base, size, 0x20);
+}
+
+static inline u32 amba_get_cid(void __iomem *base, u32 size)
+{
+	return amba_get_magic(base, size, 0x10);
+}
+
 #endif
-- 
1.7.3.2
