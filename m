From: oneukum@suse.com (Oliver Neukum)
Date: Thu, 25 Aug 2016 10:32:53 +0200
Subject: [RESEND PATCH, v5 4/5] usb: Add MediaTek USB3 DRD Driver
In-Reply-To: <1472094329-18466-5-git-send-email-chunfeng.yun@mediatek.com>
References: <1472094329-18466-1-git-send-email-chunfeng.yun@mediatek.com>
 <1472094329-18466-5-git-send-email-chunfeng.yun@mediatek.com>
Message-ID: <1472113973.2877.22.camel@suse.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2016-08-25 at 11:05 +0800, Chunfeng Yun wrote:
> This patch adds support for the MediaTek USB3 controller
> integrated into MT8173. It can be configured as Dual-Role
> Device (DRD), Peripheral Only and Host Only (xHCI) modes.
> 

> +/**
> + * General Purpose Descriptor (GPD):
> + *	The format of TX GPD is a little different from RX one.
> + *	And the size of GPD is 16 bytes.
> + *
> + * @flag:
> + *	bit0: Hardware Own (HWO)
> + *	bit1: Buffer Descriptor Present (BDP), always 0, BD is not supported
> + *	bit2: Bypass (BPS), 1: HW skips this GPD if HWO = 1
> + *	bit7: Interrupt On Completion (IOC)
> + * @chksum: This is used to validate the contents of this GPD;
> + *	If TXQ_CS_EN / RXQ_CS_EN bit is set, an interrupt is issued
> + *	when checksum validation fails;
> + *	Checksum value is calculated over the 16 bytes of the GPD by default;
> + * @data_buf_len (RX ONLY): This value indicates the length of
> + *	the assigned data buffer
> + * @next_gpd: Physical address of the next GPD
> + * @buffer: Physical address of the data buffer
> + * @buf_len:
> + *	(TX): This value indicates the length of the assigned data buffer
> + *	(RX): The total length of data received
> + * @ext_len: reserved
> + * @ext_flag:
> + *	bit5 (TX ONLY): Zero Length Packet (ZLP),
> + */
> +struct qmu_gpd {
> +	u8 flag;
> +	u8 chksum;
> +	u16 data_buf_len;
> +	u32 next_gpd;
> +	u32 buffer;
> +	u16 buf_len;
> +	u8 ext_len;
> +	u8 ext_flag;
> +} __packed;

It looks like this is shared with hardware in memory.
But you leave the endianness of the bigger fields undeclared.

> +/**
> +* dma: physical base address of GPD segment
> +* start: virtual base address of GPD segment
> +* end: the last GPD element
> +* enqueue: the first empty GPD to use
> +* dequeue: the first completed GPD serviced by ISR
> +* NOTE: the size of GPD ring should be >= 2
> +*/
> +struct mtu3_gpd_ring {
> +	dma_addr_t dma;
> +	struct qmu_gpd *start;
> +	struct qmu_gpd *end;
> +	struct qmu_gpd *enqueue;
> +	struct qmu_gpd *dequeue;
> +};
> +
> +/**
> +* @vbus: vbus 5V used by host mode
> +* @edev: external connector used to detect vbus and iddig changes
> +* @vbus_nb: notifier for vbus detection
> +* @vbus_nb: notifier for iddig(idpin) detection
> +* @extcon_reg_dwork: delay work for extcon notifier register, waiting for
> +*		xHCI driver initialization, it's necessary for system bootup
> +*		as device.
> +* @is_u3_drd: whether port0 supports usb3.0 dual-role device or not
> +* @id_*: used to maually switch between host and device modes by idpin
> +* @manual_drd_enabled: it's true when supports dual-role device by debugfs
> +*		to switch host/device modes depending on user input.

Please use a common interface for this. The Intel people are introducing
one.


> +#endif
> diff --git a/drivers/usb/mtu3/mtu3_core.c b/drivers/usb/mtu3/mtu3_core.c
> new file mode 100644
> index 0000000..fdc11b6
> --- /dev/null
> +++ b/drivers/usb/mtu3/mtu3_core.c
> @@ -0,0 +1,874 @@
> +/*
> + * mtu3_core.c - hardware access layer and gadget init/exit of
> + *                     MediaTek usb3 Dual-Role Controller Driver
> + *
> + * Copyright (C) 2016 MediaTek Inc.
> + *
> + * Author: Chunfeng Yun <chunfeng.yun@mediatek.com>
> + *
> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +#include <linux/platform_device.h>
> +
> +#include "mtu3.h"
> +
> +static int ep_fifo_alloc(struct mtu3_ep *mep, u32 seg_size)
> +{
> +	struct mtu3_fifo_info *fifo = mep->fifo;
> +	u32 num_bits = DIV_ROUND_UP(seg_size, MTU3_EP_FIFO_UNIT);
> +	u32 start_bit;
> +
> +	/* ensure that @mep->fifo_seg_size is power of two */
> +	num_bits = roundup_pow_of_two(num_bits);
> +	if (num_bits > fifo->limit)
> +		return -EINVAL;
> +
> +	mep->fifo_seg_size = num_bits * MTU3_EP_FIFO_UNIT;
> +	num_bits = num_bits * (mep->slot + 1);
> +	start_bit = bitmap_find_next_zero_area(fifo->bitmap,
> +			fifo->limit, 0, num_bits, 0);
> +	if (start_bit >= fifo->limit)
> +		return -EOVERFLOW;
> +
> +	bitmap_set(fifo->bitmap, start_bit, num_bits);
> +	mep->fifo_size = num_bits * MTU3_EP_FIFO_UNIT;
> +	mep->fifo_addr = fifo->base + MTU3_EP_FIFO_UNIT * start_bit;
> +
> +	dev_dbg(mep->mtu->dev, "%s fifo:%#x/%#x, start_bit: %d\n",
> +		__func__, mep->fifo_seg_size, mep->fifo_size, start_bit);

