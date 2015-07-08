From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Wed, 8 Jul 2015 17:41:06 +0800
Subject: [PATCH v2 4/5] xhci: mediatek: support MTK xHCI host controller
In-Reply-To: <1436348468-4126-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1436348468-4126-1-git-send-email-chunfeng.yun@mediatek.com>
Message-ID: <1436348468-4126-5-git-send-email-chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MTK xhci host controller defines some extra SW scheduling
parameters for HW to minimize the scheduling effort for
synchronous and interrupt endpoints. The parameters are
put into reseved DWs of slot context and endpoint context

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/host/Kconfig     |   9 +
 drivers/usb/host/Makefile    |   1 +
 drivers/usb/host/xhci-mtk.c  | 814 +++++++++++++++++++++++++++++++++++++++++++
 drivers/usb/host/xhci-mtk.h  | 108 ++++++
 drivers/usb/host/xhci-ring.c |  35 +-
 drivers/usb/host/xhci.c      |  19 +-
 drivers/usb/host/xhci.h      |   1 +
 7 files changed, 980 insertions(+), 7 deletions(-)
 create mode 100644 drivers/usb/host/xhci-mtk.c
 create mode 100644 drivers/usb/host/xhci-mtk.h

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 8afc3c1..2202c68 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -34,6 +34,15 @@ config USB_XHCI_PCI
 config USB_XHCI_PLATFORM
 	tristate
 
+config USB_XHCI_MTK
+	tristate "xHCI support for Mediatek MT65xx"
+	select USB_XHCI_PLATFORM
+	depends on ARCH_MEDIATEK || COMPILE_TEST
+	---help---
+	  Say 'Y' to enable the support for the xHCI host controller
+	  found in Mediatek MT65xx SoCs.
+	  If unsure, say N.
+
 config USB_XHCI_MVEBU
 	tristate "xHCI support for Marvell Armada 375/38x"
 	select USB_XHCI_PLATFORM
diff --git a/drivers/usb/host/Makefile b/drivers/usb/host/Makefile
index 754efaa..90c6eb2 100644
--- a/drivers/usb/host/Makefile
+++ b/drivers/usb/host/Makefile
@@ -30,6 +30,7 @@ endif
 
 obj-$(CONFIG_USB_XHCI_PCI)	+= xhci-pci.o
 obj-$(CONFIG_USB_XHCI_PLATFORM) += xhci-plat-hcd.o
+obj-$(CONFIG_USB_XHCI_MTK)	+= xhci-mtk.o
 
 obj-$(CONFIG_USB_EHCI_HCD)	+= ehci-hcd.o
 obj-$(CONFIG_USB_EHCI_PCI)	+= ehci-pci.o
