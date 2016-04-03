From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sun,  3 Apr 2016 11:23:59 +0200
Subject: [PATCH] ARM: pxa: remove platform dma code
Message-ID: <1459675439-25941-1-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As the last pxa related driver was converted to dmaengine, it's time to
kill the legacy dma code, which is not used anymore.

This finishes the pxa dmaengine transition.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 arch/arm/mach-pxa/devices.h          |   1 +
 arch/arm/mach-pxa/include/mach/dma.h |   1 -
 arch/arm/mach-pxa/pxa25x.c           |   3 -
 arch/arm/mach-pxa/pxa27x.c           |   3 -
 arch/arm/mach-pxa/pxa3xx.c           |   3 -
 arch/arm/plat-pxa/Makefile           |   2 -
 arch/arm/plat-pxa/dma.c              | 386 -----------------------------------
 arch/arm/plat-pxa/include/plat/dma.h | 100 ---------
 8 files changed, 1 insertion(+), 498 deletions(-)
 delete mode 100644 arch/arm/plat-pxa/dma.c
 delete mode 100644 arch/arm/plat-pxa/include/plat/dma.h

diff --git a/arch/arm/mach-pxa/devices.h b/arch/arm/mach-pxa/devices.h
index 4a13c32fb705..04580c407276 100644
--- a/arch/arm/mach-pxa/devices.h
+++ b/arch/arm/mach-pxa/devices.h
@@ -54,3 +54,4 @@ extern struct platform_device pxa3xx_device_gpio;
 extern struct platform_device pxa93x_device_gpio;
 
 void __init pxa_register_device(struct platform_device *dev, void *data);
+void __init pxa2xx_set_dmac_info(int nb_channels, int nb_requestors);
diff --git a/arch/arm/mach-pxa/include/mach/dma.h b/arch/arm/mach-pxa/include/mach/dma.h
index 5bd55894a48d..20026bdc6b24 100644
--- a/arch/arm/mach-pxa/include/mach/dma.h
+++ b/arch/arm/mach-pxa/include/mach/dma.h
@@ -17,5 +17,4 @@
 /* DMA Controller Registers Definitions */
 #define DMAC_REGS_VIRT	io_p2v(0x40000000)
 
-#include <plat/dma.h>
 #endif /* _ASM_ARCH_DMA_H */
diff --git a/arch/arm/mach-pxa/pxa25x.c b/arch/arm/mach-pxa/pxa25x.c
index 823504f48f80..ec986524863b 100644
--- a/arch/arm/mach-pxa/pxa25x.c
+++ b/arch/arm/mach-pxa/pxa25x.c
@@ -198,9 +198,6 @@ static int __init pxa25x_init(void)
 
 		reset_status = RCSR;
 
-		if ((ret = pxa_init_dma(IRQ_DMA, 16)))
-			return ret;
-
 		pxa25x_init_pm();
 
 		register_syscore_ops(&pxa_irq_syscore_ops);
diff --git a/arch/arm/mach-pxa/pxa27x.c b/arch/arm/mach-pxa/pxa27x.c
index 2eaa341dd3f8..488d0ab789d2 100644
--- a/arch/arm/mach-pxa/pxa27x.c
+++ b/arch/arm/mach-pxa/pxa27x.c
@@ -300,9 +300,6 @@ static int __init pxa27x_init(void)
 
 		reset_status = RCSR;
 
-		if ((ret = pxa_init_dma(IRQ_DMA, 32)))
-			return ret;
-
 		pxa27x_init_pm();
 
 		register_syscore_ops(&pxa_irq_syscore_ops);
diff --git a/arch/arm/mach-pxa/pxa3xx.c b/arch/arm/mach-pxa/pxa3xx.c
index 3c9184d1d6b9..6a014c8d8a47 100644
--- a/arch/arm/mach-pxa/pxa3xx.c
+++ b/arch/arm/mach-pxa/pxa3xx.c
@@ -438,9 +438,6 @@ static int __init pxa3xx_init(void)
 		 */
 		NDCR = (NDCR & ~NDCR_ND_ARB_EN) | NDCR_ND_ARB_CNTL;
 
-		if ((ret = pxa_init_dma(IRQ_DMA, 32)))
-			return ret;
-
 		pxa3xx_init_pm();
 
 		register_syscore_ops(&pxa_irq_syscore_ops);