If you use the "f" option to dynamic debugging it will give you the
function name anyway. So why include __func__ ?


> +/* enable/disable U3D SS function */
> +static void mtu3_ss_func_set(struct mtu3 *mtu, bool enable)

Inline maybe ?

> +{
> +	/* If usb3_en==0, LTSSM will go to SS.Disable state */
> +	if (enable)
> +		mtu3_setbits(mtu->mac_base, U3D_USB3_CONFIG, USB3_EN);
> +	else
> +		mtu3_clrbits(mtu->mac_base, U3D_USB3_CONFIG, USB3_EN);
> +
> +	dev_dbg(mtu->dev, "USB3_EN = %d\n", !!enable);
> +}
> +

[..]


> +int mtu3_config_ep(struct mtu3 *mtu, struct mtu3_ep *mep,
> +			int interval, int burst, int mult)
> +{
> +	void __iomem *mbase = mtu->mac_base;
> +	int epnum = mep->epnum;
> +	u32 csr0, csr1, csr2;
> +	int fifo_sgsz, fifo_addr;
> +	int num_pkts;
> +
> +	fifo_addr = ep_fifo_alloc(mep, mep->maxp);
> +	if (fifo_addr < 0) {
> +		dev_err(mtu->dev, "alloc ep fifo failed(%d)\n", mep->maxp);
> +		return -ENOMEM;
> +	}
> +	fifo_sgsz = ilog2(mep->fifo_seg_size);
> +	dev_dbg(mtu->dev, "%s fifosz: %x(%x/%x)\n", __func__, fifo_sgsz,
> +		mep->fifo_seg_size, mep->fifo_size);
> +
> +	if (mep->is_in) {
> +		csr0 = TX_TXMAXPKTSZ(mep->maxp);
> +		csr0 |= TX_DMAREQEN;
> +
> +		num_pkts = (burst + 1) * (mult + 1) - 1;
> +		csr1 = TX_SS_BURST(burst) | TX_SLOT(mep->slot);
> +		csr1 |= TX_MAX_PKT(num_pkts) | TX_MULT(mult);
> +
> +		csr2 = TX_FIFOADDR(fifo_addr >> 4);
> +		csr2 |= TX_FIFOSEGSIZE(fifo_sgsz);
> +
> +		switch (mep->type) {
> +		case USB_ENDPOINT_XFER_BULK:
> +			csr1 |= TX_TYPE(TYPE_BULK);
> +			break;
> +		case USB_ENDPOINT_XFER_ISOC:
> +			csr1 |= TX_TYPE(TYPE_ISO);
> +			csr2 |= TX_BINTERVAL(interval);
> +			break;
> +		case USB_ENDPOINT_XFER_INT:
> +			csr1 |= TX_TYPE(TYPE_INT);
> +			csr2 |= TX_BINTERVAL(interval);
> +			break;

And if it is control?

> +		}
> +
> +		/* Enable QMU Done interrupt */
> +		mtu3_setbits(mbase, U3D_QIESR0, QMU_TX_DONE_INT(epnum));
> +
> +		mtu3_writel(mbase, MU3D_EP_TXCR0(epnum), csr0);
> +		mtu3_writel(mbase, MU3D_EP_TXCR1(epnum), csr1);
> +		mtu3_writel(mbase, MU3D_EP_TXCR2(epnum), csr2);
> +
> +		dev_dbg(mtu->dev, "U3D_TX%d CSR0:%#x, CSR1:%#x, CSR2:%#x\n",
> +			epnum, mtu3_readl(mbase, MU3D_EP_TXCR0(epnum)),
> +			mtu3_readl(mbase, MU3D_EP_TXCR1(epnum)),
> +			mtu3_readl(mbase, MU3D_EP_TXCR2(epnum)));
> +	} else {
> +		csr0 = RX_RXMAXPKTSZ(mep->maxp);
> +		csr0 |= RX_DMAREQEN;
> +
> +		num_pkts = (burst + 1) * (mult + 1) - 1;
> +		csr1 = RX_SS_BURST(burst) | RX_SLOT(mep->slot);
> +		csr1 |= RX_MAX_PKT(num_pkts) | RX_MULT(mult);
> +
> +		csr2 = RX_FIFOADDR(fifo_addr >> 4);
> +		csr2 |= RX_FIFOSEGSIZE(fifo_sgsz);
> +
> +		switch (mep->type) {
> +		case USB_ENDPOINT_XFER_BULK:
> +			csr1 |= RX_TYPE(TYPE_BULK);
> +			break;
> +		case USB_ENDPOINT_XFER_ISOC:
> +			csr1 |= RX_TYPE(TYPE_ISO);
> +			csr2 |= RX_BINTERVAL(interval);
> +			break;
> +		case USB_ENDPOINT_XFER_INT:
> +			csr1 |= RX_TYPE(TYPE_INT);
> +			csr2 |= RX_BINTERVAL(interval);
> +			break;

Again: control endpoints?

> +		}
> +
> +		/*Enable QMU Done interrupt */
> +		mtu3_setbits(mbase, U3D_QIESR0, QMU_RX_DONE_INT(epnum));
> +
> +		mtu3_writel(mbase, MU3D_EP_RXCR0(epnum), csr0);
> +		mtu3_writel(mbase, MU3D_EP_RXCR1(epnum), csr1);
> +		mtu3_writel(mbase, MU3D_EP_RXCR2(epnum), csr2);
> +
> +		dev_dbg(mtu->dev, "U3D_RX%d CSR0:%#x, CSR1:%#x, CSR2:%#x\n",
> +			epnum, mtu3_readl(mbase, MU3D_EP_RXCR0(epnum)),
> +			mtu3_readl(mbase, MU3D_EP_RXCR1(epnum)),
> +			mtu3_readl(mbase, MU3D_EP_RXCR2(epnum)));
> +	}
> +
> +	dev_dbg(mtu->dev, "csr0:%#x, csr1:%#x, csr2:%#x\n", csr0, csr1, csr2);
> +	dev_dbg(mtu->dev, "%s: %s, fifo-addr:%#x, fifo-size:%#x(%#x/%#x)\n",
> +		__func__, mep->name, mep->fifo_addr, mep->fifo_size,
> +		fifo_sgsz, mep->fifo_seg_size);
> +
> +	return 0;
> +}
> +

