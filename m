From: mperttunen@nvidia.com (Mikko Perttunen)
Date: Thu, 17 Aug 2017 21:54:12 +0300
Subject: [PATCH 5/6] gpu: host1x: Add Tegra186 support
In-Reply-To: <20170817185413.6324-1-mperttunen@nvidia.com>
References: <20170817185413.6324-1-mperttunen@nvidia.com>
Message-ID: <20170817185413.6324-6-mperttunen@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for the implementation of Host1x present on the Tegra186.
The register space has been shuffled around a little bit, requiring
addition of some chip-specific code sections. Tegra186 also adds
several new features, most importantly the hypervisor, but those are
not yet supported with this commit.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/gpu/host1x/Makefile                        |   3 +-
 drivers/gpu/host1x/dev.c                           |  60 ++++++-
 drivers/gpu/host1x/dev.h                           |   4 +
 drivers/gpu/host1x/hw/cdma_hw.c                    |  49 +++---
 drivers/gpu/host1x/hw/debug_hw.c                   | 137 +---------------
 .../gpu/host1x/hw/{debug_hw.c => debug_hw_1x01.c}  | 160 ------------------
 drivers/gpu/host1x/hw/debug_hw_1x06.c              | 133 +++++++++++++++
 drivers/gpu/host1x/hw/host1x01.c                   |   2 +
 drivers/gpu/host1x/hw/host1x02.c                   |   2 +
 drivers/gpu/host1x/hw/host1x04.c                   |   2 +
 drivers/gpu/host1x/hw/host1x05.c                   |   2 +
 drivers/gpu/host1x/hw/{host1x02.c => host1x06.c}   |  12 +-
 drivers/gpu/host1x/hw/{host1x02.c => host1x06.h}   |  30 +---
 drivers/gpu/host1x/hw/host1x06_hardware.h          | 142 ++++++++++++++++
 drivers/gpu/host1x/hw/hw_host1x06_hypervisor.h     |  32 ++++
 drivers/gpu/host1x/hw/hw_host1x06_uclass.h         | 181 +++++++++++++++++++++
 drivers/gpu/host1x/hw/hw_host1x06_vm.h             |  47 ++++++
 drivers/gpu/host1x/hw/intr_hw.c                    |  29 ++--
 18 files changed, 670 insertions(+), 357 deletions(-)
 copy drivers/gpu/host1x/hw/{debug_hw.c => debug_hw_1x01.c} (53%)
 create mode 100644 drivers/gpu/host1x/hw/debug_hw_1x06.c
 copy drivers/gpu/host1x/hw/{host1x02.c => host1x06.c} (84%)
 copy drivers/gpu/host1x/hw/{host1x02.c => host1x06.h} (50%)
 create mode 100644 drivers/gpu/host1x/hw/host1x06_hardware.h
 create mode 100644 drivers/gpu/host1x/hw/hw_host1x06_hypervisor.h
 create mode 100644 drivers/gpu/host1x/hw/hw_host1x06_uclass.h
 create mode 100644 drivers/gpu/host1x/hw/hw_host1x06_vm.h

diff --git a/drivers/gpu/host1x/Makefile b/drivers/gpu/host1x/Makefile
index a1d9974cfcb5..4fb61bd57aee 100644
--- a/drivers/gpu/host1x/Makefile
+++ b/drivers/gpu/host1x/Makefile
@@ -11,6 +11,7 @@ host1x-y = \
 	hw/host1x01.o \
 	hw/host1x02.o \
 	hw/host1x04.o \
-	hw/host1x05.o
+	hw/host1x05.o \
+	hw/host1x06.o
 
 obj-$(CONFIG_TEGRA_HOST1X) += host1x.o
diff --git a/drivers/gpu/host1x/dev.c b/drivers/gpu/host1x/dev.c
index 2c58a390123a..6a4ff2d59496 100644
--- a/drivers/gpu/host1x/dev.c
+++ b/drivers/gpu/host1x/dev.c
@@ -39,6 +39,17 @@
 #include "hw/host1x02.h"
 #include "hw/host1x04.h"
 #include "hw/host1x05.h"
