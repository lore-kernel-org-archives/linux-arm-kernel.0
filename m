From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Thu, 14 May 2015 19:53:24 +0200
Subject: [PATCH v3 4/6] dmaengine: pxa_dma: add debug information
In-Reply-To: <1431626006-1708-1-git-send-email-robert.jarzmik@free.fr>
References: <1431626006-1708-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <1431626006-1708-4-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reuse the debugging features which were available in pxa architecture.
This is a copy of the code from arch/arm/plat-pxa/dma, which is doomed
to disappear once the conversion is completed towards dmaengine.

This is a transfer of the commit "[ARM] pxa/dma: add debugfs
entries" (d294948c2ce4e1c85f452154469752cc9b8e876d).

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
Since v2: bissectability
---
 drivers/dma/pxa_dma.c | 242 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 242 insertions(+)

diff --git a/drivers/dma/pxa_dma.c b/drivers/dma/pxa_dma.c
index bad1b36..f0912a2 100644
--- a/drivers/dma/pxa_dma.c
+++ b/drivers/dma/pxa_dma.c
@@ -131,6 +131,11 @@ struct pxad_device {
 	void __iomem			*base;
 	struct pxad_phy			*phys;
 	spinlock_t			phy_lock;	/* Phy association */
+#ifdef CONFIG_DEBUG_FS
+	struct dentry			*dbgfs_root;
+	struct dentry			*dbgfs_state;
+	struct dentry			**dbgfs_chan;
+#endif
 };
 
 #define tx_to_pxad_desc(tx)					\
@@ -168,6 +173,241 @@ struct pxad_device {
 			 __func__, (u32)(val), #_reg);			\
 	} while (0)
 
