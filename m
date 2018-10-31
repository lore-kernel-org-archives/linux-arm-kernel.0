From: lsun@mellanox.com (Liming Sun)
Date: Wed, 31 Oct 2018 14:09:53 -0400
Subject: [PATCH v5 1/5] soc: Add TmFifo driver for Mellanox BlueField Soc
In-Reply-To: <b143b40446c1870fb8d422b364ead95d54552be9.1527264077.git.lsun@mellanox.com>
References: <b143b40446c1870fb8d422b364ead95d54552be9.1527264077.git.lsun@mellanox.com>
Message-ID: <1541009397-76223-1-git-send-email-lsun@mellanox.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds the TmFifo driver for Mellanox BlueField Soc.
TmFifo is a shared FIFO which enables external host machine to
exchange data with the SoC via USB or PCIe. The driver is based on
virtio framework and has console and network access enabled.

Reviewed-by: David Woods <dwoods@mellanox.com>
Signed-off-by: Liming Sun <lsun@mellanox.com>
---
 drivers/soc/Kconfig                |    1 +
 drivers/soc/Makefile               |    1 +
 drivers/soc/mellanox/Kconfig       |   18 +
 drivers/soc/mellanox/Makefile      |    5 +
 drivers/soc/mellanox/tmfifo.c      | 1236 ++++++++++++++++++++++++++++++++++++
 drivers/soc/mellanox/tmfifo_regs.h |   76 +++
 6 files changed, 1337 insertions(+)
 create mode 100644 drivers/soc/mellanox/Kconfig
 create mode 100644 drivers/soc/mellanox/Makefile
 create mode 100644 drivers/soc/mellanox/tmfifo.c
 create mode 100644 drivers/soc/mellanox/tmfifo_regs.h

diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
index c07b4a8..fa87dc8 100644
--- a/drivers/soc/Kconfig
+++ b/drivers/soc/Kconfig
@@ -7,6 +7,7 @@ source "drivers/soc/bcm/Kconfig"
 source "drivers/soc/fsl/Kconfig"
 source "drivers/soc/imx/Kconfig"
 source "drivers/soc/mediatek/Kconfig"
+source "drivers/soc/mellanox/Kconfig"
 source "drivers/soc/qcom/Kconfig"
 source "drivers/soc/renesas/Kconfig"
 source "drivers/soc/rockchip/Kconfig"
diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
index 113e884..93052d0 100644
--- a/drivers/soc/Makefile
+++ b/drivers/soc/Makefile
@@ -13,6 +13,7 @@ obj-$(CONFIG_ARCH_GEMINI)	+= gemini/
 obj-$(CONFIG_ARCH_MXC)		+= imx/
 obj-$(CONFIG_SOC_XWAY)		+= lantiq/
 obj-y				+= mediatek/
+obj-$(CONFIG_SOC_MLNX)		+= mellanox/
 obj-$(CONFIG_ARCH_MESON)	+= amlogic/
 obj-y				+= qcom/
 obj-y				+= renesas/
