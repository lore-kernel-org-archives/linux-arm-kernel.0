From: stigge@antcom.de (Roland Stigge)
Date: Wed,  7 Mar 2012 21:25:29 +0100
Subject: [PATCH] ARM: LPX32xx: DMA support
Message-ID: <1331151929-23298-1-git-send-email-stigge@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds DMA support to the LPC32xx platform

Signed-off-by: Roland Stigge <stigge@antcom.de>

---

 Applies to v3.3-rc6.  This patch is a precondition for the NAND and audio
 drivers (to be sent in one of my next mails).

 arch/arm/mach-lpc32xx/Makefile            |    2 
 arch/arm/mach-lpc32xx/dma.c               |  742 ++++++++++++++++++++++++++++++
 arch/arm/mach-lpc32xx/include/mach/dma.h  |  131 +++++
 arch/arm/mach-lpc32xx/include/mach/dmac.h |  285 +++++++++++
 4 files changed, 1159 insertions(+), 1 deletion(-)

--- linux-2.6.orig/arch/arm/mach-lpc32xx/Makefile
+++ linux-2.6/arch/arm/mach-lpc32xx/Makefile
@@ -3,6 +3,6 @@
 #
 
 obj-y	:= timer.o irq.o common.o serial.o clock.o
-obj-y	+= pm.o suspend.o
+obj-y	+= dma.o pm.o suspend.o
 obj-y	+= phy3250.o
 