[..]
> +static void mtu3_set_speed(struct mtu3 *mtu)
> +{
> +	void __iomem *mbase = mtu->mac_base;
> +
> +	if (!mtu->is_u3_ip && (mtu->max_speed > USB_SPEED_HIGH))
> +		mtu->max_speed = USB_SPEED_HIGH;

You are missing the checks for USB_SPEED_WIRELESS in general.
Can you just ignore it?

> +
> +	if (mtu->max_speed == USB_SPEED_FULL) {
> +		/* disable U3 SS function */
> +		mtu3_clrbits(mbase, U3D_USB3_CONFIG, USB3_EN);
> +		/* disable HS function */
> +		mtu3_clrbits(mbase, U3D_POWER_MANAGEMENT, HS_ENABLE);
> +	} else if (mtu->max_speed == USB_SPEED_HIGH) {
> +		mtu3_clrbits(mbase, U3D_USB3_CONFIG, USB3_EN);
> +		/* HS/FS detected by HW */
> +		mtu3_setbits(mbase, U3D_POWER_MANAGEMENT, HS_ENABLE);
> +	}
> +	dev_info(mtu->dev, "max_speed: %s\n",
> +		usb_speed_string(mtu->max_speed));
> +}

[..]
> +static irqreturn_t mtu3_link_isr(struct mtu3 *mtu)
> +{
> +	void __iomem *mbase = mtu->mac_base;
> +	enum usb_device_speed udev_speed;
> +	u32 maxpkt = 64;
> +	u32 link;
> +	u32 speed;
> +
> +	link = mtu3_readl(mbase, U3D_DEV_LINK_INTR);
> +	link &= mtu3_readl(mbase, U3D_DEV_LINK_INTR_ENABLE);
> +	mtu3_writel(mbase, U3D_DEV_LINK_INTR, link); /* W1C */
> +	dev_dbg(mtu->dev, "=== LINK[%x] ===\n", link);
> +
> +	if (!(link & SSUSB_DEV_SPEED_CHG_INTR))
> +		return IRQ_NONE;

Shouldn't you do this check before you clear interrupts?

> +	speed = SSUSB_DEV_SPEED(mtu3_readl(mbase, U3D_DEVICE_CONF));

Do you really want to read this out of the hardware on every interrupt?

> +
> +	switch (speed) {
> +	case MTU3_SPEED_FULL:
> +		udev_speed = USB_SPEED_FULL;
> +		/*BESLCK = 4 < BESLCK_U3 = 10 < BESLDCK = 15 */
> +		mtu3_writel(mbase, U3D_USB20_LPM_PARAMETER, LPM_BESLDCK(0xf)
> +				| LPM_BESLCK(4) | LPM_BESLCK_U3(0xa));
> +		mtu3_setbits(mbase, U3D_POWER_MANAGEMENT,
> +				LPM_BESL_STALL | LPM_BESLD_STALL);
> +		break;
> +	case MTU3_SPEED_HIGH:
> +		udev_speed = USB_SPEED_HIGH;
> +		/*BESLCK = 4 < BESLCK_U3 = 10 < BESLDCK = 15 */
> +		mtu3_writel(mbase, U3D_USB20_LPM_PARAMETER, LPM_BESLDCK(0xf)
> +				| LPM_BESLCK(4) | LPM_BESLCK_U3(0xa));
> +		mtu3_setbits(mbase, U3D_POWER_MANAGEMENT,
> +				LPM_BESL_STALL | LPM_BESLD_STALL);
> +		break;
> +	case MTU3_SPEED_SUPER:
> +		udev_speed = USB_SPEED_SUPER;
> +		maxpkt = 512;
> +		break;
> +	default:
> +		udev_speed = USB_SPEED_UNKNOWN;
> +		break;
> +	}
> +	dev_dbg(mtu->dev, "%s: %s\n", __func__, usb_speed_string(udev_speed));
> +
> +	mtu->g.speed = udev_speed;
> +	mtu->g.ep0->maxpacket = maxpkt;
> +	mtu->ep0_state = MU3D_EP0_STATE_SETUP;
> +
> +	if (udev_speed == USB_SPEED_UNKNOWN)
> +		mtu3_gadget_disconnect(mtu);
> +	else
> +		mtu3_ep0_setup(mtu);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t mtu3_u3_ltssm_isr(struct mtu3 *mtu)
> +{
> +	void __iomem *mbase = mtu->mac_base;
> +	u32 ltssm;
> +
> +	ltssm = mtu3_readl(mbase, U3D_LTSSM_INTR);
> +	ltssm &= mtu3_readl(mbase, U3D_LTSSM_INTR_ENABLE);
> +	mtu3_writel(mbase, U3D_LTSSM_INTR, ltssm); /* W1C */
> +	dev_dbg(mtu->dev, "=== LTSSM[%x] ===\n", ltssm);
> +
> +	if (ltssm & HOT_RST_INTR)
> +		mtu3_gadget_reset(mtu);
> +
> +	if (ltssm & WARM_RST_INTR)
> +		mtu3_gadget_reset(mtu);

You really would reset the gadget twice if that happens?
And do the rest of the tests make sense in that case?

> +
> +	if (ltssm & VBUS_FALL_INTR)
> +		mtu3_ss_func_set(mtu, false);
> +
> +	if (ltssm & VBUS_RISE_INTR)
> +		mtu3_ss_func_set(mtu, true);
> +
> +	if (ltssm & EXIT_U3_INTR)
> +		mtu3_gadget_resume(mtu);
> +
> +	if (ltssm & ENTER_U3_INTR)
> +		mtu3_gadget_suspend(mtu);
> +
> +	return IRQ_HANDLED;
> +}

[..]

> +static int mtu3_hw_init(struct mtu3 *mtu)
> +{
> +	int ret;
> +
> +	mtu3_device_reset(mtu);
> +
> +	ret = mtu3_device_enable(mtu);
> +	if (ret) {
> +		dev_err(mtu->dev, "device enable failed %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = mtu3_mem_alloc(mtu);
> +	if (ret) {
> +		dev_err(mtu->dev, "mem alloc failed, aborting\n");

1. You can't leave the device enabled in that case.
2. No need for a message. The kernel will already do that if kmalloc()
fails under such circumstances.

> +		return -ENOMEM;
> +	}
> +
> +	mtu3_regs_init(mtu);
> +
> +	return 0;
> +}

> diff --git a/drivers/usb/mtu3/mtu3_dr.c b/drivers/usb/mtu3/mtu3_dr.c
> new file mode 100644
> index 0000000..f560f93
> --- /dev/null
> +++ b/drivers/usb/mtu3/mtu3_dr.c
> @@ -0,0 +1,375 @@
> +/*
> + * mtu3_dr.c - dual role switch and host glue layer
> + *
> + * Copyright (C) 2016 MediaTek Inc.
> + *
> + * Author: Chunfeng Yun <chunfeng.yun@mediatek.com>
> + *
> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + */
> +
> +#include <linux/debugfs.h>
> +#include <linux/irq.h>
> +#include <linux/kernel.h>
> +#include <linux/of_device.h>
> +#include <linux/pinctrl/consumer.h>
> +#include <linux/seq_file.h>
> +#include <linux/uaccess.h>
> +
> +#include "mtu3.h"
> +#include "mtu3_dr.h"
> +
> +#define USB2_PORT 2
> +#define USB3_PORT 3
> +
> +enum mtu3_vbus_id_state {
> +	MTU3_ID_FLOAT = 1,
> +	MTU3_ID_GROUND,
> +	MTU3_VBUS_OFF,
> +	MTU3_VBUS_VALID,
> +};
> +
> +static void toggle_opstate(struct ssusb_mtk *ssusb)
> +{
> +	if (!ssusb->otg_switch.is_u3_drd) {
> +		mtu3_setbits(ssusb->mac_base, U3D_DEVICE_CONTROL, DC_SESSION);
> +		mtu3_setbits(ssusb->mac_base, U3D_POWER_MANAGEMENT, SOFT_CONN);
> +	}
> +}
> +
> +/* only port0 supports dual-role mode */
> +static int ssusb_port0_switch(struct ssusb_mtk *ssusb,
> +	int version, bool tohost)
> +{
> +	void __iomem *ibase = ssusb->ippc_base;
> +	u32 value;
> +
> +	dev_dbg(ssusb->dev, "%s (switch u%d port0 to %s)\n", __func__,
> +		version, tohost ? "host" : "device");
> +
> +	if (version == USB2_PORT) {
> +		/* 1. power off and disable u2 port0 */
> +		value = mtu3_readl(ibase, SSUSB_U2_CTRL(0));
> +		value |= SSUSB_U2_PORT_PDN | SSUSB_U2_PORT_DIS;
> +		mtu3_writel(ibase, SSUSB_U2_CTRL(0), value);
> +
> +		/* 2. power on, enable u2 port0 and select its mode */
> +		value = mtu3_readl(ibase, SSUSB_U2_CTRL(0));
> +		value &= ~(SSUSB_U2_PORT_PDN | SSUSB_U2_PORT_DIS);
> +		value = tohost ? (value | SSUSB_U2_PORT_HOST_SEL) :
> +			(value & (~SSUSB_U2_PORT_HOST_SEL));
> +		mtu3_writel(ibase, SSUSB_U2_CTRL(0), value);
> +	} else {
> +		/* 1. power off and disable u3 port0 */
> +		value = mtu3_readl(ibase, SSUSB_U3_CTRL(0));
> +		value |= SSUSB_U3_PORT_PDN | SSUSB_U3_PORT_DIS;
> +		mtu3_writel(ibase, SSUSB_U3_CTRL(0), value);
> +
> +		/* 2. power on, enable u3 port0 and select its mode */
> +		value = mtu3_readl(ibase, SSUSB_U3_CTRL(0));
> +		value &= ~(SSUSB_U3_PORT_PDN | SSUSB_U3_PORT_DIS);
> +		value = tohost ? (value | SSUSB_U3_PORT_HOST_SEL) :
> +			(value & (~SSUSB_U3_PORT_HOST_SEL));
> +		mtu3_writel(ibase, SSUSB_U3_CTRL(0), value);
> +	}
> +
> +	return 0;
> +}
> +
> +static void switch_port_to_host(struct ssusb_mtk *ssusb)
> +{
> +	u32 check_clk = 0;
> +
> +	dev_dbg(ssusb->dev, "%s\n", __func__);
> +
> +	ssusb_port0_switch(ssusb, USB2_PORT, true);
> +
> +	if (ssusb->otg_switch.is_u3_drd) {
> +		ssusb_port0_switch(ssusb, USB3_PORT, true);
> +		check_clk = SSUSB_U3_MAC_RST_B_STS;
> +	}
> +
> +	ssusb_check_clocks(ssusb, check_clk);
> +
> +	/* after all clocks are stable */
> +	toggle_opstate(ssusb);
> +}
> +
> +static void switch_port_to_device(struct ssusb_mtk *ssusb)
> +{
> +	u32 check_clk = 0;
> +
> +	dev_dbg(ssusb->dev, "%s\n", __func__);
> +
> +	ssusb_port0_switch(ssusb, USB2_PORT, false);
> +
> +	if (ssusb->otg_switch.is_u3_drd) {
> +		ssusb_port0_switch(ssusb, USB3_PORT, false);
> +		check_clk = SSUSB_U3_MAC_RST_B_STS;
> +	}
> +
> +	ssusb_check_clocks(ssusb, check_clk);
> +}
> +
> +int ssusb_set_vbus(struct otg_switch_mtk *otg_sx, int is_on)
> +{
> +	struct ssusb_mtk *ssusb =
> +		container_of(otg_sx, struct ssusb_mtk, otg_switch);
> +	struct regulator *vbus = otg_sx->vbus;
> +	int ret;
> +
> +	/* vbus is optional */
> +	if (!vbus)
> +		return 0;
> +
> +	dev_dbg(ssusb->dev, "%s: turn %s\n", __func__, is_on ? "on" : "off");
> +
> +	if (is_on) {
> +		ret = regulator_enable(vbus);
> +		if (ret) {
> +			dev_err(ssusb->dev, "vbus regulator enable failed\n");
> +			return ret;
> +		}
> +	} else {
> +		regulator_disable(vbus);
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * switch to host: -> MTU3_VBUS_OFF --> MTU3_ID_GROUND
> + * switch to device: -> MTU3_ID_FLOAT --> MTU3_VBUS_VALID
> + */
> +static void ssusb_set_mailbox(struct otg_switch_mtk *otg_sx,
> +	enum mtu3_vbus_id_state status)
> +{
> +	struct ssusb_mtk *ssusb =
> +		container_of(otg_sx, struct ssusb_mtk, otg_switch);
> +	struct mtu3 *mtu = ssusb->u3d;
> +
> +	dev_dbg(ssusb->dev, "mailbox state(%d)\n", status);
> +
> +	switch (status) {
> +	case MTU3_ID_GROUND:
> +		switch_port_to_host(ssusb);
> +		ssusb_set_vbus(otg_sx, 1);
> +		ssusb->is_host = true;
> +		break;
> +	case MTU3_ID_FLOAT:
> +		ssusb->is_host = false;
> +		ssusb_set_vbus(otg_sx, 0);
> +		switch_port_to_device(ssusb);
> +		break;
> +	case MTU3_VBUS_OFF:
> +		mtu3_stop(mtu);
> +		pm_relax(ssusb->dev);
> +		break;
> +	case MTU3_VBUS_VALID:
> +		/* avoid suspend when works as device */
> +		pm_stay_awake(ssusb->dev);
> +		mtu3_start(mtu);
> +		break;
> +	default:
> +		dev_err(ssusb->dev, "invalid state\n");
> +	}
> +}
> +
> +static int ssusb_id_notifier(struct notifier_block *nb,
> +	unsigned long event, void *ptr)
> +{
> +	struct otg_switch_mtk *otg_sx =
> +		container_of(nb, struct otg_switch_mtk, id_nb);
> +
> +	if (event)
> +		ssusb_set_mailbox(otg_sx, MTU3_ID_GROUND);
> +	else
> +		ssusb_set_mailbox(otg_sx, MTU3_ID_FLOAT);
> +
> +	return NOTIFY_DONE;
> +}
> +
> +static int ssusb_vbus_notifier(struct notifier_block *nb,
> +	unsigned long event, void *ptr)
> +{
> +	struct otg_switch_mtk *otg_sx =
> +		container_of(nb, struct otg_switch_mtk, vbus_nb);
> +
> +	if (event)
> +		ssusb_set_mailbox(otg_sx, MTU3_VBUS_VALID);
> +	else
> +		ssusb_set_mailbox(otg_sx, MTU3_VBUS_OFF);
> +
> +	return NOTIFY_DONE;
> +}
> +
> +static int ssusb_extcon_register(struct otg_switch_mtk *otg_sx)
> +{
> +	struct ssusb_mtk *ssusb =
> +		container_of(otg_sx, struct ssusb_mtk, otg_switch);
> +	struct extcon_dev *edev = otg_sx->edev;
> +	int ret;
> +
> +	/* extcon is optional */
> +	if (!edev)
> +		return 0;
> +
> +	otg_sx->vbus_nb.notifier_call = ssusb_vbus_notifier;
> +	ret = extcon_register_notifier(edev, EXTCON_USB,
> +					&otg_sx->vbus_nb);
> +	if (ret < 0)
> +		dev_err(ssusb->dev, "failed to register notifier for USB\n");
> +
> +	otg_sx->id_nb.notifier_call = ssusb_id_notifier;
> +	ret = extcon_register_notifier(edev, EXTCON_USB_HOST,
> +					&otg_sx->id_nb);
> +	if (ret < 0)
> +		dev_err(ssusb->dev, "failed to register notifier for USB-HOST\n");
> +
> +	dev_dbg(ssusb->dev, "EXTCON_USB: %d, EXTCON_USB_HOST: %d\n",
> +		extcon_get_cable_state_(edev, EXTCON_USB),
> +		extcon_get_cable_state_(edev, EXTCON_USB_HOST));
> +
> +	/* default as host, switch to device mode if needed */
> +	if (extcon_get_cable_state_(edev, EXTCON_USB_HOST) == false)
> +		ssusb_set_mailbox(otg_sx, MTU3_ID_FLOAT);
> +	if (extcon_get_cable_state_(edev, EXTCON_USB) == true)
> +		ssusb_set_mailbox(otg_sx, MTU3_VBUS_VALID);
> +
> +	return 0;
> +}
> +
> +static void extcon_register_dwork(struct work_struct *work)
> +{
> +	struct delayed_work *dwork = to_delayed_work(work);
> +	struct otg_switch_mtk *otg_sx =
> +	    container_of(dwork, struct otg_switch_mtk, extcon_reg_dwork);
> +
> +	ssusb_extcon_register(otg_sx);
> +}
> +
> +/*
> + * We provide an interface via debugfs to switch between host and device modes
> + * depending on user input.
> + * This is useful in special cases, such as uses TYPE-A receptacle but also
> + * wants to support dual-role mode.
> + * It generates cable state changes by pulling up/down IDPIN and
> + * notifies driver to switch mode by "extcon-usb-gpio".
> + * NOTE: when use MICRO receptacle, should not enable this interface.
> + */
> +static void ssusb_mode_manual_switch(struct ssusb_mtk *ssusb, int to_host)
> +{
> +	struct otg_switch_mtk *otg_sx = &ssusb->otg_switch;
> +
> +	if (to_host)
> +		pinctrl_select_state(otg_sx->id_pinctrl, otg_sx->id_ground);
> +	else
> +		pinctrl_select_state(otg_sx->id_pinctrl, otg_sx->id_float);
> +}
> +
> +
> +static int ssusb_mode_show(struct seq_file *sf, void *unused)
> +{
> +	struct ssusb_mtk *ssusb = sf->private;
> +
> +	seq_printf(sf, "current mode: %s(%s drd)\n(echo device/host)\n",
> +		ssusb->is_host ? "host" : "device",
> +		ssusb->otg_switch.manual_drd_enabled ? "manual" : "auto");
> +
> +	return 0;
> +}
> +
> +static int ssusb_mode_open(struct inode *inode, struct file *file)
> +{
> +	return single_open(file, ssusb_mode_show, inode->i_private);
> +}
> +
> +static ssize_t ssusb_mode_write(struct file *file,
> +	const char __user *ubuf, size_t count, loff_t *ppos)
> +{
> +	struct seq_file *sf = file->private_data;
> +	struct ssusb_mtk *ssusb = sf->private;
> +	char buf[16];
> +
> +	if (copy_from_user(&buf, ubuf, min_t(size_t, sizeof(buf) - 1, count)))
> +		return -EFAULT;
> +
> +	if (!strncmp(buf, "host", 4) && !ssusb->is_host)
> +		ssusb_mode_manual_switch(ssusb, 1);
> +	else if (!strncmp(buf, "device", 6) && ssusb->is_host)
> +		ssusb_mode_manual_switch(ssusb, 0);
> +	else
> +		dev_err(ssusb->dev, "wrong or duplicated setting\n");

No proper error returns

> +
> +	return count;
> +}
> +
> +static const struct file_operations ssusb_mode_fops = {
> +	.open = ssusb_mode_open,
> +	.write = ssusb_mode_write,
> +	.read = seq_read,
> +	.llseek = seq_lseek,
> +	.release = single_release,
> +};
> +
> +static void ssusb_debugfs_init(struct ssusb_mtk *ssusb)
> +{
> +	struct dentry *root;
> +	struct dentry *file;
> +
> +	root = debugfs_create_dir(dev_name(ssusb->dev), usb_debug_root);
> +	if (IS_ERR_OR_NULL(root)) {
> +		if (!root)
> +			dev_err(ssusb->dev, "create debugfs root failed\n");
> +		return;
> +	}
> +	ssusb->dbgfs_root = root;
> +
> +	file = debugfs_create_file("mode", S_IRUGO | S_IWUSR, root,
> +			ssusb, &ssusb_mode_fops);
> +	if (!file)
> +		dev_dbg(ssusb->dev, "create debugfs mode failed\n");
> +}
> +
> +static void ssusb_debugfs_exit(struct ssusb_mtk *ssusb)
> +{
> +	debugfs_remove_recursive(ssusb->dbgfs_root);
> +}
> +
> +int ssusb_otg_switch_init(struct ssusb_mtk *ssusb)
> +{
> +	struct otg_switch_mtk *otg_sx = &ssusb->otg_switch;
> +
> +	INIT_DELAYED_WORK(&otg_sx->extcon_reg_dwork, extcon_register_dwork);
> +
> +	if (otg_sx->manual_drd_enabled)
> +		ssusb_debugfs_init(ssusb);
> +
> +	/* It is enough to delay 1s for waiting for host initialization */
> +	schedule_delayed_work(&otg_sx->extcon_reg_dwork, HZ);

You need to handle this still pending when you are deregistered.

> +
> +	return 0;
> +}
> +
> +void ssusb_otg_switch_exit(struct ssusb_mtk *ssusb)
> +{
> +	struct otg_switch_mtk *otg_sx = &ssusb->otg_switch;
> +
> +	if (otg_sx->edev) {
> +		extcon_unregister_notifier(otg_sx->edev,
> +			EXTCON_USB, &otg_sx->vbus_nb);
> +		extcon_unregister_notifier(otg_sx->edev,
> +			EXTCON_USB_HOST, &otg_sx->id_nb);
> +	}
> +
> +	if (otg_sx->manual_drd_enabled)
> +		ssusb_debugfs_exit(ssusb);
> +}

Could you break this up a bit? It is extensively long a patch?

	Regards
		Oliver
