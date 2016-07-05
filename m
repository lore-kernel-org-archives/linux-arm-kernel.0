From: josephl@nvidia.com (Joseph Lo)
Date: Tue, 5 Jul 2016 17:04:25 +0800
Subject: [PATCH V2 04/10] firmware: tegra: add IVC library
In-Reply-To: <20160705090431.5852-1-josephl@nvidia.com>
References: <20160705090431.5852-1-josephl@nvidia.com>
Message-ID: <20160705090431.5852-5-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Inter-VM communication (IVC) is a communication protocol, which is
designed for interprocessor communication (IPC) or the communication
between the hypervisor and the virtual machine with a guest OS on it. So
it can be translated as inter-virtual memory or inter-virtual machine
communication. The message channels are maintained on the DRAM or SRAM
and the data coherency should be considered. Or the data could be
corrupted or out of date when the remote client checking it.

Inside the IVC, it maintains memory-based descriptors for the TX/RX
channels and the coherency issue of the counter and payloads. So the
clients can use it to send/receive messages to/from remote ones.

We introduce it as a library for the firmware drivers, which can use it
for IPC.

Based-on-the-work-by:
Peter Newman <pnewman@nvidia.com>

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
Changes in V2:
- None
---
 drivers/firmware/Kconfig        |   1 +
 drivers/firmware/Makefile       |   1 +
 drivers/firmware/tegra/Kconfig  |  13 +
 drivers/firmware/tegra/Makefile |   1 +
 drivers/firmware/tegra/ivc.c    | 659 ++++++++++++++++++++++++++++++++++++++++
 include/soc/tegra/ivc.h         | 102 +++++++
 6 files changed, 777 insertions(+)
 create mode 100644 drivers/firmware/tegra/Kconfig
 create mode 100644 drivers/firmware/tegra/Makefile
 create mode 100644 drivers/firmware/tegra/ivc.c
 create mode 100644 include/soc/tegra/ivc.h

diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index 5e618058defe..bbd64ae8c4c6 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -200,5 +200,6 @@ config HAVE_ARM_SMCCC
 source "drivers/firmware/broadcom/Kconfig"
 source "drivers/firmware/google/Kconfig"
 source "drivers/firmware/efi/Kconfig"
+source "drivers/firmware/tegra/Kconfig"
 
 endmenu
diff --git a/drivers/firmware/Makefile b/drivers/firmware/Makefile
index 474bada56fcd..9a4df8171cc4 100644
--- a/drivers/firmware/Makefile
+++ b/drivers/firmware/Makefile
@@ -24,3 +24,4 @@ obj-y				+= broadcom/
 obj-$(CONFIG_GOOGLE_FIRMWARE)	+= google/
 obj-$(CONFIG_EFI)		+= efi/
 obj-$(CONFIG_UEFI_CPER)		+= efi/