--- /dev/null
+++ linux-2.6/arch/arm/mach-lpc32xx/dma.c
@@ -0,0 +1,742 @@
+/*
+ *  linux/arch/arm/mach-lpc32xx/dma.c
+ *
+ *  Copyright (C) 2008 NXP Semiconductors
+ *  (Based on parts of the PNX4008 DMA driver)
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/interrupt.h>
+#include <linux/errno.h>
+#include <linux/err.h>
+#include <linux/dma-mapping.h>
+#include <linux/clk.h>
+
+#include <asm/system.h>
+#include <mach/hardware.h>
+#include <mach/platform.h>
+#include <asm/dma-mapping.h>
+#include <asm/io.h>
+#include <mach/dma.h>
+#include <mach/dmac.h>
+
+#define DMAIOBASE io_p2v(LPC32XX_DMA_BASE)
+#define VALID_CHANNEL(c) (((c) >= 0) && ((c) < MAX_DMA_CHANNELS))
+
+static DEFINE_SPINLOCK(dma_lock);
+
+/* Each DMA channel has one of these structures */
+struct dma_channel {
+	char *name;
+	void (*irq_handler) (int, int, void *);
+	void *data;
+	struct dma_config *dmacfg;
+	u32 control;
+	u32 config;
+	u32 config_int_mask;
+
+	int list_entries; /* Number of list entries */
+	size_t list_size; /* Total size of allocated list in bytes */
+	struct dma_list_ctrl *list_vstart;
+	dma_addr_t list_pstart;
+	int free_entries; /* Number of free descriptors */
+	struct dma_list_ctrl *list_head, *list_tail, *list_curr;
+};
+
+struct dma_control {
+	struct clk *clk;
+	int num_clks;
+	struct dma_channel dma_channels[MAX_DMA_CHANNELS];
+};
+static struct dma_control dma_ctrl;
+
+static inline void __dma_regs_lock(void)
+{
+	spin_lock_irq(&dma_lock);
+}
+
+static inline void __dma_regs_unlock(void)
+{
+	spin_unlock_irq(&dma_lock);
+}
+
+static inline void __dma_enable(int ch)
+{
+	u32 ch_cfg = __raw_readl(DMACH_CONFIG_CH(DMAIOBASE, ch));
+	ch_cfg |= DMAC_CHAN_ENABLE;
+	__raw_writel(ch_cfg, DMACH_CONFIG_CH(DMAIOBASE, ch));
+}
+
+static inline void __dma_disable(int ch)
+{
+	u32 ch_cfg = __raw_readl(DMACH_CONFIG_CH(DMAIOBASE, ch));
+	ch_cfg &= ~DMAC_CHAN_ENABLE;
+	__raw_writel(ch_cfg, DMACH_CONFIG_CH(DMAIOBASE, ch));
+}
+
+static void dma_clocks_up(void)
+{
+	/* Enable DMA clock if needed */
+	if (dma_ctrl.num_clks == 0) {
+		clk_enable(dma_ctrl.clk);
+		__raw_writel(DMAC_CTRL_ENABLE, DMA_CONFIG(DMAIOBASE));
+	}
+
+	dma_ctrl.num_clks++;
+}
+
+static void dma_clocks_down(void)
+{
+	dma_ctrl.num_clks--;
+
+	/* Disable DMA clock if needed */
+	if (dma_ctrl.num_clks == 0) {
+		__raw_writel(0, DMA_CONFIG(DMAIOBASE));
+		clk_disable(dma_ctrl.clk);
+	}
+}
+
+static int lpc32xx_ch_setup(struct dma_config *dmachcfg)
+{
+	u32 tmpctrl, tmpcfg, tmp;
+	int ch = dmachcfg->ch;
+
+	/* Channel control setup */
+	tmpctrl = 0;
+	switch (dmachcfg->src_size) {
+	case 1:
+		tmpctrl |= DMAC_CHAN_SRC_WIDTH_8;
+		break;
+
+	case 2:
+		tmpctrl |= DMAC_CHAN_SRC_WIDTH_16;
+		break;
+
+	case 4:
+		tmpctrl |= DMAC_CHAN_SRC_WIDTH_32;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+	switch (dmachcfg->dst_size) {
+	case 1:
+		tmpctrl |= DMAC_CHAN_DEST_WIDTH_8;
+		break;
+
+	case 2:
+		tmpctrl |= DMAC_CHAN_DEST_WIDTH_16;
+		break;
+
+	case 4:
+		tmpctrl |= DMAC_CHAN_DEST_WIDTH_32;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+	if (dmachcfg->src_inc != 0)
+		tmpctrl |= DMAC_CHAN_SRC_AUTOINC;
+	if (dmachcfg->dst_inc != 0)
+		tmpctrl |= DMAC_CHAN_DEST_AUTOINC;
+	if (dmachcfg->src_ahb1 != 0)
+		tmpctrl |= DMAC_CHAN_SRC_AHB1;
+	if (dmachcfg->dst_ahb1 != 0)
+		tmpctrl |= DMAC_CHAN_DEST_AHB1;
+	if (dmachcfg->tc_inten != 0)
+		tmpctrl |= DMAC_CHAN_INT_TC_EN;
+	tmpctrl |= dmachcfg->src_bsize | dmachcfg->dst_bsize;
+	dma_ctrl.dma_channels[ch].control = tmpctrl;
+
+	/* Channel config setup */
+	tmpcfg = dmachcfg->src_prph | dmachcfg->dst_prph |
+		dmachcfg->flowctrl;
+	dma_ctrl.dma_channels[ch].config = tmpcfg;
+
+	dma_ctrl.dma_channels[ch].config_int_mask = 0;
+	if (dmachcfg->err_inten != 0)
+		dma_ctrl.dma_channels[ch].config_int_mask |=
+			DMAC_CHAN_IE;
+	if (dmachcfg->tc_inten != 0)
+		dma_ctrl.dma_channels[ch].config_int_mask |=
+			DMAC_CHAN_ITC;
+
+	tmp = __raw_readl(DMACH_CONFIG_CH(DMAIOBASE, ch));
+	tmp &= ~DMAC_CHAN_ENABLE;
+	__raw_writel(tmp, DMACH_CONFIG_CH(DMAIOBASE, ch));
+
+	/* Clear interrupts for channel */
+	__raw_writel((1 << ch), DMA_INT_TC_CLEAR(DMAIOBASE));
+	__raw_writel((1 << ch), DMA_INT_ERR_CLEAR(DMAIOBASE));
+
+	/* Write control and config words */
+	__raw_writel(tmpctrl, DMACH_CONTROL(DMAIOBASE, ch));
+	__raw_writel(tmpcfg, DMACH_CONFIG_CH(DMAIOBASE, ch));
+
+	return 0;
+}
+
+int lpc32xx_dma_ch_enable(int ch)
+{
+	if (!VALID_CHANNEL(ch) || !dma_ctrl.dma_channels[ch].name)
+		return -EINVAL;
+
+	__dma_regs_lock();
+	__dma_enable(ch);
+	__dma_regs_unlock();
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(lpc32xx_dma_ch_enable);
+
+int lpc32xx_dma_ch_disable(int ch)
+{
+	if (!VALID_CHANNEL(ch) || !dma_ctrl.dma_channels[ch].name)
+		return -EINVAL;
+
+	__dma_regs_lock();
+	__dma_disable(ch);
+	__dma_regs_unlock();
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(lpc32xx_dma_ch_disable);
+
+int lpc32xx_dma_ch_get(struct dma_config *dmachcfg, char *name,
+		       void *irq_handler, void *data)
+{
+	int ret;
+
+	if (!VALID_CHANNEL(dmachcfg->ch))
+		return -EINVAL;
+
+	/* If the channel is already enabled, return */
+	if (dma_ctrl.dma_channels[dmachcfg->ch].name != NULL)
+		return -ENODEV;
+
+	/* Save channel data */
+	dma_ctrl.dma_channels[dmachcfg->ch].dmacfg = dmachcfg;
+	dma_ctrl.dma_channels[dmachcfg->ch].name = name;
+	dma_ctrl.dma_channels[dmachcfg->ch].irq_handler = irq_handler;
+	dma_ctrl.dma_channels[dmachcfg->ch].data = data;
+
+	/* Setup channel */
+	__dma_regs_lock();
+	dma_clocks_up();
+	ret = lpc32xx_ch_setup(dmachcfg);
+	__dma_regs_unlock();
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(lpc32xx_dma_ch_get);
+
+int lpc32xx_dma_ch_put(int ch)
+{
+	u32 tmp;
+
+	if (!VALID_CHANNEL(ch))
+		return -EINVAL;
+
+	/* If the channel is already disabled, return */
+	if (dma_ctrl.dma_channels[ch].name == NULL)
+		return -EINVAL;
+
+	tmp = __raw_readl(DMACH_CONFIG_CH(DMAIOBASE, ch));
+	tmp &= ~DMAC_CHAN_ENABLE;
+	__raw_writel(tmp, DMACH_CONFIG_CH(DMAIOBASE, ch));
+
+	__dma_regs_lock();
+	lpc32xx_dma_ch_disable(ch);
+	dma_clocks_down();
+	__dma_regs_unlock();
+
+	dma_ctrl.dma_channels[ch].name = NULL;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(lpc32xx_dma_ch_put);
+
+int lpc32xx_dma_ch_pause_unpause(int ch, int pause)
+{
+	u32 tmp;
+
+	if (!VALID_CHANNEL(ch))
+		return -EINVAL;
+
+	/* If the channel is already disabled, return */
+	if (dma_ctrl.dma_channels[ch].name == NULL)
+		return -EINVAL;
+
+	tmp = __raw_readl(DMACH_CONFIG_CH(DMAIOBASE, ch));
+	if (pause)
+		tmp |= DMAC_CHAN_HALT;
+	else
+		tmp &= ~DMAC_CHAN_HALT;
+	__raw_writel(tmp, DMACH_CONFIG_CH(DMAIOBASE, ch));
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(lpc32xx_dma_ch_pause_unpause);
+
+int lpc32xx_dma_start_pflow_xfer(int ch,
+				dma_addr_t src,
+				dma_addr_t dst,
+				int enable)
+{
+	u32 tmp;
+
+	if ((!VALID_CHANNEL(ch)) || (dma_ctrl.dma_channels[ch].name == NULL))
+		return -EINVAL;
+
+	/* When starting a DMA transfer where the peripheral is the flow
+	   controller, DMA must be previously disabled */
+	tmp = __raw_readl(DMACH_CONFIG_CH(DMAIOBASE, ch));
+	if (tmp & DMAC_CHAN_ENABLE)
+		return -EBUSY;
+
+	__dma_regs_lock();
+	__raw_writel(src, DMACH_SRC_ADDR(DMAIOBASE, ch));
+	__raw_writel(dst, DMACH_DEST_ADDR(DMAIOBASE, ch));
+	__raw_writel(0, DMACH_LLI(DMAIOBASE, ch));
+	__raw_writel(dma_ctrl.dma_channels[ch].control,
+			DMACH_CONTROL(DMAIOBASE, ch));
+
+	tmp = dma_ctrl.dma_channels[ch].config |
+		dma_ctrl.dma_channels[ch].config_int_mask;
+	if (enable != 0)
+		tmp |= DMAC_CHAN_ENABLE;
+	__raw_writel(tmp, DMACH_CONFIG_CH(DMAIOBASE, ch));
+
+	__dma_regs_unlock();
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(lpc32xx_dma_start_pflow_xfer);
+
+int lpc32xx_dma_is_active(int ch)
+{
+	int active = 0;
+
+	if ((VALID_CHANNEL(ch)) && (dma_ctrl.dma_channels[ch].name != NULL)) {
+		if (__raw_readl(DMACH_CONFIG_CH(DMAIOBASE, ch)) &
+		    DMAC_CHAN_ENABLE)
+			active = 1;
+	}
+
+	return active;
+
+}
+EXPORT_SYMBOL_GPL(lpc32xx_dma_is_active);
+
+extern dma_addr_t lpc32xx_dma_llist_v_to_p(int ch, struct dma_list_ctrl *vlist)
+{
+	dma_addr_t pptr;
+
+	if ((!VALID_CHANNEL(ch)) || (dma_ctrl.dma_channels[ch].name == NULL) ||
+	    (dma_ctrl.dma_channels[ch].list_vstart == NULL))
+		return 0;
+
+	pptr = dma_ctrl.dma_channels[ch].list_pstart;
+	pptr += (vlist - dma_ctrl.dma_channels[ch].list_vstart) *
+		sizeof(struct dma_list_ctrl) ;
+
+	return pptr;
+}
+EXPORT_SYMBOL_GPL(lpc32xx_dma_llist_v_to_p);
+
+struct dma_list_ctrl *lpc32xx_dma_llist_p_to_v(int ch, dma_addr_t plist)
+{
+	struct dma_list_ctrl *vptr;
+
+	if ((!VALID_CHANNEL(ch)) || (dma_ctrl.dma_channels[ch].name == NULL) ||
+		(dma_ctrl.dma_channels[ch].list_vstart == NULL))
+		return NULL;
+
+	vptr = dma_ctrl.dma_channels[ch].list_vstart;
+	vptr += plist - dma_ctrl.dma_channels[ch].list_pstart;
+
+	return vptr;
+}
+EXPORT_SYMBOL_GPL(lpc32xx_dma_llist_p_to_v);
+
+struct dma_list_ctrl *lpc32xx_dma_alloc_llist(int ch, int entries)
+{
+	int i;
+	dma_addr_t dma_handle;
+	struct dma_list_ctrl *pdmalist, *pdmalistst;
+
+	if ((!VALID_CHANNEL(ch)) || (dma_ctrl.dma_channels[ch].name == NULL))
+		return NULL;
+
+	/*
+	 * Limit number of list entries, but add 1 extra entry as a spot holder
+	 * for the end of the list
+	 */
+	if (entries < 2)
+		entries = 2;
+	if (entries > 64)
+		entries = 64;
+	entries++;
+
+	/* Save list information */
+	dma_ctrl.dma_channels[ch].list_entries = entries;
+	dma_ctrl.dma_channels[ch].list_size =
+		(entries * sizeof(struct dma_list_ctrl));
+	dma_ctrl.dma_channels[ch].list_vstart = dma_alloc_coherent(NULL,
+		dma_ctrl.dma_channels[ch].list_size, &dma_handle, GFP_KERNEL);
+	if (dma_ctrl.dma_channels[ch].list_vstart == NULL) {
+		/* No allocated DMA space */
+		return NULL;
+	}
+	dma_ctrl.dma_channels[ch].list_pstart = dma_handle;
+
+	/* Setup list tail and head pointers */
+	pdmalist = pdmalistst =
+		(struct dma_list_ctrl *)dma_ctrl.dma_channels[ch].list_vstart;
+	for (i = 0; i < entries; i++) {
+		pdmalistst->next_list_addr = pdmalistst + 1;
+		pdmalistst->prev_list_addr = pdmalistst - 1;
+		pdmalistst->next_list_phy =
+			lpc32xx_dma_llist_v_to_p(ch,
+						 pdmalistst->next_list_addr);
+		pdmalistst->prev_list_phy =
+			lpc32xx_dma_llist_v_to_p(ch,
+						 pdmalistst->prev_list_addr);
+		pdmalistst++;
+	}
+	pdmalist[entries - 1].next_list_addr = pdmalist;
+	pdmalist[entries - 1].next_list_phy =
+		lpc32xx_dma_llist_v_to_p(ch,
+					 pdmalist[entries - 1].next_list_addr);
+	pdmalist->prev_list_addr = &pdmalist[entries - 1];
+	pdmalist->prev_list_phy =
+		lpc32xx_dma_llist_v_to_p(ch, pdmalist->prev_list_addr);
+
+	/* Save current free descriptors and current head/tail */
+	dma_ctrl.dma_channels[ch].free_entries = entries - 1;
+	dma_ctrl.dma_channels[ch].list_head = pdmalist;
+	dma_ctrl.dma_channels[ch].list_tail = pdmalist;
+	dma_ctrl.dma_channels[ch].list_curr = pdmalist;
+
+	return dma_ctrl.dma_channels[ch].list_vstart;
+}
+EXPORT_SYMBOL_GPL(lpc32xx_dma_alloc_llist);
+
+void lpc32xx_dma_dealloc_llist(int ch)
+{
+	if ((!VALID_CHANNEL(ch)) || (dma_ctrl.dma_channels[ch].name == NULL) ||
+	    (dma_ctrl.dma_channels[ch].list_vstart == 0))
+		return;
+
+	dma_free_coherent(NULL, dma_ctrl.dma_channels[ch].list_size,
+			  dma_ctrl.dma_channels[ch].list_vstart,
+			  dma_ctrl.dma_channels[ch].list_pstart);
+	dma_ctrl.dma_channels[ch].list_head = NULL;
+	dma_ctrl.dma_channels[ch].list_tail = NULL;
+	dma_ctrl.dma_channels[ch].list_entries = 0;
+	dma_ctrl.dma_channels[ch].free_entries = 0;
+	dma_ctrl.dma_channels[ch].list_vstart = NULL;
+}
+EXPORT_SYMBOL_GPL(lpc32xx_dma_dealloc_llist);
+
+struct dma_list_ctrl *lpc32xx_dma_get_llist_head(int ch)
+{
+	if ((!VALID_CHANNEL(ch)) || (dma_ctrl.dma_channels[ch].name == NULL) ||
+	    (dma_ctrl.dma_channels[ch].list_vstart == NULL))
+		return NULL;
+
+	/* Return the current list pointer (virtual) for the
+	   DMA channel */
+	return lpc32xx_dma_llist_p_to_v(ch,
+					__raw_readl(DMACH_LLI(DMAIOBASE, ch)));
+}
+EXPORT_SYMBOL_GPL(lpc32xx_dma_get_llist_head);
+
+void lpc32xx_dma_flush_llist(int ch)
+{
+	if ((!VALID_CHANNEL(ch)) || (dma_ctrl.dma_channels[ch].name == NULL) ||
+	    (dma_ctrl.dma_channels[ch].list_vstart == NULL))
+		return;
+
+	/* Disable channel and clear LLI */
+	__dma_regs_lock();
+	__dma_disable(ch);
+	__raw_writel(0, DMACH_LLI(DMAIOBASE, ch));
+	__dma_regs_unlock();
+
+	dma_ctrl.dma_channels[ch].list_head =
+		dma_ctrl.dma_channels[ch].list_vstart;
+	dma_ctrl.dma_channels[ch].list_tail =
+		dma_ctrl.dma_channels[ch].list_vstart;
+	dma_ctrl.dma_channels[ch].list_curr =
+		dma_ctrl.dma_channels[ch].list_vstart;
+	dma_ctrl.dma_channels[ch].free_entries =
+		dma_ctrl.dma_channels[ch].list_entries - 1;
+}
+EXPORT_SYMBOL_GPL(lpc32xx_dma_flush_llist);
+
+struct dma_list_ctrl *lpc32xx_dma_queue_llist_entry(int ch, dma_addr_t src,
+						    dma_addr_t dst, int size)
+{
+	struct dma_list_ctrl *plhead;
+	u32 ctrl, cfg;
+
+	if ((!VALID_CHANNEL(ch)) || (dma_ctrl.dma_channels[ch].name == NULL) ||
+	    (dma_ctrl.dma_channels[ch].list_vstart == NULL))
+		return NULL;
+
+	/* Exit if all the buffers are used */
+	if (dma_ctrl.dma_channels[ch].free_entries == 0)
+		return NULL;
+
+	/* Next available DMA link descriptor */
+	plhead = dma_ctrl.dma_channels[ch].list_head;
+
+	/* Adjust size to number of transfers (vs bytes) */
+	size = size / dma_ctrl.dma_channels[ch].dmacfg->dst_size;
+
+	/* Setup control and config words */
+	ctrl = dma_ctrl.dma_channels[ch].control | size;
+	cfg = dma_ctrl.dma_channels[ch].config | DMAC_CHAN_ENABLE |
+		dma_ctrl.dma_channels[ch].config_int_mask;
+
+	/* Populate DMA linked data structure */
+	plhead->dmall.src = src;
+	plhead->dmall.dest = dst;
+	plhead->dmall.next_lli = 0;
+	plhead->dmall.ctrl = ctrl;
+
+	__dma_regs_lock();
+
+	/* Append this link to the end of the previous link */
+	plhead->prev_list_addr->dmall.next_lli =
+		lpc32xx_dma_llist_v_to_p(ch, plhead);
+
+	/* Decrement available buffers */
+	dma_ctrl.dma_channels[ch].free_entries--;
+
+	/* If the DMA channel is idle, then the buffer needs to be placed
+	   directly into the DMA registers */
+	if ((__raw_readl(DMACH_CONFIG_CH(DMAIOBASE, ch)) & DMAC_CHAN_ENABLE)
+	    == 0) {
+		/* DMA is disabled, so move the current buffer into the
+		   channel registers and start transfer */
+		__raw_writel(src, DMACH_SRC_ADDR(DMAIOBASE, ch));
+		__raw_writel(dst, DMACH_DEST_ADDR(DMAIOBASE, ch));
+		__raw_writel(0, DMACH_LLI(DMAIOBASE, ch));
+		__raw_writel(ctrl, DMACH_CONTROL(DMAIOBASE, ch));
+		__raw_writel(cfg, DMACH_CONFIG_CH(DMAIOBASE, ch));
+	} else if (__raw_readl(DMACH_LLI(DMAIOBASE, ch)) == 0) {
+		/* Update current entry to next entry */
+		__raw_writel(dma_ctrl.dma_channels[ch].list_tail->next_list_phy,
+			     DMACH_LLI(DMAIOBASE, ch));
+
+		/*
+		 * If the channel was stopped before the next entry made it
+		 * into the hardware descriptor, the next entry didn't make
+		 * it there fast enough, so load the new descriptor here.
+		 */
+		if ((__raw_readl(DMACH_CONFIG_CH(DMAIOBASE, ch)) &
+		     DMAC_CHAN_ENABLE) == 0)	{
+			__raw_writel(src, DMACH_SRC_ADDR(DMAIOBASE, ch));
+			__raw_writel(dst, DMACH_DEST_ADDR(DMAIOBASE, ch));
+			__raw_writel(0, DMACH_LLI(DMAIOBASE, ch));
+			__raw_writel(ctrl, DMACH_CONTROL(DMAIOBASE, ch));
+			__raw_writel(cfg, DMACH_CONFIG_CH(DMAIOBASE, ch));
+		}
+	}
+
+	/* Process next link on next call */
+	dma_ctrl.dma_channels[ch].list_head = plhead->next_list_addr;
+
+	__dma_regs_unlock();
+
+	return plhead;
+}
+EXPORT_SYMBOL_GPL(lpc32xx_dma_queue_llist_entry);
+
+struct dma_list_ctrl *lpc32xx_get_free_llist_entry(int ch)
+{
+	struct dma_list_ctrl *pltail;
+
+	if ((!VALID_CHANNEL(ch)) || (dma_ctrl.dma_channels[ch].name == NULL) ||
+	    (dma_ctrl.dma_channels[ch].list_vstart == NULL))
+		return NULL;
+
+	/* Exit if no entries to free */
+	if (dma_ctrl.dma_channels[ch].free_entries ==
+	    dma_ctrl.dma_channels[ch].list_entries)
+		return NULL;
+
+	/* Get tail pointer */
+	pltail = dma_ctrl.dma_channels[ch].list_tail;
+
+	/* Next tail */
+	dma_ctrl.dma_channels[ch].list_tail = pltail->next_list_addr;
+
+	/* Increment available buffers */
+	dma_ctrl.dma_channels[ch].free_entries++;
+
+	return pltail;
+}
+EXPORT_SYMBOL_GPL(lpc32xx_get_free_llist_entry);
+
+int lpc32xx_dma_start_xfer(int ch, u32 config)
+{
+	struct dma_list_ctrl *plhead;
+
+	if ((!VALID_CHANNEL(ch)) || (dma_ctrl.dma_channels[ch].name == NULL) ||
+	    (dma_ctrl.dma_channels[ch].list_vstart == NULL))
+		return -1;
+
+	plhead = dma_ctrl.dma_channels[ch].list_head;
+	__dma_regs_lock();
+	__raw_writel(plhead->dmall.src, DMACH_SRC_ADDR(DMAIOBASE, ch));
+	__raw_writel(plhead->dmall.dest, DMACH_DEST_ADDR(DMAIOBASE, ch));
+	__raw_writel(plhead->dmall.next_lli, DMACH_LLI(DMAIOBASE, ch));
+	__raw_writel(plhead->dmall.ctrl, DMACH_CONTROL(DMAIOBASE, ch));
+	__raw_writel(config, DMACH_CONFIG_CH(DMAIOBASE, ch));
+	__dma_regs_unlock();
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(lpc32xx_dma_start_xfer);
+
+struct dma_list_ctrl *lpc32xx_dma_queue_llist(int ch, dma_addr_t src,
+						     dma_addr_t dst, int size,
+						     u32 ctrl)
+{
+	struct dma_list_ctrl *plhead;
+
+	if ((!VALID_CHANNEL(ch)) || (dma_ctrl.dma_channels[ch].name == NULL) ||
+	    (dma_ctrl.dma_channels[ch].list_vstart == NULL))
+		return NULL;
+
+	/* Exit if all the buffers are used */
+	if (dma_ctrl.dma_channels[ch].free_entries == 0)
+		return NULL;
+
+	/* Next available DMA link descriptor */
+	plhead = dma_ctrl.dma_channels[ch].list_curr;
+
+	/* Populate DMA linked data structure */
+	plhead->dmall.src = src;
+	plhead->dmall.dest = dst;
+	plhead->dmall.next_lli = 0;
+	plhead->dmall.ctrl = ctrl;
+
+	/* Append this link to the end of the previous link */
+	plhead->prev_list_addr->dmall.next_lli =
+		lpc32xx_dma_llist_v_to_p(ch, plhead);
+
+	/* Decrement available buffers */
+	dma_ctrl.dma_channels[ch].free_entries--;
+
+	/* Process next link on next call */
+	dma_ctrl.dma_channels[ch].list_curr = plhead->next_list_addr;
+
+	return plhead;
+}
+EXPORT_SYMBOL_GPL(lpc32xx_dma_queue_llist);
+
+extern void lpc32xx_dma_force_burst(int ch, int src)
+{
+	__raw_writel(1 << src, DMA_SW_BURST_REQ(DMAIOBASE));
+}
+EXPORT_SYMBOL_GPL(lpc32xx_dma_force_burst);
+
+static irqreturn_t dma_irq_handler(int irq, void *dev_id)
+{
+	int i;
+	unsigned long dint = __raw_readl(DMA_INT_STAT(DMAIOBASE));
+	unsigned long tcint = __raw_readl(DMA_INT_TC_STAT(DMAIOBASE));
+	unsigned long eint = __raw_readl(DMA_INT_ERR_STAT(DMAIOBASE));
+	unsigned long i_bit;
+
+	for (i = MAX_DMA_CHANNELS - 1; i >= 0; i--) {
+		i_bit = 1 << i;
+		if (dint & i_bit) {
+			struct dma_channel *channel = &dma_ctrl.dma_channels[i];
+
+			if (channel->name && channel->irq_handler) {
+				int cause = 0;
+
+				if (eint & i_bit) {
+					__raw_writel(i_bit,
+						DMA_INT_ERR_CLEAR(DMAIOBASE));
+					cause |= DMA_ERR_INT;
+				}
+				if (tcint & i_bit) {
+					__raw_writel(i_bit,
+						DMA_INT_TC_CLEAR(DMAIOBASE));
+					cause |= DMA_TC_INT;
+				}
+
+				channel->irq_handler(i, cause, channel->data);
+			} else {
+				/*
+				 * IRQ for an unregistered DMA channel
+				 */
+				__raw_writel(i_bit,
+					     DMA_INT_ERR_CLEAR(DMAIOBASE));
+				__raw_writel(i_bit,
+					     DMA_INT_TC_CLEAR(DMAIOBASE));
+				printk(KERN_WARNING
+				       "spurious IRQ for DMA channel %d\n", i);
+			}
+		}
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int __init lpc32xx_dma_init(void)
+{
+	int ret;
+
+	ret = request_irq(IRQ_LPC32XX_DMA, dma_irq_handler, 0, "DMA", NULL);
+	if (ret) {
+		printk(KERN_CRIT "Wow!  Can't register IRQ for DMA\n");
+		goto out;
+	}
+
+	/* Get DMA clock */
+	dma_ctrl.clk = clk_get(NULL, "clk_dmac");
+	if (IS_ERR(dma_ctrl.clk)) {
+		ret = -ENODEV;
+		goto errout;
+	}
+	clk_enable(dma_ctrl.clk);
+
+	/* Clear DMA controller */
+	__raw_writel(1, DMA_CONFIG(DMAIOBASE));
+	__raw_writel(0xFF, DMA_INT_TC_CLEAR(DMAIOBASE));
+	__raw_writel(0xFF, DMA_INT_ERR_CLEAR(DMAIOBASE));
+
+	/* Clock is only enabled when needed to save power */
+	clk_disable(dma_ctrl.clk);
+
+	return 0;
+
+errout:
+	free_irq(IRQ_LPC32XX_DMA, NULL);
+
+out:
+	return ret;
+}
+arch_initcall(lpc32xx_dma_init);
--- /dev/null
+++ linux-2.6/arch/arm/mach-lpc32xx/include/mach/dma.h
@@ -0,0 +1,131 @@
+/*
+ * asm-arm/arch-lpc32xx/dma.h
+ *
+ * Author: Kevin Wells <kevin.wells@nxp.com>
+ *
+ * Copyright (C) 2008 NXP Semiconductors
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#ifndef __ASM_ARCH_DMA_H
+#define __ASM_ARCH_DMA_H
+
+#include <mach/platform.h>
+
+#define MAX_DMA_CHANNELS 8
+
+#define DMA_CH_SDCARD_TX	0
+#define DMA_CH_SDCARD_RX	1
+#define DMA_CH_I2S_TX		2
+#define DMA_CH_I2S_RX		3
+#define DMA_CH_NAND		4
+
+enum {
+	DMA_INT_UNKNOWN = 0,
+	DMA_ERR_INT = 1,
+	DMA_TC_INT = 2,
+};
+
+struct dma_linked_list {
+	__le32 src;
+	__le32 dest;
+	__le32 next_lli;
+	__le32 ctrl;
+};
+
+/* For DMA linked list operation, a linked list of DMA descriptors
+   is maintained along with some data to manage the list in software. */
+struct dma_list_ctrl {
+	struct dma_linked_list dmall; /* DMA list descriptor */
+	struct dma_list_ctrl *next_list_addr;
+	struct dma_list_ctrl *prev_list_addr;
+	dma_addr_t next_list_phy;
+	dma_addr_t prev_list_phy;
+};
+
+/*
+ * DMA channel control structure
+ */
+struct dma_config {
+	int ch;		/* Channel # to use */
+	int tc_inten;	/* !0 = Enable TC interrupts for this channel */
+	int err_inten;	/* !0 = Enable error interrupts for this channel */
+	int src_size;	/* Source xfer size - must be 1, 2, or 4 */
+	int src_inc;	/* !0 = Enable source address increment */
+	int src_ahb1;	/* !0 = Use AHB1 for source transfer */
+	int src_bsize;	/* Source burst size (ie, DMAC_CHAN_SRC_BURST_xxx) */
+	u32 src_prph;	/* Source peripheral (ie, DMA_PERID_xxxx) */
+	int dst_size;	/* Destination xfer size - must be 1, 2, or 4 */
+	int dst_inc;	/* !0 = Enable destination address increment */
+	int dst_ahb1;	/* !0 = Use AHB1 for destination transfer */
+	int dst_bsize;	/* Destination burst size */
+			/* (ie, DMAC_CHAN_DEST_BURST_xxx) */
+	u32 dst_prph;	/* Destination peripheral (ie, DMA_PERID_xxxx) */
+	u32 flowctrl;	/* Flow control (ie, DMAC_CHAN_FLOW_xxxxxx) */
+};
+
+/*
+ * Channel enable and disable functions
+ */
+extern int lpc32xx_dma_ch_enable(int ch);
+extern int lpc32xx_dma_ch_disable(int ch);
+
+/*
+ * Channel allocation and deallocation functions
+ */
+extern int lpc32xx_dma_ch_get(struct dma_config *dmachcfg,
+				char *name,
+				void *irq_handler,
+				void *data);
+extern int lpc32xx_dma_ch_put(int ch);
+extern int lpc32xx_dma_ch_pause_unpause(int ch, int pause);
+
+/*
+ * Setup or start an unbound DMA transfer
+ */
+extern int lpc32xx_dma_start_pflow_xfer(int ch,
+					dma_addr_t src,
+					dma_addr_t dst,
+					int enable);
+
+/*
+ * DMA channel status
+ */
+extern int lpc32xx_dma_is_active(int ch);
+
+/*
+ * DMA linked list support
+ */
+extern struct dma_list_ctrl *lpc32xx_dma_alloc_llist(int ch, int entries);
+extern void lpc32xx_dma_dealloc_llist(int ch);
+extern dma_addr_t lpc32xx_dma_llist_v_to_p(int ch, struct dma_list_ctrl *vlist);
+extern struct dma_list_ctrl *lpc32xx_dma_llist_p_to_v(int ch, dma_addr_t plist);
+extern struct dma_list_ctrl *lpc32xx_dma_get_llist_head(int ch);
+extern void lpc32xx_dma_flush_llist(int ch);
+extern struct dma_list_ctrl *lpc32xx_dma_queue_llist_entry(int ch,
+							   dma_addr_t src,
+							   dma_addr_t dst,
+							   int size);
+extern struct dma_list_ctrl *lpc32xx_get_free_llist_entry(int ch);
+extern struct dma_list_ctrl *lpc32xx_dma_queue_llist(int ch,
+						     dma_addr_t src,
+						     dma_addr_t dst,
+						     int size,
+						     u32 ctrl);
+extern int lpc32xx_dma_start_xfer(int chan, u32 config);
+extern void lpc32xx_dma_force_burst(int ch, int src);
+
+#endif /* _ASM_ARCH_DMA_H */
--- /dev/null
+++ linux-2.6/arch/arm/mach-lpc32xx/include/mach/dmac.h
@@ -0,0 +1,285 @@
+/*
+ * asm-arm/arch-lpc32xx/dmac.h
+ *
+ * Author: Kevin Wells <kevin.wells@nxp.com>
+ *
+ * Copyright (C) 2008 NXP Semiconductors
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#ifndef __ASM_ARCH_DMAC_H
+#define __ASM_ARCH_DMAC_H
+
+/**********************************************************************
+* DMA register offsets
+**********************************************************************/
+
+/* DMA controller register structures */
+#define DMA_INT_STAT(x)			(x + 0x00)
+#define DMA_INT_TC_STAT(x)		(x + 0x04)
+#define DMA_INT_TC_CLEAR(x)		(x + 0x08)
+#define DMA_INT_ERR_STAT(x)		(x + 0x0C)
+#define DMA_INT_ERR_CLEAR(x)		(x + 0x10)
+#define DMA_RAW_TC_STAT(x)		(x + 0x14)
+#define DMA_RAW_ERR_STAT(x)		(x + 0x18)
+#define DMA_CH_ENABLE(x)		(x + 0x1C)
+#define DMA_SW_BURST_REQ(x)		(x + 0x20)
+#define DMA_SW_SINGLE_REQ(x)		(x + 0x24)
+#define DMA_SW_LAST_BURST_REQ(x)	(x + 0x28)
+#define DMA_SW_LAST_SINGLE_REQ(x)	(x + 0x2C)
+#define DMA_CONFIG(x)			(x + 0x30)
+#define DMA_SYNC(x)			(x + 0x34)
+
+/* DMA controller channel register structure */
+#define DMA_CH_OFFS(c)			((c * 0x20) + 0x100)
+#define DMACH_SRC_ADDR(x, c)		(x + DMA_CH_OFFS(c) + 0x00)
+#define DMACH_DEST_ADDR(x, c)		(x + DMA_CH_OFFS(c) + 0x04)
+#define DMACH_LLI(x, c)			(x + DMA_CH_OFFS(c) + 0x08)
+#define DMACH_CONTROL(x, c)		(x + DMA_CH_OFFS(c) + 0x0C)
+#define DMACH_CONFIG_CH(x, c)		(x + DMA_CH_OFFS(c) + 0x10)
+
+/* DMA linked list structure */
+#define DMA_LL_SRC(x)			(x + 0x0)
+#define DMA_LL_DEST(x)			(x + 0x4)
+#define DMA_LL_NEXT_LLI(x)		(x + 0x8)
+#define DMA_LL_NEXT_CTRL(x)		(x + 0xC)
+
+#define DMA_LL_SIZE 16
+
+/**********************************************************************
+* int_stat, int_tc_stat, int_tc_clear, int_err_stat, raw_tc_stat,
+* raw_err_stat, and chan_enable register definitions
+**********************************************************************/
+/* Macro for determining a bit position for a channel */
+#define DMAC_GET_CHAN_POS(chan)     (0x1 << ((chan) & 0x7))
+
+/**********************************************************************
+* sw_burst_req, sw_single_req, sw_last_burst_req, sw_last_single_req,
+* and sync register definitions
+**********************************************************************/
+/* Peripheral DMA bit position for I2S0 DMA0 */
+#define DMA_PER_I2S0_DMA0           _BIT(0)
+
+/* Peripheral DMA bit position for NAND FLASH (same as 12) */
+#define DMA_PER_NAND1               _BIT(1)
+
+/* Peripheral DMA bit position for I2S1 DMA0 */
+#define DMA_PER_I2S1_DMA0           _BIT(2)
+
+/* Peripheral DMA bit position for SPI2 (RX and TX) */
+#define DMA_PER_SPI2_TXRX           _BIT(3)
+
+/* Peripheral DMA bit position for SSP1 (RX) */
+#define DMA_PER_SSP1_RX             _BIT(3)
+
+/* Peripheral DMA bit position for SD card */
+#define DMA_PER_SDCARD              _BIT(4)
+
+/* Peripheral DMA bit position for HSUART1 TX */
+#define DMA_PER_HSUART1_TX          _BIT(5)
+
+/* Peripheral DMA bit position for HSUART1 RX */
+#define DMA_PER_HSUART1_RX          _BIT(6)
+
+/* Peripheral DMA bit position for HSUART2 TX */
+#define DMA_PER_HSUART2_TX          _BIT(7)
+
+/* Peripheral DMA bit position for HSUART2 RX */
+#define DMA_PER_HSUART2_RX          _BIT(8)
+
+/* Peripheral DMA bit position for HSUART7 TX */
+#define DMA_PER_HSUART7_TX          _BIT(9)
+
+/* Peripheral DMA bit position for HSUART7 RX */
+#define DMA_PER_HSUART7_RX          _BIT(10)
+
+/* Peripheral DMA bit position for I2S1 DMA1 */
+#define DMA_PER_I2S1_DMA1           _BIT(10)
+
+/* Peripheral DMA bit position for SPI1 (RX and TX) */
+#define DMA_PER_SPI1_TXRX           _BIT(11)
+
+/* Peripheral DMA bit position for SSP1 (TX) */
+#define DMA_PER_SSP1_TX             _BIT(11)
+
+/* Peripheral DMA bit position for NAND FLASH (same as 1) */
+#define DMA_PER_NAND2               _BIT(12)
+
+/* Peripheral DMA bit position for I2S0 DMA1 */
+#define DMA_PER_I2S0_DMA1           _BIT(13)
+
+/* Peripheral DMA bit position for SSP0 (RX) */
+#define DMA_PER_SSP0_RX             _BIT(14)
+
+/* Peripheral DMA bit position for SSP0 (TX) */
+#define DMA_PER_SSP0_TX             _BIT(15)
+
+/**********************************************************************
+* config register definitions
+**********************************************************************/
+/* Bit for enabling big endian mode on AHB 1 */
+#define DMAC_BIG_ENDIAN_AHB1        _BIT(2)
+
+/* Bit for enabling big endian mode on AHB 0 */
+#define DMAC_BIG_ENDIAN_AHB0        _BIT(1)
+
+/* Bit for enabling the DMA controller */
+#define DMAC_CTRL_ENABLE            _BIT(0)
+
+/**********************************************************************
+* lli register definitions
+**********************************************************************/
+/* Bit for selecting AHB0 (0) or AHB1 (1) */
+#define DMAC_CHAN_LLI_SEL_AHB1      _BIT(0)
+
+/**********************************************************************
+* control register definitions
+**********************************************************************/
+/* Bit for enabling a channel terminal count interrupt */
+#define DMAC_CHAN_INT_TC_EN         _BIT(31)
+
+/* Bit for indicating address is cacheable */
+#define DMAC_CHAN_PROT3             _BIT(30)
+
+/* Bit for indicating address is bufferable */
+#define DMAC_CHAN_PROT2             _BIT(29)
+
+/* Bit for indicating address is privelaged mode (1) or user
+   mode (0) */
+#define DMAC_CHAN_PROT1             _BIT(28)
+
+/* Bit for enabling automatic destination increment */
+#define DMAC_CHAN_DEST_AUTOINC      _BIT(27)
+
+/* Bit for enabling automatic source increment */
+#define DMAC_CHAN_SRC_AUTOINC       _BIT(26)
+
+/* Bit for using AHB1 master for destination transfer */
+#define DMAC_CHAN_DEST_AHB1         _BIT(25)
+
+/* Bit for using AHB1 master for source transfer */
+#define DMAC_CHAN_SRC_AHB1          _BIT(24)
+
+/* Destination data width selection defines */
+#define DMAC_CHAN_DEST_WIDTH_8      0x0
+#define DMAC_CHAN_DEST_WIDTH_16     _BIT(21)
+#define DMAC_CHAN_DEST_WIDTH_32     _BIT(22)
+
+/* Source data width selection defines */
+#define DMAC_CHAN_SRC_WIDTH_8       0x0
+#define DMAC_CHAN_SRC_WIDTH_16      _BIT(18)
+#define DMAC_CHAN_SRC_WIDTH_32      _BIT(19)
+
+/* Destination data burst size defines (in transfer width) */
+#define DMAC_CHAN_DEST_BURST_1      0
+#define DMAC_CHAN_DEST_BURST_4      _BIT(15)
+#define DMAC_CHAN_DEST_BURST_8      _BIT(16)
+#define DMAC_CHAN_DEST_BURST_16     (_BIT(16) | _BIT(15))
+#define DMAC_CHAN_DEST_BURST_32     _BIT(17)
+#define DMAC_CHAN_DEST_BURST_64     (_BIT(17) | _BIT(15))
+#define DMAC_CHAN_DEST_BURST_128    (_BIT(17) | _BIT(16))
+#define DMAC_CHAN_DEST_BURST_256    (_BIT(17) | _BIT(16) | _BIT(15))
+
+/* Macro for direct loading of destination burst size field */
+#define DMAC_CHAN_DEST_BURST_LOAD(n) (((n) & 0x7) << 15)
+
+/* Source data burst size defines (in transfer width) */
+#define DMAC_CHAN_SRC_BURST_1       0
+#define DMAC_CHAN_SRC_BURST_4       _BIT(12)
+#define DMAC_CHAN_SRC_BURST_8       _BIT(13)
+#define DMAC_CHAN_SRC_BURST_16      (_BIT(13) | _BIT(12))
+#define DMAC_CHAN_SRC_BURST_32      _BIT(14)
+#define DMAC_CHAN_SRC_BURST_64      (_BIT(14) | _BIT(12))
+#define DMAC_CHAN_SRC_BURST_128     (_BIT(14) | _BIT(13))
+#define DMAC_CHAN_SRC_BURST_256     (_BIT(14) | _BIT(13) | _BIT(12))
+
+/* Macro for direct loading of source burst size field */
+#define DMAC_CHAN_SRC_BURST_LOAD(n) (((n) & 0x7) << 12)
+
+/* Macro for loading transfer size */
+#define DMAC_CHAN_TRANSFER_SIZE(n)  ((n) & 0xFFF)
+
+/**********************************************************************
+* config_ch register definitions
+**********************************************************************/
+/* Bit for halting a DMA transfer */
+#define DMAC_CHAN_HALT              _BIT(18)
+
+/* Bit for checking active status of the DMA channel */
+#define DMAC_CHAN_ACTIVE            _BIT(17)
+
+/* Bit for enabling locked transfers */
+#define DMAC_CHAN_LOCK              _BIT(16)
+
+/* Terminal count interrupt mask bit */
+#define DMAC_CHAN_ITC               _BIT(15)
+
+/* Interrupt error mask bit */
+#define DMAC_CHAN_IE                _BIT(14)
+
+/* Defines for flow control with DMA as the controller */
+#define DMAC_CHAN_FLOW_D_M2M        (0x0 << 11)
+#define DMAC_CHAN_FLOW_D_M2P        (0x1 << 11)
+#define DMAC_CHAN_FLOW_D_P2M        (0x2 << 11)
+#define DMAC_CHAN_FLOW_D_SP2DP      (0x3 << 11)
+
+/* Defines for flow control with destination peripheral as the
+   controller */
+#define DMAC_CHAN_FLOW_DP_SP2DP     (0x4 << 11)
+
+/* Defines for flow control with peripheral as the controller */
+#define DMAC_CHAN_FLOW_P_M2P        (0x5 << 11)
+#define DMAC_CHAN_FLOW_P_P2M        (0x6 << 11)
+
+/* Defines for flow control with source peripheral as the
+   controller */
+#define DMAC_CHAN_FLOW_SP_SP2DP     (0x7 << 11)
+
+/* Macro for loading destination peripheral */
+#define DMAC_DEST_PERIP(n)          (((n) & 0x1F) << 6)
+
+/* Macro for loading source peripheral */
+#define DMAC_SRC_PERIP(n)           (((n) & 0x1F) << 1)
+
+/* Channel enable bit */
+#define DMAC_CHAN_ENABLE            _BIT(0)
+
+/**********************************************************************
+* config_ch register definitions (source and destination
+* peripheral ID numbers). These can be used with the DMAC_DEST_PERIP
+* and DMAC_SRC_PERIP macros.
+**********************************************************************/
+#define DMA_PERID_I2S0_DMA0         0
+#define DMA_PERID_NAND1             1
+#define DMA_PERID_I2S1_DMA0         2
+#define DMA_PERID_SPI2_TXRX         3
+#define DMA_PERID_SSP1_RX           3
+#define DMA_PERID_SDCARD            4
+#define DMA_PERID_HSUART1_TX        5
+#define DMA_PERID_HSUART1_RX        6
+#define DMA_PERID_HSUART2_TX        7
+#define DMA_PERID_HSUART2_RX        8
+#define DMA_PERID_HSUART7_TX        9
+#define DMA_PERID_HSUART7_RX        10
+#define DMA_PERID_I2S1_DMA1         10
+#define DMA_PERID_SPI1_TXRX         11
+#define DMA_PERID_SSP1_TX           11
+#define DMA_PERID_NAND2             12
+#define DMA_PERID_I2S0_DMA1         13
+#define DMA_PERID_SSP0_RX           14
+#define DMA_PERID_SSP0_TX           15
+
+#endif /* __ASM_ARCH_DMAC_H */