+#include "hw/host1x06.h"
+
+void host1x_hypervisor_writel(struct host1x *host1x, u32 v, u32 r)
+{
+	writel(v, host1x->hv_regs + r);
+}
+
+u32 host1x_hypervisor_readl(struct host1x *host1x, u32 r)
+{
+	return readl(host1x->hv_regs + r);
+}
 
 void host1x_sync_writel(struct host1x *host1x, u32 v, u32 r)
 {
@@ -104,7 +115,19 @@ static const struct host1x_info host1x05_info = {
 	.dma_mask = DMA_BIT_MASK(34),
 };
 
+static const struct host1x_info host1x06_info = {
+	.nb_channels = 63,
+	.nb_pts = 576,
+	.nb_mlocks = 24,
+	.nb_bases = 16,
+	.init = host1x06_init,
+	.sync_offset = 0x0,
+	.dma_mask = DMA_BIT_MASK(34),
+	.has_hypervisor = true,
+};
+
 static const struct of_device_id host1x_of_match[] = {
+	{ .compatible = "nvidia,tegra186-host1x", .data = &host1x06_info, },
 	{ .compatible = "nvidia,tegra210-host1x", .data = &host1x05_info, },
 	{ .compatible = "nvidia,tegra124-host1x", .data = &host1x04_info, },
 	{ .compatible = "nvidia,tegra114-host1x", .data = &host1x02_info, },
@@ -117,8 +140,9 @@ MODULE_DEVICE_TABLE(of, host1x_of_match);
 static int host1x_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *id;
+	const struct host1x_info *info;
 	struct host1x *host;
-	struct resource *regs;
+	struct resource *regs, *hv_regs = NULL;
 	int syncpt_irq;
 	int err;
 
@@ -126,10 +150,28 @@ static int host1x_probe(struct platform_device *pdev)
 	if (!id)
 		return -EINVAL;
 
-	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!regs) {
-		dev_err(&pdev->dev, "failed to get registers\n");
-		return -ENXIO;
+	info = id->data;
+
+	if (info->has_hypervisor) {
+		regs = platform_get_resource_byname(pdev, IORESOURCE_MEM, "vm");
+		if (!regs) {
+			dev_err(&pdev->dev, "failed to get vm registers\n");
+			return -ENXIO;
+		}
+
+		hv_regs = platform_get_resource_byname(pdev, IORESOURCE_MEM,
+						       "hypervisor");
+		if (!hv_regs) {
+			dev_err(&pdev->dev,
+				"failed to get hypervisor registers\n");
+			return -ENXIO;
+		}
+	} else {
+		regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+		if (!regs) {
+			dev_err(&pdev->dev, "failed to get registers\n");
+			return -ENXIO;
+		}
 	}
 
 	syncpt_irq = platform_get_irq(pdev, 0);
@@ -146,7 +188,7 @@ static int host1x_probe(struct platform_device *pdev)
 	INIT_LIST_HEAD(&host->devices);
 	INIT_LIST_HEAD(&host->list);
 	host->dev = &pdev->dev;
-	host->info = id->data;
+	host->info = info;
 
 	/* set common host1x device data */
 	platform_set_drvdata(pdev, host);
@@ -155,6 +197,12 @@ static int host1x_probe(struct platform_device *pdev)
 	if (IS_ERR(host->regs))
 		return PTR_ERR(host->regs);
 
+	if (info->has_hypervisor) {
+		host->hv_regs = devm_ioremap_resource(&pdev->dev, hv_regs);
+		if (IS_ERR(host->hv_regs))
+			return PTR_ERR(host->hv_regs);
+	}
+
 	dma_set_mask_and_coherent(host->dev, host->info->dma_mask);
 
 	if (host->info->init) {
diff --git a/drivers/gpu/host1x/dev.h b/drivers/gpu/host1x/dev.h
index ffdbc15b749b..def802c0a6bf 100644
--- a/drivers/gpu/host1x/dev.h
+++ b/drivers/gpu/host1x/dev.h
@@ -100,12 +100,14 @@ struct host1x_info {
 	int (*init)(struct host1x *host1x); /* initialize per SoC ops */
 	unsigned int sync_offset; /* offset of syncpoint registers */
 	u64 dma_mask; /* mask of addressable memory */
+	bool has_hypervisor; /* has hypervisor registers */
 };
 
 struct host1x {
 	const struct host1x_info *info;
 
 	void __iomem *regs;
+	void __iomem *hv_regs; /* hypervisor region */
 	struct host1x_syncpt *syncpt;
 	struct host1x_syncpt_base *bases;
 	struct device *dev;
@@ -140,6 +142,8 @@ struct host1x {
 	struct list_head list;
 };
 
+void host1x_hypervisor_writel(struct host1x *host1x, u32 r, u32 v);
+u32 host1x_hypervisor_readl(struct host1x *host1x, u32 r);
 void host1x_sync_writel(struct host1x *host1x, u32 r, u32 v);
 u32 host1x_sync_readl(struct host1x *host1x, u32 r);
 void host1x_ch_writel(struct host1x_channel *ch, u32 r, u32 v);
diff --git a/drivers/gpu/host1x/hw/cdma_hw.c b/drivers/gpu/host1x/hw/cdma_hw.c
index 6b231119193e..ce320534cbed 100644
--- a/drivers/gpu/host1x/hw/cdma_hw.c
+++ b/drivers/gpu/host1x/hw/cdma_hw.c
@@ -172,6 +172,30 @@ static void cdma_stop(struct host1x_cdma *cdma)
 	mutex_unlock(&cdma->lock);
 }
 
+static void cdma_hw_cmdproc_stop(struct host1x *host, struct host1x_channel *ch,
+				 bool stop)
+{
+#if HOST1X_HW >= 6
+	host1x_ch_writel(ch, stop ? 0x1 : 0x0, HOST1X_CHANNEL_CMDPROC_STOP);
+#else
+	u32 cmdproc_stop = host1x_sync_readl(host, HOST1X_SYNC_CMDPROC_STOP);
+	if (stop)
+		cmdproc_stop |= BIT(ch->id);
+	else
+		cmdproc_stop &= ~BIT(ch->id);
+	host1x_sync_writel(host, cmdproc_stop, HOST1X_SYNC_CMDPROC_STOP);
+#endif
+}
+
+static void cdma_hw_teardown(struct host1x *host, struct host1x_channel *ch)
+{
+#if HOST1X_HW >= 6
+	host1x_ch_writel(ch, 0x1, HOST1X_CHANNEL_TEARDOWN);
+#else
+	host1x_sync_writel(host, BIT(ch->id), HOST1X_SYNC_CH_TEARDOWN);
+#endif
+}
+
 /*
  * Stops both channel's command processor and CDMA immediately.
  * Also, tears down the channel and resets corresponding module.
@@ -180,7 +204,6 @@ static void cdma_freeze(struct host1x_cdma *cdma)
 {
 	struct host1x *host = cdma_to_host1x(cdma);
 	struct host1x_channel *ch = cdma_to_channel(cdma);
-	u32 cmdproc_stop;
 
 	if (cdma->torndown && !cdma->running) {
 		dev_warn(host->dev, "Already torn down\n");
@@ -189,9 +212,7 @@ static void cdma_freeze(struct host1x_cdma *cdma)
 
 	dev_dbg(host->dev, "freezing channel (id %d)\n", ch->id);
 
-	cmdproc_stop = host1x_sync_readl(host, HOST1X_SYNC_CMDPROC_STOP);
-	cmdproc_stop |= BIT(ch->id);
-	host1x_sync_writel(host, cmdproc_stop, HOST1X_SYNC_CMDPROC_STOP);
+	cdma_hw_cmdproc_stop(host, ch, true);
 
 	dev_dbg(host->dev, "%s: DMA GET 0x%x, PUT HW 0x%x / shadow 0x%x\n",
 		__func__, host1x_ch_readl(ch, HOST1X_CHANNEL_DMAGET),
@@ -201,7 +222,7 @@ static void cdma_freeze(struct host1x_cdma *cdma)
 	host1x_ch_writel(ch, HOST1X_CHANNEL_DMACTRL_DMASTOP,
 			 HOST1X_CHANNEL_DMACTRL);
 
-	host1x_sync_writel(host, BIT(ch->id), HOST1X_SYNC_CH_TEARDOWN);
+	cdma_hw_teardown(host, ch);
 
 	cdma->running = false;
 	cdma->torndown = true;
@@ -211,15 +232,12 @@ static void cdma_resume(struct host1x_cdma *cdma, u32 getptr)
 {
 	struct host1x *host1x = cdma_to_host1x(cdma);
 	struct host1x_channel *ch = cdma_to_channel(cdma);
-	u32 cmdproc_stop;
 
 	dev_dbg(host1x->dev,
 		"resuming channel (id %u, DMAGET restart = 0x%x)\n",
 		ch->id, getptr);
 
-	cmdproc_stop = host1x_sync_readl(host1x, HOST1X_SYNC_CMDPROC_STOP);
-	cmdproc_stop &= ~BIT(ch->id);
-	host1x_sync_writel(host1x, cmdproc_stop, HOST1X_SYNC_CMDPROC_STOP);
+	cdma_hw_cmdproc_stop(host1x, ch, false);
 
 	cdma->torndown = false;
 	cdma_timeout_restart(cdma, getptr);
@@ -232,7 +250,7 @@ static void cdma_resume(struct host1x_cdma *cdma, u32 getptr)
  */
 static void cdma_timeout_handler(struct work_struct *work)
 {
-	u32 prev_cmdproc, cmdproc_stop, syncpt_val;
+	u32 syncpt_val;
 	struct host1x_cdma *cdma;
 	struct host1x *host1x;
 	struct host1x_channel *ch;
@@ -254,12 +272,7 @@ static void cdma_timeout_handler(struct work_struct *work)
 	}
 
 	/* stop processing to get a clean snapshot */
-	prev_cmdproc = host1x_sync_readl(host1x, HOST1X_SYNC_CMDPROC_STOP);
-	cmdproc_stop = prev_cmdproc | BIT(ch->id);
-	host1x_sync_writel(host1x, cmdproc_stop, HOST1X_SYNC_CMDPROC_STOP);
-
-	dev_dbg(host1x->dev, "cdma_timeout: cmdproc was 0x%x is 0x%x\n",
-		prev_cmdproc, cmdproc_stop);
+	cdma_hw_cmdproc_stop(host1x, ch, true);
 
 	syncpt_val = host1x_syncpt_load(cdma->timeout.syncpt);
 
@@ -268,9 +281,7 @@ static void cdma_timeout_handler(struct work_struct *work)
 		dev_dbg(host1x->dev,
 			"cdma_timeout: expired, but buffer had completed\n");
 		/* restore */
-		cmdproc_stop = prev_cmdproc & ~(BIT(ch->id));
-		host1x_sync_writel(host1x, cmdproc_stop,
-				   HOST1X_SYNC_CMDPROC_STOP);
+		cdma_hw_cmdproc_stop(host1x, ch, false);
 		mutex_unlock(&cdma->lock);
 		return;
 	}
diff --git a/drivers/gpu/host1x/hw/debug_hw.c b/drivers/gpu/host1x/hw/debug_hw.c
index 7a4a3286e4a7..770d92e62d69 100644
--- a/drivers/gpu/host1x/hw/debug_hw.c
+++ b/drivers/gpu/host1x/hw/debug_hw.c
@@ -174,138 +174,11 @@ static void show_channel_gathers(struct output *o, struct host1x_cdma *cdma)
 	}
 }
 
