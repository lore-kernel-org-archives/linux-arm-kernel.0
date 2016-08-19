From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 19 Aug 2016 19:32:25 +0200
Subject: [PATCH v3 04/12] firmware: tegra: Add IVC library
In-Reply-To: <20160819173233.13260-1-thierry.reding@gmail.com>
References: <20160819173233.13260-1-thierry.reding@gmail.com>
Message-ID: <20160819173233.13260-5-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

The Inter-VM communication (IVC) is a communication protocol which is
designed for interprocessor communication (IPC) or the communication
between the hypervisor and the virtual machine with a guest OS.

Message channels are used to communicate between processors. They are
backed by DRAM or SRAM, so care must be taken to maintain coherence of
data.

The IVC library maintains memory-based descriptors for the transmission
and reception channels as well as the data coherence of the counter and
payload. Clients, such as the driver for the BPMP firmware, can use the
library to exchange messages with remote processors.

Based on work by Peter Newman <pnewman@nvidia.com> and Joseph Lo
<josephl@nvidia.com>.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Changes in v3:
- use a more object oriented design

 drivers/firmware/Kconfig        |   1 +
 drivers/firmware/Makefile       |   1 +
 drivers/firmware/tegra/Kconfig  |  13 +
 drivers/firmware/tegra/Makefile |   1 +
 drivers/firmware/tegra/ivc.c    | 683 ++++++++++++++++++++++++++++++++++++++++
 include/soc/tegra/ivc.h         | 109 +++++++
 6 files changed, 808 insertions(+)
 create mode 100644 drivers/firmware/tegra/Kconfig
 create mode 100644 drivers/firmware/tegra/Makefile
 create mode 100644 drivers/firmware/tegra/ivc.c
 create mode 100644 include/soc/tegra/ivc.h

diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index 0e22f241403b..e8339c86f52a 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -209,5 +209,6 @@ config HAVE_ARM_SMCCC
 source "drivers/firmware/broadcom/Kconfig"
 source "drivers/firmware/google/Kconfig"
 source "drivers/firmware/efi/Kconfig"
+source "drivers/firmware/tegra/Kconfig"
 
 endmenu
