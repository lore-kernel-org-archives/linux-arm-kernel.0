From: yt.shen@mediatek.com (YT Shen)
Date: Tue, 2 Aug 2016 17:14:48 +0800
Subject: [PATCH v5 07/10] drm/mediatek: add dsi transfer function
In-Reply-To: <1470120958.16554.16.camel@mtksdaap41>
References: <1469698084-20185-1-git-send-email-yt.shen@mediatek.com>
 <1469698084-20185-8-git-send-email-yt.shen@mediatek.com>
 <1470120958.16554.16.camel@mtksdaap41>
Message-ID: <1470129288.30671.13.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi CK,

On Tue, 2016-08-02 at 14:55 +0800, CK Hu wrote:
> Hi, YT:
> 
> On Thu, 2016-07-28 at 17:28 +0800, YT Shen wrote:
> > From: shaoming chen <shaoming.chen@mediatek.com>
> > 
> > add dsi read/write commands for transfer function
> > 
> > Signed-off-by: shaoming chen <shaoming.chen@mediatek.com>
> > ---
> >  drivers/gpu/drm/mediatek/mtk_dsi.c |  286 ++++++++++++++++++++++++++++++++++++
> >  1 file changed, 286 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
> > index 553443a..1d36524 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> > @@ -24,6 +24,7 @@
> >  #include <linux/of_graph.h>
> >  #include <linux/phy/phy.h>
> >  #include <linux/platform_device.h>
> > +#include <video/mipi_display.h>
> >  #include <video/videomode.h>
> >  
> >  #include "mtk_drm_ddp_comp.h"
> > @@ -81,8 +82,16 @@
> >  #define DSI_HBP_WC		0x54
> >  #define DSI_HFP_WC		0x58
> >  
> > +#define DSI_CMDQ_SIZE		0x60
> > +#define CMDQ_SIZE		0x3f
> > +
> >  #define DSI_HSTX_CKL_WC		0x64
> >  
> > +#define DSI_RX_DATA0		0x74
> > +#define DSI_RX_DATA1		0x78
> > +#define DSI_RX_DATA2		0x7c
> > +#define DSI_RX_DATA3		0x80
> > +
> >  #define DSI_RACK		0x84
> >  #define RACK				BIT(0)
> >  
> > @@ -118,8 +127,25 @@
> >  #define CLK_HS_POST			(0xff << 8)
> >  #define CLK_HS_EXIT			(0xff << 16)
> >  
> > +#define DSI_CMDQ0		0x180
> > +
> >  #define NS_TO_CYCLE(n, c)    ((n) / (c) + (((n) % (c)) ? 1 : 0))
> >  
> > +#define MTK_DSI_HOST_IS_READ(type) \
> > +	((type == MIPI_DSI_GENERIC_READ_REQUEST_0_PARAM) || \
> > +	(type == MIPI_DSI_GENERIC_READ_REQUEST_1_PARAM) || \
> > +	(type == MIPI_DSI_GENERIC_READ_REQUEST_2_PARAM) || \
> > +	(type == MIPI_DSI_DCS_READ))
> > +
> > +#define MTK_DSI_HOST_IS_WRITE(type) \
> > +	((type == MIPI_DSI_GENERIC_SHORT_WRITE_0_PARAM) || \
> > +	(type == MIPI_DSI_GENERIC_SHORT_WRITE_1_PARAM) || \
> > +	(type == MIPI_DSI_GENERIC_SHORT_WRITE_2_PARAM) || \
> > +	(type == MIPI_DSI_DCS_SHORT_WRITE) || \
> > +	(type == MIPI_DSI_DCS_SHORT_WRITE_PARAM) || \
> > +	(type == MIPI_DSI_GENERIC_LONG_WRITE) || \
> > +	(type == MIPI_DSI_DCS_LONG_WRITE))
> > +
> >  struct phy;
> >  
> >  struct mtk_dsi {
> > @@ -149,6 +175,17 @@ struct mtk_dsi {
> >  	int irq_data;
> >  };
> >  
> > +struct dsi_rxtx_data {
> > +	u8 byte0;
> > +	u8 byte1;
> > +	u8 byte2;
> > +	u8 byte3;
> > +};
> > +
> > +struct dsi_tx_cmdq_regs {
> > +	struct dsi_rxtx_data data[128];
> > +};
> > +
> >  static wait_queue_head_t _dsi_cmd_done_wait_queue;
> >  static wait_queue_head_t _dsi_dcs_read_wait_queue;
> >  static wait_queue_head_t _dsi_wait_vm_done_queue;
> > @@ -813,9 +850,258 @@ static int mtk_dsi_host_detach(struct mipi_dsi_host *host,
> >  	return 0;
> >  }
> >  
> > +static void mtk_dsi_set_cmdq(void __iomem *reg, u32 mask, u32 data)
> > +{
> > +	u32 temp = readl(reg);
> > +
> > +	writel((temp & ~mask) | (data & mask), reg);
> > +}
> > +
> > +static void mtk_dsi_wait_for_idle(struct mtk_dsi *dsi)
> > +{
> > +	u32 timeout_ms = 500000; /* total 1s ~ 2s timeout */
> > +
> > +	while (timeout_ms--) {
> > +		if (!(readl(dsi->regs + DSI_INTSTA) & DSI_BUSY))
> > +			break;
> > +
> > +		usleep_range(2, 4);
> > +	}
> > +
> > +	if (timeout_ms == 0) {
> > +		dev_info(dsi->dev, "polling dsi wait not busy timeout!\n");
> > +
> > +		mtk_dsi_enable(dsi);
> > +		mtk_dsi_reset_engine(dsi);
> > +	}
> > +}
> > +
> > +static void mtk_dsi_wait_for_cmd_done(struct mtk_dsi *dsi)
> > +{
> > +	s32 ret = 0;
> > +	unsigned long timeout = msecs_to_jiffies(500);
> > +
> > +	ret = wait_event_interruptible_timeout(_dsi_cmd_done_wait_queue,
> > +			dsi->irq_data & CMD_DONE_INT_FLAG, timeout);
> > +	if (ret == 0) {
> > +		dev_info(dsi->dev, "dsi wait engine cmd done fail\n");
> > +		mtk_dsi_enable(dsi);
> > +		mtk_dsi_reset_engine(dsi);
> > +		return;
> > +	}
> > +
> > +	dsi->irq_data &= ~CMD_DONE_INT_FLAG;
> 
> I think you should move this before trigger HW. Sometimes this interrupt
> is coming and this flag is set but you do not wait this event and do not
> clear it. Then when you want to wait, the flag is already set by long
> time ago interrupt.
OK, we will fix it.

> 
> > +}
> > +
> > +static ssize_t mtk_dsi_host_read_cmd(struct mtk_dsi *dsi,
> > +				     const struct mipi_dsi_msg *msg)
> > +{
> > +	u8 max_try_count = 5;
> > +	u32 recv_cnt, tmp_val;
> > +	struct dsi_rxtx_data read_data0, read_data1, read_data2, read_data3;
> > +	u8 config, type, data0, data1;
> > +	s32 ret;
> > +
> > +	u8 *buffer = msg->rx_buf;
> > +	u8 buffer_size = msg->rx_len;
> > +
> > +	if (readl(dsi->regs + DSI_MODE_CTRL) & 0x03) {
> > +		dev_info(dsi->dev, "dsi engine is not command mode\n");
> > +		return -1;
> > +	}
> > +
> > +	if (!buffer) {
> > +		dev_info(dsi->dev, "dsi receive buffer size may be NULL\n");
> > +		return -1;
> > +	}
> > +
> > +	do {
> > +		if (max_try_count == 0) {
> > +			dev_info(dsi->dev, "dsi engine read counter has been maxinum\n");
> > +			return -1;
> > +		}
> > +
> > +		max_try_count--;
> > +		recv_cnt = 0;
> > +
> > +		mtk_dsi_wait_for_idle(dsi);
> > +
> > +		config = 0x04;
> > +		data0 = *((u8 *)(msg->tx_buf));
> > +
> > +		if (buffer_size < 3)
> > +			type = MIPI_DSI_DCS_READ;
> > +		else
> > +			type = MIPI_DSI_GENERIC_READ_REQUEST_1_PARAM;
> > +
> > +		data1 = 0;
> > +
> > +		tmp_val = (data1 << 24) | (data0 << 16) | (type << 8) | config;
> > +
> > +		writel(tmp_val, dsi->regs + DSI_CMDQ0);
> > +		mtk_dsi_mask(dsi, DSI_CMDQ_SIZE, CMDQ_SIZE, 1);
> > +
> > +		mtk_dsi_start(dsi);
> 
> This part looks like the same as mtk_dsi_host_write_cmd() with
> msg->tx_len = 1. Maybe you can try to merge these two part.
Will do.

> 
> > +
> > +		/* 2s timeout*/
> > +		ret = wait_event_interruptible_timeout(_dsi_dcs_read_wait_queue,
> > +				dsi->irq_data & LPRX_RD_RDY_INT_FLAG, timeout);
> > +		if (ret == 0) {
> > +			dev_info(dsi->dev, "Wait DSI read ready timeout!!!\n");
> > +
> > +			mtk_dsi_enable(dsi);
> > +			mtk_dsi_reset_engine(dsi);
> > +
> > +			return ret;
> > +		}
> > +
> > +		dsi->irq_data &= ~LPRX_RD_RDY_INT_FLAG;
> 
> I think you should move this before trigger HW. Sometimes this interrupt
> is coming and this flag is set but you do not wait this event and do not
> clear it. Then when you want to wait, the flag is already set by long
> time ago interrupt.
Will do.

> 
> > +
> > +		*(u32 *)(&read_data0) = readl(dsi->regs + DSI_RX_DATA0);
> > +		*(u32 *)(&read_data1) = readl(dsi->regs + DSI_RX_DATA1);
> > +		*(u32 *)(&read_data2) = readl(dsi->regs + DSI_RX_DATA2);
> > +		*(u32 *)(&read_data3) = readl(dsi->regs + DSI_RX_DATA3);
> > +
> > +		type = read_data0.byte0;
> > +
> > +		if (type == MIPI_DSI_RX_GENERIC_LONG_READ_RESPONSE ||
> > +		    type == MIPI_DSI_RX_DCS_LONG_READ_RESPONSE) {
> > +
> > +			/*
> > +			 * Data ID(1 byte) + Word Count(2 bytes) + ECC(1 byte) +
> > +			 * data 0 + ...+ data WC-1 + CHECKSUM (2 bytes)
> 
> Is CHECKSUM useless? Why not check it?
We will check this.

> 
> > +			 */
> > +			recv_cnt = read_data0.byte1 + read_data0.byte2 * 16;
> > +			dev_info(dsi->dev, "long packet size: %d\n", recv_cnt);
> > +
> > +			/*
> > +			 * the buffer size is 16 bytes once, so the data payload
> > +			 * is, 16 - bytes(data ID + WC + ECC + CHECKSUM), if
> > +			 * over 10 bytes, it will be read again
> > +			 */
> > +			if (recv_cnt > 10)
> > +				recv_cnt = 10;
> > +
> > +			if (recv_cnt > buffer_size)
> > +				recv_cnt = buffer_size;
> > +
> > +			if (recv_cnt <= 4) {
> > +				memcpy(buffer, &read_data1, recv_cnt);
> > +			} else if (recv_cnt <= 8) {
> > +				memcpy(buffer, &read_data1, 4);
> > +				memcpy(buffer + 4, &read_data2, recv_cnt - 4);
> > +			} else {
> > +				memcpy(buffer, &read_data1, 4);
> > +				memcpy(buffer + 4, &read_data2, 4);
> > +				memcpy(buffer + 8, &read_data3, recv_cnt - 8);
> > +			}
> 
> I think you can ignore read_data1, read_data2, and read_data3. Using a
> 'for loop' and readb() here can directly read register data into buffer.
We will rewrite this part.

> 
> 
> > +		} else if (type == MIPI_DSI_RX_GENERIC_SHORT_READ_RESPONSE_1BYTE ||
> > +			   type == MIPI_DSI_RX_GENERIC_SHORT_READ_RESPONSE_2BYTE ||
> > +			   type == MIPI_DSI_RX_DCS_SHORT_READ_RESPONSE_1BYTE ||
> > +			   type == MIPI_DSI_RX_DCS_SHORT_READ_RESPONSE_2BYTE) {
> > +
> > +			if (type == MIPI_DSI_RX_GENERIC_SHORT_READ_RESPONSE_1BYTE ||
> > +			    type == MIPI_DSI_RX_DCS_SHORT_READ_RESPONSE_1BYTE)
> > +				recv_cnt = 1;
> > +			else
> > +				recv_cnt = 2;
> > +
> > +			if (recv_cnt > buffer_size)
> > +				recv_cnt = buffer_size;
> > +
> > +			memcpy(buffer, &read_data0.byte1, recv_cnt);
> > +		} else if (type == MIPI_DSI_RX_ACKNOWLEDGE_AND_ERROR_REPORT) {
> > +			dev_info(dsi->dev, "packet type is 0x02, try again\n");
> > +		} else {
> > +			dev_info(dsi->dev, "packet type(0x%x) cannot be non-recognize\n",
> > +				 type);
> > +
> > +			return 0;
> > +		}
> > +	} while (type == MIPI_DSI_RX_ACKNOWLEDGE_AND_ERROR_REPORT);
> > +
> > +	dev_info(dsi->dev, "dsi get %d byte data from the panel address(0x%x)\n",
> > +		 recv_cnt, *((u8 *)(msg->tx_buf)));
> > +
> > +	return recv_cnt;
> > +}
> > +
> > +static ssize_t mtk_dsi_host_write_cmd(struct mtk_dsi *dsi,
> > +				      const struct mipi_dsi_msg *msg)
> > +{
> > +	u32 i;
> > +	u32 goto_addr, mask_para, set_para, reg_val;
> > +	void __iomem *cmdq_reg;
> > +	u8 config, type, data0, data1;
> > +	u16 wc16;
> > +	const char *tx_buf = msg->tx_buf;
> > +	struct dsi_tx_cmdq_regs *dsi_cmd_reg;
> > +
> > +	dsi_cmd_reg = (struct dsi_tx_cmdq_regs *)(dsi->regs + DSI_CMDQ0);
> > +
> > +	mtk_dsi_wait_for_idle(dsi);
> > +
> > +	if (msg->tx_len > 2) {
> > +		config = 2;
> > +		type = msg->type;
> > +		wc16 = msg->tx_len;
> > +
> > +		reg_val = (wc16 << 16) | (type << 8) | config;
> > +
> > +		writel(reg_val, &dsi_cmd_reg->data[0]);
> > +
> > +		for (i = 0; i < msg->tx_len; i++) {
> > +			goto_addr = (u32)(&dsi_cmd_reg->data[1].byte0) + i;
> > +			mask_para = (0xff << ((goto_addr & 0x3) * 8));
> > +			set_para = (tx_buf[i] << ((goto_addr & 0x3) * 8));
> > +			cmdq_reg = (void __iomem *)(goto_addr & (~0x3));
> > +			mtk_dsi_set_cmdq(cmdq_reg, mask_para, set_para);
> > +		}
> 
> Because you use writel(), so this part look so complicated. If you use
> writeb(), this would be much simpler.
OK, we will use writeb() in the next version.

Regards,
yt.shen

> 
> > +
> > +		mtk_dsi_mask(dsi, DSI_CMDQ_SIZE, CMDQ_SIZE,
> > +			     1 + (msg->tx_len + 3) / 4);
> > +	} else {
> > +		config = 0;
> > +		data0 = tx_buf[0];
> > +		if (msg->tx_len == 2) {
> > +			type = MIPI_DSI_DCS_SHORT_WRITE_PARAM;
> > +			data1 = tx_buf[1];
> > +		} else {
> > +			type = MIPI_DSI_DCS_SHORT_WRITE;
> > +			data1 = 0;
> > +		}
> > +
> > +		reg_val = (data1 << 24) | (data0 << 16) | (type << 8) | config;
> > +
> > +		writel(reg_val, &dsi_cmd_reg->data[0]);
> > +		mtk_dsi_mask(dsi, DSI_CMDQ_SIZE, CMDQ_SIZE, 1);
> > +	}
> > +
> > +	mtk_dsi_start(dsi);
> > +	mtk_dsi_wait_for_cmd_done(dsi);
> > +
> > +	return 0;
> > +}
> > +
> > +static ssize_t mtk_dsi_host_transfer(struct mipi_dsi_host *host,
> > +				     const struct mipi_dsi_msg *msg)
> > +{
> > +	struct mtk_dsi *dsi = host_to_dsi(host);
> > +	u8 type = msg->type;
> > +	ssize_t ret = 0;
> > +
> > +	if (MTK_DSI_HOST_IS_READ(type))
> > +		ret = mtk_dsi_host_read_cmd(dsi, msg);
> > +	else if (MTK_DSI_HOST_IS_WRITE(type))
> > +		ret = mtk_dsi_host_write_cmd(dsi, msg);
> > +
> > +	return ret;
> > +}
> > +
> >  static const struct mipi_dsi_host_ops mtk_dsi_ops = {
> >  	.attach = mtk_dsi_host_attach,
> >  	.detach = mtk_dsi_host_detach,
> > +	.transfer = mtk_dsi_host_transfer,
> >  };
> >  
> >  static int mtk_dsi_bind(struct device *dev, struct device *master, void *data)
> 
> Regards,
> CK
> 