-static void host1x_debug_show_channel_cdma(struct host1x *host,
-					   struct host1x_channel *ch,
-					   struct output *o)
-{
-	struct host1x_cdma *cdma = &ch->cdma;
-	u32 dmaput, dmaget, dmactrl;
-	u32 cbstat, cbread;
-	u32 val, base, baseval;
-
-	dmaput = host1x_ch_readl(ch, HOST1X_CHANNEL_DMAPUT);
-	dmaget = host1x_ch_readl(ch, HOST1X_CHANNEL_DMAGET);
-	dmactrl = host1x_ch_readl(ch, HOST1X_CHANNEL_DMACTRL);
-	cbread = host1x_sync_readl(host, HOST1X_SYNC_CBREAD(ch->id));
-	cbstat = host1x_sync_readl(host, HOST1X_SYNC_CBSTAT(ch->id));
-
-	host1x_debug_output(o, "%u-%s: ", ch->id, dev_name(ch->dev));
-
-	if (HOST1X_CHANNEL_DMACTRL_DMASTOP_V(dmactrl) ||
-	    !ch->cdma.push_buffer.mapped) {
-		host1x_debug_output(o, "inactive\n\n");
-		return;
-	}
-
-	if (HOST1X_SYNC_CBSTAT_CBCLASS_V(cbstat) == HOST1X_CLASS_HOST1X &&
-	    HOST1X_SYNC_CBSTAT_CBOFFSET_V(cbstat) ==
-			HOST1X_UCLASS_WAIT_SYNCPT)
-		host1x_debug_output(o, "waiting on syncpt %d val %d\n",
-				    cbread >> 24, cbread & 0xffffff);
-	else if (HOST1X_SYNC_CBSTAT_CBCLASS_V(cbstat) ==
-				HOST1X_CLASS_HOST1X &&
-		 HOST1X_SYNC_CBSTAT_CBOFFSET_V(cbstat) ==
-				HOST1X_UCLASS_WAIT_SYNCPT_BASE) {
-		base = (cbread >> 16) & 0xff;
-		baseval =
-			host1x_sync_readl(host, HOST1X_SYNC_SYNCPT_BASE(base));
-		val = cbread & 0xffff;
-		host1x_debug_output(o, "waiting on syncpt %d val %d (base %d = %d; offset = %d)\n",
-				    cbread >> 24, baseval + val, base,
-				    baseval, val);
-	} else
-		host1x_debug_output(o, "active class %02x, offset %04x, val %08x\n",
-				    HOST1X_SYNC_CBSTAT_CBCLASS_V(cbstat),
-				    HOST1X_SYNC_CBSTAT_CBOFFSET_V(cbstat),
-				    cbread);
-
-	host1x_debug_output(o, "DMAPUT %08x, DMAGET %08x, DMACTL %08x\n",
-			    dmaput, dmaget, dmactrl);
-	host1x_debug_output(o, "CBREAD %08x, CBSTAT %08x\n", cbread, cbstat);
-
-	show_channel_gathers(o, cdma);
-	host1x_debug_output(o, "\n");
-}
-
-static void host1x_debug_show_channel_fifo(struct host1x *host,
-					   struct host1x_channel *ch,
-					   struct output *o)
-{
-	u32 val, rd_ptr, wr_ptr, start, end;
-	unsigned int data_count = 0;
-
-	host1x_debug_output(o, "%u: fifo:\n", ch->id);
-
-	val = host1x_ch_readl(ch, HOST1X_CHANNEL_FIFOSTAT);
-	host1x_debug_output(o, "FIFOSTAT %08x\n", val);
-	if (HOST1X_CHANNEL_FIFOSTAT_CFEMPTY_V(val)) {
-		host1x_debug_output(o, "[empty]\n");
-		return;
-	}
-
-	host1x_sync_writel(host, 0x0, HOST1X_SYNC_CFPEEK_CTRL);
-	host1x_sync_writel(host, HOST1X_SYNC_CFPEEK_CTRL_ENA_F(1) |
-			   HOST1X_SYNC_CFPEEK_CTRL_CHANNR_F(ch->id),
-			   HOST1X_SYNC_CFPEEK_CTRL);
-
-	val = host1x_sync_readl(host, HOST1X_SYNC_CFPEEK_PTRS);
-	rd_ptr = HOST1X_SYNC_CFPEEK_PTRS_CF_RD_PTR_V(val);
-	wr_ptr = HOST1X_SYNC_CFPEEK_PTRS_CF_WR_PTR_V(val);
-
-	val = host1x_sync_readl(host, HOST1X_SYNC_CF_SETUP(ch->id));
-	start = HOST1X_SYNC_CF_SETUP_BASE_V(val);
-	end = HOST1X_SYNC_CF_SETUP_LIMIT_V(val);
-
-	do {
-		host1x_sync_writel(host, 0x0, HOST1X_SYNC_CFPEEK_CTRL);
-		host1x_sync_writel(host, HOST1X_SYNC_CFPEEK_CTRL_ENA_F(1) |
-				   HOST1X_SYNC_CFPEEK_CTRL_CHANNR_F(ch->id) |
-				   HOST1X_SYNC_CFPEEK_CTRL_ADDR_F(rd_ptr),
-				   HOST1X_SYNC_CFPEEK_CTRL);
-		val = host1x_sync_readl(host, HOST1X_SYNC_CFPEEK_READ);
-
-		if (!data_count) {
-			host1x_debug_output(o, "%08x:", val);
-			data_count = show_channel_command(o, val);
-		} else {
-			host1x_debug_output(o, "%08x%s", val,
-					    data_count > 0 ? ", " : "])\n");
-			data_count--;
-		}
-
-		if (rd_ptr == end)
-			rd_ptr = start;
-		else
-			rd_ptr++;
-	} while (rd_ptr != wr_ptr);
-
-	if (data_count)
-		host1x_debug_output(o, ", ...])\n");
-	host1x_debug_output(o, "\n");
-
-	host1x_sync_writel(host, 0x0, HOST1X_SYNC_CFPEEK_CTRL);
-}
-
-static void host1x_debug_show_mlocks(struct host1x *host, struct output *o)
-{
-	unsigned int i;
-
-	host1x_debug_output(o, "---- mlocks ----\n");
-
-	for (i = 0; i < host1x_syncpt_nb_mlocks(host); i++) {
-		u32 owner =
-			host1x_sync_readl(host, HOST1X_SYNC_MLOCK_OWNER(i));
-		if (HOST1X_SYNC_MLOCK_OWNER_CH_OWNS_V(owner))
-			host1x_debug_output(o, "%u: locked by channel %u\n",
-				i, HOST1X_SYNC_MLOCK_OWNER_CHID_V(owner));
-		else if (HOST1X_SYNC_MLOCK_OWNER_CPU_OWNS_V(owner))
-			host1x_debug_output(o, "%u: locked by cpu\n", i);
-		else
-			host1x_debug_output(o, "%u: unlocked\n", i);
-	}
-
-	host1x_debug_output(o, "\n");
-}
+#if HOST1X_HW >= 6
+#include "debug_hw_1x06.c"
+#else
+#include "debug_hw_1x01.c"
+#endif
 
 static const struct host1x_debug_ops host1x_debug_ops = {
 	.show_channel_cdma = host1x_debug_show_channel_cdma,
diff --git a/drivers/gpu/host1x/hw/debug_hw.c b/drivers/gpu/host1x/hw/debug_hw_1x01.c
similarity index 53%
copy from drivers/gpu/host1x/hw/debug_hw.c
copy to drivers/gpu/host1x/hw/debug_hw_1x01.c
index 7a4a3286e4a7..8f243903cc7f 100644
--- a/drivers/gpu/host1x/hw/debug_hw.c
+++ b/drivers/gpu/host1x/hw/debug_hw_1x01.c
@@ -20,160 +20,6 @@
 #include "../cdma.h"
 #include "../channel.h"
 
-#define HOST1X_DEBUG_MAX_PAGE_OFFSET 102400
-
-enum {
-	HOST1X_OPCODE_SETCLASS	= 0x00,
-	HOST1X_OPCODE_INCR	= 0x01,
-	HOST1X_OPCODE_NONINCR	= 0x02,
-	HOST1X_OPCODE_MASK	= 0x03,
-	HOST1X_OPCODE_IMM	= 0x04,
-	HOST1X_OPCODE_RESTART	= 0x05,
-	HOST1X_OPCODE_GATHER	= 0x06,
-	HOST1X_OPCODE_EXTEND	= 0x0e,
-};
-
-enum {
-	HOST1X_OPCODE_EXTEND_ACQUIRE_MLOCK	= 0x00,
-	HOST1X_OPCODE_EXTEND_RELEASE_MLOCK	= 0x01,
-};
-
-static unsigned int show_channel_command(struct output *o, u32 val)
-{
-	unsigned int mask, subop;
-
-	switch (val >> 28) {
-	case HOST1X_OPCODE_SETCLASS:
-		mask = val & 0x3f;
-		if (mask) {
-			host1x_debug_output(o, "SETCL(class=%03x, offset=%03x, mask=%02x, [",
-					    val >> 6 & 0x3ff,
-					    val >> 16 & 0xfff, mask);
-			return hweight8(mask);
-		}
-
-		host1x_debug_output(o, "SETCL(class=%03x)\n", val >> 6 & 0x3ff);
-		return 0;
-
-	case HOST1X_OPCODE_INCR:
-		host1x_debug_output(o, "INCR(offset=%03x, [",
-				    val >> 16 & 0xfff);
-		return val & 0xffff;
-
-	case HOST1X_OPCODE_NONINCR:
-		host1x_debug_output(o, "NONINCR(offset=%03x, [",
-				    val >> 16 & 0xfff);
-		return val & 0xffff;
-
-	case HOST1X_OPCODE_MASK:
-		mask = val & 0xffff;
-		host1x_debug_output(o, "MASK(offset=%03x, mask=%03x, [",
-				    val >> 16 & 0xfff, mask);
-		return hweight16(mask);
-
-	case HOST1X_OPCODE_IMM:
-		host1x_debug_output(o, "IMM(offset=%03x, data=%03x)\n",
-				    val >> 16 & 0xfff, val & 0xffff);
-		return 0;
-
-	case HOST1X_OPCODE_RESTART:
-		host1x_debug_output(o, "RESTART(offset=%08x)\n", val << 4);
-		return 0;
-
-	case HOST1X_OPCODE_GATHER:
-		host1x_debug_output(o, "GATHER(offset=%03x, insert=%d, type=%d, count=%04x, addr=[",
-				    val >> 16 & 0xfff, val >> 15 & 0x1,
-				    val >> 14 & 0x1, val & 0x3fff);
-		return 1;
-
-	case HOST1X_OPCODE_EXTEND:
-		subop = val >> 24 & 0xf;
-		if (subop == HOST1X_OPCODE_EXTEND_ACQUIRE_MLOCK)
-			host1x_debug_output(o, "ACQUIRE_MLOCK(index=%d)\n",
-					    val & 0xff);
-		else if (subop == HOST1X_OPCODE_EXTEND_RELEASE_MLOCK)
-			host1x_debug_output(o, "RELEASE_MLOCK(index=%d)\n",
-					    val & 0xff);
-		else
-			host1x_debug_output(o, "EXTEND_UNKNOWN(%08x)\n", val);
-		return 0;
-
-	default:
-		return 0;
-	}
-}
-
-static void show_gather(struct output *o, phys_addr_t phys_addr,
-			unsigned int words, struct host1x_cdma *cdma,
-			phys_addr_t pin_addr, u32 *map_addr)
-{
-	/* Map dmaget cursor to corresponding mem handle */
-	u32 offset = phys_addr - pin_addr;
-	unsigned int data_count = 0, i;
-
-	/*
-	 * Sometimes we're given different hardware address to the same
-	 * page - in these cases the offset will get an invalid number and
-	 * we just have to bail out.
-	 */
-	if (offset > HOST1X_DEBUG_MAX_PAGE_OFFSET) {
-		host1x_debug_output(o, "[address mismatch]\n");
-		return;
-	}
-
-	for (i = 0; i < words; i++) {
-		u32 addr = phys_addr + i * 4;
-		u32 val = *(map_addr + offset / 4 + i);
-
-		if (!data_count) {
-			host1x_debug_output(o, "%08x: %08x:", addr, val);
-			data_count = show_channel_command(o, val);
-		} else {
-			host1x_debug_output(o, "%08x%s", val,
-					    data_count > 0 ? ", " : "])\n");
-			data_count--;
-		}
-	}
-}
-
-static void show_channel_gathers(struct output *o, struct host1x_cdma *cdma)
-{
-	struct host1x_job *job;
-
-	list_for_each_entry(job, &cdma->sync_queue, list) {
-		unsigned int i;
-
-		host1x_debug_output(o, "\n%p: JOB, syncpt_id=%d, syncpt_val=%d, first_get=%08x, timeout=%d num_slots=%d, num_handles=%d\n",
-				    job, job->syncpt_id, job->syncpt_end,
-				    job->first_get, job->timeout,
-				    job->num_slots, job->num_unpins);
-
-		for (i = 0; i < job->num_gathers; i++) {
-			struct host1x_job_gather *g = &job->gathers[i];
-			u32 *mapped;
-
-			if (job->gather_copy_mapped)
-				mapped = (u32 *)job->gather_copy_mapped;
-			else
-				mapped = host1x_bo_mmap(g->bo);
-
-			if (!mapped) {
-				host1x_debug_output(o, "[could not mmap]\n");
-				continue;
-			}
-
-			host1x_debug_output(o, "    GATHER at %pad+%#x, %d words\n",
-					    &g->base, g->offset, g->words);
-
-			show_gather(o, g->base + g->offset, g->words, cdma,
-				    g->base, mapped);
-
-			if (!job->gather_copy_mapped)
-				host1x_bo_munmap(g->bo, mapped);
-		}
-	}
-}
-
 static void host1x_debug_show_channel_cdma(struct host1x *host,
 					   struct host1x_channel *ch,
 					   struct output *o)
@@ -306,9 +152,3 @@ static void host1x_debug_show_mlocks(struct host1x *host, struct output *o)
 
 	host1x_debug_output(o, "\n");
 }