+obj-y				+= tegra/
diff --git a/drivers/firmware/tegra/Kconfig b/drivers/firmware/tegra/Kconfig
new file mode 100644
index 000000000000..1fa3e4e136a5
--- /dev/null
+++ b/drivers/firmware/tegra/Kconfig
@@ -0,0 +1,13 @@
+menu "Tegra firmware driver"
+
+config TEGRA_IVC
+	bool "Tegra IVC protocol"
+	depends on ARCH_TEGRA
+	help
+	  IVC (Inter-VM Communication) protocol is part of the IPC
+	  (Inter Processor Communication) framework on Tegra. It maintains the
+	  data and the different commuication channels in SysRAM or RAM and
+	  keeps the content is synchronization between host CPU and remote
+	  processors.
+
+endmenu
diff --git a/drivers/firmware/tegra/Makefile b/drivers/firmware/tegra/Makefile
new file mode 100644
index 000000000000..92e2153e8173
--- /dev/null
+++ b/drivers/firmware/tegra/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_TEGRA_IVC)		+= ivc.o
diff --git a/drivers/firmware/tegra/ivc.c b/drivers/firmware/tegra/ivc.c
new file mode 100644
index 000000000000..3e736bb9915a
--- /dev/null
+++ b/drivers/firmware/tegra/ivc.c
@@ -0,0 +1,659 @@
+/*
+ * Copyright (c) 2014-2016, NVIDIA CORPORATION.  All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ */
+
+#include <linux/module.h>
+
+#include <soc/tegra/ivc.h>
+
+#define IVC_ALIGN 64
+
+#ifdef CONFIG_SMP
+
+static inline void ivc_rmb(void)
+{
+	smp_rmb();
+}
+
+static inline void ivc_wmb(void)
+{
+	smp_wmb();
+}
+
+static inline void ivc_mb(void)
+{
+	smp_mb();
+}
+
+#else
+
+static inline void ivc_rmb(void)
+{
+	rmb();
+}
+
+static inline void ivc_wmb(void)
+{
+	wmb();
+}
+
+static inline void ivc_mb(void)
+{
+	mb();
+}
+
+#endif
+
+/*
+ * IVC channel reset protocol.
+ *
+ * Each end uses its tx_channel.state to indicate its synchronization state.
+ */
+enum ivc_state {
+	/*
+	 * This value is zero for backwards compatibility with services that
+	 * assume channels to be initially zeroed. Such channels are in an
+	 * initially valid state, but cannot be asynchronously reset, and must
+	 * maintain a valid state at all times.
+	 *
+	 * The transmitting end can enter the established state from the sync or
+	 * ack state when it observes the receiving endpoint in the ack or
+	 * established state, indicating that has cleared the counters in our
+	 * rx_channel.
+	 */
+	ivc_state_established = 0,
+
+	/*
+	 * If an endpoint is observed in the sync state, the remote endpoint is
+	 * allowed to clear the counters it owns asynchronously with respect to
+	 * the current endpoint. Therefore, the current endpoint is no longer
+	 * allowed to communicate.
+	 */
+	ivc_state_sync,
+
+	/*
+	 * When the transmitting end observes the receiving end in the sync
+	 * state, it can clear the w_count and r_count and transition to the ack
+	 * state. If the remote endpoint observes us in the ack state, it can
+	 * return to the established state once it has cleared its counters.
+	 */
+	ivc_state_ack
+};
+
+/*
+ * This structure is divided into two-cache aligned parts, the first is only
+ * written through the tx_channel pointer, while the second is only written
+ * through the rx_channel pointer. This delineates ownership of the cache lines,
+ * which is critical to performance and necessary in non-cache coherent
+ * implementations.
+ */
+struct ivc_channel_header {
+	union {
+		struct {
+			/* fields owned by the transmitting end */
+			uint32_t w_count;
+			uint32_t state;
+		};
+		uint8_t w_align[IVC_ALIGN];
+	};
+	union {
+		/* fields owned by the receiving end */
+		uint32_t r_count;
+		uint8_t r_align[IVC_ALIGN];
+	};
+};
+
+static inline void ivc_invalidate_counter(struct ivc *ivc,
+		dma_addr_t handle)
+{
+	if (!ivc->peer_device)
+		return;
+	dma_sync_single_for_cpu(ivc->peer_device, handle, IVC_ALIGN,
+			DMA_FROM_DEVICE);
+}
+
+static inline void ivc_flush_counter(struct ivc *ivc, dma_addr_t handle)
+{
+	if (!ivc->peer_device)
+		return;
+	dma_sync_single_for_device(ivc->peer_device, handle, IVC_ALIGN,
+			DMA_TO_DEVICE);
+}
+
+static inline int ivc_channel_empty(struct ivc *ivc,
+		struct ivc_channel_header *ch)
+{
+	/*
+	 * This function performs multiple checks on the same values with
+	 * security implications, so create snapshots with ACCESS_ONCE() to
+	 * ensure that these checks use the same values.
+	 */
+	uint32_t w_count = ACCESS_ONCE(ch->w_count);
+	uint32_t r_count = ACCESS_ONCE(ch->r_count);
+
+	/*
+	 * Perform an over-full check to prevent denial of service attacks where
+	 * a server could be easily fooled into believing that there's an
+	 * extremely large number of frames ready, since receivers are not
+	 * expected to check for full or over-full conditions.
+	 *
+	 * Although the channel isn't empty, this is an invalid case caused by
+	 * a potentially malicious peer, so returning empty is safer, because it
+	 * gives the impression that the channel has gone silent.
+	 */
+	if (w_count - r_count > ivc->nframes)
+		return 1;
+
+	return w_count == r_count;
+}
+
+static inline int ivc_channel_full(struct ivc *ivc,
+		struct ivc_channel_header *ch)
+{
+	/*
+	 * Invalid cases where the counters indicate that the queue is over
+	 * capacity also appear full.
+	 */
+	return ACCESS_ONCE(ch->w_count) - ACCESS_ONCE(ch->r_count)
+		>= ivc->nframes;
+}
+
+static inline uint32_t ivc_channel_avail_count(struct ivc *ivc,
+		struct ivc_channel_header *ch)
+{
+	/*
+	 * This function isn't expected to be used in scenarios where an
+	 * over-full situation can lead to denial of service attacks. See the
+	 * comment in ivc_channel_empty() for an explanation about special
+	 * over-full considerations.
+	 */
+	return ACCESS_ONCE(ch->w_count) - ACCESS_ONCE(ch->r_count);
+}
+
+static inline void ivc_advance_tx(struct ivc *ivc)
+{
+	ACCESS_ONCE(ivc->tx_channel->w_count) =
+		ACCESS_ONCE(ivc->tx_channel->w_count) + 1;
+
+	if (ivc->w_pos == ivc->nframes - 1)
+		ivc->w_pos = 0;
+	else
+		ivc->w_pos++;
+}
+
+static inline void ivc_advance_rx(struct ivc *ivc)
+{
+	ACCESS_ONCE(ivc->rx_channel->r_count) =
+		ACCESS_ONCE(ivc->rx_channel->r_count) + 1;
+
+	if (ivc->r_pos == ivc->nframes - 1)
+		ivc->r_pos = 0;
+	else
+		ivc->r_pos++;
+}
+
+static inline int ivc_check_read(struct ivc *ivc)
+{
+	/*
+	 * tx_channel->state is set locally, so it is not synchronized with
+	 * state from the remote peer. The remote peer cannot reset its
+	 * transmit counters until we've acknowledged its synchronization
+	 * request, so no additional synchronization is required because an
+	 * asynchronous transition of rx_channel->state to ivc_state_ack is not
+	 * allowed.
+	 */
+	if (ivc->tx_channel->state != ivc_state_established)
+		return -ECONNRESET;
+
+	/*
+	 * Avoid unnecessary invalidations when performing repeated accesses to
+	 * an IVC channel by checking the old queue pointers first.
+	 * Synchronization is only necessary when these pointers indicate empty
+	 * or full.
+	 */
+	if (!ivc_channel_empty(ivc, ivc->rx_channel))
+		return 0;
+
+	ivc_invalidate_counter(ivc, ivc->rx_handle +
+			offsetof(struct ivc_channel_header, w_count));
+	return ivc_channel_empty(ivc, ivc->rx_channel) ? -ENOMEM : 0;
+}
+
+static inline int ivc_check_write(struct ivc *ivc)
+{
+	if (ivc->tx_channel->state != ivc_state_established)
+		return -ECONNRESET;
+
+	if (!ivc_channel_full(ivc, ivc->tx_channel))
+		return 0;
+
+	ivc_invalidate_counter(ivc, ivc->tx_handle +
+			offsetof(struct ivc_channel_header, r_count));
+	return ivc_channel_full(ivc, ivc->tx_channel) ? -ENOMEM : 0;
+}
+
+static void *ivc_frame_pointer(struct ivc *ivc, struct ivc_channel_header *ch,
+		uint32_t frame)
+{
+	BUG_ON(frame >= ivc->nframes);
+	return (void *)((uintptr_t)(ch + 1) + ivc->frame_size * frame);
+}
+
+static inline dma_addr_t ivc_frame_handle(struct ivc *ivc,
+		dma_addr_t channel_handle, uint32_t frame)
+{
+	BUG_ON(!ivc->peer_device);
+	BUG_ON(frame >= ivc->nframes);
+	return channel_handle + sizeof(struct ivc_channel_header) +
+		ivc->frame_size * frame;
+}
+
+static inline void ivc_invalidate_frame(struct ivc *ivc,
+		dma_addr_t channel_handle, unsigned frame, int offset, int len)
+{
+	if (!ivc->peer_device)
+		return;
+	dma_sync_single_for_cpu(ivc->peer_device,
+			ivc_frame_handle(ivc, channel_handle, frame) + offset,
+			len, DMA_FROM_DEVICE);
+}
+
+static inline void ivc_flush_frame(struct ivc *ivc, dma_addr_t channel_handle,
+		unsigned frame, int offset, int len)
+{
+	if (!ivc->peer_device)
+		return;
+	dma_sync_single_for_device(ivc->peer_device,
+			ivc_frame_handle(ivc, channel_handle, frame) + offset,
+			len, DMA_TO_DEVICE);
+}
+
+/* directly peek at the next frame rx'ed */
+void *tegra_ivc_read_get_next_frame(struct ivc *ivc)
+{
+	int result = ivc_check_read(ivc);
+	if (result)
+		return ERR_PTR(result);
+
+	/*
+	 * Order observation of w_pos potentially indicating new data before
+	 * data read.
+	 */
+	ivc_rmb();
+
+	ivc_invalidate_frame(ivc, ivc->rx_handle, ivc->r_pos, 0,
+			ivc->frame_size);
+	return ivc_frame_pointer(ivc, ivc->rx_channel, ivc->r_pos);
+}
+EXPORT_SYMBOL(tegra_ivc_read_get_next_frame);
+
+int tegra_ivc_read_advance(struct ivc *ivc)
+{
+	/*
+	 * No read barriers or synchronization here: the caller is expected to
+	 * have already observed the channel non-empty. This check is just to
+	 * catch programming errors.
+	 */
+	int result = ivc_check_read(ivc);
+	if (result)
+		return result;
+
+	ivc_advance_rx(ivc);
+	ivc_flush_counter(ivc, ivc->rx_handle +
+			offsetof(struct ivc_channel_header, r_count));
+
+	/*
+	 * Ensure our write to r_pos occurs before our read from w_pos.
+	 */
+	ivc_mb();
+
+	/*
+	 * Notify only upon transition from full to non-full.
+	 * The available count can only asynchronously increase, so the
+	 * worst possible side-effect will be a spurious notification.
+	 */
+	ivc_invalidate_counter(ivc, ivc->rx_handle +
+		offsetof(struct ivc_channel_header, w_count));
+
+	if (ivc_channel_avail_count(ivc, ivc->rx_channel) == ivc->nframes - 1)
+		ivc->notify(ivc);
+
+	return 0;
+}
+EXPORT_SYMBOL(tegra_ivc_read_advance);
+
+/* directly poke at the next frame to be tx'ed */
+void *tegra_ivc_write_get_next_frame(struct ivc *ivc)
+{
+	int result = ivc_check_write(ivc);
+	if (result)
+		return ERR_PTR(result);
+
+	return ivc_frame_pointer(ivc, ivc->tx_channel, ivc->w_pos);
+}
+EXPORT_SYMBOL(tegra_ivc_write_get_next_frame);
+
+/* advance the tx buffer */
+int tegra_ivc_write_advance(struct ivc *ivc)
+{
+	int result = ivc_check_write(ivc);
+	if (result)
+		return result;
+
+	ivc_flush_frame(ivc, ivc->tx_handle, ivc->w_pos, 0, ivc->frame_size);
+
+	/*
+	 * Order any possible stores to the frame before update of w_pos.
+	 */
+	ivc_wmb();
+
+	ivc_advance_tx(ivc);
+	ivc_flush_counter(ivc, ivc->tx_handle +
+			offsetof(struct ivc_channel_header, w_count));
+
+	/*
+	 * Ensure our write to w_pos occurs before our read from r_pos.
+	 */
+	ivc_mb();
+
+	/*
+	 * Notify only upon transition from empty to non-empty.
+	 * The available count can only asynchronously decrease, so the
+	 * worst possible side-effect will be a spurious notification.
+	 */
+	ivc_invalidate_counter(ivc, ivc->tx_handle +
+		offsetof(struct ivc_channel_header, r_count));
+
+	if (ivc_channel_avail_count(ivc, ivc->tx_channel) == 1)
+		ivc->notify(ivc);
+
+	return 0;
+}
+EXPORT_SYMBOL(tegra_ivc_write_advance);
+
+void tegra_ivc_channel_reset(struct ivc *ivc)
+{
+	ivc->tx_channel->state = ivc_state_sync;
+	ivc_flush_counter(ivc, ivc->tx_handle +
+			offsetof(struct ivc_channel_header, w_count));
+	ivc->notify(ivc);
+}
+EXPORT_SYMBOL(tegra_ivc_channel_reset);
+
+/*
+ * ===============================================================
+ *  IVC State Transition Table - see tegra_ivc_channel_notified()
+ * ===============================================================
+ *
+ *	local	remote	action
+ *	-----	------	-----------------------------------
+ *	SYNC	EST	<none>
+ *	SYNC	ACK	reset counters; move to EST; notify
+ *	SYNC	SYNC	reset counters; move to ACK; notify
+ *	ACK	EST	move to EST; notify
+ *	ACK	ACK	move to EST; notify
+ *	ACK	SYNC	reset counters; move to ACK; notify
+ *	EST	EST	<none>
+ *	EST	ACK	<none>
+ *	EST	SYNC	reset counters; move to ACK; notify
+ *
+ * ===============================================================
+ */
+
+int tegra_ivc_channel_notified(struct ivc *ivc)
+{
+	enum ivc_state peer_state;
+
+	/* Copy the receiver's state out of shared memory. */
+	ivc_invalidate_counter(ivc, ivc->rx_handle +
+			offsetof(struct ivc_channel_header, w_count));
+	peer_state = ACCESS_ONCE(ivc->rx_channel->state);
+
+	if (peer_state == ivc_state_sync) {
+		/*
+		 * Order observation of ivc_state_sync before stores clearing
+		 * tx_channel.
+		 */
+		ivc_rmb();
+
+		/*
+		 * Reset tx_channel counters. The remote end is in the SYNC
+		 * state and won't make progress until we change our state,
+		 * so the counters are not in use at this time.
+		 */
+		ivc->tx_channel->w_count = 0;
+		ivc->rx_channel->r_count = 0;
+
+		ivc->w_pos = 0;
+		ivc->r_pos = 0;
+
+		/*
+		 * Ensure that counters appear cleared before new state can be
+		 * observed.
+		 */
+		ivc_wmb();
+
+		/*
+		 * Move to ACK state. We have just cleared our counters, so it
+		 * is now safe for the remote end to start using these values.
+		 */
+		ivc->tx_channel->state = ivc_state_ack;
+		ivc_flush_counter(ivc, ivc->tx_handle +
+				offsetof(struct ivc_channel_header, w_count));
+
+		/*
+		 * Notify remote end to observe state transition.
+		 */
+		ivc->notify(ivc);
+
+	} else if (ivc->tx_channel->state == ivc_state_sync &&
+			peer_state == ivc_state_ack) {
+		/*
+		 * Order observation of ivc_state_sync before stores clearing
+		 * tx_channel.
+		 */
+		ivc_rmb();
+
+		/*
+		 * Reset tx_channel counters. The remote end is in the ACK
+		 * state and won't make progress until we change our state,
+		 * so the counters are not in use at this time.
+		 */
+		ivc->tx_channel->w_count = 0;
+		ivc->rx_channel->r_count = 0;
+
+		ivc->w_pos = 0;
+		ivc->r_pos = 0;
+
+		/*
+		 * Ensure that counters appear cleared before new state can be
+		 * observed.
+		 */
+		ivc_wmb();
+
+		/*
+		 * Move to ESTABLISHED state. We know that the remote end has
+		 * already cleared its counters, so it is safe to start
+		 * writing/reading on this channel.
+		 */
+		ivc->tx_channel->state = ivc_state_established;
+		ivc_flush_counter(ivc, ivc->tx_handle +
+				offsetof(struct ivc_channel_header, w_count));
+
+		/*
+		 * Notify remote end to observe state transition.
+		 */
+		ivc->notify(ivc);
+
+	} else if (ivc->tx_channel->state == ivc_state_ack) {
+		/*
+		 * At this point, we have observed the peer to be in either
+		 * the ACK or ESTABLISHED state. Next, order observation of
+		 * peer state before storing to tx_channel.
+		 */
+		ivc_rmb();
+
+		/*
+		 * Move to ESTABLISHED state. We know that we have previously
+		 * cleared our counters, and we know that the remote end has
+		 * cleared its counters, so it is safe to start writing/reading
+		 * on this channel.
+		 */
+		ivc->tx_channel->state = ivc_state_established;
+		ivc_flush_counter(ivc, ivc->tx_handle +
+				offsetof(struct ivc_channel_header, w_count));
+
+		/*
+		 * Notify remote end to observe state transition.
+		 */
+		ivc->notify(ivc);
+
+	} else {
+		/*
+		 * There is no need to handle any further action. Either the
+		 * channel is already fully established, or we are waiting for
+		 * the remote end to catch up with our current state. Refer
+		 * to the diagram in "IVC State Transition Table" above.
+		 */
+	}
+
+	return ivc->tx_channel->state == ivc_state_established ? 0 : -EAGAIN;
+}
+EXPORT_SYMBOL(tegra_ivc_channel_notified);
+
+size_t tegra_ivc_align(size_t size)
+{
+	return (size + (IVC_ALIGN - 1)) & ~(IVC_ALIGN - 1);
+}
+EXPORT_SYMBOL(tegra_ivc_align);
+
+unsigned tegra_ivc_total_queue_size(unsigned queue_size)
+{
+	if (queue_size & (IVC_ALIGN - 1)) {
+		pr_err("%s: queue_size (%u) must be %u-byte aligned\n",
+				__func__, queue_size, IVC_ALIGN);
+		return 0;
+	}
+	return queue_size + sizeof(struct ivc_channel_header);
+}
+EXPORT_SYMBOL(tegra_ivc_total_queue_size);
+
+static int check_ivc_params(uintptr_t queue_base1, uintptr_t queue_base2,
+		unsigned nframes, unsigned frame_size)
+{
+	BUG_ON(offsetof(struct ivc_channel_header, w_count) & (IVC_ALIGN - 1));
+	BUG_ON(offsetof(struct ivc_channel_header, r_count) & (IVC_ALIGN - 1));
+	BUG_ON(sizeof(struct ivc_channel_header) & (IVC_ALIGN - 1));
+
+	if ((uint64_t)nframes * (uint64_t)frame_size >= 0x100000000) {
+		pr_err("nframes * frame_size overflows\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * The headers must at least be aligned enough for counters
+	 * to be accessed atomically.
+	 */
+	if (queue_base1 & (IVC_ALIGN - 1)) {
+		pr_err("ivc channel start not aligned: %lx\n", queue_base1);
+		return -EINVAL;
+	}
+	if (queue_base2 & (IVC_ALIGN - 1)) {
+		pr_err("ivc channel start not aligned: %lx\n", queue_base2);
+		return -EINVAL;
+	}
+
+	if (frame_size & (IVC_ALIGN - 1)) {
+		pr_err("frame size not adequately aligned: %u\n", frame_size);
+		return -EINVAL;
+	}
+
+	if (queue_base1 < queue_base2) {
+		if (queue_base1 + frame_size * nframes > queue_base2) {
+			pr_err("queue regions overlap: %lx + %x, %x\n",
+					queue_base1, frame_size,
+					frame_size * nframes);
+			return -EINVAL;
+		}
+	} else {
+		if (queue_base2 + frame_size * nframes > queue_base1) {
+			pr_err("queue regions overlap: %lx + %x, %x\n",
+					queue_base2, frame_size,
+					frame_size * nframes);
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+int tegra_ivc_init(struct ivc *ivc, uintptr_t rx_base, dma_addr_t rx_handle,
+		   uintptr_t tx_base, dma_addr_t tx_handle, unsigned nframes,
+		   unsigned frame_size, struct device *peer_device,
+		   void (*notify)(struct ivc *))
+{
+	size_t queue_size;
+
+	int result = check_ivc_params(rx_base, tx_base, nframes, frame_size);
+	if (result)
+		return result;
+
+	BUG_ON(!ivc);
+	BUG_ON(!notify);
+
+	queue_size = tegra_ivc_total_queue_size(nframes * frame_size);
+
+	/*
+	 * All sizes that can be returned by communication functions should
+	 * fit in an int.
+	 */
+	if (frame_size > INT_MAX)
+		return -E2BIG;
+
+	ivc->rx_channel = (struct ivc_channel_header *)rx_base;
+	ivc->tx_channel = (struct ivc_channel_header *)tx_base;
+
+	if (peer_device) {
+		if (rx_handle != DMA_ERROR_CODE) {
+			ivc->rx_handle = rx_handle;
+			ivc->tx_handle = tx_handle;
+		} else {
+			ivc->rx_handle = dma_map_single(peer_device,
+				ivc->rx_channel, queue_size, DMA_BIDIRECTIONAL);
+			if (ivc->rx_handle == DMA_ERROR_CODE)
+				return -ENOMEM;
+
+			ivc->tx_handle = dma_map_single(peer_device,
+				ivc->tx_channel, queue_size, DMA_BIDIRECTIONAL);
+			if (ivc->tx_handle == DMA_ERROR_CODE) {
+				dma_unmap_single(peer_device, ivc->rx_handle,
+					queue_size, DMA_BIDIRECTIONAL);
+				return -ENOMEM;
+			}
+		}
+	}
+
+	ivc->notify = notify;
+	ivc->frame_size = frame_size;
+	ivc->nframes = nframes;
+	ivc->peer_device = peer_device;
+
+	/*
+	 * These values aren't necessarily correct until the channel has been
+	 * reset.
+	 */
+	ivc->w_pos = 0;
+	ivc->r_pos = 0;
+
+	return 0;
+}
+EXPORT_SYMBOL(tegra_ivc_init);
diff --git a/include/soc/tegra/ivc.h b/include/soc/tegra/ivc.h
new file mode 100644
index 000000000000..1762fbee3fa2
--- /dev/null
+++ b/include/soc/tegra/ivc.h
@@ -0,0 +1,102 @@
+/*
+ * Copyright (c) 2016, NVIDIA CORPORATION.  All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ */
+
+#ifndef __TEGRA_IVC_H
+
+#include <linux/device.h>
+#include <linux/dma-mapping.h>
+#include <linux/types.h>
+
+struct ivc_channel_header;
+
+struct ivc {
+	struct ivc_channel_header *rx_channel, *tx_channel;
+	uint32_t w_pos, r_pos;
+
+	void (*notify)(struct ivc *);
+	uint32_t nframes, frame_size;
+
+	struct device *peer_device;
+	dma_addr_t rx_handle, tx_handle;
+};
+
+/**
+ * tegra_ivc_read_get_next_frame - Peek at the next frame to receive
+ * @ivc		pointer of the IVC channel
+ *
+ * Peek at the next frame to be received, without removing it from
+ * the queue.
+ *
+ * Returns a pointer to the frame, or an error encoded pointer.
+ */
+void *tegra_ivc_read_get_next_frame(struct ivc *ivc);
+
+/**
+ * tegra_ivc_read_advance - Advance the read queue
+ * @ivc		pointer of the IVC channel
+ *
+ * Advance the read queue
+ *
+ * Returns 0, or a negative error value if failed.
+ */
+int tegra_ivc_read_advance(struct ivc *ivc);
+
+/**
+ * tegra_ivc_write_get_next_frame - Poke at the next frame to transmit
+ * @ivc		pointer of the IVC channel
+ *
+ * Get access to the next frame.
+ *
+ * Returns a pointer to the frame, or an error encoded pointer.
+ */
+void *tegra_ivc_write_get_next_frame(struct ivc *ivc);
+
+/**
+ * tegra_ivc_write_advance - Advance the write queue
+ * @ivc		pointer of the IVC channel
+ *
+ * Advance the write queue
+ *
+ * Returns 0, or a negative error value if failed.
+ */
+int tegra_ivc_write_advance(struct ivc *ivc);
+
+/**
+ * tegra_ivc_channel_notified - handle internal messages
+ * @ivc		pointer of the IVC channel
+ *
+ * This function must be called following every notification.
+ *
+ * Returns 0 if the channel is ready for communication, or -EAGAIN if a channel
+ * reset is in progress.
+ */
+int tegra_ivc_channel_notified(struct ivc *ivc);
+
+/**
+ * tegra_ivc_channel_reset - initiates a reset of the shared memory state
+ * @ivc		pointer of the IVC channel
+ *
+ * This function must be called after a channel is reserved before it is used
+ * for communication. The channel will be ready for use when a subsequent call
+ * to notify the remote of the channel reset.
+ */
+void tegra_ivc_channel_reset(struct ivc *ivc);
+
+size_t tegra_ivc_align(size_t size);
+unsigned tegra_ivc_total_queue_size(unsigned queue_size);
+int tegra_ivc_init(struct ivc *ivc, uintptr_t rx_base, dma_addr_t rx_handle,
+		   uintptr_t tx_base, dma_addr_t tx_handle, unsigned nframes,
+		   unsigned frame_size, struct device *peer_device,
+		   void (*notify)(struct ivc *));
+
+#endif /* __TEGRA_IVC_H */
-- 
2.9.0
