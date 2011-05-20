From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 20 May 2011 09:59:24 +0200
Subject: [PATCH 8/9] dma IPU: rework irq handling
In-Reply-To: <1305878365-827-1-git-send-email-s.hauer@pengutronix.de>
References: <1305878365-827-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1305878365-827-10-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

By the time interrupt descriptors were a precious resource the ipu
driver had a mechanism to map all ipu interrupts to a configurable
number of hardware interrupts. Now with sparse irqs we can simplify
it significantly and switch to standard chained handlers.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/dma/Kconfig          |   10 --
 drivers/dma/ipu/ipu_idmac.c  |   41 ++----
 drivers/dma/ipu/ipu_intern.h |   14 +--
 drivers/dma/ipu/ipu_irq.c    |  300 ++++++------------------------------------
 4 files changed, 54 insertions(+), 311 deletions(-)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index a572600..4119188 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -131,16 +131,6 @@ config MX3_IPU
 	  If you plan to use the Image Processing unit in the i.MX3x, say
 	  Y here. If unsure, select Y.
 
-config MX3_IPU_IRQS
-	int "Number of dynamically mapped interrupts for IPU"
-	depends on MX3_IPU
-	range 2 137
-	default 4
-	help
-	  Out of 137 interrupt sources on i.MX31 IPU only very few are used.
-	  To avoid bloating the irq_desc[] array we allocate a sufficient
-	  number of IRQ slots and map them dynamically to specific sources.
-
 config TXX9_DMAC
 	tristate "Toshiba TXx9 SoC DMA support"
 	depends on MACH_TX49XX || MACH_TX39XX
diff --git a/drivers/dma/ipu/ipu_idmac.c b/drivers/dma/ipu/ipu_idmac.c
index c1a125e..3c17c5a 100644
--- a/drivers/dma/ipu/ipu_idmac.c
+++ b/drivers/dma/ipu/ipu_idmac.c
@@ -1132,7 +1132,7 @@ static int ipu_disable_channel(struct idmac *idmac, struct idmac_channel *ichan,
 	if (wait_for_stop && (channel == IDMAC_SDC_0 ||
 			      channel == IDMAC_SDC_1)) {
 		for (timeout = 5;
-		     timeout && !ipu_irq_status(ichan->eof_irq); timeout--)
+		     timeout && !ipu_irq_status(ipu, ichan->eof_irq); timeout--)
 			msleep(5);
 	}
 
@@ -1203,10 +1203,10 @@ static irqreturn_t idmac_interrupt(int irq, void *dev_id)
 	ready0	= idmac_read_ipureg(&ipu_data, IPU_CHA_BUF0_RDY);
 	ready1	= idmac_read_ipureg(&ipu_data, IPU_CHA_BUF1_RDY);
 	curbuf	= idmac_read_ipureg(&ipu_data, IPU_CHA_CUR_BUF);