-
-static const struct host1x_debug_ops host1x_debug_ops = {
-	.show_channel_cdma = host1x_debug_show_channel_cdma,
-	.show_channel_fifo = host1x_debug_show_channel_fifo,
-	.show_mlocks = host1x_debug_show_mlocks,
-};
diff --git a/drivers/gpu/host1x/hw/debug_hw_1x06.c b/drivers/gpu/host1x/hw/debug_hw_1x06.c
new file mode 100644
index 000000000000..9cdee657fb46
--- /dev/null
+++ b/drivers/gpu/host1x/hw/debug_hw_1x06.c
@@ -0,0 +1,133 @@
+/*
+ * Copyright (C) 2010 Google, Inc.
+ * Author: Erik Gilling <konkers@android.com>
+ *
+ * Copyright (C) 2011-2017 NVIDIA Corporation
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include "../dev.h"
+#include "../debug.h"
+#include "../cdma.h"
+#include "../channel.h"
+
+static void host1x_debug_show_channel_cdma(struct host1x *host,
+					   struct host1x_channel *ch,
+					   struct output *o)
+{
+	struct host1x_cdma *cdma = &ch->cdma;
+	u32 dmaput, dmaget, dmactrl;
+	u32 offset, class;
+	u32 ch_stat;
+
+	dmaput = host1x_ch_readl(ch, HOST1X_CHANNEL_DMAPUT);
+	dmaget = host1x_ch_readl(ch, HOST1X_CHANNEL_DMAGET);
+	dmactrl = host1x_ch_readl(ch, HOST1X_CHANNEL_DMACTRL);
+	offset = host1x_ch_readl(ch, HOST1X_CHANNEL_CMDP_OFFSET);
+	class = host1x_ch_readl(ch, HOST1X_CHANNEL_CMDP_CLASS);
+	ch_stat = host1x_ch_readl(ch, HOST1X_CHANNEL_CHANNELSTAT);
+
+	host1x_debug_output(o, "%u-%s: ", ch->id, dev_name(ch->dev));
+
+	if (dmactrl & HOST1X_CHANNEL_DMACTRL_DMASTOP ||
+	    !ch->cdma.push_buffer.mapped) {
+		host1x_debug_output(o, "inactive\n\n");
+		return;
+	}
+
+	if (class == HOST1X_CLASS_HOST1X && offset == HOST1X_UCLASS_WAIT_SYNCPT)
+		host1x_debug_output(o, "waiting on syncpt\n");
+	else
+		host1x_debug_output(o, "active class %02x, offset %04x\n",
+				    class, offset);
+
+	host1x_debug_output(o, "DMAPUT %08x, DMAGET %08x, DMACTL %08x\n",
+			    dmaput, dmaget, dmactrl);
+	host1x_debug_output(o, "CHANNELSTAT %02x\n", ch_stat);
+
+	show_channel_gathers(o, cdma);
+	host1x_debug_output(o, "\n");
+}
+
+static void host1x_debug_show_channel_fifo(struct host1x *host,
+					   struct host1x_channel *ch,
+					   struct output *o)
+{
+	u32 val, rd_ptr, wr_ptr, start, end;
+	unsigned int data_count = 0;
+
+	host1x_debug_output(o, "%u: fifo:\n", ch->id);
+
+	val = host1x_ch_readl(ch, HOST1X_CHANNEL_CMDFIFO_STAT);
+	host1x_debug_output(o, "CMDFIFO_STAT %08x\n", val);
+	if (val & HOST1X_CHANNEL_CMDFIFO_STAT_EMPTY) {
+		host1x_debug_output(o, "[empty]\n");
+		return;
+	}
+
+	val = host1x_ch_readl(ch, HOST1X_CHANNEL_CMDFIFO_RDATA);
+	host1x_debug_output(o, "CMDFIFO_RDATA %08x\n", val);
+
+	/* Peek pointer values are invalid during SLCG, so disable it */
+	host1x_hypervisor_writel(host, 0x1, HOST1X_HV_ICG_EN_OVERRIDE);
+
+	val = 0;
+	val |= HOST1X_HV_CMDFIFO_PEEK_CTRL_ENABLE;
+	val |= HOST1X_HV_CMDFIFO_PEEK_CTRL_CHANNEL(ch->id);
+	host1x_hypervisor_writel(host, val, HOST1X_HV_CMDFIFO_PEEK_CTRL);
+
+	val = host1x_hypervisor_readl(host, HOST1X_HV_CMDFIFO_PEEK_PTRS);
+	rd_ptr = HOST1X_HV_CMDFIFO_PEEK_PTRS_RD_PTR_V(val);
+	wr_ptr = HOST1X_HV_CMDFIFO_PEEK_PTRS_WR_PTR_V(val);
+
+	val = host1x_hypervisor_readl(host, HOST1X_HV_CMDFIFO_SETUP(ch->id));
+	start = HOST1X_HV_CMDFIFO_SETUP_BASE_V(val);
+	end = HOST1X_HV_CMDFIFO_SETUP_LIMIT_V(val);
+
+	do {
+		val = 0;
+		val |= HOST1X_HV_CMDFIFO_PEEK_CTRL_ENABLE;
+		val |= HOST1X_HV_CMDFIFO_PEEK_CTRL_CHANNEL(ch->id);
+		val |= HOST1X_HV_CMDFIFO_PEEK_CTRL_ADDR(rd_ptr);
+		host1x_hypervisor_writel(host, val,
+					 HOST1X_HV_CMDFIFO_PEEK_CTRL);
+
+		val = host1x_hypervisor_readl(host,
+					      HOST1X_HV_CMDFIFO_PEEK_READ);
+
+		if (!data_count) {
+			host1x_debug_output(o, "%08x:", val);
+			data_count = show_channel_command(o, val);
+		} else {
+			host1x_debug_output(o, "%08x%s", val,
+					    data_count > 0 ? ", " : "])\n");
+			data_count--;
+		}
+
+		if (rd_ptr == end)
+			rd_ptr = start;
+		else
+			rd_ptr++;
+	} while (rd_ptr != wr_ptr);
+
+	if (data_count)
+		host1x_debug_output(o, ", ...])\n");
+	host1x_debug_output(o, "\n");
+
+	host1x_hypervisor_writel(host, 0x0, HOST1X_HV_CMDFIFO_PEEK_CTRL);
+	host1x_hypervisor_writel(host, 0x0, HOST1X_HV_ICG_EN_OVERRIDE);
+}
+
+static void host1x_debug_show_mlocks(struct host1x *host, struct output *o)
+{
+	/* TODO */
+}
diff --git a/drivers/gpu/host1x/hw/host1x01.c b/drivers/gpu/host1x/hw/host1x01.c
index 859b73beb4d0..bb124f8b4af8 100644
--- a/drivers/gpu/host1x/hw/host1x01.c
+++ b/drivers/gpu/host1x/hw/host1x01.c
@@ -21,6 +21,8 @@
 #include "host1x01_hardware.h"
 
 /* include code */