diff --git a/drivers/usb/host/xhci-mtk.c b/drivers/usb/host/xhci-mtk.c
new file mode 100644
index 0000000..45f0606
--- /dev/null
+++ b/drivers/usb/host/xhci-mtk.c
@@ -0,0 +1,814 @@
+/*
+ * Copyright (c) 2015 MediaTek Inc.
+ * Author:
+ *  Zhigang.Wei <zhigang.wei@mediatek.com>
+ *  Chunfeng.Yun <chunfeng.yun@mediatek.com>
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
+#include <linux/kernel.h>
+#include <linux/clk.h>
+#include <linux/dma-mapping.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/usb/phy.h>
+#include <linux/slab.h>
+#include <linux/usb/xhci_pdriver.h>
+#include <linux/regulator/consumer.h>
+#include <linux/pm_runtime.h>
+
+#include "xhci.h"
+#include "xhci-mtk.h"
+
+
+#define SS_BW_BOUNDARY	51000
+/* table 5-5. High-speed Isoc Transaction Limits in usb_20 spec */
+#define HS_BW_BOUNDARY	6144
+/* usb2 spec section11.18.1: at most 188 FS bytes per microframe */
+#define FS_PAYLOAD_MAX 188
+
+/* mtk scheduler bitmasks */
+#define EP_BPKTS(p)	((p) & 0x3f)
+#define EP_BCSCOUNT(p)	(((p) & 0x7) << 8)
+#define EP_BBM(p)	((p) << 11)
+#define EP_BOFFSET(p)	((p) & 0x3fff)
+#define EP_BREPEAT(p)	(((p) & 0x7fff) << 16)
+
+
+struct xhci_hcd_mtk {
+	struct device *dev;
+	struct usb_hcd *hcd;
+	struct mu3h_sch_bw_info *sch_array;
+	struct regulator *vusb33;
+	struct regulator *vbus;
+	struct clk *sys_mac;	/* sys and mac clock */
+};
+
+
+static int is_fs_or_ls(enum usb_device_speed speed)
+{
+	return speed == USB_SPEED_FULL || speed == USB_SPEED_LOW;
+}
+
+static int get_bw_index(struct xhci_hcd *xhci, struct usb_device *udev,
+	struct usb_host_endpoint *ep)
+{
+	int bw_index;
+	int port_id;
+	struct xhci_virt_device *virt_dev;
+
+	virt_dev = xhci->devs[udev->slot_id];
+	port_id = virt_dev->real_port;
+
+	if (udev->speed == USB_SPEED_SUPER) {
+		if (usb_endpoint_dir_out(&ep->desc))
+			bw_index = (port_id - 1) * 2;
+		else
+			bw_index = (port_id - 1) * 2 + 1;
+	} else {
+		bw_index = port_id + xhci->num_usb3_ports - 1;
+	}
+
+	return bw_index;
+}
+
+
+static void setup_sch_info(struct usb_device *udev,
+		struct xhci_ep_ctx *ep_ctx, struct mu3h_sch_ep_info *sch_ep)
+{
+	u32 ep_type;
+	u32 ep_interval;
+	u32 max_packet_size;
+	u32 max_burst;
+	u32 mult;
+	u32 esit_pkts;
+
+	ep_type = CTX_TO_EP_TYPE(le32_to_cpu(ep_ctx->ep_info2));
+	ep_interval = CTX_TO_EP_INTERVAL(le32_to_cpu(ep_ctx->ep_info));
+	max_packet_size = MAX_PACKET_DECODED(le32_to_cpu(ep_ctx->ep_info2));
+	max_burst = CTX_TO_MAX_BURST(le32_to_cpu(ep_ctx->ep_info2));
+	mult = CTX_TO_EP_MULT(le32_to_cpu(ep_ctx->ep_info));
+	pr_debug("%s: max_burst = %d, mult = %d\n", __func__, max_burst, mult);
+
+	sch_ep->ep_type = ep_type;
+	sch_ep->max_packet_size = max_packet_size;
+	sch_ep->esit = 1 << ep_interval;
+	sch_ep->offset = 0;
+	sch_ep->burst_mode = 0;
+
+	if (udev->speed == USB_SPEED_HIGH) {
+		sch_ep->cs_count = 0;
+		/*
+		 * usb_20 spec section5.9
+		 * a single microframe is enough for HS synchromous endpoints
+		 * in a interval
+		 */
+		sch_ep->num_budget_microframes = 1;
+		sch_ep->repeat = 0;
+		/*
+		 * xHCI spec section6.2.3.4
+		 * @max_busrt is the number of additional transactions
+		 * opportunities per microframe
+		 */
+		sch_ep->pkts = max_burst + 1;
+		sch_ep->bw_cost_per_microframe = max_packet_size * sch_ep->pkts;
+	} else if (udev->speed == USB_SPEED_SUPER) {
+		/* usb3_r1 spec section4.4.7 & 4.4.8 */
+		sch_ep->cs_count = 0;
+		esit_pkts = (mult + 1) * (max_burst + 1);
+		if (ep_type == INT_IN_EP || ep_type == INT_OUT_EP) {
+			sch_ep->pkts = esit_pkts;
+			sch_ep->num_budget_microframes = 1;
+			sch_ep->repeat = 0;
+		}
+
+		if (ep_type == ISOC_IN_EP || ep_type == ISOC_OUT_EP) {
+			if (esit_pkts <= sch_ep->esit)
+				sch_ep->pkts = 1;
+			else
+				sch_ep->pkts = roundup_pow_of_two(esit_pkts)
+					/ sch_ep->esit;
+
+			sch_ep->num_budget_microframes =
+				DIV_ROUND_UP(esit_pkts, sch_ep->pkts);
+
+			if (sch_ep->num_budget_microframes > 1)
+				sch_ep->repeat = 1;
+			else
+				sch_ep->repeat = 0;
+		}
+		sch_ep->bw_cost_per_microframe = max_packet_size * sch_ep->pkts;
+	} else if (is_fs_or_ls(udev->speed)) {
+		/*
+		 * usb_20 spec section11.18.4
+		 * assume worst cases
+		 */
+		sch_ep->repeat = 0;
+		sch_ep->pkts = 1; /* at most one packet for each microframe */
+		if (ep_type == INT_IN_EP || ep_type == INT_OUT_EP) {
+			sch_ep->cs_count = 3; /* at most need 3 CS*/
+			/* one for SS and one for budgeted transaction */
+			sch_ep->num_budget_microframes = sch_ep->cs_count + 2;
+			sch_ep->bw_cost_per_microframe = max_packet_size;
+		}
+		if (ep_type == ISOC_OUT_EP) {
+			/* must never schedule a cs ISOC OUT ep */
+			sch_ep->cs_count = 0;
+			/*
+			 * the best case FS budget assumes that 188 FS bytes
+			 * occur in each microframe
+			 */
+			sch_ep->num_budget_microframes = DIV_ROUND_UP(
+				sch_ep->max_packet_size, FS_PAYLOAD_MAX);
+			sch_ep->bw_cost_per_microframe = FS_PAYLOAD_MAX;
+		}
+		if (ep_type == ISOC_IN_EP) {
+			/* at most need additional two CS. */
+			sch_ep->cs_count = DIV_ROUND_UP(
+				sch_ep->max_packet_size, FS_PAYLOAD_MAX) + 2;
+			sch_ep->num_budget_microframes = sch_ep->cs_count + 2;
+			sch_ep->bw_cost_per_microframe = FS_PAYLOAD_MAX;
+		}
+	}
+}
+
+/* Get maximum bandwidth when we schedule at offset slot. */
+static u32 get_max_bw(struct mu3h_sch_bw_info *sch_bw,
+	struct mu3h_sch_ep_info *sch_ep, u32 offset)
+{
+	u32 num_esit;
+	u32 max_bw = 0;
+	int i;
+	int j;
+
+	num_esit = XHCI_MTK_MAX_ESIT / sch_ep->esit;
+	for (i = 0; i < num_esit; i++) {
+		u32 base = offset + i * sch_ep->esit;
+
+		for (j = 0; j < sch_ep->num_budget_microframes; j++) {
+			if (sch_bw->bus_bw[base + j] > max_bw)
+				max_bw = sch_bw->bus_bw[base + j];
+		}
+	}
+	return max_bw;
+}
+
+static void update_bus_bw(struct mu3h_sch_bw_info *sch_bw,
+	struct mu3h_sch_ep_info *sch_ep, int bw_cost)
+{
+	u32 num_esit;
+	u32 base;
+	int i;
+	int j;
+
+	num_esit = XHCI_MTK_MAX_ESIT / sch_ep->esit;
+	for (i = 0; i < num_esit; i++) {
+		base = sch_ep->offset + i * sch_ep->esit;
+		for (j = 0; j < sch_ep->num_budget_microframes; j++)
+			sch_bw->bus_bw[base + j] += bw_cost;
+	}
+
+}
+
+static void debug_sch_ep(struct mu3h_sch_ep_info *sch_ep)
+{
+	pr_debug("%s:\n", __func__);
+	pr_debug("sch_ep->ep_type = %d\n", sch_ep->ep_type);
+	pr_debug("sch_ep->max_packet_size = %d\n", sch_ep->max_packet_size);
+	pr_debug("sch_ep->esit = %d\n", sch_ep->esit);
+	pr_debug("sch_ep->num_budget_microframes = %d\n",
+			sch_ep->num_budget_microframes);
+	pr_debug("sch_ep->bw_cost_per_microframe = %d\n",
+			sch_ep->bw_cost_per_microframe);
+	pr_debug("sch_ep->ep = %p\n", sch_ep->ep);
+	pr_debug("sch_ep->offset = %d\n", sch_ep->offset);
+	pr_debug("sch_ep->repeat = %d\n", sch_ep->repeat);
+	pr_debug("sch_ep->pkts = %d\n", sch_ep->pkts);
+	pr_debug("sch_ep->cs_count = %d\n", sch_ep->cs_count);
+}
+
+static int check_sch_bw(struct usb_device *udev,
+	struct mu3h_sch_bw_info *sch_bw, struct mu3h_sch_ep_info *sch_ep)
+{
+	u32 offset;
+	u32 esit;
+	u32 num_budget_microframes;
+	u32 min_bw;
+	u32 min_index;
+	u32 worst_bw;
+	u32 bw_boundary;
+
+	if (sch_ep->esit > XHCI_MTK_MAX_ESIT)
+		sch_ep->esit = XHCI_MTK_MAX_ESIT;
+
+	esit = sch_ep->esit;
+	num_budget_microframes = sch_ep->num_budget_microframes;
+
+	/*
+	 * Search through all possible schedule microframes.
+	 * and find a microframe where its worst bandwidth is minimum.
+	 */
+	min_bw = ~0;
+	min_index = 0;
+	for (offset = 0; offset < esit; offset++) {
+		if ((offset + num_budget_microframes) > sch_ep->esit)
+			break;
+		/*
+		 * usb_20 spec section11.18:
+		 * must never schedule Start-Split in Y6
+		 */
+		if (is_fs_or_ls(udev->speed) && (offset % 8 == 6))
+			continue;
+
+		worst_bw = get_max_bw(sch_bw, sch_ep, offset);
+		if (min_bw > worst_bw) {
+			min_bw = worst_bw;
+			min_index = offset;
+		}
+		if (min_bw == 0)
+			break;
+	}
+	sch_ep->offset = min_index;
+
+	debug_sch_ep(sch_ep);
+
+	bw_boundary = (udev->speed == USB_SPEED_SUPER)
+				? SS_BW_BOUNDARY : HS_BW_BOUNDARY;
+
+	/* check bandwidth */
+	if (min_bw + sch_ep->bw_cost_per_microframe > bw_boundary)
+		return -1;
+
+	/* update bus bandwidth info */
+	update_bus_bw(sch_bw, sch_ep, sch_ep->bw_cost_per_microframe);
+
+	return 0;
+}
+
+static void debug_sch_bw(struct mu3h_sch_bw_info *sch_bw)
+{
+	int i;
+
+	pr_debug("%s: bus_bw_info\n", __func__);
+	for (i = 0; i < XHCI_MTK_MAX_ESIT; i++)
+		pr_debug("%d  ", sch_bw->bus_bw[i]);
+
+	pr_debug("\n");
+}
+
+
+static bool need_bw_sch(struct usb_host_endpoint *ep,
+	enum usb_device_speed speed, int has_tt)
+{
+	/* only for periodic endpoints */
+	if (usb_endpoint_xfer_control(&ep->desc)
+		|| usb_endpoint_xfer_bulk(&ep->desc))
+		return false;
+	/*
+	 * for LS & FS periodic endpoints which its device don't attach
+	 * to TT are also ignored, root-hub will schedule them directly
+	 */
+	if (is_fs_or_ls(speed) && !has_tt)
+		return false;
+
+	return true;
+}
+
+static int xhci_mtk_sch_init(struct xhci_hcd *xhci)
+{
+	struct usb_hcd *hcd = xhci_to_hcd(xhci);
+	struct device *dev = hcd->self.controller;
+	struct xhci_hcd_mtk *mtk = dev_get_drvdata(dev);
+	struct mu3h_sch_bw_info *sch_array;
+	int num_usb_bus;
+	int i;
+
+	/* ss IN and OUT are separated */
+	num_usb_bus = xhci->num_usb3_ports * 2 + xhci->num_usb2_ports;
+
+	sch_array = kcalloc(num_usb_bus, sizeof(*sch_array), GFP_KERNEL);
+	if (sch_array == NULL)
+		return -ENOMEM;
+
+	for (i = 0; i < num_usb_bus; i++)
+		INIT_LIST_HEAD(&sch_array[i].bw_ep_list);
+
+	mtk->sch_array = sch_array;
+
+	return 0;
+}
+
+
+static void xhci_mtk_sch_exit(struct xhci_hcd *xhci)
+{
+	struct usb_hcd *hcd = xhci_to_hcd(xhci);
+	struct device *dev = hcd->self.controller;
+	struct xhci_hcd_mtk *mtk = dev_get_drvdata(dev);
+
+	kfree(mtk->sch_array);
+}
+
+
+int xhci_mtk_add_ep_quirk(struct usb_hcd *hcd, struct usb_device *udev,
+		struct usb_host_endpoint *ep)
+{
+	struct device *dev = hcd->self.controller;
+	struct xhci_hcd_mtk *mtk = dev_get_drvdata(dev);
+
+	int ret = 0;
+	int port_id;
+	int bw_index;
+	struct xhci_hcd *xhci;
+	unsigned int ep_index;
+	struct xhci_ep_ctx *ep_ctx;
+	struct xhci_slot_ctx *slot_ctx;
+	struct xhci_virt_device *virt_dev;
+	struct mu3h_sch_bw_info *sch_bw;
+	struct mu3h_sch_ep_info *sch_ep;
+	struct mu3h_sch_bw_info *sch_array;
+
+	xhci = hcd_to_xhci(hcd);
+	virt_dev = xhci->devs[udev->slot_id];
+	ep_index = xhci_get_endpoint_index(&ep->desc);
+	slot_ctx = xhci_get_slot_ctx(xhci, virt_dev->in_ctx);
+	ep_ctx = xhci_get_ep_ctx(xhci, virt_dev->in_ctx, ep_index);
+	sch_array = mtk->sch_array;
+
+	port_id = virt_dev->real_port;
+	xhci_dbg(xhci, "%s() xfer_type: %d, speed:%d, ep:%p\n", __func__,
+		usb_endpoint_type(&ep->desc), udev->speed, ep);
+
+	if (!need_bw_sch(ep, udev->speed, slot_ctx->tt_info & TT_SLOT))
+		return 0;
+
+	bw_index = get_bw_index(xhci, udev, ep);
+	sch_bw = &sch_array[bw_index];
+
+	sch_ep = kzalloc(sizeof(struct mu3h_sch_ep_info), GFP_NOIO);
+	if (!sch_ep)
+		return -ENOMEM;
+
+	setup_sch_info(udev, ep_ctx, sch_ep);
+
+	ret = check_sch_bw(udev, sch_bw, sch_ep);
+	if (ret) {
+		xhci_err(xhci, "Not enough bandwidth!\n");
+		kfree(sch_ep);
+		return -ENOSPC;
+	}
+
+	list_add_tail(&sch_ep->endpoint, &sch_bw->bw_ep_list);
+	sch_ep->ep = ep;
+
+	ep_ctx->reserved[0] |= cpu_to_le32(EP_BPKTS(sch_ep->pkts)
+		| EP_BCSCOUNT(sch_ep->cs_count) | EP_BBM(sch_ep->burst_mode));
+	ep_ctx->reserved[1] |= cpu_to_le32(EP_BOFFSET(sch_ep->offset)
+		| EP_BREPEAT(sch_ep->repeat));
+
+	debug_sch_bw(sch_bw);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(xhci_mtk_add_ep_quirk);
+
+
+void xhci_mtk_drop_ep_quirk(struct usb_hcd *hcd, struct usb_device *udev,
+		struct usb_host_endpoint *ep)
+{
+	struct device *dev = hcd->self.controller;
+	struct xhci_hcd_mtk *mtk = dev_get_drvdata(dev);
+
+	int bw_index;
+	struct xhci_hcd *xhci;
+	struct xhci_slot_ctx *slot_ctx;
+	struct xhci_virt_device *virt_dev;
+	struct mu3h_sch_bw_info *sch_array;
+	struct mu3h_sch_bw_info *sch_bw;
+	struct mu3h_sch_ep_info *sch_ep;
+
+	xhci = hcd_to_xhci(hcd);
+	virt_dev = xhci->devs[udev->slot_id];
+	slot_ctx = xhci_get_slot_ctx(xhci, virt_dev->in_ctx);
+	sch_array = mtk->sch_array;
+
+	xhci_dbg(xhci, "%s() xfer_type: %d, speed:%d, ep:%p\n", __func__,
+		usb_endpoint_type(&ep->desc), udev->speed, ep);
+
+	if (!need_bw_sch(ep, udev->speed, slot_ctx->tt_info & TT_SLOT))
+		return;
+
+	bw_index = get_bw_index(xhci, udev, ep);
+	sch_bw = &sch_array[bw_index];
+
+	list_for_each_entry(sch_ep, &sch_bw->bw_ep_list, endpoint) {
+		if (sch_ep->ep == ep) {
+			update_bus_bw(sch_bw, sch_ep,
+				-sch_ep->bw_cost_per_microframe);
+			list_del(&sch_ep->endpoint);
+			kfree(sch_ep);
+			break;
+		}
+	}
+	debug_sch_bw(sch_bw);
+}
+EXPORT_SYMBOL_GPL(xhci_mtk_drop_ep_quirk);
+
+
+/*
+ * The TD size is the number of max packet sized packets remaining in the TD
+ *  (including this TRB), right shifted by 10.
+ * It must fit in bits 21:17, so it can't be bigger than 31.
+ */
+u32 xhci_mtk_td_remainder_quirk(unsigned int td_running_total,
+	unsigned trb_buffer_length, struct urb *urb)
+{
+	u32 max = 31;
+	int remainder, td_packet_count, packet_transferred;
+	unsigned int td_transfer_size = urb->transfer_buffer_length;
+	unsigned int maxp;
+
+	maxp = GET_MAX_PACKET(usb_endpoint_maxp(&urb->ep->desc));
+
+	/* 0 for the last TRB */
+	if (td_running_total + trb_buffer_length == td_transfer_size)
+		return 0;
+
+	packet_transferred = td_running_total / maxp;
+	td_packet_count = DIV_ROUND_UP(td_transfer_size, maxp);
+	remainder = td_packet_count - packet_transferred;
+
+	if (remainder > max)
+		return max << 17;
+	else
+		return remainder << 17;
+}
+EXPORT_SYMBOL_GPL(xhci_mtk_td_remainder_quirk);
+
+
+static int xhci_mtk_setup(struct usb_hcd *hcd);
+static const struct xhci_driver_overrides xhci_mtk_overrides __initconst = {
+	.extra_priv_size = sizeof(struct xhci_hcd),
+	.reset = xhci_mtk_setup,
+};
+
+static struct hc_driver __read_mostly xhci_mtk_hc_driver;
+
+
+static int xhci_mtk_ldos_enable(struct xhci_hcd_mtk *mtk)
+{
+	int ret;
+
+	ret = regulator_enable(mtk->vbus);
+	if (ret) {
+		dev_err(mtk->dev, "failed to enable vbus\n");
+		return ret;
+	}
+
+	ret = regulator_enable(mtk->vusb33);
+	if (ret) {
+		dev_err(mtk->dev, "failed to enable vusb33\n");
+		regulator_disable(mtk->vbus);
+		return ret;
+	}
+	return 0;
+}
+
+static void xhci_mtk_ldos_disable(struct xhci_hcd_mtk *mtk)
+{
+	regulator_disable(mtk->vbus);
+	regulator_disable(mtk->vusb33);
+}
+
+static void xhci_mtk_quirks(struct device *dev, struct xhci_hcd *xhci)
+{
+	/*
+	 * As of now platform drivers don't provide MSI support so we ensure
+	 * here that the generic code does not try to make a pci_dev from our
+	 * dev struct in order to setup MSI
+	 */
+	xhci->quirks |= XHCI_PLAT;
+	xhci->quirks |= XHCI_MTK_HOST;
+	/*
+	 * MTK host controller gives a spurious successful event after a
+	 * short transfer. Ignore it.
+	 */
+	xhci->quirks |= XHCI_SPURIOUS_SUCCESS;
+}
+
+/* called during probe() after chip reset completes */
+static int xhci_mtk_setup(struct usb_hcd *hcd)
+{
+	struct xhci_hcd *xhci;
+	int ret;
+
+	ret = xhci_gen_setup(hcd, xhci_mtk_quirks);
+	if (ret)
+		return ret;
+
+	if (!usb_hcd_is_primary_hcd(hcd))
+		return 0;
+
+	xhci = hcd_to_xhci(hcd);
+	ret = xhci_mtk_sch_init(xhci);
+	if (ret) {
+		kfree(xhci);
+		return ret;
+	}
+
+	return ret;
+}
+
+
+static int xhci_mtk_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *node = pdev->dev.of_node;
+	struct usb_xhci_pdata *pdata = dev_get_platdata(dev);
+	struct xhci_hcd_mtk *mtk;
+	const struct hc_driver *driver;
+	struct xhci_hcd *xhci;
+	struct resource *res;
+	struct usb_hcd *hcd;
+	int ret = -ENODEV;
+	int irq;
+
+	if (usb_disabled())
+		return -ENODEV;
+
+	driver = &xhci_mtk_hc_driver;
+	mtk = devm_kzalloc(dev, sizeof(*mtk), GFP_KERNEL);
+	if (!mtk)
+		return -ENOMEM;
+	mtk->dev = dev;
+
+	mtk->sys_mac = devm_clk_get(dev, "sys_mac");
+	if (IS_ERR(mtk->sys_mac)) {
+		dev_err(dev, "error to get sys_mac\n");
+		ret = PTR_ERR(mtk->sys_mac);
+		goto err;
+	}
+
+	mtk->vbus = devm_regulator_get(dev, "reg-vbus");
+	if (IS_ERR(mtk->vbus)) {
+		dev_err(dev, "fail to get vbus\n");
+		ret = PTR_ERR(mtk->vbus);
+		goto err;
+	}
+
+	mtk->vusb33 = devm_regulator_get(dev, "reg-vusb33");
+	if (IS_ERR(mtk->vusb33)) {
+		dev_err(dev, "fail to get vusb33\n");
+		ret = PTR_ERR(mtk->vusb33);
+		goto err;
+	}
+	pm_runtime_enable(dev);
+	pm_runtime_get_sync(dev);
+
+	ret = xhci_mtk_ldos_enable(mtk);
+	if (ret)
+		goto disable_pm;
+
+	ret = clk_prepare_enable(mtk->sys_mac);
+	if (ret)
+		goto disable_ldos;
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		goto disable_clk;
+
+	/* Initialize dma_mask and coherent_dma_mask to 32-bits */
+	ret = dma_set_coherent_mask(dev, DMA_BIT_MASK(32));
+	if (ret)
+		goto disable_clk;
+
+	if (!dev->dma_mask)
+		dev->dma_mask = &dev->coherent_dma_mask;
+	else
+		dma_set_mask(dev, DMA_BIT_MASK(32));
+
+	hcd = usb_create_hcd(driver, dev, dev_name(dev));
+	if (!hcd) {
+		ret = -ENOMEM;
+		goto disable_clk;
+	}
+
+	/*
+	 * USB 2.0 roothub is stored in the platform_device.
+	 * Swap it with mtk HCD.
+	 */
+	mtk->hcd = platform_get_drvdata(pdev);
+	platform_set_drvdata(pdev, mtk);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	hcd->regs = devm_ioremap_resource(dev, res);
+	if (IS_ERR(hcd->regs)) {
+		ret = PTR_ERR(hcd->regs);
+		goto put_usb2_hcd;
+	}
+	hcd->rsrc_start = res->start;
+	hcd->rsrc_len = resource_size(res);
+
+	hcd->usb_phy = devm_usb_get_phy_by_phandle(dev, "usb-phy", 0);
+	if (IS_ERR(hcd->usb_phy)) {
+		ret = PTR_ERR(hcd->usb_phy);
+		if (ret == -EPROBE_DEFER)
+			goto put_usb2_hcd;
+		hcd->usb_phy = NULL;
+	} else {
+		ret = usb_phy_init(hcd->usb_phy);
+		if (ret)
+			goto put_usb2_hcd;
+	}
+
+	device_wakeup_enable(hcd->self.controller);
+
+	xhci = hcd_to_xhci(hcd);
+	xhci->main_hcd = hcd;
+	xhci->shared_hcd = usb_create_shared_hcd(driver, dev,
+			dev_name(dev), hcd);
+	if (!xhci->shared_hcd) {
+		ret = -ENOMEM;
+		goto disable_usb_phy;
+	}
+
+	if ((node && of_property_read_bool(node, "usb3-lpm-capable")) ||
+			(pdata && pdata->usb3_lpm_capable))
+		xhci->quirks |= XHCI_LPM_SUPPORT;
+
+	if (HCC_MAX_PSA(xhci->hcc_params) >= 4)
+		xhci->shared_hcd->can_do_streams = 1;
+
+	ret = usb_add_hcd(hcd, irq, IRQF_SHARED);
+	if (ret)
+		goto put_usb3_hcd;
+
+	ret = usb_add_hcd(xhci->shared_hcd, irq, IRQF_SHARED);
+	if (ret)
+		goto dealloc_usb2_hcd;
+
+	return 0;
+
+
+dealloc_usb2_hcd:
+	usb_remove_hcd(hcd);
+
+put_usb3_hcd:
+	usb_put_hcd(xhci->shared_hcd);
+
+disable_usb_phy:
+	usb_phy_shutdown(hcd->usb_phy);
+
+put_usb2_hcd:
+	usb_put_hcd(hcd);
+
+disable_clk:
+	clk_disable_unprepare(mtk->sys_mac);
+
+disable_ldos:
+	xhci_mtk_ldos_disable(mtk);
+
+disable_pm:
+	pm_runtime_put_sync(dev);
+	pm_runtime_disable(dev);
+
+err:
+	return ret;
+}
+
+static int xhci_mtk_remove(struct platform_device *dev)
+{
+	struct xhci_hcd_mtk *mtk = platform_get_drvdata(dev);
+	struct usb_hcd	*hcd = mtk->hcd;
+	struct xhci_hcd	*xhci = hcd_to_xhci(hcd);
+
+	usb_remove_hcd(xhci->shared_hcd);
+	usb_phy_shutdown(hcd->usb_phy);
+
+	usb_remove_hcd(hcd);
+	usb_put_hcd(xhci->shared_hcd);
+	usb_put_hcd(hcd);
+	xhci_mtk_sch_exit(xhci);
+	clk_disable_unprepare(mtk->sys_mac);
+	xhci_mtk_ldos_disable(mtk);
+	pm_runtime_put_sync(&dev->dev);
+	pm_runtime_disable(&dev->dev);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int xhci_mtk_suspend(struct device *dev)
+{
+	struct xhci_hcd_mtk *mtk = dev_get_drvdata(dev);
+	struct usb_hcd	*hcd = mtk->hcd;
+	int ret;
+
+	ret = usb_phy_set_suspend(hcd->usb_phy, 1);
+	/* keep on power of mac to maintain register, and only close clock */
+	clk_disable_unprepare(mtk->sys_mac);
+	return ret;
+}
+
+static int xhci_mtk_resume(struct device *dev)
+{
+	struct xhci_hcd_mtk *mtk = dev_get_drvdata(dev);
+	struct usb_hcd	*hcd = mtk->hcd;
+	int ret;
+
+	clk_prepare_enable(mtk->sys_mac);
+	ret = usb_phy_set_suspend(hcd->usb_phy, 0);
+
+	return ret;
+}
+
+static const struct dev_pm_ops xhci_mtk_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(xhci_mtk_suspend, xhci_mtk_resume)
+};
+#define DEV_PM_OPS	(&xhci_mtk_pm_ops)
+#else
+#define DEV_PM_OPS	NULL
+#endif /* CONFIG_PM */
+
+#ifdef CONFIG_OF
+static const struct of_device_id mtk_xhci_of_match[] = {
+	{ .compatible = "mediatek,mt8173-xhci"},
+	{ },
+};
+MODULE_DEVICE_TABLE(of, mtk_xhci_of_match);
+#endif
+
+static struct platform_driver mtk_xhci_driver = {
+	.probe	= xhci_mtk_probe,
+	.remove	= xhci_mtk_remove,
+	.driver	= {
+		.name = "xhci-mtk",
+		.pm = DEV_PM_OPS,
+		.of_match_table = of_match_ptr(mtk_xhci_of_match),
+	},
+};
+
+static int __init xhci_mtk_init(void)
+{
+	xhci_init_driver(&xhci_mtk_hc_driver, &xhci_mtk_overrides);
+	return platform_driver_register(&mtk_xhci_driver);
+}
+module_init(xhci_mtk_init);
+
+static void __exit xhci_mtk_exit(void)
+{
+	platform_driver_unregister(&mtk_xhci_driver);
+}
+module_exit(xhci_mtk_exit);
+
+MODULE_DESCRIPTION("MediaTek xHCI Host Controller Driver");
+MODULE_LICENSE("GPL v2");
+
diff --git a/drivers/usb/host/xhci-mtk.h b/drivers/usb/host/xhci-mtk.h
new file mode 100644
index 0000000..e0fdd19
--- /dev/null
+++ b/drivers/usb/host/xhci-mtk.h
@@ -0,0 +1,108 @@
+/*
+ * Copyright (c) 2015 MediaTek Inc.
+ * Author:
+ *  Zhigang.Wei <zhigang.wei@mediatek.com>
+ *  Chunfeng.Yun <chunfeng.yun@mediatek.com>
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
+#ifndef _XHCI_MTK_H_
+#define _XHCI_MTK_H_
+
+#include "xhci.h"
+
+/**
+ * To simplify scheduler algorithm, set a upper limit for ESIT,
+ * if a synchromous ep's ESIT is larger than @XHCI_MTK_MAX_ESIT,
+ * round down to the limit value, that means allocating more
+ * bandwidth to it.
+ */
+#define XHCI_MTK_MAX_ESIT	64
+
+/**
+ * struct mu3h_sch_bw_info
+ * @bus_bw: array to keep track of bandwidth already used at each uframes
+ * @bw_ep_list: eps in the bandwidth domain
+ *
+ * treat a HS root port as a bandwidth domain, but treat a SS root port as
+ * two bandwidth domains, one for IN eps and another for OUT eps.
+ */
+struct mu3h_sch_bw_info {
+	u32 bus_bw[XHCI_MTK_MAX_ESIT];
+	struct list_head bw_ep_list;
+};
+
+/**
+ * struct mu3h_sch_ep_info
+ * @esit: unit is 125us, equal to 2 << Interval field in ep-context
+ * @num_budget_microframes: number of continuous uframes
+ *		(@repeat==1) scheduled within the interval
+ * @ep: address of usb_host_endpoint
+ * @offset: which uframe of the interval that transfer should be
+ *		scheduled first time within the interval
+ * @repeat: the time gap between two uframes that transfers are
+ *		scheduled within a interval. in the simple algorithm, only
+ *		assign 0 or 1 to it; 0 means using only one uframe in a
+ *		interval, and1 means using @num_budget_microframes
+ *		continuous uframes
+ * @pkts: number of packets to be transferred in the scheduled uframes
+ * @cs_count: number of CS that host will trigger
+ */
+struct mu3h_sch_ep_info {
+	u32 ep_type;
+	u32 max_packet_size;
+	u32 esit;
+	u32 num_budget_microframes;
+	u32 bw_cost_per_microframe;
+	void *ep;
+	struct list_head endpoint;
+
+	/* mtk xhci scheduling info */
+	u32 offset;
+	u32 repeat;
+	u32 pkts;
+	u32 cs_count;
+	u32 burst_mode;
+};
+
+
+#if IS_ENABLED(CONFIG_USB_XHCI_MTK)
+
+int xhci_mtk_add_ep_quirk(struct usb_hcd *hcd, struct usb_device *udev,
+		struct usb_host_endpoint *ep);
+void xhci_mtk_drop_ep_quirk(struct usb_hcd *hcd, struct usb_device *udev,
+		struct usb_host_endpoint *ep);
+u32 xhci_mtk_td_remainder_quirk(unsigned int td_running_total,
+	unsigned trb_buffer_length, struct urb *urb);
+
+#else
+static inline int xhci_mtk_add_ep_quirk(struct usb_hcd *hcd,
+	struct usb_device *udev, struct usb_host_endpoint *ep)
+{
+	return 0;
+}
+
+static inline void xhci_mtk_drop_ep_quirk(struct usb_hcd *hcd,
+	struct usb_device *udev, struct usb_host_endpoint *ep)
+{
+	return 0;
+}
+
+static inline u32 xhci_mtk_td_remainder_quirk(unsigned int td_running_total,
+	unsigned trb_buffer_length, struct urb *urb)
+{
+	return 0;
+}
+
+#endif
+
+#endif		/* _XHCI_MTK_H_ */
diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 94416ff..73997a0 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -68,6 +68,7 @@
 #include <linux/slab.h>
 #include "xhci.h"
 #include "xhci-trace.h"
