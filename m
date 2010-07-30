From: ccross@google.com (Colin Cross)
Date: Thu, 29 Jul 2010 17:36:39 -0700
Subject: [PATCH] [ARM] tegra: Add APB DMA support
Message-ID: <1280450199-25058-1-git-send-email-ccross@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Colin Cross <ccross@android.com>

The APB DMA block handles DMA transfers to and from some peripherals
in the Tegra SOC.  It reads from sequential addresses on the memory
bus, and writes repeatedly to the same address on the APB bus.

Two transfer modes are supported, oneshot for transferring a known
size to or from a peripheral, and continuous for streaming data.
In continuous mode, a callback occurs when the buffer is half full
to allow the existing data to be handled and a new request queued.x

Signed-off-by: Colin Cross <ccross@android.com>
---
 arch/arm/mach-tegra/Kconfig            |    7 +
 arch/arm/mach-tegra/Makefile           |    1 +
 arch/arm/mach-tegra/common.c           |    7 +
 arch/arm/mach-tegra/dma.c              |  752 ++++++++++++++++++++++++++++++++
 arch/arm/mach-tegra/include/mach/dma.h |  155 +++++++
 5 files changed, 922 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-tegra/dma.c
 create mode 100644 arch/arm/mach-tegra/include/mach/dma.h

diff --git a/arch/arm/mach-tegra/Kconfig b/arch/arm/mach-tegra/Kconfig
index a57713c..8e32d9d 100644
--- a/arch/arm/mach-tegra/Kconfig
+++ b/arch/arm/mach-tegra/Kconfig
@@ -47,4 +47,11 @@ config TEGRA_DEBUG_UARTE
 
 endchoice
 
+config TEGRA_SYSTEM_DMA
+	bool "Enable system DMA driver for NVIDIA Tegra SoCs"
+	default y
+	help
+	  Adds system DMA functionality for NVIDIA Tegra SoCs, used by
+	  several Tegra device drivers
+
 endif
diff --git a/arch/arm/mach-tegra/Makefile b/arch/arm/mach-tegra/Makefile
index 2a37621..fc069a9 100644
--- a/arch/arm/mach-tegra/Makefile
+++ b/arch/arm/mach-tegra/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_ARCH_TEGRA_2x_SOC)         += tegra2_dvfs.o
 obj-$(CONFIG_ARCH_TEGRA_2x_SOC)		+= pinmux-t2-tables.o
 obj-$(CONFIG_SMP)                       += platsmp.o localtimer.o headsmp.o
 obj-$(CONFIG_HOTPLUG_CPU)               += hotplug.o
+obj-$(CONFIG_TEGRA_SYSTEM_DMA)		+= dma.o
 obj-$(CONFIG_CPU_FREQ)                  += cpu-tegra.o
 
 obj-${CONFIG_MACH_HARMONY}              += board-harmony.o
diff --git a/arch/arm/mach-tegra/common.c b/arch/arm/mach-tegra/common.c
index 445104a..7c91e2b 100644
--- a/arch/arm/mach-tegra/common.c
+++ b/arch/arm/mach-tegra/common.c
@@ -19,10 +19,13 @@
 
 #include <linux/init.h>
 #include <linux/io.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
 
 #include <asm/hardware/cache-l2x0.h>
 
 #include <mach/iomap.h>
+#include <mach/dma.h>
 
 #include "board.h"
 #include "clock.h"
@@ -52,6 +55,7 @@ void __init tegra_init_cache(void)
 
 	l2x0_init(p, 0x6C080001, 0x8200c3fe);
 #endif
+
 }
 
 void __init tegra_common_init(void)
@@ -60,4 +64,7 @@ void __init tegra_common_init(void)
 	tegra_init_clock();
 	tegra_clk_init_from_table(common_clk_init_table);
 	tegra_init_cache();
+#ifdef CONFIG_TEGRA_SYSTEM_DMA
+	tegra_dma_init();
+#endif
 }