+#define HOST1X_HW 1
+
 #include "cdma_hw.c"
 #include "channel_hw.c"
 #include "debug_hw.c"
diff --git a/drivers/gpu/host1x/hw/host1x02.c b/drivers/gpu/host1x/hw/host1x02.c
index 928946c2144b..c5f85dbedb98 100644
--- a/drivers/gpu/host1x/hw/host1x02.c
+++ b/drivers/gpu/host1x/hw/host1x02.c
@@ -21,6 +21,8 @@
 #include "host1x02_hardware.h"
 
 /* include code */
+#define HOST1X_HW 2
+
 #include "cdma_hw.c"
 #include "channel_hw.c"
 #include "debug_hw.c"
diff --git a/drivers/gpu/host1x/hw/host1x04.c b/drivers/gpu/host1x/hw/host1x04.c
index 8007c70fa9c4..f102a1a7743f 100644
--- a/drivers/gpu/host1x/hw/host1x04.c
+++ b/drivers/gpu/host1x/hw/host1x04.c
@@ -21,6 +21,8 @@
 #include "host1x04_hardware.h"
 
 /* include code */
+#define HOST1X_HW 4
+
 #include "cdma_hw.c"
 #include "channel_hw.c"
 #include "debug_hw.c"
diff --git a/drivers/gpu/host1x/hw/host1x05.c b/drivers/gpu/host1x/hw/host1x05.c
index 047097ce3bad..2b1239d6ec67 100644
--- a/drivers/gpu/host1x/hw/host1x05.c
+++ b/drivers/gpu/host1x/hw/host1x05.c
@@ -21,6 +21,8 @@
 #include "host1x05_hardware.h"
 
 /* include code */
+#define HOST1X_HW 5
+
 #include "cdma_hw.c"
 #include "channel_hw.c"
 #include "debug_hw.c"