+#include "xhci-mtk.h"
 
 /*
  * Returns zero if the TRB isn't in this segment, otherwise it returns the DMA
@@ -3131,9 +3132,14 @@ static int queue_bulk_sg_tx(struct xhci_hcd *xhci, gfp_t mem_flags,
 
 		/* Set the TRB length, TD size, and interrupter fields. */
 		if (xhci->hci_version < 0x100) {
-			remainder = xhci_td_remainder(
+			if (xhci->quirks & XHCI_MTK_HOST) {
+				remainder = xhci_mtk_td_remainder_quirk(
+					running_total, trb_buff_len, urb);
+			} else {
+				remainder = xhci_td_remainder(
 					urb->transfer_buffer_length -
 					running_total);
+			}
 		} else {
 			remainder = xhci_v1_0_td_remainder(running_total,
 					trb_buff_len, total_packet_count, urb,
@@ -3286,9 +3292,14 @@ int xhci_queue_bulk_tx(struct xhci_hcd *xhci, gfp_t mem_flags,
 
 		/* Set the TRB length, TD size, and interrupter fields. */
 		if (xhci->hci_version < 0x100) {
-			remainder = xhci_td_remainder(
+			if (xhci->quirks & XHCI_MTK_HOST) {
+				remainder = xhci_mtk_td_remainder_quirk(
+					running_total, trb_buff_len, urb);
+			} else {
+				remainder = xhci_td_remainder(
 					urb->transfer_buffer_length -
 					running_total);
+			}
 		} else {
 			remainder = xhci_v1_0_td_remainder(running_total,
 					trb_buff_len, total_packet_count, urb,
@@ -3383,7 +3394,7 @@ int xhci_queue_ctrl_tx(struct xhci_hcd *xhci, gfp_t mem_flags,
 		field |= 0x1;
 
 	/* xHCI 1.0 6.4.1.2.1: Transfer Type field */
-	if (xhci->hci_version == 0x100) {
+	if ((xhci->hci_version == 0x100) || (xhci->quirks & XHCI_MTK_HOST)) {
 		if (urb->transfer_buffer_length > 0) {
 			if (setup->bRequestType & USB_DIR_IN)
 				field |= TRB_TX_TYPE(TRB_DATA_IN);
@@ -3407,8 +3418,14 @@ int xhci_queue_ctrl_tx(struct xhci_hcd *xhci, gfp_t mem_flags,
 		field = TRB_TYPE(TRB_DATA);
 
 	length_field = TRB_LEN(urb->transfer_buffer_length) |
-		xhci_td_remainder(urb->transfer_buffer_length) |
 		TRB_INTR_TARGET(0);
+
+	if (xhci->quirks & XHCI_MTK_HOST)
+		length_field |= xhci_mtk_td_remainder_quirk(0,
+				urb->transfer_buffer_length, urb);
+	else
+		length_field |= xhci_td_remainder(urb->transfer_buffer_length);
+
 	if (urb->transfer_buffer_length > 0) {
 		if (setup->bRequestType & USB_DIR_IN)
 			field |= TRB_DIR_IN;
@@ -3632,8 +3649,14 @@ static int xhci_queue_isoc_tx(struct xhci_hcd *xhci, gfp_t mem_flags,
 
 			/* Set the TRB length, TD size, & interrupter fields. */
 			if (xhci->hci_version < 0x100) {
-				remainder = xhci_td_remainder(
-						td_len - running_total);
+				if (xhci->quirks & XHCI_MTK_HOST) {
+					remainder = xhci_mtk_td_remainder_quirk(
+						running_total, trb_buff_len,
+						urb);
+				} else {
+					remainder = xhci_td_remainder(
+							td_len - running_total);
+				}
 			} else {
 				remainder = xhci_v1_0_td_remainder(
 						running_total, trb_buff_len,
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 7da0d60..209fc8a 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -31,6 +31,7 @@
 
 #include "xhci.h"
 #include "xhci-trace.h"
+#include "xhci-mtk.h"
 
 #define DRIVER_AUTHOR "Sarah Sharp"
 #define DRIVER_DESC "'eXtensible' Host Controller (xHC) Driver"
@@ -623,7 +624,11 @@ int xhci_run(struct usb_hcd *hcd)
 			"// Set the interrupt modulation register");
 	temp = readl(&xhci->ir_set->irq_control);
 	temp &= ~ER_IRQ_INTERVAL_MASK;
-	temp |= (u32) 160;
+	/*
+	 * the increment interval is 8 times as much as that defined
+	 * in xHCI spec on MTK's controller
+	 */
+	temp |= (u32) ((xhci->quirks & XHCI_MTK_HOST) ? 20 : 160);
 	writel(temp, &xhci->ir_set->irq_control);
 
 	/* Set the HCD state before we enable the irqs */
@@ -1688,6 +1693,9 @@ int xhci_drop_endpoint(struct usb_hcd *hcd, struct usb_device *udev,
 
 	xhci_endpoint_zero(xhci, xhci->devs[udev->slot_id], ep);
 
+	if (xhci->quirks & XHCI_MTK_HOST)
+		xhci_mtk_drop_ep_quirk(hcd, udev, ep);
+
 	xhci_dbg(xhci, "drop ep 0x%x, slot id %d, new drop flags = %#x, new add flags = %#x\n",
 			(unsigned int) ep->desc.bEndpointAddress,
 			udev->slot_id,
@@ -1783,6 +1791,15 @@ int xhci_add_endpoint(struct usb_hcd *hcd, struct usb_device *udev,
 		return -ENOMEM;
 	}
 
+	if (xhci->quirks & XHCI_MTK_HOST) {
+		ret = xhci_mtk_add_ep_quirk(hcd, udev, ep);
+		if (ret < 0) {
+			xhci_free_or_cache_endpoint_ring(xhci,
+				virt_dev, ep_index);
+			return ret;
+		}
+	}
+
 	ctrl_ctx->add_flags |= cpu_to_le32(added_ctxs);
 	new_add_flags = le32_to_cpu(ctrl_ctx->add_flags);
 
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 31e46cc..d257ce3 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1567,6 +1567,7 @@ struct xhci_hcd {
 /* For controllers with a broken beyond repair streams implementation */
 #define XHCI_BROKEN_STREAMS	(1 << 19)
 #define XHCI_PME_STUCK_QUIRK	(1 << 20)
+#define XHCI_MTK_HOST		(1 << 21)
 	unsigned int		num_active_eps;
 	unsigned int		limit_active_eps;
 	/* There are two roothubs to keep track of bus suspend info for */
-- 
1.8.1.1.dirty