diff --git a/drivers/soc/mellanox/Kconfig b/drivers/soc/mellanox/Kconfig
new file mode 100644
index 0000000..d88efa1
--- /dev/null
+++ b/drivers/soc/mellanox/Kconfig
@@ -0,0 +1,18 @@
+menuconfig SOC_MLNX
+	bool "Mellanox SoC drivers"
+	default y if ARCH_MLNX_BLUEFIELD
+
+if ARCH_MLNX_BLUEFIELD || COMPILE_TEST
+
+config MLNX_BLUEFIELD_TMFIFO
+	tristate "Mellanox BlueField SoC TmFifo driver"
+	depends on ARM64
+	default m
+	select VIRTIO_CONSOLE
+	select VIRTIO_NET
+	help
+	  Say y here to enable TmFifo support. The TmFifo driver provides the
+	  virtio driver framework for the TMFIFO of Mellanox BlueField SoC and
+	  the implementation of a console and network driver.
+
+endif # ARCH_MLNX_BLUEFIELD
diff --git a/drivers/soc/mellanox/Makefile b/drivers/soc/mellanox/Makefile
new file mode 100644
index 0000000..c44c0e2
--- /dev/null
+++ b/drivers/soc/mellanox/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for Mellanox SoC drivers.
+#
+obj-$(CONFIG_MLNX_BLUEFIELD_TMFIFO)	+= tmfifo.o
diff --git a/drivers/soc/mellanox/tmfifo.c b/drivers/soc/mellanox/tmfifo.c
new file mode 100644
index 0000000..d5e3550
--- /dev/null
+++ b/drivers/soc/mellanox/tmfifo.c
@@ -0,0 +1,1236 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2018, Mellanox Technologies. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/acpi.h>
+#include <linux/bitfield.h>
+#include <linux/cache.h>
+#include <linux/device.h>
+#include <linux/dma-mapping.h>
+#include <linux/efi.h>
+#include <linux/io.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/kernel.h>
+#include <linux/math64.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/mutex.h>
+#include <linux/platform_device.h>
+#include <linux/resource.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+#include <linux/version.h>
+#include <linux/virtio.h>
+#include <linux/virtio_config.h>
+#include <linux/virtio_console.h>
+#include <linux/virtio_ids.h>
+#include <linux/virtio_net.h>
+#include <linux/virtio_ring.h>
+#include <asm/byteorder.h>
+
+#include "tmfifo_regs.h"
+
+/* Vring size. */
+#define TMFIFO_VRING_SIZE			1024
+
+/* Console Tx buffer size. */
+#define TMFIFO_CONS_TX_BUF_SIZE			(32 * 1024)
+
+/* House-keeping timer interval. */
+static int tmfifo_timer_interval = HZ / 10;
+module_param(tmfifo_timer_interval, int, 0644);
+MODULE_PARM_DESC(tmfifo_timer_interval, "timer interval");
+
+/* Global lock. */
+static DEFINE_MUTEX(tmfifo_lock);
+
+/* Virtio ring size. */
+static int tmfifo_vring_size = TMFIFO_VRING_SIZE;
+module_param(tmfifo_vring_size, int, 0444);
+MODULE_PARM_DESC(tmfifo_vring_size, "Size of the vring");
+
+/* Struct declaration. */
+struct tmfifo;
+
+/* Virtual devices sharing the TM FIFO. */
+#define TMFIFO_VDEV_MAX		(VIRTIO_ID_CONSOLE + 1)
+
+/* Structure to maintain the ring state. */
+struct tmfifo_vring {
+	void *va;			/* virtual address */
+	dma_addr_t dma;			/* dma address */
+	struct virtqueue *vq;		/* virtqueue pointer */
+	struct vring_desc *desc;	/* current desc */
+	struct vring_desc *desc_head;	/* current desc head */
+	int cur_len;			/* processed len in current desc */
+	int rem_len;			/* remaining length to be processed */
+	int size;			/* vring size */
+	int align;			/* vring alignment */
+	int id;				/* vring id */
+	int vdev_id;			/* TMFIFO_VDEV_xxx */
+	u32 pkt_len;			/* packet total length */
+	__virtio16 next_avail;		/* next avail desc id */
+	struct tmfifo *fifo;		/* pointer back to the tmfifo */
+};
+
+/* Interrupt types. */
+enum {
+	TM_RX_LWM_IRQ,			/* Rx low water mark irq */
+	TM_RX_HWM_IRQ,			/* Rx high water mark irq */
+	TM_TX_LWM_IRQ,			/* Tx low water mark irq */
+	TM_TX_HWM_IRQ,			/* Tx high water mark irq */
+	TM_IRQ_CNT
+};
+
+/* Ring types (Rx & Tx). */
+enum {
+	TMFIFO_VRING_RX,		/* Rx ring */
+	TMFIFO_VRING_TX,		/* Tx ring */
+	TMFIFO_VRING_NUM
+};
+
+struct tmfifo_vdev {
+	struct virtio_device vdev;	/* virtual device */
+	u8 status;
+	u64 features;
+	union {				/* virtio config space */
+		struct virtio_console_config cons;
+		struct virtio_net_config net;
+	} config;
+	struct tmfifo_vring vrings[TMFIFO_VRING_NUM];
+	u8 *tx_buf;			/* tx buffer */
+	u32 tx_head;			/* tx buffer head */
+	u32 tx_tail;			/* tx buffer tail */
+};
+
+/* TMFIFO device structure */
+struct tmfifo {
+	struct tmfifo_vdev *vdev[TMFIFO_VDEV_MAX];	/* virtual devices */
+	struct platform_device *pdev;	/* platform device */
+	struct mutex lock;
+	void __iomem *rx_base;		/* mapped register base */
+	void __iomem *tx_base;		/* mapped register base */
+	int tx_fifo_size;		/* number of entries of the Tx FIFO */
+	int rx_fifo_size;		/* number of entries of the Rx FIFO */
+	unsigned long pend_events;	/* pending bits for deferred process */
+	int irq[TM_IRQ_CNT];		/* irq numbers */
+	struct work_struct work;	/* work struct for deferred process */
+	struct timer_list timer;	/* keepalive timer */
+	struct tmfifo_vring *vring[2];	/* current Tx/Rx ring */
+	bool is_ready;			/* ready flag */
+	spinlock_t spin_lock;		/* spin lock */
+};
+
+union tmfifo_msg_hdr {
+	struct {
+		u8 type;		/* message type */
+		__be16 len;		/* payload length */
+		u8 unused[5];		/* reserved, set to 0 */
+	} __packed;
+	u64 data;
+};
+
+/*
+ * Default MAC.
+ * This MAC address will be read from EFI persistent variable if configured.
+ * It can also be reconfigured with standard Linux tools.
+ */
+static u8 tmfifo_net_default_mac[6] = {0x00, 0x1A, 0xCA, 0xFF, 0xFF, 0x01};
+
+/* MTU setting of the virtio-net interface. */
+#define TMFIFO_NET_MTU		1500
+
+/* Supported virtio-net features. */
+#define TMFIFO_NET_FEATURES	((1UL << VIRTIO_NET_F_MTU) | \
+				 (1UL << VIRTIO_NET_F_STATUS) | \
+				 (1UL << VIRTIO_NET_F_MAC))
+
+/* Return the available Tx buffer space. */
+static inline int tmfifo_vdev_tx_buf_avail(struct tmfifo_vdev *vdev)
+{
+	return ((vdev->tx_tail >= vdev->tx_head) ?
+		(TMFIFO_CONS_TX_BUF_SIZE - 8 - (vdev->tx_tail -
+		vdev->tx_head)) : (vdev->tx_head - vdev->tx_tail - 8));
+}
+
+/* Update Tx buffer pointer after pushing data. */
+static inline void tmfifo_vdev_tx_buf_push(struct tmfifo_vdev *vdev, u32 len)
+{
+	vdev->tx_tail += len;
+	if (vdev->tx_tail >= TMFIFO_CONS_TX_BUF_SIZE)
+		vdev->tx_tail -= TMFIFO_CONS_TX_BUF_SIZE;
+}
+
+/* Update Tx buffer pointer after popping data. */
+static inline void tmfifo_vdev_tx_buf_pop(struct tmfifo_vdev *vdev, u32 len)
+{
+	vdev->tx_head += len;
+	if (vdev->tx_head >= TMFIFO_CONS_TX_BUF_SIZE)
+		vdev->tx_head -= TMFIFO_CONS_TX_BUF_SIZE;
+}
+
+/* Allocate vrings for the fifo. */
+static int tmfifo_alloc_vrings(struct tmfifo *fifo,
+			       struct tmfifo_vdev *tm_vdev, int vdev_id)
+{
+	dma_addr_t dma;
+	void *va;
+	int i, size;
+	struct tmfifo_vring *vring;
+
+	for (i = 0; i < ARRAY_SIZE(tm_vdev->vrings); i++) {
+		vring = &tm_vdev->vrings[i];
+		vring->fifo = fifo;
+		vring->size = tmfifo_vring_size;
+		vring->align = SMP_CACHE_BYTES;
+		vring->id = i;
+		vring->vdev_id = vdev_id;
+
+		size = PAGE_ALIGN(vring_size(vring->size, vring->align));
+		va = dma_alloc_coherent(tm_vdev->vdev.dev.parent, size, &dma,
+					GFP_KERNEL);
+		if (!va) {
+			dev_err(tm_vdev->vdev.dev.parent,
+				"vring allocation failed\n");
+			return -EINVAL;
+		}
+
+		vring->va = va;
+		vring->dma = dma;
+	}
+
+	return 0;
+}
+
+/* Free vrings of the fifo device. */
+static void tmfifo_free_vrings(struct tmfifo *fifo, int vdev_id)
+{
+	int i, size;
+	struct tmfifo_vring *vring;
+	struct tmfifo_vdev *tm_vdev = fifo->vdev[vdev_id];
+
+	for (i = 0; i < ARRAY_SIZE(tm_vdev->vrings); i++) {
+		vring = &tm_vdev->vrings[i];
+
+		size = PAGE_ALIGN(vring_size(vring->size, vring->align));
+		if (vring->va) {
+			dma_free_coherent(tm_vdev->vdev.dev.parent, size,
+					  vring->va, vring->dma);
+			vring->va = NULL;
+			if (vring->vq) {
+				vring_del_virtqueue(vring->vq);
+				vring->vq = NULL;
+			}
+		}
+	}
+}
+
+/* Free interrupts of the fifo device. */
+static void tmfifo_free_irqs(struct tmfifo *fifo)
+{
+	int i, irq;
+
+	for (i = 0; i < TM_IRQ_CNT; i++) {
+		irq = fifo->irq[i];
+		if (irq) {
+			fifo->irq[i] = 0;
+			disable_irq(irq);
+			free_irq(irq, (u8 *)fifo + i);
+		}
+	}
+}
+
+/* Interrupt handler. */
+static irqreturn_t tmfifo_irq_handler(int irq, void *dev_id)
+{
+	int i = (uintptr_t)dev_id % sizeof(void *);
+	struct tmfifo *fifo = dev_id - i;
+
+	if (i < TM_IRQ_CNT && !test_and_set_bit(i, &fifo->pend_events))
+		schedule_work(&fifo->work);
+
+	return IRQ_HANDLED;
+}
+
+/* Nothing to do for now. */
+static void tmfifo_virtio_dev_release(struct device *dev)
+{
+}
+
+/* Get the next packet descriptor from the vring. */
+static inline struct vring_desc *
+tmfifo_virtio_get_next_desc(struct virtqueue *vq)
+{
+	unsigned int idx, head;
+	struct vring *vr = (struct vring *)virtqueue_get_vring(vq);
+	struct tmfifo_vring *vring = (struct tmfifo_vring *)vq->priv;
+
+	if (!vr || vring->next_avail == vr->avail->idx)
+		return NULL;
+
+	idx = vring->next_avail % vr->num;
+	head = vr->avail->ring[idx];
+	BUG_ON(head >= vr->num);
+	vring->next_avail++;
+	return &vr->desc[head];
+}
+
+static inline void tmfifo_virtio_release_desc(struct virtio_device *vdev,
+					      struct vring *vr,
+					      struct vring_desc *desc, u32 len)
+{
+	unsigned int idx;
+
+	idx = vr->used->idx % vr->num;
+	vr->used->ring[idx].id = desc - vr->desc;
+	vr->used->ring[idx].len = cpu_to_virtio32(vdev, len);
+
+	/* Virtio could poll and check the 'idx' to decide
+	 * whether the desc is done or not. Add a memory
+	 * barrier here to make sure the update above completes
+	 * before updating the idx.
+	 */
+	mb();
+	vr->used->idx++;
+}
+
+/* Get the total length of a descriptor chain. */
+static inline u32 tmfifo_virtio_get_pkt_len(struct virtio_device *vdev,
+			struct vring_desc *desc, struct vring *vr)
+{
+	u32 len = 0, idx;
+
+	while (desc) {
+		len += virtio32_to_cpu(vdev, desc->len);
+		if (!(virtio16_to_cpu(vdev, desc->flags) & VRING_DESC_F_NEXT))
+			break;
+		idx = virtio16_to_cpu(vdev, desc->next);
+		desc = &vr->desc[idx];
+	}
+
+	return len;
+}
+
+static void tmfifo_release_pkt(struct virtio_device *vdev,
+			       struct tmfifo_vring *vring,
+			       struct vring_desc **desc)
+{
+	struct vring *vr = (struct vring *)virtqueue_get_vring(vring->vq);
+	struct vring_desc *desc_head;
+	uint32_t pkt_len = 0;
+
+	if (!vr)
+		return;
+
+	if (desc != NULL && *desc != NULL && vring->desc_head != NULL) {
+		desc_head = vring->desc_head;
+		pkt_len = vring->pkt_len;
+	} else {
+		desc_head = tmfifo_virtio_get_next_desc(vring->vq);
+		if (desc_head != NULL) {
+			pkt_len = tmfifo_virtio_get_pkt_len(vdev,
+							desc_head, vr);
+		}
+	}
+
+	if (desc_head != NULL)
+		tmfifo_virtio_release_desc(vdev, vr, desc_head, pkt_len);
+
+	if (desc != NULL)
+		*desc = NULL;
+	vring->pkt_len = 0;
+}
+
+/* House-keeping timer. */
+static void tmfifo_timer(struct timer_list *arg)
+{
+	struct tmfifo *fifo = container_of(arg, struct tmfifo, timer);
+
+	/*
+	 * Wake up the work handler to poll the Rx FIFO in case interrupt
+	 * missing or any leftover bytes stuck in the FIFO.
+	 */
+	test_and_set_bit(TM_RX_HWM_IRQ, &fifo->pend_events);
+
+	/*
+	 * Wake up Tx handler in case virtio has queued too many packets
+	 * and are waiting for buffer return.
+	 */
+	test_and_set_bit(TM_TX_LWM_IRQ, &fifo->pend_events);
+
+	schedule_work(&fifo->work);
+
+	mod_timer(&fifo->timer, jiffies + tmfifo_timer_interval);
+}
+
+/* Buffer the console output. */
+static void tmfifo_console_output(struct tmfifo_vdev *cons,
+				  struct virtqueue *vq)
+{
+	u32 len, pkt_len, idx;
+	struct vring_desc *head_desc, *desc = NULL;
+	struct vring *vr = (struct vring *)virtqueue_get_vring(vq);
+	struct virtio_device *vdev = &cons->vdev;
+	void *addr;
+	union tmfifo_msg_hdr *hdr;
+
+	for (;;) {
+		head_desc = tmfifo_virtio_get_next_desc(vq);
+		if (head_desc == NULL)
+			break;
+
+		/* Release the packet if no more space. */
+		pkt_len = tmfifo_virtio_get_pkt_len(vdev, head_desc, vr);
+		if (pkt_len + sizeof(*hdr) > tmfifo_vdev_tx_buf_avail(cons)) {
+			tmfifo_virtio_release_desc(vdev, vr, head_desc,
+						   pkt_len);
+			break;
+		}
+
+		hdr = (union tmfifo_msg_hdr *)&cons->tx_buf[cons->tx_tail];
+		hdr->data = 0;
+		hdr->type = VIRTIO_ID_CONSOLE;
+		hdr->len = htons(pkt_len);
+
+		tmfifo_vdev_tx_buf_push(cons, sizeof(*hdr));
+		desc = head_desc;
+
+		while (desc != NULL) {
+			addr = phys_to_virt(virtio64_to_cpu(vdev, desc->addr));
+			len = virtio32_to_cpu(vdev, desc->len);
+
+			if (len <= TMFIFO_CONS_TX_BUF_SIZE - cons->tx_tail) {
+				memcpy(cons->tx_buf + cons->tx_tail, addr, len);
+			} else {
+				u32 seg;
+
+				seg = TMFIFO_CONS_TX_BUF_SIZE - cons->tx_tail;
+				memcpy(cons->tx_buf + cons->tx_tail, addr, seg);
+				addr += seg;
+				memcpy(cons->tx_buf, addr, len - seg);
+			}
+			tmfifo_vdev_tx_buf_push(cons, len);
+
+			if (!(virtio16_to_cpu(vdev, desc->flags) &
+			    VRING_DESC_F_NEXT))
+				break;
+			idx = virtio16_to_cpu(vdev, desc->next);
+			desc = &vr->desc[idx];
+		}
+
+		/* Make each packet 8-byte aligned. */
+		tmfifo_vdev_tx_buf_push(cons, ((pkt_len + 7) & -8) - pkt_len);
+
+		tmfifo_virtio_release_desc(vdev, vr, head_desc, pkt_len);
+	}
+}
+
+/* Rx & Tx processing of a virtual queue. */
+static void tmfifo_virtio_rxtx(struct virtqueue *vq, bool is_rx)
+{
+	struct tmfifo_vring *vring;
+	struct tmfifo *fifo;
+	struct vring *vr;
+	struct virtio_device *vdev;
+	u64 sts, data;
+	int num_avail = 0, hdr_len, tx_reserve;
+	void *addr;
+	u32 len, idx;
+	struct vring_desc *desc;
+	unsigned long flags;
+	struct tmfifo_vdev *cons;
+
+	if (!vq)
+		return;
+
+	vring = (struct tmfifo_vring *)vq->priv;
+	fifo = vring->fifo;
+	vr = (struct vring *)virtqueue_get_vring(vq);
+
+	if (!fifo->vdev[vring->vdev_id])
+		return;
+	vdev = &fifo->vdev[vring->vdev_id]->vdev;
+	cons = fifo->vdev[VIRTIO_ID_CONSOLE];
+
+	/* Don't continue if another vring is running. */
+	if (fifo->vring[is_rx] != NULL && fifo->vring[is_rx] != vring)
+		return;
+
+	/* tx_reserve is used to reserved some room in FIFO for console. */
+	if (vring->vdev_id == VIRTIO_ID_NET) {
+		hdr_len = sizeof(struct virtio_net_hdr);
+		tx_reserve = fifo->tx_fifo_size / 16;
+	} else {
+		BUG_ON(vring->vdev_id != VIRTIO_ID_CONSOLE);
+		hdr_len = 0;
+		tx_reserve = 1;
+	}
+
+	desc = vring->desc;
+
+again:
+	while (1) {
+		/* Get available FIFO space. */
+		if (num_avail == 0) {
+			if (is_rx) {
+				/* Get the number of available words in FIFO. */
+				sts = readq(fifo->rx_base + TMFIFO_RX_STS);
+				num_avail = FIELD_GET(
+					TMFIFO_RX_STS__COUNT_MASK, sts);
+
+				/* Don't continue if nothing in FIFO. */
+				if (num_avail <= 0)
+					break;
+			} else {
+				/* Get available space in FIFO. */
+				sts = readq(fifo->tx_base + TMFIFO_TX_STS);
+				num_avail = fifo->tx_fifo_size - tx_reserve -
+					FIELD_GET(
+						TMFIFO_TX_STS__COUNT_MASK, sts);
+
+				if (num_avail <= 0)
+					break;
+			}
+		}
+
+		/* Console output always comes from the Tx buffer. */
+		if (!is_rx && vring->vdev_id == VIRTIO_ID_CONSOLE &&
+		    cons != NULL && cons->tx_buf != NULL) {
+			for (;;) {
+				spin_lock_irqsave(&fifo->spin_lock, flags);
+				if (cons->tx_head == cons->tx_tail) {
+					spin_unlock_irqrestore(
+						&fifo->spin_lock, flags);
+					return;
+				}
+				addr = cons->tx_buf + cons->tx_head;
+				writeq(cpu_to_le64(*(u64 *)addr),
+				       fifo->tx_base + TMFIFO_TX_DATA);
+				tmfifo_vdev_tx_buf_pop(cons, sizeof(u64));
+				spin_unlock_irqrestore(&fifo->spin_lock,
+						       flags);
+				if (--num_avail <= 0)
+					goto again;
+			}
+		}
+
+		/* Get the desc of next packet. */
+		if (!desc) {
+			/* Save the head desc of the chain. */
+			vring->desc_head = tmfifo_virtio_get_next_desc(vq);
+			if (!vring->desc_head) {
+				vring->desc = NULL;
+				return;
+			}
+			desc = vring->desc_head;
+			vring->desc = desc;
+
+			if (is_rx && vring->vdev_id == VIRTIO_ID_NET) {
+				struct virtio_net_hdr *net_hdr;
+
+				/* Initialize the packet header. */
+				net_hdr = (struct virtio_net_hdr *)
+					phys_to_virt(virtio64_to_cpu(
+						vdev, desc->addr));
+				memset(net_hdr, 0, sizeof(*net_hdr));
+			}
+		}
+
+		/* Beginning of each packet. */
+		if (vring->pkt_len == 0) {
+			int vdev_id, vring_change = 0;
+			union tmfifo_msg_hdr hdr;
+
+			num_avail--;
+
+			/* Read/Write packet length. */
+			if (is_rx) {
+				hdr.data = readq(fifo->rx_base +
+						 TMFIFO_RX_DATA);
+				hdr.data = le64_to_cpu(hdr.data);
+
+				/* Skip the length 0 packet (keepalive). */
+				if (hdr.len == 0)
+					continue;
+
+				/* Check packet type. */
+				if (hdr.type == VIRTIO_ID_NET) {
+					vdev_id = VIRTIO_ID_NET;
+					hdr_len = sizeof(struct virtio_net_hdr);
+				} else if (hdr.type == VIRTIO_ID_CONSOLE) {
+					vdev_id = VIRTIO_ID_CONSOLE;
+					hdr_len = 0;
+				} else {
+					continue;
+				}
+
+				/*
+				 * Check whether the new packet still belongs
+				 * to this vring or not. If not, update the
+				 * pkt_len of the new vring and return.
+				 */
+				if (vdev_id != vring->vdev_id) {
+					struct tmfifo_vdev *dev2 =
+						fifo->vdev[vdev_id];
+
+					if (!dev2)
+						break;
+					vring->desc = desc;
+					vring = &dev2->vrings[TMFIFO_VRING_RX];
+					vring_change = 1;
+				}
+				vring->pkt_len = ntohs(hdr.len) + hdr_len;
+			} else {
+				vring->pkt_len = tmfifo_virtio_get_pkt_len(
+					vdev, desc, vr);
+
+				hdr.data = 0;
+				hdr.type = (vring->vdev_id == VIRTIO_ID_NET) ?
+					VIRTIO_ID_NET :
+					VIRTIO_ID_CONSOLE;
+				hdr.len = htons(vring->pkt_len - hdr_len);
+				writeq(cpu_to_le64(hdr.data),
+				       fifo->tx_base + TMFIFO_TX_DATA);
+			}
+
+			vring->cur_len = hdr_len;
+			vring->rem_len = vring->pkt_len;
+			fifo->vring[is_rx] = vring;
+
+			if (vring_change)
+				return;
+			continue;
+		}
+
+		/* Check available space in this desc. */
+		len = virtio32_to_cpu(vdev, desc->len);
+		if (len > vring->rem_len)
+			len = vring->rem_len;
+
+		/* Check if the current desc is already done. */
+		if (vring->cur_len == len)
+			goto check_done;
+
+		addr = phys_to_virt(virtio64_to_cpu(vdev, desc->addr));
+
+		/* Read a word from FIFO for Rx. */
+		if (is_rx) {
+			data = readq(fifo->rx_base + TMFIFO_RX_DATA);
+			data = le64_to_cpu(data);
+		}
+
+		if (vring->cur_len + sizeof(u64) <= len) {
+			/* The whole word. */
+			if (is_rx) {
+				memcpy(addr + vring->cur_len, &data,
+				       sizeof(u64));
+			} else {
+				memcpy(&data, addr + vring->cur_len,
+				       sizeof(u64));
+			}
+			vring->cur_len += sizeof(u64);
+		} else {
+			/* Leftover bytes. */
+			BUG_ON(vring->cur_len > len);
+			if (is_rx) {
+				memcpy(addr + vring->cur_len, &data,
+				       len - vring->cur_len);
+			} else {
+				memcpy(&data, addr + vring->cur_len,
+				       len - vring->cur_len);
+			}
+			vring->cur_len = len;
+		}
+
+		/* Write the word into FIFO for Tx. */
+		if (!is_rx) {
+			writeq(cpu_to_le64(data),
+			       fifo->tx_base + TMFIFO_TX_DATA);
+		}
+
+		num_avail--;
+
+check_done:
+		/* Check whether this desc is full or completed. */
+		if (vring->cur_len == len) {
+			vring->cur_len = 0;
+			vring->rem_len -= len;
+
+			/* Get the next desc on the chain. */
+			if (vring->rem_len > 0 &&
+			    (virtio16_to_cpu(vdev, desc->flags) &
+						VRING_DESC_F_NEXT)) {
+				idx = virtio16_to_cpu(vdev, desc->next);
+				desc = &vr->desc[idx];
+				continue;
+			}
+
+			/* Done and release the desc. */
+			tmfifo_release_pkt(vdev, vring, &desc);
+			fifo->vring[is_rx] = NULL;
+
+			/* Notify upper layer that packet is done. */
+			spin_lock_irqsave(&fifo->spin_lock, flags);
+			vring_interrupt(0, vq);
+			spin_unlock_irqrestore(&fifo->spin_lock, flags);
+			continue;
+		}
+	}
+
+	/* Save the current desc. */
+	vring->desc = desc;
+}
+
+/* The notify function is called when new buffers are posted. */
+static bool tmfifo_virtio_notify(struct virtqueue *vq)
+{
+	struct tmfifo_vring *vring = (struct tmfifo_vring *)vq->priv;
+	struct tmfifo *fifo = vring->fifo;
+	unsigned long flags;
+
+	/*
+	 * Virtio maintains vrings in pairs, even number ring for Rx
+	 * and odd number ring for Tx.
+	 */
+	if (!(vring->id & 1)) {
+		/* Set the RX HWM bit to start Rx. */
+		if (!test_and_set_bit(TM_RX_HWM_IRQ, &fifo->pend_events))
+			schedule_work(&fifo->work);
+	} else {
+		/*
+		 * Console could make blocking call with interrupts disabled.
+		 * In such case, the vring needs to be served right away. For
+		 * other cases, just set the TX LWM bit to start Tx in the
+		 * worker handler.
+		 */
+		if (vring->vdev_id == VIRTIO_ID_CONSOLE) {
+			spin_lock_irqsave(&fifo->spin_lock, flags);
+			tmfifo_console_output(fifo->vdev[VIRTIO_ID_CONSOLE],
+					      vq);
+			spin_unlock_irqrestore(&fifo->spin_lock, flags);
+			schedule_work(&fifo->work);
+		} else if (!test_and_set_bit(TM_TX_LWM_IRQ, &fifo->pend_events))
+			schedule_work(&fifo->work);
+	}
+
+	return true;
+}
+
+/* Work handler for Rx, Tx or activity monitoring. */
+static void tmfifo_work_handler(struct work_struct *work)
+{
+	int i;
+	struct tmfifo_vdev *tm_vdev;
+	struct tmfifo *fifo = container_of(work, struct tmfifo, work);
+
+	if (!fifo->is_ready)
+		return;
+
+	mutex_lock(&fifo->lock);
+
+	/* Tx. */
+	if (test_and_clear_bit(TM_TX_LWM_IRQ, &fifo->pend_events) &&
+		       fifo->irq[TM_TX_LWM_IRQ]) {
+		for (i = 0; i < TMFIFO_VDEV_MAX; i++) {
+			tm_vdev = fifo->vdev[i];
+			if (tm_vdev != NULL) {
+				tmfifo_virtio_rxtx(
+					tm_vdev->vrings[TMFIFO_VRING_TX].vq,
+					false);
+			}
+		}
+	}
+
+	/* Rx. */
+	if (test_and_clear_bit(TM_RX_HWM_IRQ, &fifo->pend_events) &&
+		       fifo->irq[TM_RX_HWM_IRQ]) {
+		for (i = 0; i < TMFIFO_VDEV_MAX; i++) {
+			tm_vdev = fifo->vdev[i];
+			if (tm_vdev != NULL) {
+				tmfifo_virtio_rxtx(
+					tm_vdev->vrings[TMFIFO_VRING_RX].vq,
+					true);
+			}
+		}
+	}
+
+	mutex_unlock(&fifo->lock);
+}
+
+/* Get the array of feature bits for this device. */
+static u64 tmfifo_virtio_get_features(struct virtio_device *vdev)
+{
+	struct tmfifo_vdev *tm_vdev = container_of(vdev, struct tmfifo_vdev,
+						   vdev);
+
+	return tm_vdev->features;
+}
+
+/* Confirm device features to use. */
+static int tmfifo_virtio_finalize_features(struct virtio_device *vdev)
+{
+	struct tmfifo_vdev *tm_vdev = container_of(vdev, struct tmfifo_vdev,
+						   vdev);
+
+	tm_vdev->features = vdev->features;
+	return 0;
+}
+
+/* Free virtqueues found by find_vqs(). */
+static void tmfifo_virtio_del_vqs(struct virtio_device *vdev)
+{
+	int i;
+	struct tmfifo_vring *vring;
+	struct virtqueue *vq;
+	struct tmfifo_vdev *tm_vdev = container_of(vdev, struct tmfifo_vdev,
+						   vdev);
+
+	for (i = 0; i < ARRAY_SIZE(tm_vdev->vrings); i++) {
+		vring = &tm_vdev->vrings[i];
+
+		/* Release the pending packet. */
+		if (vring->desc != NULL)
+			tmfifo_release_pkt(&tm_vdev->vdev, vring, &vring->desc);
+
+		vq = vring->vq;
+		if (vq) {
+			vring->vq = NULL;
+			vring_del_virtqueue(vq);
+		}
+	}
+}
+
+/* Create and initialize the virtual queues. */
+static int tmfifo_virtio_find_vqs(struct virtio_device *vdev,
+				  unsigned int nvqs,
+				  struct virtqueue *vqs[],
+				  vq_callback_t *callbacks[],
+				  const char * const names[],
+				  const bool *ctx,
+				  struct irq_affinity *desc)
+{
+	int i, ret = -EINVAL, size;
+	struct tmfifo_vring *vring;
+	struct virtqueue *vq;
+	struct tmfifo_vdev *tm_vdev = container_of(vdev, struct tmfifo_vdev,
+						   vdev);
+
+	if (nvqs > ARRAY_SIZE(tm_vdev->vrings))
+		return -EINVAL;
+
+	for (i = 0; i < nvqs; ++i) {
+		if (!names[i])
+			goto error;
+		vring = &tm_vdev->vrings[i];
+
+		/* zero vring */
+		size = vring_size(vring->size, vring->align);
+		memset(vring->va, 0, size);
+		vq = vring_new_virtqueue(i, vring->size, vring->align, vdev,
+					 false, false, vring->va,
+					 tmfifo_virtio_notify,
+					 callbacks[i], names[i]);
+		if (!vq) {
+			dev_err(&vdev->dev, "vring_new_virtqueue failed\n");
+			ret = -ENOMEM;
+			goto error;
+		}
+
+		vqs[i] = vq;
+		vring->vq = vq;
+		vq->priv = vring;
+	}
+
+	return 0;
+
+error:
+	tmfifo_virtio_del_vqs(vdev);
+	return ret;
+}
+
+/* Read the status byte. */
+static u8 tmfifo_virtio_get_status(struct virtio_device *vdev)
+{
+	struct tmfifo_vdev *tm_vdev = container_of(vdev, struct tmfifo_vdev,
+						   vdev);
+
+	return tm_vdev->status;
+}
+
+/* Write the status byte. */
+static void tmfifo_virtio_set_status(struct virtio_device *vdev, u8 status)
+{
+	struct tmfifo_vdev *tm_vdev = container_of(vdev, struct tmfifo_vdev,
+						   vdev);
+
+	tm_vdev->status = status;
+}
+
+/* Reset the device. Not much here for now. */
+static void tmfifo_virtio_reset(struct virtio_device *vdev)
+{
+	struct tmfifo_vdev *tm_vdev = container_of(vdev, struct tmfifo_vdev,
+						   vdev);
+
+	tm_vdev->status = 0;
+}
+
+/* Read the value of a configuration field. */
+static void tmfifo_virtio_get(struct virtio_device *vdev,
+			      unsigned int offset,
+			      void *buf,
+			      unsigned int len)
+{
+	struct tmfifo_vdev *tm_vdev = container_of(vdev, struct tmfifo_vdev,
+						   vdev);
+
+	if (offset + len > sizeof(tm_vdev->config) || offset + len < len) {
+		dev_err(vdev->dev.parent, "virtio_get access out of bounds\n");
+		return;
+	}
+
+	memcpy(buf, (u8 *)&tm_vdev->config + offset, len);
+}
+
+/* Write the value of a configuration field. */
+static void tmfifo_virtio_set(struct virtio_device *vdev,
+				 unsigned int offset,
+				 const void *buf,
+				 unsigned int len)
+{
+	struct tmfifo_vdev *tm_vdev = container_of(vdev, struct tmfifo_vdev,
+						   vdev);
+
+	if (offset + len > sizeof(tm_vdev->config) || offset + len < len) {
+		dev_err(vdev->dev.parent, "virtio_get access out of bounds\n");
+		return;
+	}
+
+	memcpy((u8 *)&tm_vdev->config + offset, buf, len);
+}
+
+/* Virtio config operations. */
+static const struct virtio_config_ops tmfifo_virtio_config_ops = {
+	.get_features = tmfifo_virtio_get_features,
+	.finalize_features = tmfifo_virtio_finalize_features,
+	.find_vqs = tmfifo_virtio_find_vqs,
+	.del_vqs = tmfifo_virtio_del_vqs,
+	.reset = tmfifo_virtio_reset,
+	.set_status = tmfifo_virtio_set_status,
+	.get_status = tmfifo_virtio_get_status,
+	.get = tmfifo_virtio_get,
+	.set = tmfifo_virtio_set,
+};
+
+/* Create vdev type in a tmfifo. */
+int tmfifo_create_vdev(struct tmfifo *fifo, int vdev_id, u64 features,
+		       void *config, u32 size)
+{
+	struct tmfifo_vdev *tm_vdev;
+	int ret = 0;
+
+	mutex_lock(&fifo->lock);
+
+	tm_vdev = fifo->vdev[vdev_id];
+	if (tm_vdev != NULL) {
+		pr_err("vdev %d already exists\n", vdev_id);
+		ret = -EEXIST;
+		goto already_exist;
+	}
+
+	tm_vdev = kzalloc(sizeof(*tm_vdev), GFP_KERNEL);
+	if (!tm_vdev) {
+		ret = -ENOMEM;
+		goto already_exist;
+	}
+
+	tm_vdev->vdev.id.device = vdev_id;
+	tm_vdev->vdev.config = &tmfifo_virtio_config_ops;
+	tm_vdev->vdev.dev.parent = &fifo->pdev->dev;
+	tm_vdev->vdev.dev.release = tmfifo_virtio_dev_release;
+	tm_vdev->features = features;
+	if (config)
+		memcpy(&tm_vdev->config, config, size);
+	if (tmfifo_alloc_vrings(fifo, tm_vdev, vdev_id)) {
+		pr_err("Unable to allocate vring\n");
+		ret = -ENOMEM;
+		goto alloc_vring_fail;
+	}
+	if (vdev_id == VIRTIO_ID_CONSOLE) {
+		tm_vdev->tx_buf = kmalloc(TMFIFO_CONS_TX_BUF_SIZE,
+					  GFP_KERNEL);
+	}
+	fifo->vdev[vdev_id] = tm_vdev;
+
+	/* Register the virtio device. */
+	ret = register_virtio_device(&tm_vdev->vdev);
+	if (ret) {
+		dev_err(&fifo->pdev->dev, "register_virtio_device() failed\n");
+		goto register_fail;
+	}
+
+	mutex_unlock(&fifo->lock);
+	return 0;
+
+register_fail:
+	tmfifo_free_vrings(fifo, vdev_id);
+	fifo->vdev[vdev_id] = NULL;
+alloc_vring_fail:
+	kfree(tm_vdev);
+already_exist:
+	mutex_unlock(&fifo->lock);
+	return ret;
+}
+
+/* Delete vdev type from a tmfifo. */
+int tmfifo_delete_vdev(struct tmfifo *fifo, int vdev_id)
+{
+	struct tmfifo_vdev *tm_vdev;
+
+	mutex_lock(&fifo->lock);
+
+	/* Unregister vdev. */
+	tm_vdev = fifo->vdev[vdev_id];
+	if (tm_vdev) {
+		unregister_virtio_device(&tm_vdev->vdev);
+		tmfifo_free_vrings(fifo, vdev_id);
+		kfree(tm_vdev->tx_buf);
+		kfree(tm_vdev);
+		fifo->vdev[vdev_id] = NULL;
+	}
+
+	mutex_unlock(&fifo->lock);
+
+	return 0;
+}
+
+/* Device remove function. */
+static int tmfifo_remove(struct platform_device *pdev)
+{
+	int i;
+	struct tmfifo *fifo = platform_get_drvdata(pdev);
+	struct resource *rx_res, *tx_res;
+
+	if (fifo) {
+		mutex_lock(&tmfifo_lock);
+
+		fifo->is_ready = false;
+
+		/* Stop the timer. */
+		del_timer_sync(&fifo->timer);
+
+		/* Release interrupts. */
+		tmfifo_free_irqs(fifo);
+
+		/* Cancel the pending work. */
+		cancel_work_sync(&fifo->work);
+
+		for (i = 0; i < TMFIFO_VDEV_MAX; i++)
+			tmfifo_delete_vdev(fifo, i);
+
+		/* Release IO resources. */
+		if (fifo->rx_base)
+			iounmap(fifo->rx_base);
+		if (fifo->tx_base)
+			iounmap(fifo->tx_base);
+
+		platform_set_drvdata(pdev, NULL);
+		kfree(fifo);
+
+		mutex_unlock(&tmfifo_lock);
+	}
+
+	rx_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (rx_res)
+		release_mem_region(rx_res->start, resource_size(rx_res));
+	tx_res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	if (tx_res)
+		release_mem_region(tx_res->start, resource_size(tx_res));
+
+	return 0;
+}
+
+/* Read the configured network MAC address from efi variable. */
+static void tmfifo_get_cfg_mac(u8 *mac)
+{
+	u8 buf[6];
+	efi_status_t status;
+	unsigned long size = sizeof(buf);
+	efi_char16_t name[] = { 'R', 's', 'h', 'i', 'm', 'M', 'a', 'c',
+				'A', 'd', 'd', 'r', 0 };
+	efi_guid_t guid = EFI_GLOBAL_VARIABLE_GUID;
+
+	status = efi.get_variable(name, &guid, NULL, &size, buf);
+	if (status == EFI_SUCCESS && size == sizeof(buf))
+		memcpy(mac, buf, sizeof(buf));
+}
+
+/* Probe the TMFIFO. */
+static int tmfifo_probe(struct platform_device *pdev)
+{
+	u64 ctl;
+	struct tmfifo *fifo;
+	struct resource *rx_res, *tx_res;
+	struct virtio_net_config net_config;
+	int i, ret;
+
+	/* Get the resource of the Rx & Tx FIFO. */
+	rx_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	tx_res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	if (!rx_res || !tx_res) {
+		ret = -EINVAL;
+		goto err;
+	}
+
+	if (request_mem_region(rx_res->start,
+			       resource_size(rx_res), "bf-tmfifo") == NULL) {
+		ret = -EBUSY;
+		goto early_err;
+	}
+
+	if (request_mem_region(tx_res->start,
+			       resource_size(tx_res), "bf-tmfifo") == NULL) {
+		release_mem_region(rx_res->start, resource_size(rx_res));
+		ret = -EBUSY;
+		goto early_err;
+	}
+
+	ret = -ENOMEM;
+	fifo = kzalloc(sizeof(struct tmfifo), GFP_KERNEL);
+	if (!fifo)
+		goto err;
+
+	fifo->pdev = pdev;
+	platform_set_drvdata(pdev, fifo);
+
+	spin_lock_init(&fifo->spin_lock);
+	INIT_WORK(&fifo->work, tmfifo_work_handler);
+
+	timer_setup(&fifo->timer, tmfifo_timer, 0);
+	fifo->timer.function = tmfifo_timer;
+
+	for (i = 0; i < TM_IRQ_CNT; i++) {
+		fifo->irq[i] = platform_get_irq(pdev, i);
+		ret = request_irq(fifo->irq[i], tmfifo_irq_handler, 0,
+				  "tmfifo", (u8 *)fifo + i);
+		if (ret) {
+			pr_err("Unable to request irq\n");
+			fifo->irq[i] = 0;
+			goto err;
+		}
+	}
+
+	fifo->rx_base = ioremap(rx_res->start, resource_size(rx_res));
+	if (!fifo->rx_base)
+		goto err;
+
+	fifo->tx_base = ioremap(tx_res->start, resource_size(tx_res));
+	if (!fifo->tx_base)
+		goto err;
+
+	/* Get Tx FIFO size and set the low/high watermark. */
+	ctl = readq(fifo->tx_base + TMFIFO_TX_CTL);
+	fifo->tx_fifo_size =
+		FIELD_GET(TMFIFO_TX_CTL__MAX_ENTRIES_MASK, ctl);
+	ctl = (ctl & ~TMFIFO_TX_CTL__LWM_MASK) |
+		FIELD_PREP(TMFIFO_TX_CTL__LWM_MASK, fifo->tx_fifo_size / 2);
+	ctl = (ctl & ~TMFIFO_TX_CTL__HWM_MASK) |
+		FIELD_PREP(TMFIFO_TX_CTL__HWM_MASK, fifo->tx_fifo_size - 1);
+	writeq(ctl, fifo->tx_base + TMFIFO_TX_CTL);
+
+	/* Get Rx FIFO size and set the low/high watermark. */
+	ctl = readq(fifo->rx_base + TMFIFO_RX_CTL);
+	fifo->rx_fifo_size =
+		FIELD_GET(TMFIFO_RX_CTL__MAX_ENTRIES_MASK, ctl);
+	ctl = (ctl & ~TMFIFO_RX_CTL__LWM_MASK) |
+		FIELD_PREP(TMFIFO_RX_CTL__LWM_MASK, 0);
+	ctl = (ctl & ~TMFIFO_RX_CTL__HWM_MASK) |
+		FIELD_PREP(TMFIFO_RX_CTL__HWM_MASK, 1);
+	writeq(ctl, fifo->rx_base + TMFIFO_RX_CTL);
+
+	mutex_init(&fifo->lock);
+
+	/* Create the console vdev. */
+	ret = tmfifo_create_vdev(fifo, VIRTIO_ID_CONSOLE, 0, NULL, 0);
+	if (ret)
+		goto err;
+
+	/* Create the network vdev. */
+	memset(&net_config, 0, sizeof(net_config));
+	net_config.mtu = TMFIFO_NET_MTU;
+	net_config.status = VIRTIO_NET_S_LINK_UP;
+	memcpy(net_config.mac, tmfifo_net_default_mac, 6);
+	tmfifo_get_cfg_mac(net_config.mac);
+	ret = tmfifo_create_vdev(fifo, VIRTIO_ID_NET, TMFIFO_NET_FEATURES,
+				 &net_config, sizeof(net_config));
+	if (ret)
+		goto err;
+
+	mod_timer(&fifo->timer, jiffies + tmfifo_timer_interval);
+
+	fifo->is_ready = true;
+
+	return 0;
+
+err:
+	tmfifo_remove(pdev);
+early_err:
+	dev_err(&pdev->dev, "Probe Failed\n");
+	return ret;
+}
+
+static const struct of_device_id tmfifo_match[] = {
+	{ .compatible = "mellanox,bf-tmfifo" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, tmfifo_match);
+
+static const struct acpi_device_id bf_tmfifo_acpi_match[] = {
+	{ "MLNXBF01", 0 },
+	{},
+};
+MODULE_DEVICE_TABLE(acpi, bf_tmfifo_acpi_match);
+
+static struct platform_driver tmfifo_driver = {
+	.probe = tmfifo_probe,
+	.remove = tmfifo_remove,
+	.driver = {
+		.name = "bf-tmfifo",
+		.of_match_table = tmfifo_match,
+		.acpi_match_table = ACPI_PTR(bf_tmfifo_acpi_match),
+	},
+};
+
+static int __init tmfifo_init(void)
+{
+	int ret;
+
+	ret = platform_driver_register(&tmfifo_driver);
+	if (ret)
+		pr_err("Failed to register tmfifo driver.\n");
+
+	return ret;
+}
+
+static void __exit tmfifo_exit(void)
+{
+	platform_driver_unregister(&tmfifo_driver);
+}
+
+module_init(tmfifo_init);
+module_exit(tmfifo_exit);
+
+MODULE_DESCRIPTION("Mellanox BlueField SoC TMFIFO Driver");
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Mellanox Technologies");
diff --git a/drivers/soc/mellanox/tmfifo_regs.h b/drivers/soc/mellanox/tmfifo_regs.h
new file mode 100644
index 0000000..9f21764
--- /dev/null
+++ b/drivers/soc/mellanox/tmfifo_regs.h
@@ -0,0 +1,76 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2018, Mellanox Technologies. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef __TMFIFO_REGS_H__
+#define __TMFIFO_REGS_H__
+
+#include <linux/types.h>
+
+#define TMFIFO_TX_DATA 0x0
+
+#define TMFIFO_TX_STS 0x8
+#define TMFIFO_TX_STS__LENGTH 0x0001
+#define TMFIFO_TX_STS__COUNT_SHIFT 0
+#define TMFIFO_TX_STS__COUNT_WIDTH 9
+#define TMFIFO_TX_STS__COUNT_RESET_VAL 0
+#define TMFIFO_TX_STS__COUNT_RMASK 0x1ff
+#define TMFIFO_TX_STS__COUNT_MASK  0x1ff
+
+#define TMFIFO_TX_CTL 0x10
+#define TMFIFO_TX_CTL__LENGTH 0x0001
+#define TMFIFO_TX_CTL__LWM_SHIFT 0
+#define TMFIFO_TX_CTL__LWM_WIDTH 8
+#define TMFIFO_TX_CTL__LWM_RESET_VAL 128
+#define TMFIFO_TX_CTL__LWM_RMASK 0xff
+#define TMFIFO_TX_CTL__LWM_MASK  0xff
+#define TMFIFO_TX_CTL__HWM_SHIFT 8
+#define TMFIFO_TX_CTL__HWM_WIDTH 8
+#define TMFIFO_TX_CTL__HWM_RESET_VAL 128
+#define TMFIFO_TX_CTL__HWM_RMASK 0xff
+#define TMFIFO_TX_CTL__HWM_MASK  0xff00
+#define TMFIFO_TX_CTL__MAX_ENTRIES_SHIFT 32
+#define TMFIFO_TX_CTL__MAX_ENTRIES_WIDTH 9
+#define TMFIFO_TX_CTL__MAX_ENTRIES_RESET_VAL 256
+#define TMFIFO_TX_CTL__MAX_ENTRIES_RMASK 0x1ff
+#define TMFIFO_TX_CTL__MAX_ENTRIES_MASK  0x1ff00000000ULL
+
+#define TMFIFO_RX_DATA 0x0
+
+#define TMFIFO_RX_STS 0x8
+#define TMFIFO_RX_STS__LENGTH 0x0001
+#define TMFIFO_RX_STS__COUNT_SHIFT 0
+#define TMFIFO_RX_STS__COUNT_WIDTH 9
+#define TMFIFO_RX_STS__COUNT_RESET_VAL 0
+#define TMFIFO_RX_STS__COUNT_RMASK 0x1ff
+#define TMFIFO_RX_STS__COUNT_MASK  0x1ff
+
+#define TMFIFO_RX_CTL 0x10
+#define TMFIFO_RX_CTL__LENGTH 0x0001
+#define TMFIFO_RX_CTL__LWM_SHIFT 0
+#define TMFIFO_RX_CTL__LWM_WIDTH 8
+#define TMFIFO_RX_CTL__LWM_RESET_VAL 128
+#define TMFIFO_RX_CTL__LWM_RMASK 0xff
+#define TMFIFO_RX_CTL__LWM_MASK  0xff
+#define TMFIFO_RX_CTL__HWM_SHIFT 8
+#define TMFIFO_RX_CTL__HWM_WIDTH 8
+#define TMFIFO_RX_CTL__HWM_RESET_VAL 128
+#define TMFIFO_RX_CTL__HWM_RMASK 0xff
+#define TMFIFO_RX_CTL__HWM_MASK  0xff00
+#define TMFIFO_RX_CTL__MAX_ENTRIES_SHIFT 32
+#define TMFIFO_RX_CTL__MAX_ENTRIES_WIDTH 9
+#define TMFIFO_RX_CTL__MAX_ENTRIES_RESET_VAL 256
+#define TMFIFO_RX_CTL__MAX_ENTRIES_RMASK 0x1ff
+#define TMFIFO_RX_CTL__MAX_ENTRIES_MASK  0x1ff00000000ULL
+
+#endif /* !defined(__TMFIFO_REGS_H__) */
-- 
1.8.3.1