diff --git a/arch/arm/plat-pxa/Makefile b/arch/arm/plat-pxa/Makefile
index 557b134db772..2f06a2e8b1dd 100644
--- a/arch/arm/plat-pxa/Makefile
+++ b/arch/arm/plat-pxa/Makefile
@@ -3,8 +3,6 @@
 #
 ccflags-$(CONFIG_ARCH_MMP) := -I$(srctree)/$(src)/include
 
-obj-$(CONFIG_ARCH_PXA)		:= dma.o
-
 obj-$(CONFIG_PXA3xx)		+= mfp.o
 obj-$(CONFIG_ARCH_MMP)		+= mfp.o
 
diff --git a/arch/arm/plat-pxa/dma.c b/arch/arm/plat-pxa/dma.c
deleted file mode 100644
index de2b061889ec..000000000000
--- a/arch/arm/plat-pxa/dma.c
+++ /dev/null
@@ -1,386 +0,0 @@
-/*
- *  linux/arch/arm/plat-pxa/dma.c
- *
- *  PXA DMA registration and IRQ dispatching
- *
- *  Author:	Nicolas Pitre
- *  Created:	Nov 15, 2001
- *  Copyright:	MontaVista Software Inc.
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2 as
- *  published by the Free Software Foundation.
- */
-
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/slab.h>
-#include <linux/kernel.h>
-#include <linux/interrupt.h>
-#include <linux/errno.h>
-#include <linux/dma-mapping.h>
-
-#include <asm/irq.h>
-#include <asm/memory.h>
-#include <mach/hardware.h>
-#include <mach/dma.h>
-
-#define DMA_DEBUG_NAME		"pxa_dma"
-#define DMA_MAX_REQUESTERS	64
-
-struct dma_channel {
-	char *name;
-	pxa_dma_prio prio;
-	void (*irq_handler)(int, void *);
-	void *data;
-	spinlock_t lock;
-};
-
-static struct dma_channel *dma_channels;
-static int num_dma_channels;
-
-/*
- * Debug fs
- */
-#ifdef CONFIG_DEBUG_FS
-#include <linux/debugfs.h>
-#include <linux/uaccess.h>
-#include <linux/seq_file.h>
-
-static struct dentry *dbgfs_root, *dbgfs_state, **dbgfs_chan;
-
-static int dbg_show_requester_chan(struct seq_file *s, void *p)
-{
-	int chan = (int)s->private;
-	int i;
-	u32 drcmr;
-
-	seq_printf(s, "DMA channel %d requesters list :\n", chan);
-	for (i = 0; i < DMA_MAX_REQUESTERS; i++) {
-		drcmr = DRCMR(i);
-		if ((drcmr & DRCMR_CHLNUM) == chan)
-			seq_printf(s, "\tRequester %d (MAPVLD=%d)\n",
-				   i, !!(drcmr & DRCMR_MAPVLD));
-	}
-
-	return 0;
-}
-
-static inline int dbg_burst_from_dcmd(u32 dcmd)
-{
-	int burst = (dcmd >> 16) & 0x3;
-
-	return burst ? 4 << burst : 0;
-}
-
-static int is_phys_valid(unsigned long addr)
-{
-	return pfn_valid(__phys_to_pfn(addr));
-}
-
-#define DCSR_STR(flag) (dcsr & DCSR_##flag ? #flag" " : "")
-#define DCMD_STR(flag) (dcmd & DCMD_##flag ? #flag" " : "")
-
-static int dbg_show_descriptors(struct seq_file *s, void *p)
-{
-	int chan = (int)s->private;
-	int i, max_show = 20, burst, width;
-	u32 dcmd;
-	unsigned long phys_desc;
-	struct pxa_dma_desc *desc;
-	unsigned long flags;
-
-	spin_lock_irqsave(&dma_channels[chan].lock, flags);
-	phys_desc = DDADR(chan);
-
-	seq_printf(s, "DMA channel %d descriptors :\n", chan);
-	seq_printf(s, "[%03d] First descriptor unknown\n", 0);
-	for (i = 1; i < max_show && is_phys_valid(phys_desc); i++) {
-		desc = phys_to_virt(phys_desc);
-		dcmd = desc->dcmd;
-		burst = dbg_burst_from_dcmd(dcmd);
-		width = (1 << ((dcmd >> 14) & 0x3)) >> 1;
-
-		seq_printf(s, "[%03d] Desc at %08lx(virt %p)\n",
-			   i, phys_desc, desc);
-		seq_printf(s, "\tDDADR = %08x\n", desc->ddadr);
-		seq_printf(s, "\tDSADR = %08x\n", desc->dsadr);
-		seq_printf(s, "\tDTADR = %08x\n", desc->dtadr);
-		seq_printf(s, "\tDCMD  = %08x (%s%s%s%s%s%s%sburst=%d width=%d len=%d)\n",
-			   dcmd,
-			   DCMD_STR(INCSRCADDR), DCMD_STR(INCTRGADDR),
-			   DCMD_STR(FLOWSRC), DCMD_STR(FLOWTRG),
-			   DCMD_STR(STARTIRQEN), DCMD_STR(ENDIRQEN),
-			   DCMD_STR(ENDIAN), burst, width,
-			   dcmd & DCMD_LENGTH);
-		phys_desc = desc->ddadr;
-	}
-	if (i == max_show)
-		seq_printf(s, "[%03d] Desc at %08lx ... max display reached\n",
-			   i, phys_desc);
-	else
-		seq_printf(s, "[%03d] Desc at %08lx is %s\n",
-			   i, phys_desc, phys_desc == DDADR_STOP ?
-			   "DDADR_STOP" : "invalid");
-
-	spin_unlock_irqrestore(&dma_channels[chan].lock, flags);
-
-	return 0;
-}
-
-static int dbg_show_chan_state(struct seq_file *s, void *p)
-{
-	int chan = (int)s->private;
-	u32 dcsr, dcmd;
-	int burst, width;
-	static char *str_prio[] = { "high", "normal", "low" };
-
-	dcsr = DCSR(chan);
-	dcmd = DCMD(chan);
-	burst = dbg_burst_from_dcmd(dcmd);
-	width = (1 << ((dcmd >> 14) & 0x3)) >> 1;
-
-	seq_printf(s, "DMA channel %d\n", chan);
-	seq_printf(s, "\tPriority : %s\n", str_prio[dma_channels[chan].prio]);
-	seq_printf(s, "\tUnaligned transfer bit: %s\n",
-		   DALGN & (1 << chan) ? "yes" : "no");
-	seq_printf(s, "\tDCSR  = %08x (%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s)\n",
-		   dcsr, DCSR_STR(RUN), DCSR_STR(NODESC),
-		   DCSR_STR(STOPIRQEN), DCSR_STR(EORIRQEN),
-		   DCSR_STR(EORJMPEN), DCSR_STR(EORSTOPEN),
-		   DCSR_STR(SETCMPST), DCSR_STR(CLRCMPST),
-		   DCSR_STR(CMPST), DCSR_STR(EORINTR), DCSR_STR(REQPEND),
-		   DCSR_STR(STOPSTATE), DCSR_STR(ENDINTR),
-		   DCSR_STR(STARTINTR), DCSR_STR(BUSERR));
-
-	seq_printf(s, "\tDCMD  = %08x (%s%s%s%s%s%s%sburst=%d width=%d len=%d)\n",
-		   dcmd,
-		   DCMD_STR(INCSRCADDR), DCMD_STR(INCTRGADDR),
-		   DCMD_STR(FLOWSRC), DCMD_STR(FLOWTRG),
-		   DCMD_STR(STARTIRQEN), DCMD_STR(ENDIRQEN),
-		   DCMD_STR(ENDIAN), burst, width, dcmd & DCMD_LENGTH);
-	seq_printf(s, "\tDSADR = %08x\n", DSADR(chan));
-	seq_printf(s, "\tDTADR = %08x\n", DTADR(chan));
-	seq_printf(s, "\tDDADR = %08x\n", DDADR(chan));
-
-	return 0;
-}
-
-static int dbg_show_state(struct seq_file *s, void *p)
-{
-	/* basic device status */
-	seq_puts(s, "DMA engine status\n");
-	seq_printf(s, "\tChannel number: %d\n", num_dma_channels);
-
-	return 0;
-}
-
-#define DBGFS_FUNC_DECL(name) \
-static int dbg_open_##name(struct inode *inode, struct file *file) \
-{ \
-	return single_open(file, dbg_show_##name, inode->i_private); \
-} \
-static const struct file_operations dbg_fops_##name = { \
-	.owner		= THIS_MODULE, \
-	.open		= dbg_open_##name, \
-	.llseek		= seq_lseek, \
-	.read		= seq_read, \
-	.release	= single_release, \
-}
-
-DBGFS_FUNC_DECL(state);
-DBGFS_FUNC_DECL(chan_state);
-DBGFS_FUNC_DECL(descriptors);
-DBGFS_FUNC_DECL(requester_chan);
-
-static struct dentry *pxa_dma_dbg_alloc_chan(int ch, struct dentry *chandir)
-{
-	char chan_name[11];
-	struct dentry *chan, *chan_state = NULL, *chan_descr = NULL;
-	struct dentry *chan_reqs = NULL;
-	void *dt;
-
-	scnprintf(chan_name, sizeof(chan_name), "%d", ch);
-	chan = debugfs_create_dir(chan_name, chandir);
-	dt = (void *)ch;
-
-	if (chan)
-		chan_state = debugfs_create_file("state", 0400, chan, dt,
-						 &dbg_fops_chan_state);
-	if (chan_state)
-		chan_descr = debugfs_create_file("descriptors", 0400, chan, dt,
-						 &dbg_fops_descriptors);
-	if (chan_descr)
-		chan_reqs = debugfs_create_file("requesters", 0400, chan, dt,
-						&dbg_fops_requester_chan);
-	if (!chan_reqs)
-		goto err_state;
-
-	return chan;
-
-err_state:
-	debugfs_remove_recursive(chan);
-	return NULL;
-}
-
-static void pxa_dma_init_debugfs(void)
-{
-	int i;
-	struct dentry *chandir;
-
-	dbgfs_root = debugfs_create_dir(DMA_DEBUG_NAME, NULL);
-	if (IS_ERR(dbgfs_root) || !dbgfs_root)
-		goto err_root;
-
-	dbgfs_state = debugfs_create_file("state", 0400, dbgfs_root, NULL,
-					  &dbg_fops_state);
-	if (!dbgfs_state)
-		goto err_state;
-
-	dbgfs_chan = kmalloc(sizeof(*dbgfs_state) * num_dma_channels,
-			     GFP_KERNEL);
-	if (!dbgfs_chan)
-		goto err_alloc;
-
-	chandir = debugfs_create_dir("channels", dbgfs_root);
-	if (!chandir)
-		goto err_chandir;
-
-	for (i = 0; i < num_dma_channels; i++) {
-		dbgfs_chan[i] = pxa_dma_dbg_alloc_chan(i, chandir);
-		if (!dbgfs_chan[i])
-			goto err_chans;
-	}
-
-	return;
-err_chans:
-err_chandir:
-	kfree(dbgfs_chan);
-err_alloc:
-err_state:
-	debugfs_remove_recursive(dbgfs_root);
-err_root:
-	pr_err("pxa_dma: debugfs is not available\n");
-}
-
-static void __exit pxa_dma_cleanup_debugfs(void)
-{
-	debugfs_remove_recursive(dbgfs_root);
-}
-#else
-static inline void pxa_dma_init_debugfs(void) {}
-static inline void pxa_dma_cleanup_debugfs(void) {}
-#endif
-
-int pxa_request_dma (char *name, pxa_dma_prio prio,
-			void (*irq_handler)(int, void *),
-			void *data)
-{
-	unsigned long flags;
-	int i, found = 0;
-
-	/* basic sanity checks */
-	if (!name || !irq_handler)
-		return -EINVAL;
-
-	local_irq_save(flags);
-
-	do {
-		/* try grabbing a DMA channel with the requested priority */
-		for (i = 0; i < num_dma_channels; i++) {
-			if ((dma_channels[i].prio == prio) &&
-			    !dma_channels[i].name &&
-			    !pxad_toggle_reserved_channel(i)) {
-				found = 1;
-				break;
-			}
-		}
-		/* if requested prio group is full, try a hier priority */
-	} while (!found && prio--);
-
-	if (found) {
-		DCSR(i) = DCSR_STARTINTR|DCSR_ENDINTR|DCSR_BUSERR;
-		dma_channels[i].name = name;
-		dma_channels[i].irq_handler = irq_handler;
-		dma_channels[i].data = data;
-	} else {
-		printk (KERN_WARNING "No more available DMA channels for %s\n", name);
-		i = -ENODEV;
-	}
-
-	local_irq_restore(flags);
-	return i;
-}
-EXPORT_SYMBOL(pxa_request_dma);
-
-void pxa_free_dma (int dma_ch)
-{
-	unsigned long flags;
-
-	if (!dma_channels[dma_ch].name) {
-		printk (KERN_CRIT
-			"%s: trying to free channel %d which is already freed\n",
-			__func__, dma_ch);
-		return;
-	}
-
-	local_irq_save(flags);
-	DCSR(dma_ch) = DCSR_STARTINTR|DCSR_ENDINTR|DCSR_BUSERR;
-	dma_channels[dma_ch].name = NULL;
-	pxad_toggle_reserved_channel(dma_ch);
-	local_irq_restore(flags);
-}
-EXPORT_SYMBOL(pxa_free_dma);
-
-static irqreturn_t dma_irq_handler(int irq, void *dev_id)
-{
-	int i, dint = DINT, done = 0;
-	struct dma_channel *channel;
-
-	while (dint) {
-		i = __ffs(dint);
-		dint &= (dint - 1);
-		channel = &dma_channels[i];
-		if (channel->name && channel->irq_handler) {
-			channel->irq_handler(i, channel->data);
-			done++;
-		}
-	}
-	if (done)
-		return IRQ_HANDLED;
-	else
-		return IRQ_NONE;
-}
-
-int __init pxa_init_dma(int irq, int num_ch)
-{
-	int i, ret;
-
-	dma_channels = kzalloc(sizeof(struct dma_channel) * num_ch, GFP_KERNEL);
-	if (dma_channels == NULL)
-		return -ENOMEM;
-
-	/* dma channel priorities on pxa2xx processors:
-	 * ch 0 - 3,  16 - 19  <--> (0) DMA_PRIO_HIGH
-	 * ch 4 - 7,  20 - 23  <--> (1) DMA_PRIO_MEDIUM
-	 * ch 8 - 15, 24 - 31  <--> (2) DMA_PRIO_LOW
-	 */
-	for (i = 0; i < num_ch; i++) {
-		DCSR(i) = 0;
-		dma_channels[i].prio = min((i & 0xf) >> 2, DMA_PRIO_LOW);
-		spin_lock_init(&dma_channels[i].lock);
-	}
-
-	ret = request_irq(irq, dma_irq_handler, IRQF_SHARED, "DMA",
-			  dma_channels);
-	if (ret) {
-		printk (KERN_CRIT "Wow!  Can't register IRQ for DMA\n");
-		kfree(dma_channels);
-		return ret;
-	}
-	num_dma_channels = num_ch;
-
-	pxa_dma_init_debugfs();
-
-	return 0;
-}
diff --git a/arch/arm/plat-pxa/include/plat/dma.h b/arch/arm/plat-pxa/include/plat/dma.h
deleted file mode 100644
index ceba3e4184fc..000000000000
--- a/arch/arm/plat-pxa/include/plat/dma.h
+++ /dev/null
@@ -1,100 +0,0 @@
-#ifndef __PLAT_DMA_H
-#define __PLAT_DMA_H
-
-#define DMAC_REG(x)	(*((volatile u32 *)(DMAC_REGS_VIRT + (x))))
-
-#define DCSR(n)		DMAC_REG((n) << 2)
-#define DALGN		DMAC_REG(0x00a0)  /* DMA Alignment Register */
-#define DINT		DMAC_REG(0x00f0)  /* DMA Interrupt Register */
-#define DDADR(n)	DMAC_REG(0x0200 + ((n) << 4))
-#define DSADR(n)	DMAC_REG(0x0204 + ((n) << 4))
-#define DTADR(n)	DMAC_REG(0x0208 + ((n) << 4))
-#define DCMD(n)		DMAC_REG(0x020c + ((n) << 4))
-#define DRCMR(n)	DMAC_REG((((n) < 64) ? 0x0100 : 0x1100) + \
-				 (((n) & 0x3f) << 2))
-
-#define DCSR_RUN	(1 << 31)	/* Run Bit (read / write) */
-#define DCSR_NODESC	(1 << 30)	/* No-Descriptor Fetch (read / write) */
-#define DCSR_STOPIRQEN	(1 << 29)	/* Stop Interrupt Enable (read / write) */
-#define DCSR_REQPEND	(1 << 8)	/* Request Pending (read-only) */
-#define DCSR_STOPSTATE	(1 << 3)	/* Stop State (read-only) */
-#define DCSR_ENDINTR	(1 << 2)	/* End Interrupt (read / write) */
-#define DCSR_STARTINTR	(1 << 1)	/* Start Interrupt (read / write) */
-#define DCSR_BUSERR	(1 << 0)	/* Bus Error Interrupt (read / write) */
-
-#define DCSR_EORIRQEN	(1 << 28)       /* End of Receive Interrupt Enable (R/W) */
-#define DCSR_EORJMPEN	(1 << 27)       /* Jump to next descriptor on EOR */
-#define DCSR_EORSTOPEN	(1 << 26)       /* STOP on an EOR */
-#define DCSR_SETCMPST	(1 << 25)       /* Set Descriptor Compare Status */
-#define DCSR_CLRCMPST	(1 << 24)       /* Clear Descriptor Compare Status */
-#define DCSR_CMPST	(1 << 10)       /* The Descriptor Compare Status */
-#define DCSR_EORINTR	(1 << 9)        /* The end of Receive */
-
-#define DRCMR_MAPVLD	(1 << 7)	/* Map Valid (read / write) */
-#define DRCMR_CHLNUM	0x1f		/* mask for Channel Number (read / write) */
-
-#define DDADR_DESCADDR	0xfffffff0	/* Address of next descriptor (mask) */
-#define DDADR_STOP	(1 << 0)	/* Stop (read / write) */
-
-#define DCMD_INCSRCADDR	(1 << 31)	/* Source Address Increment Setting. */
-#define DCMD_INCTRGADDR	(1 << 30)	/* Target Address Increment Setting. */
-#define DCMD_FLOWSRC	(1 << 29)	/* Flow Control by the source. */
-#define DCMD_FLOWTRG	(1 << 28)	/* Flow Control by the target. */
-#define DCMD_STARTIRQEN	(1 << 22)	/* Start Interrupt Enable */
-#define DCMD_ENDIRQEN	(1 << 21)	/* End Interrupt Enable */
-#define DCMD_ENDIAN	(1 << 18)	/* Device Endian-ness. */
-#define DCMD_BURST8	(1 << 16)	/* 8 byte burst */
-#define DCMD_BURST16	(2 << 16)	/* 16 byte burst */
-#define DCMD_BURST32	(3 << 16)	/* 32 byte burst */
-#define DCMD_WIDTH1	(1 << 14)	/* 1 byte width */
-#define DCMD_WIDTH2	(2 << 14)	/* 2 byte width (HalfWord) */
-#define DCMD_WIDTH4	(3 << 14)	/* 4 byte width (Word) */
-#define DCMD_LENGTH	0x01fff		/* length mask (max = 8K - 1) */
-
-/*
- * Descriptor structure for PXA's DMA engine
- * Note: this structure must always be aligned to a 16-byte boundary.
- */
-
-typedef struct pxa_dma_desc {
-	volatile u32 ddadr;	/* Points to the next descriptor + flags */
-	volatile u32 dsadr;	/* DSADR value for the current transfer */
-	volatile u32 dtadr;	/* DTADR value for the current transfer */
-	volatile u32 dcmd;	/* DCMD value for the current transfer */
-} pxa_dma_desc;
-
-typedef enum {
-	DMA_PRIO_HIGH = 0,
-	DMA_PRIO_MEDIUM = 1,
-	DMA_PRIO_LOW = 2
-} pxa_dma_prio;
-
-/*
- * DMA registration
- */
-
-int __init pxa_init_dma(int irq, int num_ch);
-
-int pxa_request_dma (char *name,
-			 pxa_dma_prio prio,
-			 void (*irq_handler)(int, void *),
-			 void *data);
-
-void pxa_free_dma (int dma_ch);
-
-/*
- * Cooperation with pxa_dma + dmaengine while there remains@least one pxa
- * driver not converted to dmaengine.
- */
-#if defined(CONFIG_PXA_DMA)
-extern int pxad_toggle_reserved_channel(int legacy_channel);
-#else
-static inline int pxad_toggle_reserved_channel(int legacy_channel)
-{
-	return 0;
-}
-#endif
-
-extern void __init pxa2xx_set_dmac_info(int nb_channels, int nb_requestors);
-
-#endif /* __PLAT_DMA_H */
-- 
2.1.4