-	err	= idmac_read_ipureg(&ipu_data, IPU_INT_STAT_4);
+	err	= idmac_read_ipureg(&ipu_data, IPU_INT_STAT(3));
 
 	if (err & (1 << chan_id)) {
-		idmac_write_ipureg(&ipu_data, 1 << chan_id, IPU_INT_STAT_4);
+		idmac_write_ipureg(&ipu_data, 1 << chan_id, IPU_INT_STAT(3));
 		spin_unlock_irqrestore(&ipu_data.lock, flags);
 		/*
 		 * Doing this
@@ -1505,6 +1505,7 @@ static int idmac_alloc_chan_resources(struct dma_chan *chan)
 {
 	struct idmac_channel *ichan = to_idmac_chan(chan);
 	struct idmac *idmac = to_idmac(chan->device);
+	struct ipu *ipu = to_ipu(idmac);
 	int ret;
 
 	/* dmaengine.c now guarantees to only offer free channels */
@@ -1514,11 +1515,7 @@ static int idmac_alloc_chan_resources(struct dma_chan *chan)
 	chan->cookie		= 1;
 	ichan->completed	= -ENXIO;
 
-	ret = ipu_irq_map(chan->chan_id);
-	if (ret < 0)
-		goto eimap;
-
-	ichan->eof_irq = ret;
+	ichan->eof_irq = ipu->irq_base + chan->chan_id;
 
 	/*
 	 * Important to first disable the channel, because maybe someone
@@ -1537,12 +1534,10 @@ static int idmac_alloc_chan_resources(struct dma_chan *chan)
 
 #ifdef DEBUG
 	if (chan->chan_id == IDMAC_IC_7) {
-		ic_sof = ipu_irq_map(69);
-		if (ic_sof > 0)
-			request_irq(ic_sof, ic_sof_irq, 0, "IC SOF", ichan);
-		ic_eof = ipu_irq_map(70);
-		if (ic_eof > 0)
-			request_irq(ic_eof, ic_eof_irq, 0, "IC EOF", ichan);
+		ic_sof = ipu->irq_base + 69;
+		request_irq(ic_sof, ic_sof_irq, 0, "IC SOF", ichan);
+		ic_eof = ipu->irq_base + 70;
+		request_irq(ic_eof, ic_eof_irq, 0, "IC EOF", ichan);
 	}
 #endif
 
@@ -1556,8 +1551,6 @@ static int idmac_alloc_chan_resources(struct dma_chan *chan)
 erirq:
 	ipu_uninit_channel(idmac, ichan);
 eichan:
-	ipu_irq_unmap(chan->chan_id);
-eimap:
 	return ret;
 }
 
@@ -1575,18 +1568,15 @@ static void idmac_free_chan_resources(struct dma_chan *chan)
 		if (chan->chan_id == IDMAC_IC_7) {
 			if (ic_sof > 0) {
 				free_irq(ic_sof, ichan);
-				ipu_irq_unmap(69);
 				ic_sof = -EINVAL;
 			}
 			if (ic_eof > 0) {
 				free_irq(ic_eof, ichan);
-				ipu_irq_unmap(70);
 				ic_eof = -EINVAL;
 			}
 		}
 #endif
 		free_irq(ichan->eof_irq, ichan);
-		ipu_irq_unmap(chan->chan_id);
 	}
 
 	ichan->status = IPU_CHANNEL_FREE;
@@ -1674,15 +1664,14 @@ static void __exit ipu_idmac_exit(struct ipu *ipu)
 
 static int __init ipu_probe(struct platform_device *pdev)
 {
-	struct ipu_platform_data *pdata = pdev->dev.platform_data;
 	struct resource *mem_ipu, *mem_ic;
-	int ret;
+	int i, ret;
 
 	spin_lock_init(&ipu_data.lock);
 
 	mem_ipu	= platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	mem_ic	= platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	if (!pdata || !mem_ipu || !mem_ic)
+	if (!mem_ipu || !mem_ic)
 		return -EINVAL;
 
 	ipu_data.dev = &pdev->dev;
@@ -1699,7 +1688,6 @@ static int __init ipu_probe(struct platform_device *pdev)
 		goto err_noirq;
 
 	ipu_data.irq_err = ret;
-	ipu_data.irq_base = pdata->irq_base;
 
 	dev_dbg(&pdev->dev, "fn irq %u, err irq %u, irq-base %u\n",
 		ipu_data.irq_fn, ipu_data.irq_err, ipu_data.irq_base);
@@ -1731,11 +1719,8 @@ static int __init ipu_probe(struct platform_device *pdev)
 	clk_enable(ipu_data.ipu_clk);
 
 	/* Disable all interrupts */
-	idmac_write_ipureg(&ipu_data, 0, IPU_INT_CTRL_1);
-	idmac_write_ipureg(&ipu_data, 0, IPU_INT_CTRL_2);
-	idmac_write_ipureg(&ipu_data, 0, IPU_INT_CTRL_3);
-	idmac_write_ipureg(&ipu_data, 0, IPU_INT_CTRL_4);
-	idmac_write_ipureg(&ipu_data, 0, IPU_INT_CTRL_5);
+	for (i = 0; i < 5; i++)
+		idmac_write_ipureg(&ipu_data, 0, IPU_INT_CTRL(i));
 
 	dev_dbg(&pdev->dev, "%s @ 0x%08lx, fn irq %u, err irq %u\n", pdev->name,
 		(unsigned long)mem_ipu->start, ipu_data.irq_fn, ipu_data.irq_err);
diff --git a/drivers/dma/ipu/ipu_intern.h b/drivers/dma/ipu/ipu_intern.h
index 545cf11..4eb7d0b 100644
--- a/drivers/dma/ipu/ipu_intern.h
+++ b/drivers/dma/ipu/ipu_intern.h
@@ -27,16 +27,8 @@
 #define IPU_TASKS_STAT		0x1C
 #define IPU_IMA_ADDR		0x20
 #define IPU_IMA_DATA		0x24
-#define IPU_INT_CTRL_1		0x28
-#define IPU_INT_CTRL_2		0x2C
-#define IPU_INT_CTRL_3		0x30
-#define IPU_INT_CTRL_4		0x34
-#define IPU_INT_CTRL_5		0x38
-#define IPU_INT_STAT_1		0x3C
-#define IPU_INT_STAT_2		0x40
-#define IPU_INT_STAT_3		0x44
-#define IPU_INT_STAT_4		0x48
-#define IPU_INT_STAT_5		0x4C
+#define IPU_INT_CTRL(n)		(0x28 + (n) * 4)
+#define IPU_INT_STAT(n)		(0x3c + (n) * 4)
 #define IPU_BRK_CTRL_1		0x50
 #define IPU_BRK_CTRL_2		0x54
 #define IPU_BRK_STAT		0x58
@@ -169,7 +161,7 @@ struct ipu {
 extern int ipu_irq_attach_irq(struct ipu *ipu, struct platform_device *dev);
 extern void ipu_irq_detach_irq(struct ipu *ipu, struct platform_device *dev);
 
-extern bool ipu_irq_status(uint32_t irq);
+extern bool ipu_irq_status(struct ipu *ipu, uint32_t irq);
 extern int ipu_irq_map(unsigned int source);
 extern int ipu_irq_unmap(unsigned int source);
 
diff --git a/drivers/dma/ipu/ipu_irq.c b/drivers/dma/ipu/ipu_irq.c
index ab8a4ef..bf28df9 100644
--- a/drivers/dma/ipu/ipu_irq.c
+++ b/drivers/dma/ipu/ipu_irq.c
@@ -40,122 +40,51 @@ static void ipu_write_reg(struct ipu *ipu, u32 value, unsigned long reg)
 #define IPU_IRQ_NR_FN_BANKS 3
 #define IPU_IRQ_NR_ERR_BANKS 2
 #define IPU_IRQ_NR_BANKS (IPU_IRQ_NR_FN_BANKS + IPU_IRQ_NR_ERR_BANKS)
+#define IPU_NUM_IRQS	(IPU_IRQ_NR_BANKS * 32)
 
-struct ipu_irq_bank {
-	unsigned int	control;
-	unsigned int	status;
-	spinlock_t	lock;
-	struct ipu	*ipu;
-};
-
-static struct ipu_irq_bank irq_bank[IPU_IRQ_NR_BANKS] = {
-	/* 3 groups of functional interrupts */
-	{
-		.control	= IPU_INT_CTRL_1,
-		.status		= IPU_INT_STAT_1,
-	}, {
-		.control	= IPU_INT_CTRL_2,
-		.status		= IPU_INT_STAT_2,
-	}, {
-		.control	= IPU_INT_CTRL_3,
-		.status		= IPU_INT_STAT_3,
-	},
-	/* 2 groups of error interrupts */
-	{
-		.control	= IPU_INT_CTRL_4,
-		.status		= IPU_INT_STAT_4,
-	}, {
-		.control	= IPU_INT_CTRL_5,
-		.status		= IPU_INT_STAT_5,
-	},
-};
-
-struct ipu_irq_map {
-	unsigned int		irq;
-	int			source;
-	struct ipu_irq_bank	*bank;
-	struct ipu		*ipu;
-};
-
-static struct ipu_irq_map irq_map[CONFIG_MX3_IPU_IRQS];
-/* Protects allocations from the above array of maps */
-static DEFINE_MUTEX(map_lock);
 /* Protects register accesses and individual mappings */
 static DEFINE_SPINLOCK(bank_lock);
 
-static struct ipu_irq_map *src2map(unsigned int src)
-{
-	int i;
-
-	for (i = 0; i < CONFIG_MX3_IPU_IRQS; i++)
-		if (irq_map[i].source == src)
-			return irq_map + i;
-
-	return NULL;
-}
-
 static void ipu_irq_unmask(struct irq_data *d)
 {
-	struct ipu_irq_map *map = irq_data_get_irq_chip_data(d);
-	struct ipu_irq_bank *bank;
+	struct ipu *ipu = irq_data_get_irq_chip_data(d);
+	int ipu_irq = d->irq - ipu->irq_base;
 	uint32_t reg;
 	unsigned long lock_flags;
 
 	spin_lock_irqsave(&bank_lock, lock_flags);
 
-	bank = map->bank;
-	if (!bank) {
-		spin_unlock_irqrestore(&bank_lock, lock_flags);
-		pr_err("IPU: %s(%u) - unmapped!\n", __func__, d->irq);
-		return;
-	}
-
-	reg = ipu_read_reg(bank->ipu, bank->control);
-	reg |= (1UL << (map->source & 31));
-	ipu_write_reg(bank->ipu, reg, bank->control);
+	reg = ipu_read_reg(ipu, IPU_INT_CTRL(ipu_irq / 32));
+	reg |= 1UL << (ipu_irq & 31);
+	ipu_write_reg(ipu, reg, IPU_INT_CTRL(ipu_irq / 32));
 
 	spin_unlock_irqrestore(&bank_lock, lock_flags);
 }
 
 static void ipu_irq_mask(struct irq_data *d)
 {
-	struct ipu_irq_map *map = irq_data_get_irq_chip_data(d);
-	struct ipu_irq_bank *bank;
+	struct ipu *ipu = irq_data_get_irq_chip_data(d);
+	int ipu_irq = d->irq - ipu->irq_base;
 	uint32_t reg;
 	unsigned long lock_flags;
 
 	spin_lock_irqsave(&bank_lock, lock_flags);
 
-	bank = map->bank;
-	if (!bank) {
-		spin_unlock_irqrestore(&bank_lock, lock_flags);
-		pr_err("IPU: %s(%u) - unmapped!\n", __func__, d->irq);
-		return;
-	}
-
-	reg = ipu_read_reg(bank->ipu, bank->control);
-	reg &= ~(1UL << (map->source & 31));
-	ipu_write_reg(bank->ipu, reg, bank->control);
+	reg = ipu_read_reg(ipu, IPU_INT_CTRL(ipu_irq / 32));
+	reg &= ~(1UL << (ipu_irq & 31));
+	ipu_write_reg(ipu, reg, IPU_INT_CTRL(ipu_irq / 32));
 
 	spin_unlock_irqrestore(&bank_lock, lock_flags);
 }
 
 static void ipu_irq_ack(struct irq_data *d)
 {
-	struct ipu_irq_map *map = irq_data_get_irq_chip_data(d);
-	struct ipu_irq_bank *bank;
+	struct ipu *ipu = irq_data_get_irq_chip_data(d);
+	int ipu_irq = d->irq - ipu->irq_base;
 	unsigned long lock_flags;
 
 	spin_lock_irqsave(&bank_lock, lock_flags);
-
-	bank = map->bank;
-	if (!bank) {
-		spin_unlock_irqrestore(&bank_lock, lock_flags);
-		pr_err("IPU: %s(%u) - unmapped!\n", __func__, d->irq);
-		return;
-	}
-
-	ipu_write_reg(bank->ipu, 1UL << (map->source & 31), bank->status);
+	ipu_write_reg(ipu, 1UL << (ipu_irq & 31), IPU_INT_STAT(ipu_irq / 32));
 	spin_unlock_irqrestore(&bank_lock, lock_flags);
 }
 
@@ -165,182 +94,38 @@ static void ipu_irq_ack(struct irq_data *d)
  * @return:	true if the interrupt is pending/asserted or false if the
  *		interrupt is not pending.
  */
-bool ipu_irq_status(unsigned int irq)
+bool ipu_irq_status(struct ipu *ipu, unsigned int irq)
 {
-	struct ipu_irq_map *map = irq_get_chip_data(irq);
-	struct ipu_irq_bank *bank;
-	unsigned long lock_flags;
+	int ipu_irq = irq - ipu->irq_base;
 	bool ret;
 
-	spin_lock_irqsave(&bank_lock, lock_flags);
-	bank = map->bank;
-	ret = bank && ipu_read_reg(bank->ipu, bank->status) &
-		(1UL << (map->source & 31));
-	spin_unlock_irqrestore(&bank_lock, lock_flags);
-
-	return ret;
-}
-
-/**
- * ipu_irq_map() - map an IPU interrupt source to an IRQ number
- * @source:	interrupt source bit position (see below)
- * @return:	mapped IRQ number or negative error code
- *
- * The source parameter has to be explained further. On i.MX31 IPU has 137 IRQ
- * sources, they are broken down in 5 32-bit registers, like 32, 32, 24, 32, 17.
- * However, the source argument of this function is not the sequence number of
- * the possible IRQ, but rather its bit position. So, first interrupt in fourth
- * register has source number 96, and not 88. This makes calculations easier,
- * and also provides forward compatibility with any future IPU implementations
- * with any interrupt bit assignments.
- */
-int ipu_irq_map(unsigned int source)
-{
-	int i, ret = -ENOMEM;
-	struct ipu_irq_map *map;
-
-	might_sleep();
-
-	mutex_lock(&map_lock);
-	map = src2map(source);
-	if (map) {
-		pr_err("IPU: Source %u already mapped to IRQ %u\n", source, map->irq);
-		ret = -EBUSY;
-		goto out;
-	}
-
-	for (i = 0; i < CONFIG_MX3_IPU_IRQS; i++) {
-		if (irq_map[i].source < 0) {
-			unsigned long lock_flags;
-
-			spin_lock_irqsave(&bank_lock, lock_flags);
-			irq_map[i].source = source;
-			irq_map[i].bank = irq_bank + source / 32;
-			spin_unlock_irqrestore(&bank_lock, lock_flags);
-
-			ret = irq_map[i].irq;
-			pr_debug("IPU: mapped source %u to IRQ %u\n",
-				 source, ret);
-			break;
-		}
-	}
-out:
-	mutex_unlock(&map_lock);
-
-	if (ret < 0)
-		pr_err("IPU: couldn't map source %u: %d\n", source, ret);
-
-	return ret;
-}
-
-/**
- * ipu_irq_map() - map an IPU interrupt source to an IRQ number
- * @source:	interrupt source bit position (see ipu_irq_map())
- * @return:	0 or negative error code
- */
-int ipu_irq_unmap(unsigned int source)
-{
-	int i, ret = -EINVAL;
-
-	might_sleep();
-
-	mutex_lock(&map_lock);
-	for (i = 0; i < CONFIG_MX3_IPU_IRQS; i++) {
-		if (irq_map[i].source == source) {
-			unsigned long lock_flags;
-
-			pr_debug("IPU: unmapped source %u from IRQ %u\n",
-				 source, irq_map[i].irq);
-
-			spin_lock_irqsave(&bank_lock, lock_flags);
-			irq_map[i].source = -EINVAL;
-			irq_map[i].bank = NULL;
-			spin_unlock_irqrestore(&bank_lock, lock_flags);
-
-			ret = 0;
-			break;
-		}
-	}
-	mutex_unlock(&map_lock);
+	ret = ipu_read_reg(ipu, IPU_INT_STAT(ipu_irq / 32)) &
+		(1UL << (ipu_irq & 31));
 
 	return ret;
 }
 
 /* Chained IRQ handler for IPU error interrupt */
-static void ipu_irq_err(unsigned int irq, struct irq_desc *desc)
+static void ipu_irq(unsigned int irq, struct irq_desc *desc)
 {
 	struct ipu *ipu = irq_get_handler_data(irq);
-	u32 status;
-	int i, line;
+	unsigned long status;
+	unsigned long bit;
+	int i;
 
-	for (i = IPU_IRQ_NR_FN_BANKS; i < IPU_IRQ_NR_BANKS; i++) {
-		struct ipu_irq_bank *bank = irq_bank + i;
+	for (i = 0; i < IPU_IRQ_NR_BANKS; i++) {
 
 		spin_lock(&bank_lock);
-		status = ipu_read_reg(ipu, bank->status);
+		status = ipu_read_reg(ipu, IPU_INT_STAT(i));
 		/*
 		 * Don't think we have to clear all interrupts here, they will
 		 * be acked by ->handle_irq() (handle_level_irq). However, we
 		 * might want to clear unhandled interrupts after the loop...
 		 */
-		status &= ipu_read_reg(ipu, bank->control);
+		status &= ipu_read_reg(ipu, IPU_INT_CTRL(i));
 		spin_unlock(&bank_lock);
-		while ((line = ffs(status))) {
-			struct ipu_irq_map *map;
-
-			line--;
-			status &= ~(1UL << line);
-
-			spin_lock(&bank_lock);
-			map = src2map(32 * i + line);
-			if (map)
-				irq = map->irq;
-			spin_unlock(&bank_lock);
-
-			if (!map) {
-				pr_err("IPU: Interrupt on unmapped source %u bank %d\n",
-				       line, i);
-				continue;
-			}
-			generic_handle_irq(irq);
-		}
-	}
-}
-
-/* Chained IRQ handler for IPU function interrupt */
-static void ipu_irq_fn(unsigned int irq, struct irq_desc *desc)
-{
-	struct ipu *ipu = irq_desc_get_handler_data(desc);
-	u32 status;
-	int i, line;
-
-	for (i = 0; i < IPU_IRQ_NR_FN_BANKS; i++) {
-		struct ipu_irq_bank *bank = irq_bank + i;
-
-		spin_lock(&bank_lock);
-		status = ipu_read_reg(ipu, bank->status);
-		/* Not clearing all interrupts, see above */
-		status &= ipu_read_reg(ipu, bank->control);
-		spin_unlock(&bank_lock);
-		while ((line = ffs(status))) {
-			struct ipu_irq_map *map;
-
-			line--;
-			status &= ~(1UL << line);
-
-			spin_lock(&bank_lock);
-			map = src2map(32 * i + line);
-			if (map)
-				irq = map->irq;
-			spin_unlock(&bank_lock);
-
-			if (!map) {
-				pr_err("IPU: Interrupt on unmapped source %u bank %d\n",
-				       line, i);
-				continue;
-			}
-			generic_handle_irq(irq);
-		}
+		for_each_set_bit(bit, &status, 32)
+			generic_handle_irq(ipu->irq_base + i * 32 + bit);
 	}
 }
 
@@ -354,48 +139,41 @@ static struct irq_chip ipu_irq_chip = {
 /* Install the IRQ handler */
 int __init ipu_irq_attach_irq(struct ipu *ipu, struct platform_device *dev)
 {
-	struct ipu_platform_data *pdata = dev->dev.platform_data;
-	unsigned int irq, irq_base, i;
+	unsigned int irq, irq_base;
 
-	irq_base = pdata->irq_base;
+	irq_base = irq_alloc_descs(-1, 0, IPU_IRQ_NR_BANKS * 32, 0);
+	if (irq_base < 0)
+		return irq_base;
 
-	for (i = 0; i < IPU_IRQ_NR_BANKS; i++)
-		irq_bank[i].ipu = ipu;
+	ipu->irq_base = irq_base;
 
-	for (i = 0; i < CONFIG_MX3_IPU_IRQS; i++) {
+	for (irq = irq_base; irq < irq_base + IPU_NUM_IRQS; irq++) {
 		int ret;
 
-		irq = irq_base + i;
 		ret = irq_set_chip(irq, &ipu_irq_chip);
 		if (ret < 0)
 			return ret;
-		ret = irq_set_chip_data(irq, irq_map + i);
+		ret = irq_set_chip_data(irq, ipu);
 		if (ret < 0)
 			return ret;
-		irq_map[i].ipu = ipu;
-		irq_map[i].irq = irq;
-		irq_map[i].source = -EINVAL;
 		irq_set_handler(irq, handle_level_irq);
-#ifdef CONFIG_ARM
 		set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
-#endif
 	}
 
 	irq_set_handler_data(ipu->irq_fn, ipu);
-	irq_set_chained_handler(ipu->irq_fn, ipu_irq_fn);
+	irq_set_chained_handler(ipu->irq_fn, ipu_irq);
 
 	irq_set_handler_data(ipu->irq_err, ipu);
-	irq_set_chained_handler(ipu->irq_err, ipu_irq_err);
+	irq_set_chained_handler(ipu->irq_err, ipu_irq);
 
 	return 0;
 }
 
 void ipu_irq_detach_irq(struct ipu *ipu, struct platform_device *dev)
 {
-	struct ipu_platform_data *pdata = dev->dev.platform_data;
 	unsigned int irq, irq_base;
 
-	irq_base = pdata->irq_base;
+	irq_base = ipu->irq_base;
 
 	irq_set_chained_handler(ipu->irq_fn, NULL);
 	irq_set_handler_data(ipu->irq_fn, NULL);
@@ -403,10 +181,8 @@ void ipu_irq_detach_irq(struct ipu *ipu, struct platform_device *dev)
 	irq_set_chained_handler(ipu->irq_err, NULL);
 	irq_set_handler_data(ipu->irq_err, NULL);
 
-	for (irq = irq_base; irq < irq_base + CONFIG_MX3_IPU_IRQS; irq++) {
-#ifdef CONFIG_ARM
+	for (irq = irq_base; irq < irq_base + IPU_IRQ_NR_BANKS * 32; irq++) {
 		set_irq_flags(irq, 0);
-#endif
 		irq_set_chip(irq, NULL);
 		irq_set_chip_data(irq, NULL);
 	}
-- 
1.7.4.1