+/*
+ * Debug fs
+ */
+#ifdef CONFIG_DEBUG_FS
+#include <linux/debugfs.h>
+#include <linux/uaccess.h>
+#include <linux/seq_file.h>
+
+static int dbg_show_requester_chan(struct seq_file *s, void *p)
+{
+	int pos = 0;
+	struct pxad_phy *phy = s->private;
+	int i;
+	u32 drcmr;
+
+	pos += seq_printf(s, "DMA channel %d requester :\n", phy->idx);
+	for (i = 0; i < 70; i++) {
+		drcmr = readl_relaxed(phy->base + DRCMR(i));
+		if ((drcmr & DRCMR_CHLNUM) == phy->idx)
+			pos += seq_printf(s, "\tRequester %d (MAPVLD=%d)\n", i,
+					  !!(drcmr & DRCMR_MAPVLD));
+	}
+	return pos;
+}
+
+static inline int dbg_burst_from_dcmd(u32 dcmd)
+{
+	int burst = (dcmd >> 16) & 0x3;
+
+	return burst ? 4 << burst : 0;
+}
+
+static int is_phys_valid(unsigned long addr)
+{
+	return pfn_valid(__phys_to_pfn(addr));
+}
+
+#define DCSR_STR(flag) (dcsr & DCSR_##flag ? #flag" " : "")
+#define PXA_DCMD_STR(flag) (dcmd & PXA_DCMD_##flag ? #flag" " : "")
+
+static int dbg_show_descriptors(struct seq_file *s, void *p)
+{
+	struct pxad_phy *phy = s->private;
+	int i, max_show = 20, burst, width;
+	u32 dcmd;
+	unsigned long phys_desc, ddadr;
+	struct pxad_desc_hw *desc;
+
+	phys_desc = ddadr = _phy_readl_relaxed(phy, DDADR);
+
+	seq_printf(s, "DMA channel %d descriptors :\n", phy->idx);
+	seq_printf(s, "[%03d] First descriptor unknown\n", 0);
+	for (i = 1; i < max_show && is_phys_valid(phys_desc); i++) {
+		desc = phys_to_virt(phys_desc);
+		dcmd = desc->dcmd;
+		burst = dbg_burst_from_dcmd(dcmd);
+		width = (1 << ((dcmd >> 14) & 0x3)) >> 1;
+
+		seq_printf(s, "[%03d] Desc at %08lx(virt %p)\n",
+			   i, phys_desc, desc);
+		seq_printf(s, "\tDDADR = %08x\n", desc->ddadr);
+		seq_printf(s, "\tDSADR = %08x\n", desc->dsadr);
+		seq_printf(s, "\tDTADR = %08x\n", desc->dtadr);
+		seq_printf(s, "\tDCMD  = %08x (%s%s%s%s%s%s%sburst=%d width=%d len=%d)\n",
+			   dcmd,
+			   PXA_DCMD_STR(INCSRCADDR), PXA_DCMD_STR(INCTRGADDR),
+			   PXA_DCMD_STR(FLOWSRC), PXA_DCMD_STR(FLOWTRG),
+			   PXA_DCMD_STR(STARTIRQEN), PXA_DCMD_STR(ENDIRQEN),
+			   PXA_DCMD_STR(ENDIAN), burst, width,
+			   dcmd & PXA_DCMD_LENGTH);
+		phys_desc = desc->ddadr;
+	}
+	if (i == max_show)
+		seq_printf(s, "[%03d] Desc at %08lx ... max display reached\n",
+			   i, phys_desc);
+	else
+		seq_printf(s, "[%03d] Desc at %08lx is %s\n",
+			   i, phys_desc, phys_desc == DDADR_STOP ?
+			   "DDADR_STOP" : "invalid");
+
+	return 0;
+}
+
+static int dbg_show_chan_state(struct seq_file *s, void *p)
+{
+	struct pxad_phy *phy = s->private;
+	u32 dcsr, dcmd;
+	int burst, width;
+	static const char * const str_prio[] = {
+		"high", "normal", "low", "invalid"
+	};
+
+	dcsr = _phy_readl_relaxed(phy, DCSR);
+	dcmd = _phy_readl_relaxed(phy, DCMD);
+	burst = dbg_burst_from_dcmd(dcmd);
+	width = (1 << ((dcmd >> 14) & 0x3)) >> 1;
+
+	seq_printf(s, "DMA channel %d\n", phy->idx);
+	seq_printf(s, "\tPriority : %s\n",
+			  str_prio[(phy->idx & 0xf) / 4]);
+	seq_printf(s, "\tUnaligned transfer bit: %s\n",
+			  _phy_readl_relaxed(phy, DALGN) & BIT(phy->idx) ?
+			  "yes" : "no");
+	seq_printf(s, "\tDCSR  = %08x (%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s)\n",
+			  dcsr, DCSR_STR(RUN), DCSR_STR(NODESC),
+			  DCSR_STR(STOPIRQEN), DCSR_STR(EORIRQEN),
+			  DCSR_STR(EORJMPEN), DCSR_STR(EORSTOPEN),
+			  DCSR_STR(SETCMPST), DCSR_STR(CLRCMPST),
+			  DCSR_STR(CMPST), DCSR_STR(EORINTR), DCSR_STR(REQPEND),
+			  DCSR_STR(STOPSTATE), DCSR_STR(ENDINTR),
+			  DCSR_STR(STARTINTR), DCSR_STR(BUSERR));
+
+	seq_printf(s, "\tDCMD  = %08x (%s%s%s%s%s%s%sburst=%d width=%d len=%d)\n",
+		   dcmd,
+		   PXA_DCMD_STR(INCSRCADDR), PXA_DCMD_STR(INCTRGADDR),
+		   PXA_DCMD_STR(FLOWSRC), PXA_DCMD_STR(FLOWTRG),
+		   PXA_DCMD_STR(STARTIRQEN), PXA_DCMD_STR(ENDIRQEN),
+		   PXA_DCMD_STR(ENDIAN), burst, width, dcmd & PXA_DCMD_LENGTH);
+	seq_printf(s, "\tDSADR = %08x\n", _phy_readl_relaxed(phy, DSADR));
+	seq_printf(s, "\tDTADR = %08x\n", _phy_readl_relaxed(phy, DTADR));
+	seq_printf(s, "\tDDADR = %08x\n", _phy_readl_relaxed(phy, DDADR));
+
+	return 0;
+}
+
+static int dbg_show_state(struct seq_file *s, void *p)
+{
+	struct pxad_device *pdev = s->private;
+
+	/* basic device status */
+	seq_puts(s, "DMA engine status\n");
+	seq_printf(s, "\tChannel number: %d\n", pdev->nr_chans);
+
+	return 0;
+}
+
+#define DBGFS_FUNC_DECL(name) \
+static int dbg_open_##name(struct inode *inode, struct file *file) \
+{ \
+	return single_open(file, dbg_show_##name, inode->i_private); \
+} \
+static const struct file_operations dbg_fops_##name = { \
+	.owner		= THIS_MODULE, \
+	.open		= dbg_open_##name, \
+	.llseek		= seq_lseek, \
+	.read		= seq_read, \
+	.release	= single_release, \
+}
+
+DBGFS_FUNC_DECL(state);
+DBGFS_FUNC_DECL(chan_state);
+DBGFS_FUNC_DECL(descriptors);
+DBGFS_FUNC_DECL(requester_chan);
+
+static struct dentry *pxad_dbg_alloc_chan(struct pxad_device *pdev,
+					     int ch, struct dentry *chandir)
+{
+	char chan_name[11];
+	struct dentry *chan, *chan_state = NULL, *chan_descr = NULL;
+	struct dentry *chan_reqs = NULL;
+	void *dt;
+
+	scnprintf(chan_name, sizeof(chan_name), "%d", ch);
+	chan = debugfs_create_dir(chan_name, chandir);
+	dt = (void *)&pdev->phys[ch];
+
+	if (chan)
+		chan_state = debugfs_create_file("state", 0400, chan, dt,
+						 &dbg_fops_chan_state);
+	if (chan_state)
+		chan_descr = debugfs_create_file("descriptors", 0400, chan, dt,
+						 &dbg_fops_descriptors);
+	if (chan_descr)
+		chan_reqs = debugfs_create_file("requesters", 0400, chan, dt,
+						&dbg_fops_requester_chan);
+	if (!chan_reqs)
+		goto err_state;
+
+	return chan;
+
+err_state:
+	debugfs_remove_recursive(chan);
+	return NULL;
+}
+
+static void pxad_init_debugfs(struct pxad_device *pdev)
+{
+	int i;
+	struct dentry *chandir;
+
+	pdev->dbgfs_root = debugfs_create_dir(dev_name(pdev->slave.dev), NULL);
+	if (IS_ERR(pdev->dbgfs_root) || !pdev->dbgfs_root)
+		goto err_root;
+
+	pdev->dbgfs_state = debugfs_create_file("state", 0400, pdev->dbgfs_root,
+						pdev, &dbg_fops_state);
+	if (!pdev->dbgfs_state)
+		goto err_state;
+
+	pdev->dbgfs_chan =
+		kmalloc_array(pdev->nr_chans, sizeof(*pdev->dbgfs_state),
+			      GFP_KERNEL);
+	if (!pdev->dbgfs_chan)
+		goto err_alloc;
+
+	chandir = debugfs_create_dir("channels", pdev->dbgfs_root);
+	if (!chandir)
+		goto err_chandir;
+
+	for (i = 0; i < pdev->nr_chans; i++) {
+		pdev->dbgfs_chan[i] = pxad_dbg_alloc_chan(pdev, i, chandir);
+		if (!pdev->dbgfs_chan[i])
+			goto err_chans;
+	}
+
+	return;
+err_chans:
+err_chandir:
+	kfree(pdev->dbgfs_chan);
+err_alloc:
+err_state:
+	debugfs_remove_recursive(pdev->dbgfs_root);
+err_root:
+	pr_err("pxad: debugfs is not available\n");
+}
+
+static void pxad_cleanup_debugfs(struct pxad_device *pdev)
+{
+	debugfs_remove_recursive(pdev->dbgfs_root);
+}
+#else
+static inline void pxad_init_debugfs(struct pxad_device *pdev) {}
+static inline void pxad_cleanup_debugfs(struct pxad_device *pdev) {}
+#endif
+
 static struct pxad_phy *lookup_phy(struct pxad_chan *pchan)
 {
 	int prio, i;
@@ -981,6 +1221,7 @@ static int pxad_remove(struct platform_device *op)
 {
 	struct pxad_device *pdev = platform_get_drvdata(op);
 
+	pxad_cleanup_debugfs(pdev);
 	pxad_free_channels(&pdev->slave);
 	dma_async_device_unregister(&pdev->slave);
 	return 0;
@@ -1153,6 +1394,7 @@ static int pxad_probe(struct platform_device *op)
 	}
 
 	platform_set_drvdata(op, pdev);
+	pxad_init_debugfs(pdev);
 	dev_info(pdev->slave.dev, "initialized %d channels\n", dma_channels);
 	return 0;
 }
-- 
2.1.4