diff --git a/arch/arm/mach-tegra/dma.c b/arch/arm/mach-tegra/dma.c
new file mode 100644
index 0000000..acae0b1
--- /dev/null
+++ b/arch/arm/mach-tegra/dma.c
@@ -0,0 +1,752 @@
+/*
+ * arch/arm/mach-tegra/dma.c
+ *
+ * System DMA driver for NVIDIA Tegra SoCs
+ *
+ * Copyright (c) 2008-2009, NVIDIA Corporation.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
+ */
+
+#include <linux/io.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/spinlock.h>
+#include <linux/err.h>
+#include <linux/irq.h>
+#include <linux/delay.h>
+#include <mach/dma.h>
+#include <mach/irqs.h>
+#include <mach/iomap.h>
+
+#define APB_DMA_GEN				0x000
+#define GEN_ENABLE				(1<<31)
+
+#define APB_DMA_CNTRL				0x010
+
+#define APB_DMA_IRQ_MASK			0x01c
+
+#define APB_DMA_IRQ_MASK_SET			0x020
+
+#define APB_DMA_CHAN_CSR			0x000
+#define CSR_ENB					(1<<31)
+#define CSR_IE_EOC				(1<<30)
+#define CSR_HOLD				(1<<29)
+#define CSR_DIR					(1<<28)
+#define CSR_ONCE				(1<<27)
+#define CSR_FLOW				(1<<21)
+#define CSR_REQ_SEL_SHIFT			16
+#define CSR_REQ_SEL_MASK			(0x1F<<CSR_REQ_SEL_SHIFT)
+#define CSR_REQ_SEL_INVALID			(31<<CSR_REQ_SEL_SHIFT)
+#define CSR_WCOUNT_SHIFT			2
+#define CSR_WCOUNT_MASK				0xFFFC
+
+#define APB_DMA_CHAN_STA				0x004
+#define STA_BUSY				(1<<31)
+#define STA_ISE_EOC				(1<<30)
+#define STA_HALT				(1<<29)
+#define STA_PING_PONG				(1<<28)
+#define STA_COUNT_SHIFT				2
+#define STA_COUNT_MASK				0xFFFC
+
+#define APB_DMA_CHAN_AHB_PTR				0x010
+
+#define APB_DMA_CHAN_AHB_SEQ				0x014
+#define AHB_SEQ_INTR_ENB			(1<<31)
+#define AHB_SEQ_BUS_WIDTH_SHIFT			28
+#define AHB_SEQ_BUS_WIDTH_MASK			(0x7<<AHB_SEQ_BUS_WIDTH_SHIFT)
+#define AHB_SEQ_BUS_WIDTH_8			(0<<AHB_SEQ_BUS_WIDTH_SHIFT)
+#define AHB_SEQ_BUS_WIDTH_16			(1<<AHB_SEQ_BUS_WIDTH_SHIFT)
+#define AHB_SEQ_BUS_WIDTH_32			(2<<AHB_SEQ_BUS_WIDTH_SHIFT)
+#define AHB_SEQ_BUS_WIDTH_64			(3<<AHB_SEQ_BUS_WIDTH_SHIFT)
+#define AHB_SEQ_BUS_WIDTH_128			(4<<AHB_SEQ_BUS_WIDTH_SHIFT)
+#define AHB_SEQ_DATA_SWAP			(1<<27)
+#define AHB_SEQ_BURST_MASK			(0x7<<24)
+#define AHB_SEQ_BURST_1				(4<<24)
+#define AHB_SEQ_BURST_4				(5<<24)
+#define AHB_SEQ_BURST_8				(6<<24)
+#define AHB_SEQ_DBL_BUF				(1<<19)
+#define AHB_SEQ_WRAP_SHIFT			16
+#define AHB_SEQ_WRAP_MASK			(0x7<<AHB_SEQ_WRAP_SHIFT)
+
+#define APB_DMA_CHAN_APB_PTR				0x018
+
+#define APB_DMA_CHAN_APB_SEQ				0x01c
+#define APB_SEQ_BUS_WIDTH_SHIFT			28
+#define APB_SEQ_BUS_WIDTH_MASK			(0x7<<APB_SEQ_BUS_WIDTH_SHIFT)
+#define APB_SEQ_BUS_WIDTH_8			(0<<APB_SEQ_BUS_WIDTH_SHIFT)
+#define APB_SEQ_BUS_WIDTH_16			(1<<APB_SEQ_BUS_WIDTH_SHIFT)
+#define APB_SEQ_BUS_WIDTH_32			(2<<APB_SEQ_BUS_WIDTH_SHIFT)
+#define APB_SEQ_BUS_WIDTH_64			(3<<APB_SEQ_BUS_WIDTH_SHIFT)
+#define APB_SEQ_BUS_WIDTH_128			(4<<APB_SEQ_BUS_WIDTH_SHIFT)
+#define APB_SEQ_DATA_SWAP			(1<<27)
+#define APB_SEQ_WRAP_SHIFT			16
+#define APB_SEQ_WRAP_MASK			(0x7<<APB_SEQ_WRAP_SHIFT)
+
+#define TEGRA_SYSTEM_DMA_CH_NR			16
+#define TEGRA_SYSTEM_DMA_AVP_CH_NUM		4
+#define TEGRA_SYSTEM_DMA_CH_MIN			0
+#define TEGRA_SYSTEM_DMA_CH_MAX	\
+	(TEGRA_SYSTEM_DMA_CH_NR - TEGRA_SYSTEM_DMA_AVP_CH_NUM - 1)
+
+#define NV_DMA_MAX_TRASFER_SIZE 0x10000
+
+const unsigned int ahb_addr_wrap_table[8] = {
+	0, 32, 64, 128, 256, 512, 1024, 2048
+};
+
+const unsigned int apb_addr_wrap_table[8] = {0, 1, 2, 4, 8, 16, 32, 64};
+
+const unsigned int bus_width_table[5] = {8, 16, 32, 64, 128};
+
+#define TEGRA_DMA_NAME_SIZE 16
+struct tegra_dma_channel {
+	struct list_head	list;
+	int			id;
+	spinlock_t		lock;
+	char			name[TEGRA_DMA_NAME_SIZE];
+	void  __iomem		*addr;
+	int			mode;
+	int			irq;
+
+	/* Register shadow */
+	u32			csr;
+	u32			ahb_seq;
+	u32			ahb_ptr;
+	u32			apb_seq;
+	u32			apb_ptr;
+};
+
+#define  NV_DMA_MAX_CHANNELS  32
+
+static DECLARE_BITMAP(channel_usage, NV_DMA_MAX_CHANNELS);
+static struct tegra_dma_channel dma_channels[NV_DMA_MAX_CHANNELS];
+
+static void tegra_dma_update_hw(struct tegra_dma_channel *ch,
+	struct tegra_dma_req *req);
+static void tegra_dma_update_hw_partial(struct tegra_dma_channel *ch,
+	struct tegra_dma_req *req);
+static void tegra_dma_init_hw(struct tegra_dma_channel *ch);
+static void tegra_dma_stop(struct tegra_dma_channel *ch);
+
+void tegra_dma_flush(struct tegra_dma_channel *ch)
+{
+}
+EXPORT_SYMBOL(tegra_dma_flush);
+
+void tegra_dma_dequeue(struct tegra_dma_channel *ch)
+{
+	struct tegra_dma_req *req;
+
+	req = list_entry(ch->list.next, typeof(*req), node);
+
+	tegra_dma_dequeue_req(ch, req);
+	return;
+}
+
+void tegra_dma_stop(struct tegra_dma_channel *ch)
+{
+	unsigned int csr;
+	unsigned int status;
+
+	csr = ch->csr;
+	csr &= ~CSR_IE_EOC;
+	writel(csr, ch->addr + APB_DMA_CHAN_CSR);
+
+	csr &= ~CSR_ENB;
+	writel(csr, ch->addr + APB_DMA_CHAN_CSR);
+
+	status = readl(ch->addr + APB_DMA_CHAN_STA);
+	if (status & STA_ISE_EOC)
+		writel(status, ch->addr + APB_DMA_CHAN_STA);
+}
+
+int tegra_dma_cancel(struct tegra_dma_channel *ch)
+{
+	unsigned int csr;
+	unsigned long irq_flags;
+
+	spin_lock_irqsave(&ch->lock, irq_flags);
+	while (!list_empty(&ch->list))
+		list_del(ch->list.next);
+
+	csr = ch->csr;
+	csr &= ~CSR_REQ_SEL_MASK;
+	csr |= CSR_REQ_SEL_INVALID;
+
+	/* Set the enable as that is not shadowed */
+	csr |= CSR_ENB;
+	writel(csr, ch->addr + APB_DMA_CHAN_CSR);
+
+	tegra_dma_stop(ch);
+
+	spin_unlock_irqrestore(&ch->lock, irq_flags);
+	return 0;
+}
+
+int tegra_dma_dequeue_req(struct tegra_dma_channel *ch,
+	struct tegra_dma_req *_req)
+{
+	unsigned int csr;
+	unsigned int status;
+	struct tegra_dma_req *req = NULL;
+	int found = 0;
+	unsigned long irq_flags;
+	int to_transfer;
+	int req_transfer_count;
+
+	spin_lock_irqsave(&ch->lock, irq_flags);
+	list_for_each_entry(req, &ch->list, node) {
+		if (req == _req) {
+			list_del(&req->node);
+			found = 1;
+			break;
+		}
+	}
+	if (!found) {
+		spin_unlock_irqrestore(&ch->lock, irq_flags);
+		return 0;
+	}
+
+	/* STOP the DMA and get the transfer count.
+	 * Getting the transfer count is tricky.
+	 *  - Change the source selector to invalid to stop the DMA from
+	 *    FIFO to memory.
+	 *  - Read the status register to know the number of pending
+	 *    bytes to be transfered.
+	 *  - Finally stop or program the DMA to the next buffer in the
+	 *    list.
+	 */
+	csr = ch->csr;
+	csr &= ~CSR_REQ_SEL_MASK;
+	csr |= CSR_REQ_SEL_INVALID;
+
+	/* Set the enable as that is not shadowed */
+	csr |= CSR_ENB;
+	writel(csr, ch->addr + APB_DMA_CHAN_CSR);
+
+	/* Get the transfer count */
+	status = readl(ch->addr + APB_DMA_CHAN_STA);
+	to_transfer = (status & STA_COUNT_MASK) >> STA_COUNT_SHIFT;
+	req_transfer_count = (ch->csr & CSR_WCOUNT_MASK) >> CSR_WCOUNT_SHIFT;
+	req_transfer_count += 1;
+	to_transfer += 1;
+
+	req->bytes_transferred = req_transfer_count;
+
+	if (status & STA_BUSY)
+		req->bytes_transferred -= to_transfer;
+
+	/* In continous transfer mode, DMA only tracks the count of the
+	 * half DMA buffer. So, if the DMA already finished half the DMA
+	 * then add the half buffer to the completed count.
+	 *
+	 *	FIXME: There can be a race here. What if the req to
+	 *	dequue happens at the same time as the DMA just moved to
+	 *	the new buffer and SW didn't yet received the interrupt?
+	 */
+	if (ch->mode & TEGRA_DMA_MODE_CONTINOUS)
+		if (req->buffer_status == TEGRA_DMA_REQ_BUF_STATUS_HALF_FULL)
+			req->bytes_transferred += req_transfer_count;
+
+	req->bytes_transferred *= 4;
+
+	tegra_dma_stop(ch);
+	if (!list_empty(&ch->list)) {
+		/* if the list is not empty, queue the next request */
+		struct tegra_dma_req *next_req;
+		next_req = list_entry(ch->list.next,
+			typeof(*next_req), node);
+		tegra_dma_update_hw(ch, next_req);
+	}
+	req->status = -TEGRA_DMA_REQ_ERROR_ABORTED;
+
+	spin_unlock_irqrestore(&ch->lock, irq_flags);
+
+	/* Callback should be called without any lock */
+	req->complete(req);
+	return 0;
+}
+EXPORT_SYMBOL(tegra_dma_dequeue_req);
+
+bool tegra_dma_is_empty(struct tegra_dma_channel *ch)
+{
+	unsigned long irq_flags;
+	bool is_empty;
+
+	spin_lock_irqsave(&ch->lock, irq_flags);
+	if (list_empty(&ch->list))
+		is_empty = true;
+	else
+		is_empty = false;
+	spin_unlock_irqrestore(&ch->lock, irq_flags);
+	return is_empty;
+}
+EXPORT_SYMBOL(tegra_dma_is_empty);
+
+bool tegra_dma_is_req_inflight(struct tegra_dma_channel *ch,
+	struct tegra_dma_req *_req)
+{
+	unsigned long irq_flags;
+	struct tegra_dma_req *req;
+
+	spin_lock_irqsave(&ch->lock, irq_flags);
+	list_for_each_entry(req, &ch->list, node) {
+		if (req == _req) {
+			spin_unlock_irqrestore(&ch->lock, irq_flags);
+			return true;
+		}
+	}
+	spin_unlock_irqrestore(&ch->lock, irq_flags);
+	return false;
+}
+EXPORT_SYMBOL(tegra_dma_is_req_inflight);
+
+int tegra_dma_enqueue_req(struct tegra_dma_channel *ch,
+	struct tegra_dma_req *req)
+{
+	unsigned long irq_flags;
+	int start_dma = 0;
+
+	if (req->size > NV_DMA_MAX_TRASFER_SIZE ||
+		req->source_addr & 0x3 || req->dest_addr & 0x3) {
+		pr_err("Invalid DMA request for channel %d\n", ch->id);
+		return -EINVAL;
+	}
+
+	spin_lock_irqsave(&ch->lock, irq_flags);
+
+	req->bytes_transferred = 0;
+	req->status = 0;
+	req->buffer_status = 0;
+	if (list_empty(&ch->list))
+		start_dma = 1;
+
+	list_add_tail(&req->node, &ch->list);
+
+	if (start_dma)
+		tegra_dma_update_hw(ch, req);
+
+	spin_unlock_irqrestore(&ch->lock, irq_flags);
+
+	return 0;
+}
+EXPORT_SYMBOL(tegra_dma_enqueue_req);
+
+struct tegra_dma_channel *tegra_dma_allocate_channel(int mode)
+{
+	int channel;
+	struct tegra_dma_channel *ch;
+
+	/* first channel is the shared channel */
+	if (mode & TEGRA_DMA_SHARED) {
+		channel = TEGRA_SYSTEM_DMA_CH_MIN;
+	} else {
+		channel = find_first_zero_bit(channel_usage,
+			ARRAY_SIZE(dma_channels));
+		if (channel >= ARRAY_SIZE(dma_channels))
+			return ERR_PTR(ENODEV);
+	}
+	__set_bit(channel, channel_usage);
+	ch = &dma_channels[channel];
+	ch->mode = mode;
+	return ch;
+}
+EXPORT_SYMBOL(tegra_dma_allocate_channel);
+
+void tegra_dma_free_channel(struct tegra_dma_channel *ch)
+{
+	if (ch->mode & TEGRA_DMA_SHARED)
+		return;
+	tegra_dma_cancel(ch);
+	__clear_bit(ch->id, channel_usage);
+}
+EXPORT_SYMBOL(tegra_dma_free_channel);
+
+static void tegra_dma_update_hw_partial(struct tegra_dma_channel *ch,
+	struct tegra_dma_req *req)
+{
+	if (req->to_memory) {
+		ch->apb_ptr = req->source_addr;
+		ch->ahb_ptr = req->dest_addr;
+	} else {
+		ch->apb_ptr = req->dest_addr;
+		ch->ahb_ptr = req->source_addr;
+	}
+	writel(ch->apb_ptr, ch->addr + APB_DMA_CHAN_APB_PTR);
+	writel(ch->ahb_ptr, ch->addr + APB_DMA_CHAN_AHB_PTR);
+
+	req->status = TEGRA_DMA_REQ_INFLIGHT;
+	return;
+}
+
+static void tegra_dma_update_hw(struct tegra_dma_channel *ch,
+	struct tegra_dma_req *req)
+{
+	int ahb_addr_wrap;
+	int apb_addr_wrap;
+	int ahb_bus_width;
+	int apb_bus_width;
+	int index;
+	unsigned long csr;
+
+
+	ch->csr |= CSR_FLOW;
+	ch->csr &= ~CSR_REQ_SEL_MASK;
+	ch->csr |= req->req_sel << CSR_REQ_SEL_SHIFT;
+	ch->ahb_seq &= ~AHB_SEQ_BURST_MASK;
+	ch->ahb_seq |= AHB_SEQ_BURST_1;
+
+	/* One shot mode is always single buffered,
+	 * continuous mode is always double buffered
+	 * */
+	if (ch->mode & TEGRA_DMA_MODE_ONESHOT) {
+		ch->csr |= CSR_ONCE;
+		ch->ahb_seq &= ~AHB_SEQ_DBL_BUF;
+		ch->csr &= ~CSR_WCOUNT_MASK;
+		ch->csr |= ((req->size>>2) - 1) << CSR_WCOUNT_SHIFT;
+	} else {
+		ch->csr &= ~CSR_ONCE;
+		ch->ahb_seq |= AHB_SEQ_DBL_BUF;
+
+		/* In double buffered mode, we set the size to half the
+		 * requested size and interrupt when half the buffer
+		 * is full */
+		ch->csr &= ~CSR_WCOUNT_MASK;
+		ch->csr |= ((req->size>>3) - 1) << CSR_WCOUNT_SHIFT;
+	}
+
+	if (req->to_memory) {
+		ch->csr &= ~CSR_DIR;
+		ch->apb_ptr = req->source_addr;
+		ch->ahb_ptr = req->dest_addr;
+
+		apb_addr_wrap = req->source_wrap;
+		ahb_addr_wrap = req->dest_wrap;
+		apb_bus_width = req->source_bus_width;
+		ahb_bus_width = req->dest_bus_width;
+
+	} else {
+		ch->csr |= CSR_DIR;
+		ch->apb_ptr = req->dest_addr;
+		ch->ahb_ptr = req->source_addr;
+
+		apb_addr_wrap = req->dest_wrap;
+		ahb_addr_wrap = req->source_wrap;
+		apb_bus_width = req->dest_bus_width;
+		ahb_bus_width = req->source_bus_width;
+	}
+
+	apb_addr_wrap >>= 2;
+	ahb_addr_wrap >>= 2;
+
+	/* set address wrap for APB size */
+	index = 0;
+	do  {
+		if (apb_addr_wrap_table[index] == apb_addr_wrap)
+			break;
+		index++;
+	} while (index < ARRAY_SIZE(apb_addr_wrap_table));
+	BUG_ON(index == ARRAY_SIZE(apb_addr_wrap_table));
+	ch->apb_seq &= ~APB_SEQ_WRAP_MASK;
+	ch->apb_seq |= index << APB_SEQ_WRAP_SHIFT;
+
+	/* set address wrap for AHB size */
+	index = 0;
+	do  {
+		if (ahb_addr_wrap_table[index] == ahb_addr_wrap)
+			break;
+		index++;
+	} while (index < ARRAY_SIZE(ahb_addr_wrap_table));
+	BUG_ON(index == ARRAY_SIZE(ahb_addr_wrap_table));
+	ch->ahb_seq &= ~AHB_SEQ_WRAP_MASK;
+	ch->ahb_seq |= index << AHB_SEQ_WRAP_SHIFT;
+
+	for (index = 0; index < ARRAY_SIZE(bus_width_table); index++) {
+		if (bus_width_table[index] == ahb_bus_width)
+			break;
+	}
+	BUG_ON(index == ARRAY_SIZE(bus_width_table));
+	ch->ahb_seq &= ~AHB_SEQ_BUS_WIDTH_MASK;
+	ch->ahb_seq |= index << AHB_SEQ_BUS_WIDTH_SHIFT;
+
+	for (index = 0; index < ARRAY_SIZE(bus_width_table); index++) {
+		if (bus_width_table[index] == apb_bus_width)
+			break;
+	}
+	BUG_ON(index == ARRAY_SIZE(bus_width_table));
+	ch->apb_seq &= ~APB_SEQ_BUS_WIDTH_MASK;
+	ch->apb_seq |= index << APB_SEQ_BUS_WIDTH_SHIFT;
+
+	ch->csr |= CSR_IE_EOC;
+
+	/* update hw registers with the shadow */
+	writel(ch->csr, ch->addr + APB_DMA_CHAN_CSR);
+	writel(ch->apb_seq, ch->addr + APB_DMA_CHAN_APB_SEQ);
+	writel(ch->apb_ptr, ch->addr + APB_DMA_CHAN_APB_PTR);
+	writel(ch->ahb_seq, ch->addr + APB_DMA_CHAN_AHB_SEQ);
+	writel(ch->ahb_ptr, ch->addr + APB_DMA_CHAN_AHB_PTR);
+
+	csr = ch->csr | CSR_ENB;
+	writel(csr, ch->addr + APB_DMA_CHAN_CSR);
+
+	req->status = TEGRA_DMA_REQ_INFLIGHT;
+}
+
+static void tegra_dma_init_hw(struct tegra_dma_channel *ch)
+{
+	/* One shot with an interrupt to CPU after transfer */
+	ch->csr = CSR_ONCE | CSR_IE_EOC;
+	ch->ahb_seq = AHB_SEQ_BUS_WIDTH_32 | AHB_SEQ_INTR_ENB;
+	ch->apb_seq = APB_SEQ_BUS_WIDTH_32 | 1 << APB_SEQ_WRAP_SHIFT;
+}
+
+static void handle_oneshot_dma(struct tegra_dma_channel *ch)
+{
+	struct tegra_dma_req *req;
+
+	spin_lock(&ch->lock);
+	if (list_empty(&ch->list)) {
+		spin_unlock(&ch->lock);
+		return;
+	}
+
+	req = list_entry(ch->list.next, typeof(*req), node);
+	if (req) {
+		int bytes_transferred;
+
+		bytes_transferred =
+			(ch->csr & CSR_WCOUNT_MASK) >> CSR_WCOUNT_SHIFT;
+		bytes_transferred += 1;
+		bytes_transferred <<= 2;
+
+		list_del(&req->node);
+		req->bytes_transferred = bytes_transferred;
+		req->status = TEGRA_DMA_REQ_SUCCESS;
+
+		spin_unlock(&ch->lock);
+		/* Callback should be called without any lock */
+		pr_debug("%s: transferred %d bytes\n", __func__,
+			req->bytes_transferred);
+		req->complete(req);
+		spin_lock(&ch->lock);
+	}
+
+	if (!list_empty(&ch->list)) {
+		req = list_entry(ch->list.next, typeof(*req), node);
+		/* the complete function we just called may have enqueued
+		   another req, in which case dma has already started */
+		if (req->status != TEGRA_DMA_REQ_INFLIGHT)
+			tegra_dma_update_hw(ch, req);
+	}
+	spin_unlock(&ch->lock);
+}
+
+static void handle_continuous_dma(struct tegra_dma_channel *ch)
+{
+	struct tegra_dma_req *req;
+
+	spin_lock(&ch->lock);
+	if (list_empty(&ch->list)) {
+		spin_unlock(&ch->lock);
+		return;
+	}
+
+	req = list_entry(ch->list.next, typeof(*req), node);
+	if (req) {
+		if (req->buffer_status == TEGRA_DMA_REQ_BUF_STATUS_EMPTY) {
+			/* Load the next request into the hardware, if available
+			 * */
+			if (!list_is_last(&req->node, &ch->list)) {
+				struct tegra_dma_req *next_req;
+
+				next_req = list_entry(req->node.next,
+					typeof(*next_req), node);
+				tegra_dma_update_hw_partial(ch, next_req);
+			}
+			req->buffer_status = TEGRA_DMA_REQ_BUF_STATUS_HALF_FULL;
+			req->status = TEGRA_DMA_REQ_SUCCESS;
+			/* DMA lock is NOT held when callback is called */
+			spin_unlock(&ch->lock);
+			if (likely(req->threshold))
+				req->threshold(req);
+			return;
+
+		} else if (req->buffer_status ==
+			TEGRA_DMA_REQ_BUF_STATUS_HALF_FULL) {
+			/* Callback when the buffer is completely full (i.e on
+			 * the second  interrupt */
+			int bytes_transferred;
+
+			bytes_transferred =
+				(ch->csr & CSR_WCOUNT_MASK) >> CSR_WCOUNT_SHIFT;
+			bytes_transferred += 1;
+			bytes_transferred <<= 3;
+
+			req->buffer_status = TEGRA_DMA_REQ_BUF_STATUS_FULL;
+			req->bytes_transferred = bytes_transferred;
+			req->status = TEGRA_DMA_REQ_SUCCESS;
+			list_del(&req->node);
+
+			/* DMA lock is NOT held when callbak is called */
+			spin_unlock(&ch->lock);
+			req->complete(req);
+			return;
+
+		} else {
+			BUG();
+		}
+	}
+	spin_unlock(&ch->lock);
+}
+
+static irqreturn_t dma_isr(int irq, void *data)
+{
+	struct tegra_dma_channel *ch = data;
+	unsigned long status;
+
+	status = readl(ch->addr + APB_DMA_CHAN_STA);
+	if (status & STA_ISE_EOC)
+		writel(status, ch->addr + APB_DMA_CHAN_STA);
+	else {
+		pr_warning("Got a spurious ISR for DMA channel %d\n", ch->id);
+		return IRQ_HANDLED;
+	}
+	return IRQ_WAKE_THREAD;
+}
+
+static irqreturn_t dma_thread_fn(int irq, void *data)
+{
+	struct tegra_dma_channel *ch = data;
+
+	if (ch->mode & TEGRA_DMA_MODE_ONESHOT)
+		handle_oneshot_dma(ch);
+	else
+		handle_continuous_dma(ch);
+
+
+	return IRQ_HANDLED;
+}
+
+int __init tegra_dma_init(void)
+{
+	int ret = 0;
+	int i;
+	unsigned int irq;
+	void __iomem *addr;
+
+	addr = IO_ADDRESS(TEGRA_APB_DMA_BASE);
+	writel(GEN_ENABLE, addr + APB_DMA_GEN);
+	writel(0, addr + APB_DMA_CNTRL);
+	writel(0xFFFFFFFFul >> (31 - TEGRA_SYSTEM_DMA_CH_MAX),
+	       addr + APB_DMA_IRQ_MASK_SET);
+
+	memset(channel_usage, 0, sizeof(channel_usage));
+	memset(dma_channels, 0, sizeof(dma_channels));
+
+	/* Reserve all the channels we are not supposed to touch */
+	for (i = 0; i < TEGRA_SYSTEM_DMA_CH_MIN; i++)
+		__set_bit(i, channel_usage);
+
+	for (i = TEGRA_SYSTEM_DMA_CH_MIN; i <= TEGRA_SYSTEM_DMA_CH_MAX; i++) {
+		struct tegra_dma_channel *ch = &dma_channels[i];
+
+		__clear_bit(i, channel_usage);
+
+		ch->id = i;
+		snprintf(ch->name, TEGRA_DMA_NAME_SIZE, "dma_channel_%d", i);
+
+		ch->addr = IO_ADDRESS(TEGRA_APB_DMA_CH0_BASE +
+			TEGRA_APB_DMA_CH0_SIZE * i);
+
+		spin_lock_init(&ch->lock);
+		INIT_LIST_HEAD(&ch->list);
+		tegra_dma_init_hw(ch);
+
+		irq = INT_APB_DMA_CH0 + i;
+		ret = request_threaded_irq(irq, dma_isr, dma_thread_fn, 0,
+			dma_channels[i].name, ch);
+		if (ret) {
+			pr_err("Failed to register IRQ %d for DMA %d\n",
+				irq, i);
+			goto fail;
+		}
+		ch->irq = irq;
+	}
+	/* mark the shared channel allocated */
+	__set_bit(TEGRA_SYSTEM_DMA_CH_MIN, channel_usage);
+
+	for (i = TEGRA_SYSTEM_DMA_CH_MAX+1; i < NV_DMA_MAX_CHANNELS; i++)
+		__set_bit(i, channel_usage);
+
+	return ret;
+fail:
+	writel(0, addr + APB_DMA_GEN);
+	for (i = TEGRA_SYSTEM_DMA_CH_MIN; i <= TEGRA_SYSTEM_DMA_CH_MAX; i++) {
+		struct tegra_dma_channel *ch = &dma_channels[i];
+		if (ch->irq)
+			free_irq(ch->irq, ch);
+	}
+	return ret;
+}
+
+#ifdef CONFIG_PM
+static u32 apb_dma[5*TEGRA_SYSTEM_DMA_CH_NR + 3];
+
+void tegra_dma_suspend(void)
+{
+	void __iomem *addr = IO_ADDRESS(TEGRA_APB_DMA_BASE);
+	u32 *ctx = apb_dma;
+	int i;
+
+	*ctx++ = readl(addr + APB_DMA_GEN);
+	*ctx++ = readl(addr + APB_DMA_CNTRL);
+	*ctx++ = readl(addr + APB_DMA_IRQ_MASK);
+
+	for (i = 0; i < TEGRA_SYSTEM_DMA_CH_NR; i++) {
+		addr = IO_ADDRESS(TEGRA_APB_DMA_CH0_BASE +
+				  TEGRA_APB_DMA_CH0_SIZE * i);
+
+		*ctx++ = readl(addr + APB_DMA_CHAN_CSR);
+		*ctx++ = readl(addr + APB_DMA_CHAN_AHB_PTR);
+		*ctx++ = readl(addr + APB_DMA_CHAN_AHB_SEQ);
+		*ctx++ = readl(addr + APB_DMA_CHAN_APB_PTR);
+		*ctx++ = readl(addr + APB_DMA_CHAN_APB_SEQ);
+	}
+}
+
+void tegra_dma_resume(void)
+{
+	void __iomem *addr = IO_ADDRESS(TEGRA_APB_DMA_BASE);
+	u32 *ctx = apb_dma;
+	int i;
+
+	writel(*ctx++, addr + APB_DMA_GEN);
+	writel(*ctx++, addr + APB_DMA_CNTRL);
+	writel(*ctx++, addr + APB_DMA_IRQ_MASK);
+
+	for (i = 0; i < TEGRA_SYSTEM_DMA_CH_NR; i++) {
+		addr = IO_ADDRESS(TEGRA_APB_DMA_CH0_BASE +
+				  TEGRA_APB_DMA_CH0_SIZE * i);
+
+		writel(*ctx++, addr + APB_DMA_CHAN_CSR);
+		writel(*ctx++, addr + APB_DMA_CHAN_AHB_PTR);
+		writel(*ctx++, addr + APB_DMA_CHAN_AHB_SEQ);
+		writel(*ctx++, addr + APB_DMA_CHAN_APB_PTR);
+		writel(*ctx++, addr + APB_DMA_CHAN_APB_SEQ);
+	}
+}
+
+#endif
diff --git a/arch/arm/mach-tegra/include/mach/dma.h b/arch/arm/mach-tegra/include/mach/dma.h
new file mode 100644
index 0000000..39011bd
--- /dev/null
+++ b/arch/arm/mach-tegra/include/mach/dma.h
@@ -0,0 +1,155 @@
+/*
+ * arch/arm/mach-tegra/include/mach/dma.h
+ *
+ * Copyright (c) 2008-2009, NVIDIA Corporation.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
+ */
+
+#ifndef __MACH_TEGRA_DMA_H
+#define __MACH_TEGRA_DMA_H
+
+#include <linux/list.h>
+
+#if defined(CONFIG_TEGRA_SYSTEM_DMA)
+
+struct tegra_dma_req;
+struct tegra_dma_channel;
+
+#define TEGRA_DMA_REQ_SEL_CNTR			0
+#define TEGRA_DMA_REQ_SEL_I2S_2			1
+#define TEGRA_DMA_REQ_SEL_I2S_1			2
+#define TEGRA_DMA_REQ_SEL_SPD_I			3
+#define TEGRA_DMA_REQ_SEL_UI_I			4
+#define TEGRA_DMA_REQ_SEL_MIPI			5
+#define TEGRA_DMA_REQ_SEL_I2S2_2		6
+#define TEGRA_DMA_REQ_SEL_I2S2_1		7
+#define TEGRA_DMA_REQ_SEL_UARTA			8
+#define TEGRA_DMA_REQ_SEL_UARTB			9
+#define TEGRA_DMA_REQ_SEL_UARTC			10
+#define TEGRA_DMA_REQ_SEL_SPI			11
+#define TEGRA_DMA_REQ_SEL_AC97			12
+#define TEGRA_DMA_REQ_SEL_ACMODEM		13
+#define TEGRA_DMA_REQ_SEL_SL4B			14
+#define TEGRA_DMA_REQ_SEL_SL2B1			15
+#define TEGRA_DMA_REQ_SEL_SL2B2			16
+#define TEGRA_DMA_REQ_SEL_SL2B3			17
+#define TEGRA_DMA_REQ_SEL_SL2B4			18
+#define TEGRA_DMA_REQ_SEL_UARTD			19
+#define TEGRA_DMA_REQ_SEL_UARTE			20
+#define TEGRA_DMA_REQ_SEL_I2C			21
+#define TEGRA_DMA_REQ_SEL_I2C2			22
+#define TEGRA_DMA_REQ_SEL_I2C3			23
+#define TEGRA_DMA_REQ_SEL_DVC_I2C		24
+#define TEGRA_DMA_REQ_SEL_OWR			25
+#define TEGRA_DMA_REQ_SEL_INVALID		31
+
+enum tegra_dma_mode {
+	TEGRA_DMA_SHARED = 1,
+	TEGRA_DMA_MODE_CONTINOUS = 2,
+	TEGRA_DMA_MODE_ONESHOT = 4,
+};
+
+enum tegra_dma_req_error {
+	TEGRA_DMA_REQ_SUCCESS = 0,
+	TEGRA_DMA_REQ_ERROR_ABORTED,
+	TEGRA_DMA_REQ_INFLIGHT,
+};
+
+enum tegra_dma_req_buff_status {
+	TEGRA_DMA_REQ_BUF_STATUS_EMPTY = 0,
+	TEGRA_DMA_REQ_BUF_STATUS_HALF_FULL,
+	TEGRA_DMA_REQ_BUF_STATUS_FULL,
+};
+
+struct tegra_dma_req {
+	struct list_head node;
+	unsigned int modid;
+	int instance;
+
+	/* Called when the req is complete and from the DMA ISR context.
+	 * When this is called the req structure is no longer queued by
+	 * the DMA channel.
+	 *
+	 * State of the DMA depends on the number of req it has. If there are
+	 * no DMA requests queued up, then it will STOP the DMA. It there are
+	 * more requests in the DMA, then it will queue the next request.
+	 */
+	void (*complete)(struct tegra_dma_req *req);
+
+	/*  This is a called from the DMA ISR context when the DMA is still in
+	 *  progress and is actively filling same buffer.
+	 *
+	 *  In case of continous mode receive, this threshold is 1/2 the buffer
+	 *  size. In other cases, this will not even be called as there is no
+	 *  hardware support for it.
+	 *
+	 * In the case of continous mode receive, if there is next req already
+	 * queued, DMA programs the HW to use that req when this req is
+	 * completed. If there is no "next req" queued, then DMA ISR doesn't do
+	 * anything before calling this callback.
+	 *
+	 *	This is mainly used by the cases, where the clients has queued
+	 *	only one req and want to get some sort of DMA threshold
+	 *	callback to program the next buffer.
+	 *
+	 */
+	void (*threshold)(struct tegra_dma_req *req);
+
+	/* 1 to copy to memory.
+	 * 0 to copy from the memory to device FIFO */
+	int to_memory;
+
+	void *virt_addr;
+
+	unsigned long source_addr;
+	unsigned long dest_addr;
+	unsigned long dest_wrap;
+	unsigned long source_wrap;
+	unsigned long source_bus_width;
+	unsigned long dest_bus_width;
+	unsigned long req_sel;
+	unsigned int size;
+
+	/* Updated by the DMA driver on the conpletion of the request. */
+	int bytes_transferred;
+	int status;
+
+	/* DMA completion tracking information */
+	int buffer_status;
+
+	/* Client specific data */
+	void *dev;
+};
+
+int tegra_dma_enqueue_req(struct tegra_dma_channel *ch,
+	struct tegra_dma_req *req);
+int tegra_dma_dequeue_req(struct tegra_dma_channel *ch,
+	struct tegra_dma_req *req);
+void tegra_dma_dequeue(struct tegra_dma_channel *ch);
+void tegra_dma_flush(struct tegra_dma_channel *ch);
+
+bool tegra_dma_is_req_inflight(struct tegra_dma_channel *ch,
+	struct tegra_dma_req *req);
+bool tegra_dma_is_empty(struct tegra_dma_channel *ch);
+
+struct tegra_dma_channel *tegra_dma_allocate_channel(int mode);
+void tegra_dma_free_channel(struct tegra_dma_channel *ch);
+
+int __init tegra_dma_init(void);
+
+#endif
+
+#endif
-- 
1.7.1