diff --git a/drivers/firmware/Makefile b/drivers/firmware/Makefile
index 44a59dcfc398..78a06d5513ff 100644
--- a/drivers/firmware/Makefile
+++ b/drivers/firmware/Makefile
@@ -25,3 +25,4 @@ obj-y				+= broadcom/
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
index 000000000000..aab92bf8d0e1
--- /dev/null
+++ b/drivers/firmware/tegra/ivc.c
@@ -0,0 +1,683 @@
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
+#define TEGRA_IVC_ALIGN 64
+
+/*
+ * IVC channel reset protocol.
+ *
+ * Each end uses its tx_channel.state to indicate its synchronization state.
+ */
+enum tegra_ivc_state {
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
+	TEGRA_IVC_STATE_ESTABLISHED = 0,
+
+	/*
+	 * If an endpoint is observed in the sync state, the remote endpoint is
+	 * allowed to clear the counters it owns asynchronously with respect to
+	 * the current endpoint. Therefore, the current endpoint is no longer
+	 * allowed to communicate.
+	 */
+	TEGRA_IVC_STATE_SYNC,
+
+	/*
+	 * When the transmitting end observes the receiving end in the sync
+	 * state, it can clear the w_count and r_count and transition to the ack
+	 * state. If the remote endpoint observes us in the ack state, it can
+	 * return to the established state once it has cleared its counters.
+	 */
+	TEGRA_IVC_STATE_ACK
+};
+
+/*
+ * This structure is divided into two-cache aligned parts, the first is only
+ * written through the tx.channel pointer, while the second is only written
+ * through the rx.channel pointer. This delineates ownership of the cache
+ * lines, which is critical to performance and necessary in non-cache coherent
+ * implementations.
+ */
+struct tegra_ivc_header {
+	union {
+		struct {
+			/* fields owned by the transmitting end */
+			u32 count;
+			u32 state;
+		};
+
+		u8 pad[TEGRA_IVC_ALIGN];
+	} tx;
+
+	union {
+		/* fields owned by the receiving end */
+		u32 count;
+		u8 pad[TEGRA_IVC_ALIGN];
+	} rx;
+};
+
+static inline void tegra_ivc_invalidate(struct tegra_ivc *ivc, dma_addr_t phys)
+{
+	if (!ivc->peer)
+		return;
+
+	dma_sync_single_for_cpu(ivc->peer, phys, TEGRA_IVC_ALIGN,
+				DMA_FROM_DEVICE);
+}
+
+static inline void tegra_ivc_flush(struct tegra_ivc *ivc, dma_addr_t phys)
+{
+	if (!ivc->peer)
+		return;
+
+	dma_sync_single_for_device(ivc->peer, phys, TEGRA_IVC_ALIGN,
+				   DMA_TO_DEVICE);
+}
+
+static inline bool tegra_ivc_empty(struct tegra_ivc *ivc,
+				   struct tegra_ivc_header *header)
+{
+	/*
+	 * This function performs multiple checks on the same values with
+	 * security implications, so create snapshots with ACCESS_ONCE() to
+	 * ensure that these checks use the same values.
+	 */
+	u32 tx = ACCESS_ONCE(header->tx.count);
+	u32 rx = ACCESS_ONCE(header->rx.count);
+
+	/*
+	 * Perform an over-full check to prevent denial of service attacks
+	 * where a server could be easily fooled into believing that there's
+	 * an extremely large number of frames ready, since receivers are not
+	 * expected to check for full or over-full conditions.
+	 *
+	 * Although the channel isn't empty, this is an invalid case caused by
+	 * a potentially malicious peer, so returning empty is safer, because
+	 * it gives the impression that the channel has gone silent.
+	 */
+	if (tx - rx > ivc->num_frames)
+		return true;
+
+	return tx == rx;
+}
+
+static inline bool tegra_ivc_full(struct tegra_ivc *ivc,
+				  struct tegra_ivc_header *header)
+{
+	u32 tx = ACCESS_ONCE(header->tx.count);
+	u32 rx = ACCESS_ONCE(header->rx.count);
+
+	/*
+	 * Invalid cases where the counters indicate that the queue is over
+	 * capacity also appear full.
+	 */
+	return tx - rx >= ivc->num_frames;
+}
+
+static inline u32 tegra_ivc_available(struct tegra_ivc *ivc,
+				      struct tegra_ivc_header *header)
+{
+	u32 tx = ACCESS_ONCE(header->tx.count);
+	u32 rx = ACCESS_ONCE(header->rx.count);
+
+	/*
+	 * This function isn't expected to be used in scenarios where an
+	 * over-full situation can lead to denial of service attacks. See the
+	 * comment in tegra_ivc_empty() for an explanation about special
+	 * over-full considerations.
+	 */
+	return tx - rx;
+}
+
+static inline void tegra_ivc_advance_tx(struct tegra_ivc *ivc)
+{
+	ACCESS_ONCE(ivc->tx.channel->tx.count) =
+		ACCESS_ONCE(ivc->tx.channel->tx.count) + 1;
+
+	if (ivc->tx.position == ivc->num_frames - 1)
+		ivc->tx.position = 0;
+	else
+		ivc->tx.position++;
+}
+
+static inline void tegra_ivc_advance_rx(struct tegra_ivc *ivc)
+{
+	ACCESS_ONCE(ivc->rx.channel->rx.count) =
+		ACCESS_ONCE(ivc->rx.channel->rx.count) + 1;
+
+	if (ivc->rx.position == ivc->num_frames - 1)
+		ivc->rx.position = 0;
+	else
+		ivc->rx.position++;
+}
+
+static inline int tegra_ivc_check_read(struct tegra_ivc *ivc)
+{
+	unsigned int offset = offsetof(struct tegra_ivc_header, tx.count);
+
+	/*
+	 * tx.channel->state is set locally, so it is not synchronized with
+	 * state from the remote peer. The remote peer cannot reset its
+	 * transmit counters until we've acknowledged its synchronization
+	 * request, so no additional synchronization is required because an
+	 * asynchronous transition of rx.channel->state to
+	 * TEGRA_IVC_STATE_ACK is not allowed.
+	 */
+	if (ivc->tx.channel->tx.state != TEGRA_IVC_STATE_ESTABLISHED)
+		return -ECONNRESET;
+
+	/*
+	 * Avoid unnecessary invalidations when performing repeated accesses
+	 * to an IVC channel by checking the old queue pointers first.
+	 *
+	 * Synchronization is only necessary when these pointers indicate
+	 * empty or full.
+	 */
+	if (!tegra_ivc_empty(ivc, ivc->rx.channel))
+		return 0;
+
+	tegra_ivc_invalidate(ivc, ivc->rx.phys + offset);
+
+	if (tegra_ivc_empty(ivc, ivc->rx.channel))
+		return -ENOSPC;
+
+	return 0;
+}
+
+static inline int tegra_ivc_check_write(struct tegra_ivc *ivc)
+{
+	unsigned int offset = offsetof(struct tegra_ivc_header, rx.count);
+
+	if (ivc->tx.channel->tx.state != TEGRA_IVC_STATE_ESTABLISHED)
+		return -ECONNRESET;
+
+	if (!tegra_ivc_full(ivc, ivc->tx.channel))
+		return 0;
+
+	tegra_ivc_invalidate(ivc, ivc->tx.phys + offset);
+
+	if (tegra_ivc_full(ivc, ivc->tx.channel))
+		return -ENOSPC;
+
+	return 0;
+}
+
+static void *tegra_ivc_frame_virt(struct tegra_ivc *ivc,
+				  struct tegra_ivc_header *header,
+				  unsigned int frame)
+{
+	BUG_ON(frame >= ivc->num_frames);
+
+	return (void *)(header + 1) + ivc->frame_size * frame;
+}
+
+static inline dma_addr_t tegra_ivc_frame_phys(struct tegra_ivc *ivc,
+					      dma_addr_t phys,
+					      unsigned int frame)
+{
+	unsigned long offset;
+
+	BUG_ON(!ivc->peer);
+	BUG_ON(frame >= ivc->num_frames);
+
+	offset = sizeof(struct tegra_ivc_header) + ivc->frame_size * frame;
+
+	return phys + offset;
+}
+
+static inline void tegra_ivc_invalidate_frame(struct tegra_ivc *ivc,
+					      dma_addr_t phys,
+					      unsigned int frame,
+					      unsigned int offset,
+					      size_t size)
+{
+	if (!ivc->peer)
+		return;
+
+	phys = tegra_ivc_frame_phys(ivc, phys, frame) + offset;
+
+	dma_sync_single_for_cpu(ivc->peer, phys, size, DMA_FROM_DEVICE);
+}
+
+static inline void tegra_ivc_flush_frame(struct tegra_ivc *ivc,
+					 dma_addr_t phys,
+					 unsigned int frame,
+					 unsigned int offset,
+					 size_t size)
+{
+	if (!ivc->peer)
+		return;
+
+	phys = tegra_ivc_frame_phys(ivc, phys, frame) + offset;
+
+	dma_sync_single_for_device(ivc->peer, phys, size, DMA_TO_DEVICE);
+}
+
+/* directly peek at the next frame rx'ed */
+void *tegra_ivc_read_get_next_frame(struct tegra_ivc *ivc)
+{
+	int err;
+
+	err = tegra_ivc_check_read(ivc);
+	if (err)
+		return ERR_PTR(err);
+
+	/*
+	 * Order observation of w_pos potentially indicating new data before
+	 * data read.
+	 */
+	smp_rmb();
+
+	tegra_ivc_invalidate_frame(ivc, ivc->rx.phys, ivc->rx.position, 0,
+				   ivc->frame_size);
+
+	return tegra_ivc_frame_virt(ivc, ivc->rx.channel, ivc->rx.position);
+}
+EXPORT_SYMBOL(tegra_ivc_read_get_next_frame);
+
+int tegra_ivc_read_advance(struct tegra_ivc *ivc)
+{
+	unsigned int rx = offsetof(struct tegra_ivc_header, rx.count);
+	unsigned int tx = offsetof(struct tegra_ivc_header, tx.count);
+	int err;
+
+	/*
+	 * No read barriers or synchronization here: the caller is expected to
+	 * have already observed the channel non-empty. This check is just to
+	 * catch programming errors.
+	 */
+	err = tegra_ivc_check_read(ivc);
+	if (err)
+		return err;
+
+	tegra_ivc_advance_rx(ivc);
+
+	tegra_ivc_flush(ivc, ivc->rx.phys + rx);
+
+	/*
+	 * Ensure our write to r_pos occurs before our read from w_pos.
+	 */
+	smp_mb();
+
+	/*
+	 * Notify only upon transition from full to non-full.
+	 * The available count can only asynchronously increase, so the
+	 * worst possible side-effect will be a spurious notification.
+	 */
+	tegra_ivc_invalidate(ivc, ivc->rx.phys + tx);
+
+	if (tegra_ivc_available(ivc, ivc->rx.channel) == ivc->num_frames - 1)
+		ivc->notify(ivc, ivc->notify_data);
+
+	return 0;
+}
+EXPORT_SYMBOL(tegra_ivc_read_advance);
+
+/* directly poke at the next frame to be tx'ed */
+void *tegra_ivc_write_get_next_frame(struct tegra_ivc *ivc)
+{
+	int err;
+
+	err = tegra_ivc_check_write(ivc);
+	if (err)
+		return ERR_PTR(err);
+
+	return tegra_ivc_frame_virt(ivc, ivc->tx.channel, ivc->tx.position);
+}
+EXPORT_SYMBOL(tegra_ivc_write_get_next_frame);
+
+/* advance the tx buffer */
+int tegra_ivc_write_advance(struct tegra_ivc *ivc)
+{
+	unsigned int tx = offsetof(struct tegra_ivc_header, tx.count);
+	unsigned int rx = offsetof(struct tegra_ivc_header, rx.count);
+	int err;
+
+	err = tegra_ivc_check_write(ivc);
+	if (err)
+		return err;
+
+	tegra_ivc_flush_frame(ivc, ivc->tx.phys, ivc->tx.position, 0,
+			      ivc->frame_size);
+
+	/*
+	 * Order any possible stores to the frame before update of w_pos.
+	 */
+	smp_wmb();
+
+	tegra_ivc_advance_tx(ivc);
+	tegra_ivc_flush(ivc, ivc->tx.phys + tx);
+
+	/*
+	 * Ensure our write to w_pos occurs before our read from r_pos.
+	 */
+	smp_mb();
+
+	/*
+	 * Notify only upon transition from empty to non-empty.
+	 * The available count can only asynchronously decrease, so the
+	 * worst possible side-effect will be a spurious notification.
+	 */
+	tegra_ivc_invalidate(ivc, ivc->tx.phys + rx);
+
+	if (tegra_ivc_available(ivc, ivc->tx.channel) == 1)
+		ivc->notify(ivc, ivc->notify_data);
+
+	return 0;
+}
+EXPORT_SYMBOL(tegra_ivc_write_advance);
+
+void tegra_ivc_reset(struct tegra_ivc *ivc)
+{
+	unsigned int offset = offsetof(struct tegra_ivc_header, tx.count);
+
+	ivc->tx.channel->tx.state = TEGRA_IVC_STATE_SYNC;
+	tegra_ivc_flush(ivc, ivc->tx.phys + offset);
+	ivc->notify(ivc, ivc->notify_data);
+}
+EXPORT_SYMBOL(tegra_ivc_reset);
+
+/*
+ * =======================================================
+ *  IVC State Transition Table - see tegra_ivc_notified()
+ * =======================================================
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
+int tegra_ivc_notified(struct tegra_ivc *ivc)
+{
+	unsigned int offset = offsetof(struct tegra_ivc_header, tx.count);
+	enum tegra_ivc_state state;
+
+	/* Copy the receiver's state out of shared memory. */
+	tegra_ivc_invalidate(ivc, ivc->rx.phys + offset);
+	state = ACCESS_ONCE(ivc->rx.channel->tx.state);
+
+	if (state == TEGRA_IVC_STATE_SYNC) {
+		offset =  offsetof(struct tegra_ivc_header, tx.count);
+
+		/*
+		 * Order observation of TEGRA_IVC_STATE_SYNC before stores
+		 * clearing tx.channel.
+		 */
+		smp_rmb();
+
+		/*
+		 * Reset tx.channel counters. The remote end is in the SYNC
+		 * state and won't make progress until we change our state,
+		 * so the counters are not in use at this time.
+		 */
+		ivc->tx.channel->tx.count = 0;
+		ivc->rx.channel->rx.count = 0;
+
+		ivc->tx.position = 0;
+		ivc->rx.position = 0;
+
+		/*
+		 * Ensure that counters appear cleared before new state can be
+		 * observed.
+		 */
+		smp_wmb();
+
+		/*
+		 * Move to ACK state. We have just cleared our counters, so it
+		 * is now safe for the remote end to start using these values.
+		 */
+		ivc->tx.channel->tx.state = TEGRA_IVC_STATE_ACK;
+		tegra_ivc_flush(ivc, ivc->tx.phys + offset);
+
+		/*
+		 * Notify remote end to observe state transition.
+		 */
+		ivc->notify(ivc, ivc->notify_data);
+
+	} else if (ivc->tx.channel->tx.state == TEGRA_IVC_STATE_SYNC &&
+		   state == TEGRA_IVC_STATE_ACK) {
+		offset = offsetof(struct tegra_ivc_header, tx.count);
+
+		/*
+		 * Order observation of ivc_state_sync before stores clearing
+		 * tx_channel.
+		 */
+		smp_rmb();
+
+		/*
+		 * Reset tx.channel counters. The remote end is in the ACK
+		 * state and won't make progress until we change our state,
+		 * so the counters are not in use at this time.
+		 */
+		ivc->tx.channel->tx.count = 0;
+		ivc->rx.channel->rx.count = 0;
+
+		ivc->tx.position = 0;
+		ivc->rx.position = 0;
+
+		/*
+		 * Ensure that counters appear cleared before new state can be
+		 * observed.
+		 */
+		smp_wmb();
+
+		/*
+		 * Move to ESTABLISHED state. We know that the remote end has
+		 * already cleared its counters, so it is safe to start
+		 * writing/reading on this channel.
+		 */
+		ivc->tx.channel->tx.state = TEGRA_IVC_STATE_ESTABLISHED;
+		tegra_ivc_flush(ivc, ivc->tx.phys + offset);
+
+		/*
+		 * Notify remote end to observe state transition.
+		 */
+		ivc->notify(ivc, ivc->notify_data);
+
+	} else if (ivc->tx.channel->tx.state == TEGRA_IVC_STATE_ACK) {
+		offset = offsetof(struct tegra_ivc_header, tx.count);
+
+		/*
+		 * At this point, we have observed the peer to be in either
+		 * the ACK or ESTABLISHED state. Next, order observation of
+		 * peer state before storing to tx.channel.
+		 */
+		smp_rmb();
+
+		/*
+		 * Move to ESTABLISHED state. We know that we have previously
+		 * cleared our counters, and we know that the remote end has
+		 * cleared its counters, so it is safe to start writing/reading
+		 * on this channel.
+		 */
+		ivc->tx.channel->tx.state = TEGRA_IVC_STATE_ESTABLISHED;
+		tegra_ivc_flush(ivc, ivc->tx.phys + offset);
+
+		/*
+		 * Notify remote end to observe state transition.
+		 */
+		ivc->notify(ivc, ivc->notify_data);
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
+	if (ivc->tx.channel->tx.state != TEGRA_IVC_STATE_ESTABLISHED)
+		return -EAGAIN;
+
+	return 0;
+}
+EXPORT_SYMBOL(tegra_ivc_notified);
+
+size_t tegra_ivc_align(size_t size)
+{
+	return (size + (TEGRA_IVC_ALIGN - 1)) & ~(TEGRA_IVC_ALIGN - 1);
+}
+EXPORT_SYMBOL(tegra_ivc_align);
+
+unsigned tegra_ivc_total_queue_size(unsigned queue_size)
+{
+	if (queue_size & (TEGRA_IVC_ALIGN - 1)) {
+		pr_err("%s: queue_size (%u) must be %u-byte aligned\n",
+		       __func__, queue_size, TEGRA_IVC_ALIGN);
+		return 0;
+	}
+
+	return queue_size + sizeof(struct tegra_ivc_header);
+}
+EXPORT_SYMBOL(tegra_ivc_total_queue_size);
+
+static int check_ivc_params(unsigned long base1, unsigned long base2,
+			    unsigned int num_frames, size_t frame_size)
+{
+	BUG_ON(offsetof(struct tegra_ivc_header, tx.count) & (TEGRA_IVC_ALIGN - 1));
+	BUG_ON(offsetof(struct tegra_ivc_header, rx.count) & (TEGRA_IVC_ALIGN - 1));
+	BUG_ON(sizeof(struct tegra_ivc_header) & (TEGRA_IVC_ALIGN - 1));
+
+	if ((uint64_t)num_frames * (uint64_t)frame_size >= 0x100000000) {
+		pr_err("num_frames * frame_size overflows\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * The headers must at least be aligned enough for counters
+	 * to be accessed atomically.
+	 */
+	if (base1 & (TEGRA_IVC_ALIGN - 1)) {
+		pr_err("IVC channel start not aligned: %lx\n", base1);
+		return -EINVAL;
+	}
+
+	if (base2 & (TEGRA_IVC_ALIGN - 1)) {
+		pr_err("IVC channel start not aligned: %lx\n", base2);
+		return -EINVAL;
+	}
+
+	if (frame_size & (TEGRA_IVC_ALIGN - 1)) {
+		pr_err("frame size not adequately aligned: %zu\n", frame_size);
+		return -EINVAL;
+	}
+
+	if (base1 < base2) {
+		if (base1 + frame_size * num_frames > base2) {
+			pr_err("queue regions overlap: %lx + %zx, %zx\n",
+			       base1, frame_size, frame_size * num_frames);
+			return -EINVAL;
+		}
+	} else {
+		if (base2 + frame_size * num_frames > base1) {
+			pr_err("queue regions overlap: %lx + %zx, %zx\n",
+			       base2, frame_size, frame_size * num_frames);
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+int tegra_ivc_init(struct tegra_ivc *ivc, struct device *peer,
+		   void __iomem *rx_virt, dma_addr_t rx_phys,
+		   void __iomem *tx_virt, dma_addr_t tx_phys,
+		   unsigned int num_frames, size_t frame_size,
+		   void (*notify)(struct tegra_ivc *ivc, void *data),
+		   void *data)
+{
+	size_t queue_size;
+	int err;
+
+	err = check_ivc_params((unsigned long)rx_virt, (unsigned long)tx_virt,
+			       num_frames, frame_size);
+	if (err < 0)
+		return err;
+
+	BUG_ON(!ivc);
+	BUG_ON(!notify);
+
+	queue_size = tegra_ivc_total_queue_size(num_frames * frame_size);
+
+	/*
+	 * All sizes that can be returned by communication functions should
+	 * fit in an int.
+	 */
+	if (frame_size > INT_MAX)
+		return -E2BIG;
+
+	ivc->rx.channel = (struct tegra_ivc_header *)rx_virt;
+	ivc->tx.channel = (struct tegra_ivc_header *)tx_virt;
+
+	if (peer) {
+		if (rx_phys != DMA_ERROR_CODE) {
+			ivc->rx.phys = rx_phys;
+			ivc->tx.phys = tx_phys;
+		} else {
+			ivc->rx.phys = dma_map_single(peer, ivc->rx.channel,
+						      queue_size,
+						      DMA_BIDIRECTIONAL);
+			if (ivc->rx.phys == DMA_ERROR_CODE)
+				return -ENOMEM;
+
+			ivc->tx.phys = dma_map_single(peer, ivc->tx.channel,
+						      queue_size,
+						      DMA_BIDIRECTIONAL);
+			if (ivc->tx.phys == DMA_ERROR_CODE) {
+				dma_unmap_single(peer, ivc->rx.phys,
+						 queue_size,
+						 DMA_BIDIRECTIONAL);
+				return -ENOMEM;
+			}
+		}
+	}
+
+	ivc->peer = peer;
+	ivc->notify = notify;
+	ivc->notify_data = data;
+	ivc->frame_size = frame_size;
+	ivc->num_frames = num_frames;
+
+	/*
+	 * These values aren't necessarily correct until the channel has been
+	 * reset.
+	 */
+	ivc->tx.position = 0;
+	ivc->rx.position = 0;
+
+	return 0;
+}
+EXPORT_SYMBOL(tegra_ivc_init);
diff --git a/include/soc/tegra/ivc.h b/include/soc/tegra/ivc.h
new file mode 100644
index 000000000000..af9a54a54e45
--- /dev/null
+++ b/include/soc/tegra/ivc.h
@@ -0,0 +1,109 @@
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
+struct tegra_ivc_header;
+
+struct tegra_ivc {
+	struct device *peer;
+
+	struct {
+		struct tegra_ivc_header *channel;
+		dma_addr_t phys;
+		u32 position;
+	} rx, tx;
+
+	void (*notify)(struct tegra_ivc *ivc, void *data);
+	void *notify_data;
+
+	unsigned int num_frames;
+	size_t frame_size;
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
+void *tegra_ivc_read_get_next_frame(struct tegra_ivc *ivc);
+
+/**
+ * tegra_ivc_read_advance - Advance the read queue
+ * @ivc		pointer of the IVC channel
+ *
+ * Advance the read queue
+ *
+ * Returns 0, or a negative error value if failed.
+ */
+int tegra_ivc_read_advance(struct tegra_ivc *ivc);
+
+/**
+ * tegra_ivc_write_get_next_frame - Poke at the next frame to transmit
+ * @ivc		pointer of the IVC channel
+ *
+ * Get access to the next frame.
+ *
+ * Returns a pointer to the frame, or an error encoded pointer.
+ */
+void *tegra_ivc_write_get_next_frame(struct tegra_ivc *ivc);
+
+/**
+ * tegra_ivc_write_advance - Advance the write queue
+ * @ivc		pointer of the IVC channel
+ *
+ * Advance the write queue
+ *
+ * Returns 0, or a negative error value if failed.
+ */
+int tegra_ivc_write_advance(struct tegra_ivc *ivc);
+
+/**
+ * tegra_ivc_notified - handle internal messages
+ * @ivc		pointer of the IVC channel
+ *
+ * This function must be called following every notification.
+ *
+ * Returns 0 if the channel is ready for communication, or -EAGAIN if a channel
+ * reset is in progress.
+ */
+int tegra_ivc_notified(struct tegra_ivc *ivc);
+
+/**
+ * tegra_ivc_reset - initiates a reset of the shared memory state
+ * @ivc		pointer of the IVC channel
+ *
+ * This function must be called after a channel is reserved before it is used
+ * for communication. The channel will be ready for use when a subsequent call
+ * to notify the remote of the channel reset.
+ */
+void tegra_ivc_reset(struct tegra_ivc *ivc);
+
+size_t tegra_ivc_align(size_t size);
+unsigned tegra_ivc_total_queue_size(unsigned queue_size);
+int tegra_ivc_init(struct tegra_ivc *ivc, struct device *peer,
+		   void __iomem *rx_virt, dma_addr_t rx_phys,
+		   void __iomem *tx_virt, dma_addr_t tx_phys,
+		   unsigned int num_frames, size_t frame_size,
+		   void (*notify)(struct tegra_ivc *ivc, void *data),
+		   void *data);
+
+#endif /* __TEGRA_IVC_H */
-- 
2.9.0