diff --git a/drivers/gpu/host1x/hw/host1x02.c b/drivers/gpu/host1x/hw/host1x06.c
similarity index 84%
copy from drivers/gpu/host1x/hw/host1x02.c
copy to drivers/gpu/host1x/hw/host1x06.c
index 928946c2144b..a66230827c59 100644
--- a/drivers/gpu/host1x/hw/host1x02.c
+++ b/drivers/gpu/host1x/hw/host1x06.c
@@ -1,7 +1,7 @@
 /*
- * Host1x init for Tegra114 SoCs
+ * Host1x init for Tegra186 SoCs
  *
- * Copyright (c) 2013 NVIDIA Corporation.
+ * Copyright (c) 2017 NVIDIA Corporation.
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms and conditions of the GNU General Public License,
@@ -17,10 +17,12 @@
  */
 
 /* include hw specification */
-#include "host1x02.h"
-#include "host1x02_hardware.h"
+#include "host1x06.h"
+#include "host1x06_hardware.h"
 
 /* include code */
+#define HOST1X_HW 6
+
 #include "cdma_hw.c"
 #include "channel_hw.c"
 #include "debug_hw.c"
@@ -29,7 +31,7 @@
 
 #include "../dev.h"
 
-int host1x02_init(struct host1x *host)
+int host1x06_init(struct host1x *host)
 {
 	host->channel_op = &host1x_channel_ops;
 	host->cdma_op = &host1x_cdma_ops;
diff --git a/drivers/gpu/host1x/hw/host1x02.c b/drivers/gpu/host1x/hw/host1x06.h
similarity index 50%
copy from drivers/gpu/host1x/hw/host1x02.c
copy to drivers/gpu/host1x/hw/host1x06.h
index 928946c2144b..d9abe1489241 100644
--- a/drivers/gpu/host1x/hw/host1x02.c
+++ b/drivers/gpu/host1x/hw/host1x06.h
@@ -1,7 +1,7 @@
 /*
- * Host1x init for Tegra114 SoCs
+ * Host1x init for Tegra186 SoCs
  *
- * Copyright (c) 2013 NVIDIA Corporation.
+ * Copyright (c) 2017 NVIDIA Corporation.
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms and conditions of the GNU General Public License,
@@ -16,27 +16,11 @@
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
-/* include hw specification */
-#include "host1x02.h"
-#include "host1x02_hardware.h"
+#ifndef HOST1X_HOST1X06_H
+#define HOST1X_HOST1X06_H
 
-/* include code */
-#include "cdma_hw.c"
-#include "channel_hw.c"
-#include "debug_hw.c"
-#include "intr_hw.c"
-#include "syncpt_hw.c"
+struct host1x;
 
-#include "../dev.h"
+int host1x06_init(struct host1x *host);
 
-int host1x02_init(struct host1x *host)
-{
-	host->channel_op = &host1x_channel_ops;
-	host->cdma_op = &host1x_cdma_ops;
-	host->cdma_pb_op = &host1x_pushbuffer_ops;
-	host->syncpt_op = &host1x_syncpt_ops;
-	host->intr_op = &host1x_intr_ops;
-	host->debug_op = &host1x_debug_ops;
-
-	return 0;
-}
+#endif
diff --git a/drivers/gpu/host1x/hw/host1x06_hardware.h b/drivers/gpu/host1x/hw/host1x06_hardware.h
new file mode 100644
index 000000000000..3039c92ea605
--- /dev/null
+++ b/drivers/gpu/host1x/hw/host1x06_hardware.h
@@ -0,0 +1,142 @@
+/*
+ * Tegra host1x Register Offsets for Tegra186
+ *
+ * Copyright (c) 2017 NVIDIA Corporation.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef __HOST1X_HOST1X06_HARDWARE_H
+#define __HOST1X_HOST1X06_HARDWARE_H
+
+#include <linux/types.h>
+#include <linux/bitops.h>
+
+#include "hw_host1x06_uclass.h"
+#include "hw_host1x06_vm.h"
+#include "hw_host1x06_hypervisor.h"
+
+static inline u32 host1x_class_host_wait_syncpt(
+	unsigned indx, unsigned threshold)
+{
+	return host1x_uclass_wait_syncpt_indx_f(indx)
+		| host1x_uclass_wait_syncpt_thresh_f(threshold);
+}
+
+static inline u32 host1x_class_host_load_syncpt_base(
+	unsigned indx, unsigned threshold)
+{
+	return host1x_uclass_load_syncpt_base_base_indx_f(indx)
+		| host1x_uclass_load_syncpt_base_value_f(threshold);
+}
+
+static inline u32 host1x_class_host_wait_syncpt_base(
+	unsigned indx, unsigned base_indx, unsigned offset)
+{
+	return host1x_uclass_wait_syncpt_base_indx_f(indx)
+		| host1x_uclass_wait_syncpt_base_base_indx_f(base_indx)
+		| host1x_uclass_wait_syncpt_base_offset_f(offset);
+}
+
+static inline u32 host1x_class_host_incr_syncpt_base(
+	unsigned base_indx, unsigned offset)
+{
+	return host1x_uclass_incr_syncpt_base_base_indx_f(base_indx)
+		| host1x_uclass_incr_syncpt_base_offset_f(offset);
+}
+
+static inline u32 host1x_class_host_incr_syncpt(
+	unsigned cond, unsigned indx)
+{
+	return host1x_uclass_incr_syncpt_cond_f(cond)
+		| host1x_uclass_incr_syncpt_indx_f(indx);
+}
+
+static inline u32 host1x_class_host_indoff_reg_write(
+	unsigned mod_id, unsigned offset, bool auto_inc)
+{
+	u32 v = host1x_uclass_indoff_indbe_f(0xf)
+		| host1x_uclass_indoff_indmodid_f(mod_id)
+		| host1x_uclass_indoff_indroffset_f(offset);
+	if (auto_inc)
+		v |= host1x_uclass_indoff_autoinc_f(1);
+	return v;
+}
+
+static inline u32 host1x_class_host_indoff_reg_read(
+	unsigned mod_id, unsigned offset, bool auto_inc)
+{
+	u32 v = host1x_uclass_indoff_indmodid_f(mod_id)
+		| host1x_uclass_indoff_indroffset_f(offset)
+		| host1x_uclass_indoff_rwn_read_v();
+	if (auto_inc)
+		v |= host1x_uclass_indoff_autoinc_f(1);
+	return v;
+}
+
+/* cdma opcodes */
+static inline u32 host1x_opcode_setclass(
+	unsigned class_id, unsigned offset, unsigned mask)
+{
+	return (0 << 28) | (offset << 16) | (class_id << 6) | mask;
+}
+
+static inline u32 host1x_opcode_incr(unsigned offset, unsigned count)
+{
+	return (1 << 28) | (offset << 16) | count;
+}
+
+static inline u32 host1x_opcode_nonincr(unsigned offset, unsigned count)
+{
+	return (2 << 28) | (offset << 16) | count;
+}
+
+static inline u32 host1x_opcode_mask(unsigned offset, unsigned mask)
+{
+	return (3 << 28) | (offset << 16) | mask;
+}
+
+static inline u32 host1x_opcode_imm(unsigned offset, unsigned value)
+{
+	return (4 << 28) | (offset << 16) | value;
+}
+
+static inline u32 host1x_opcode_imm_incr_syncpt(unsigned cond, unsigned indx)
+{
+	return host1x_opcode_imm(host1x_uclass_incr_syncpt_r(),
+		host1x_class_host_incr_syncpt(cond, indx));
+}
+
+static inline u32 host1x_opcode_restart(unsigned address)
+{
+	return (5 << 28) | (address >> 4);
+}
+
+static inline u32 host1x_opcode_gather(unsigned count)
+{
+	return (6 << 28) | count;
+}
+
+static inline u32 host1x_opcode_gather_nonincr(unsigned offset,	unsigned count)
+{
+	return (6 << 28) | (offset << 16) | BIT(15) | count;
+}
+
+static inline u32 host1x_opcode_gather_incr(unsigned offset, unsigned count)
+{
+	return (6 << 28) | (offset << 16) | BIT(15) | BIT(14) | count;
+}
+
+#define HOST1X_OPCODE_NOP host1x_opcode_nonincr(0, 0)
+
+#endif
diff --git a/drivers/gpu/host1x/hw/hw_host1x06_hypervisor.h b/drivers/gpu/host1x/hw/hw_host1x06_hypervisor.h
new file mode 100644
index 000000000000..c05dab8a178b
--- /dev/null
+++ b/drivers/gpu/host1x/hw/hw_host1x06_hypervisor.h
@@ -0,0 +1,32 @@
+/*
+ * Copyright (c) 2017 NVIDIA Corporation.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ *
+ */
+
+#define HOST1X_HV_SYNCPT_PROT_EN			0x1ac4
+#define HOST1X_HV_SYNCPT_PROT_EN_CH_EN			BIT(1)
+#define HOST1X_HV_CH_KERNEL_FILTER_GBUFFER(x)		(0x2020 + (x * 4))
+#define HOST1X_HV_CMDFIFO_PEEK_CTRL			0x233c
+#define HOST1X_HV_CMDFIFO_PEEK_CTRL_ADDR(x)		(x)
+#define HOST1X_HV_CMDFIFO_PEEK_CTRL_CHANNEL(x)		((x) << 16)
+#define HOST1X_HV_CMDFIFO_PEEK_CTRL_ENABLE		BIT(31)
+#define HOST1X_HV_CMDFIFO_PEEK_READ			0x2340
+#define HOST1X_HV_CMDFIFO_PEEK_PTRS			0x2344
+#define HOST1X_HV_CMDFIFO_PEEK_PTRS_WR_PTR_V(x)		(((x) >> 16) & 0xfff)
+#define HOST1X_HV_CMDFIFO_PEEK_PTRS_RD_PTR_V(x)		((x) & 0xfff)
+#define HOST1X_HV_CMDFIFO_SETUP(x)			(0x2588 + (x * 4))
+#define HOST1X_HV_CMDFIFO_SETUP_LIMIT_V(x)		(((x) >> 16) & 0xfff)
+#define HOST1X_HV_CMDFIFO_SETUP_BASE_V(x)		((x) & 0xfff)
+#define HOST1X_HV_ICG_EN_OVERRIDE			0x2aa8
diff --git a/drivers/gpu/host1x/hw/hw_host1x06_uclass.h b/drivers/gpu/host1x/hw/hw_host1x06_uclass.h
new file mode 100644
index 000000000000..4457486c72b0
--- /dev/null
+++ b/drivers/gpu/host1x/hw/hw_host1x06_uclass.h
@@ -0,0 +1,181 @@
+/*
+ * Copyright (c) 2017 NVIDIA Corporation.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ *
+ */
+
+ /*
+  * Function naming determines intended use:
+  *
+  *     <x>_r(void) : Returns the offset for register <x>.
+  *
+  *     <x>_w(void) : Returns the word offset for word (4 byte) element <x>.
+  *
+  *     <x>_<y>_s(void) : Returns size of field <y> of register <x> in bits.
+  *
+  *     <x>_<y>_f(u32 v) : Returns a value based on 'v' which has been shifted
+  *         and masked to place it at field <y> of register <x>.  This value
+  *         can be |'d with others to produce a full register value for
+  *         register <x>.
+  *
+  *     <x>_<y>_m(void) : Returns a mask for field <y> of register <x>.  This
+  *         value can be ~'d and then &'d to clear the value of field <y> for
+  *         register <x>.
+  *
+  *     <x>_<y>_<z>_f(void) : Returns the constant value <z> after being shifted
+  *         to place it at field <y> of register <x>.  This value can be |'d
+  *         with others to produce a full register value for <x>.
+  *
+  *     <x>_<y>_v(u32 r) : Returns the value of field <y> from a full register
+  *         <x> value 'r' after being shifted to place its LSB at bit 0.
+  *         This value is suitable for direct comparison with other unshifted
+  *         values appropriate for use in field <y> of register <x>.
+  *
+  *     <x>_<y>_<z>_v(void) : Returns the constant value for <z> defined for
+  *         field <y> of register <x>.  This value is suitable for direct
+  *         comparison with unshifted values appropriate for use in field <y>
+  *         of register <x>.
+  */
+
+#ifndef HOST1X_HW_HOST1X06_UCLASS_H
+#define HOST1X_HW_HOST1X06_UCLASS_H
+
+static inline u32 host1x_uclass_incr_syncpt_r(void)
+{
+	return 0x0;
+}
+#define HOST1X_UCLASS_INCR_SYNCPT \
+	host1x_uclass_incr_syncpt_r()
+static inline u32 host1x_uclass_incr_syncpt_cond_f(u32 v)
+{
+	return (v & 0xff) << 8;
+}
+#define HOST1X_UCLASS_INCR_SYNCPT_COND_F(v) \
+	host1x_uclass_incr_syncpt_cond_f(v)
+static inline u32 host1x_uclass_incr_syncpt_indx_f(u32 v)
+{
+	return (v & 0xff) << 0;
+}
+#define HOST1X_UCLASS_INCR_SYNCPT_INDX_F(v) \
+	host1x_uclass_incr_syncpt_indx_f(v)
+static inline u32 host1x_uclass_wait_syncpt_r(void)
+{
+	return 0x8;
+}
+#define HOST1X_UCLASS_WAIT_SYNCPT \
+	host1x_uclass_wait_syncpt_r()
+static inline u32 host1x_uclass_wait_syncpt_indx_f(u32 v)
+{
+	return (v & 0xff) << 24;
+}
+#define HOST1X_UCLASS_WAIT_SYNCPT_INDX_F(v) \
+	host1x_uclass_wait_syncpt_indx_f(v)
+static inline u32 host1x_uclass_wait_syncpt_thresh_f(u32 v)
+{
+	return (v & 0xffffff) << 0;
+}
+#define HOST1X_UCLASS_WAIT_SYNCPT_THRESH_F(v) \
+	host1x_uclass_wait_syncpt_thresh_f(v)
+static inline u32 host1x_uclass_wait_syncpt_base_r(void)
+{
+	return 0x9;
+}
+#define HOST1X_UCLASS_WAIT_SYNCPT_BASE \
+	host1x_uclass_wait_syncpt_base_r()
+static inline u32 host1x_uclass_wait_syncpt_base_indx_f(u32 v)
+{
+	return (v & 0xff) << 24;
+}
+#define HOST1X_UCLASS_WAIT_SYNCPT_BASE_INDX_F(v) \
+	host1x_uclass_wait_syncpt_base_indx_f(v)
+static inline u32 host1x_uclass_wait_syncpt_base_base_indx_f(u32 v)
+{
+	return (v & 0xff) << 16;
+}
+#define HOST1X_UCLASS_WAIT_SYNCPT_BASE_BASE_INDX_F(v) \
+	host1x_uclass_wait_syncpt_base_base_indx_f(v)
+static inline u32 host1x_uclass_wait_syncpt_base_offset_f(u32 v)
+{
+	return (v & 0xffff) << 0;
+}
+#define HOST1X_UCLASS_WAIT_SYNCPT_BASE_OFFSET_F(v) \
+	host1x_uclass_wait_syncpt_base_offset_f(v)
+static inline u32 host1x_uclass_load_syncpt_base_r(void)
+{
+	return 0xb;
+}
+#define HOST1X_UCLASS_LOAD_SYNCPT_BASE \
+	host1x_uclass_load_syncpt_base_r()
+static inline u32 host1x_uclass_load_syncpt_base_base_indx_f(u32 v)
+{
+	return (v & 0xff) << 24;
+}
+#define HOST1X_UCLASS_LOAD_SYNCPT_BASE_BASE_INDX_F(v) \
+	host1x_uclass_load_syncpt_base_base_indx_f(v)
+static inline u32 host1x_uclass_load_syncpt_base_value_f(u32 v)
+{
+	return (v & 0xffffff) << 0;
+}
+#define HOST1X_UCLASS_LOAD_SYNCPT_BASE_VALUE_F(v) \
+	host1x_uclass_load_syncpt_base_value_f(v)
+static inline u32 host1x_uclass_incr_syncpt_base_base_indx_f(u32 v)
+{
+	return (v & 0xff) << 24;
+}
+#define HOST1X_UCLASS_INCR_SYNCPT_BASE_BASE_INDX_F(v) \
+	host1x_uclass_incr_syncpt_base_base_indx_f(v)
+static inline u32 host1x_uclass_incr_syncpt_base_offset_f(u32 v)
+{
+	return (v & 0xffffff) << 0;
+}
+#define HOST1X_UCLASS_INCR_SYNCPT_BASE_OFFSET_F(v) \
+	host1x_uclass_incr_syncpt_base_offset_f(v)
+static inline u32 host1x_uclass_indoff_r(void)
+{
+	return 0x2d;
+}
+#define HOST1X_UCLASS_INDOFF \
+	host1x_uclass_indoff_r()
+static inline u32 host1x_uclass_indoff_indbe_f(u32 v)
+{
+	return (v & 0xf) << 28;
+}
+#define HOST1X_UCLASS_INDOFF_INDBE_F(v) \
+	host1x_uclass_indoff_indbe_f(v)
+static inline u32 host1x_uclass_indoff_autoinc_f(u32 v)
+{
+	return (v & 0x1) << 27;
+}
+#define HOST1X_UCLASS_INDOFF_AUTOINC_F(v) \
+	host1x_uclass_indoff_autoinc_f(v)
+static inline u32 host1x_uclass_indoff_indmodid_f(u32 v)
+{
+	return (v & 0xff) << 18;
+}
+#define HOST1X_UCLASS_INDOFF_INDMODID_F(v) \
+	host1x_uclass_indoff_indmodid_f(v)
+static inline u32 host1x_uclass_indoff_indroffset_f(u32 v)
+{
+	return (v & 0xffff) << 2;
+}
+#define HOST1X_UCLASS_INDOFF_INDROFFSET_F(v) \
+	host1x_uclass_indoff_indroffset_f(v)
+static inline u32 host1x_uclass_indoff_rwn_read_v(void)
+{
+	return 1;
+}
+#define HOST1X_UCLASS_INDOFF_INDROFFSET_F(v) \
+	host1x_uclass_indoff_indroffset_f(v)
+
+#endif
diff --git a/drivers/gpu/host1x/hw/hw_host1x06_vm.h b/drivers/gpu/host1x/hw/hw_host1x06_vm.h
new file mode 100644
index 000000000000..e54b33902332
--- /dev/null
+++ b/drivers/gpu/host1x/hw/hw_host1x06_vm.h
@@ -0,0 +1,47 @@
+/*
+ * Copyright (c) 2017 NVIDIA Corporation.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ *
+ */
+
+#define HOST1X_CHANNEL_DMASTART				0x0000
+#define HOST1X_CHANNEL_DMASTART_HI			0x0004
+#define HOST1X_CHANNEL_DMAPUT				0x0008
+#define HOST1X_CHANNEL_DMAPUT_HI			0x000c
+#define HOST1X_CHANNEL_DMAGET				0x0010
+#define HOST1X_CHANNEL_DMAGET_HI			0x0014
+#define HOST1X_CHANNEL_DMAEND				0x0018
+#define HOST1X_CHANNEL_DMAEND_HI			0x001c
+#define HOST1X_CHANNEL_DMACTRL				0x0020
+#define HOST1X_CHANNEL_DMACTRL_DMASTOP			BIT(0)
+#define HOST1X_CHANNEL_DMACTRL_DMAGETRST		BIT(1)
+#define HOST1X_CHANNEL_DMACTRL_DMAINITGET		BIT(2)
+#define HOST1X_CHANNEL_CMDFIFO_STAT			0x0024
+#define HOST1X_CHANNEL_CMDFIFO_STAT_EMPTY		BIT(13)
+#define HOST1X_CHANNEL_CMDFIFO_RDATA			0x0028
+#define HOST1X_CHANNEL_CMDP_OFFSET			0x0030
+#define HOST1X_CHANNEL_CMDP_CLASS			0x0034
+#define HOST1X_CHANNEL_CHANNELSTAT			0x0038
+#define HOST1X_CHANNEL_CMDPROC_STOP			0x0048
+#define HOST1X_CHANNEL_TEARDOWN				0x004c
+
+#define HOST1X_SYNC_SYNCPT_CPU_INCR(x)			(0x6400 + 4*(x))
+#define HOST1X_SYNC_SYNCPT_THRESH_CPU0_INT_STATUS(x)	(0x6464 + 4*(x))
+#define HOST1X_SYNC_SYNCPT_THRESH_INT_ENABLE_CPU0(x)	(0x652c + 4*(x))
+#define HOST1X_SYNC_SYNCPT_THRESH_INT_DISABLE(x)	(0x6590 + 4*(x))
+#define HOST1X_SYNC_SYNCPT_BASE(x)			(0x8000 + 4*(x))
+#define HOST1X_SYNC_SYNCPT(x)				(0x8080 + 4*(x))
+#define HOST1X_SYNC_SYNCPT_INT_THRESH(x)		(0x8a00 + 4*(x))
+#define HOST1X_SYNC_SYNCPT_CH_APP(x)			(0x9384 + 4*(x))
+#define HOST1X_SYNC_SYNCPT_CH_APP_CH(v)			(((v) & 0x3f) << 8)
diff --git a/drivers/gpu/host1x/hw/intr_hw.c b/drivers/gpu/host1x/hw/intr_hw.c
index 37ebb51703fa..329239237090 100644
--- a/drivers/gpu/host1x/hw/intr_hw.c
+++ b/drivers/gpu/host1x/hw/intr_hw.c
@@ -72,6 +72,23 @@ static void _host1x_intr_disable_all_syncpt_intrs(struct host1x *host)
 	}
 }
 
+static void intr_hw_init(struct host1x *host, u32 cpm)
+{
+#if HOST1X_HW < 6
+	/* disable the ip_busy_timeout. this prevents write drops */
+	host1x_sync_writel(host, 0, HOST1X_SYNC_IP_BUSY_TIMEOUT);
+
+	/*
+	 * increase the auto-ack timout to the maximum value. 2d will hang
+	 * otherwise on Tegra2.
+	 */
+	host1x_sync_writel(host, 0xff, HOST1X_SYNC_CTXSW_TIMEOUT_CFG);
+
+	/* update host clocks per usec */
+	host1x_sync_writel(host, cpm, HOST1X_SYNC_USEC_CLK);
+#endif
+}
+
 static int
 _host1x_intr_init_host_sync(struct host1x *host, u32 cpm,
 			    void (*syncpt_thresh_work)(struct work_struct *))
@@ -92,17 +109,7 @@ _host1x_intr_init_host_sync(struct host1x *host, u32 cpm,
 		return err;
 	}
 
-	/* disable the ip_busy_timeout. this prevents write drops */
-	host1x_sync_writel(host, 0, HOST1X_SYNC_IP_BUSY_TIMEOUT);
-
-	/*
-	 * increase the auto-ack timout to the maximum value. 2d will hang
-	 * otherwise on Tegra2.
-	 */
-	host1x_sync_writel(host, 0xff, HOST1X_SYNC_CTXSW_TIMEOUT_CFG);
-
-	/* update host clocks per usec */
-	host1x_sync_writel(host, cpm, HOST1X_SYNC_USEC_CLK);
+	intr_hw_init(host, cpm);
 
 	return 0;
 }
-- 
2.14.1
