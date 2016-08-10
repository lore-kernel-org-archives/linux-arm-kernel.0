From: yt.shen@mediatek.com (YT Shen)
Date: Wed, 10 Aug 2016 15:24:26 +0800
Subject: [PATCH v6 07/10] drm/mediatek: add dsi transfer function
In-Reply-To: <1470391697.16554.60.camel@mtksdaap41>
References: <1470308844-20895-1-git-send-email-yt.shen@mediatek.com>
 <1470308844-20895-8-git-send-email-yt.shen@mediatek.com>
 <1470391697.16554.60.camel@mtksdaap41>
Message-ID: <1470813866.27526.14.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi CK,

On Fri, 2016-08-05 at 18:08 +0800, CK Hu wrote:
> Hi, YT:
> 
> On Thu, 2016-08-04 at 19:07 +0800, YT Shen wrote:
> > From: shaoming chen <shaoming.chen@mediatek.com>
> > 
> > add dsi read/write commands for transfer function
> > 
> > Signed-off-by: shaoming chen <shaoming.chen@mediatek.com>
> > ---
> >  drivers/gpu/drm/mediatek/mtk_dsi.c |  261 ++++++++++++++++++++++++++++++++++++
> >  1 file changed, 261 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
> > index eea6192..4541f59 100644
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
> > @@ -149,6 +175,13 @@ struct mtk_dsi {
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
> >  static wait_queue_head_t _dsi_irq_wait_queue;
> >  
> >  static inline struct mtk_dsi *encoder_to_dsi(struct drm_encoder *e)
> > @@ -799,9 +832,237 @@ static int mtk_dsi_host_detach(struct mipi_dsi_host *host,
> >  	return 0;
> >  }
> >  
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
> > +	dsi->irq_data &= ~CMD_DONE_INT_FLAG;
> 
> You should move this clearing of flag before mtk_dsi_start().
OK, we will update it in the next version.

> 
> > +
> > +	ret = wait_event_interruptible_timeout(_dsi_irq_wait_queue,
> > +			dsi->irq_data & CMD_DONE_INT_FLAG, timeout);
> > +	if (ret == 0) {
> > +		dev_info(dsi->dev, "dsi wait engine cmd done fail\n");
> > +
> > +		mtk_dsi_enable(dsi);
> > +		mtk_dsi_reset_engine(dsi);
> > +	}
> > +}
> > +
> > +static void mtk_dsi_cmdq(struct mtk_dsi *dsi, const struct mipi_dsi_msg *msg)
> > +{
> > +	const char *tx_buf = msg->tx_buf;
> > +	u32 reg_val, i;
> > +	u16 wc16;
> > +	u8 config, data0, data1, type;
> > +
> > +	if (MTK_DSI_HOST_IS_READ(type)) {
> 
> 'type' is used before assigned.
Will fix.

> 
> > +		config = 4;
> > +		data0 = tx_buf[0];
> > +
> > +		if (msg->rx_len < 3)
> > +			type = MIPI_DSI_DCS_READ;
> > +		else
> > +			type = MIPI_DSI_GENERIC_READ_REQUEST_1_PARAM;
> > +
> > +		data1 = 0;
> > +		reg_val = (data1 << 24) | (data0 << 16) | (type << 8) | config;
> > +
> > +		writel(reg_val, dsi->regs + DSI_CMDQ0);
> > +		mtk_dsi_mask(dsi, DSI_CMDQ_SIZE, CMDQ_SIZE, 1);
> 
> I think this part looks like 'else' part. The difference is type and
> config. I think type should be msg->type and you can independently set
> BIT(2) of config.
msg->type only tells about read or write, for the details we need to
check other parameters.  This part is for read, the else part is for
write short packet.  Not only BIT(2) of config is different, but also
type and data1 is changed.  Such a change would lead to difficult to
understand.

> 
> > +	} else if (msg->tx_len > 2) {	/* send long packet */
> > +		config = 2;
> > +		type = msg->type;
> > +		wc16 = msg->tx_len;
> > +
> > +		reg_val = (wc16 << 16) | (type << 8) | config;
> > +
> > +		writel(reg_val, dsi->regs + DSI_CMDQ0);
> > +
> > +		for (i = 0; i < msg->tx_len; i++)
> > +			writeb(tx_buf[i], dsi->regs + DSI_CMDQ0 + 4 + i);
> > +
> > +		mtk_dsi_mask(dsi, DSI_CMDQ_SIZE, CMDQ_SIZE,
> > +			     1 + (msg->tx_len + 3) / 4);
> > +	} else {	/* send short packet */
> > +		config = 0;
> > +		data0 = tx_buf[0];
> > +
> > +		if (msg->tx_len == 2) {
> > +			type = MIPI_DSI_DCS_SHORT_WRITE_PARAM;
> 
> Why do you not set type as msg->type? This behavior looks like you
> modify transfer type, but is this acceptable?
msg->type only tells about read or write, for the details we need to
check other parameters.

> 
> > +			data1 = tx_buf[1];
> > +		} else {
> > +			type = MIPI_DSI_DCS_SHORT_WRITE;
> > +			data1 = 0;
> > +		}
> > +
> > +		reg_val = (data1 << 24) | (data0 << 16) | (type << 8) | config;
> > +
> > +		writel(reg_val, dsi->regs + DSI_CMDQ0);
> > +		mtk_dsi_mask(dsi, DSI_CMDQ_SIZE, CMDQ_SIZE, 1);
> > +	}
> > +}
> > +
> > +static ssize_t mtk_dsi_host_read_cmd(struct mtk_dsi *dsi,
> > +				     const struct mipi_dsi_msg *msg)
> > +{
> > +	u8 max_try_count = 5;
> > +	u32 recv_cnt;
> > +	struct dsi_rxtx_data read_data[4];
> > +	s32 ret;
> > +	unsigned long timeout = msecs_to_jiffies(2000);
> > +
> > +	u8 *buffer = msg->rx_buf;
> > +	u8 buffer_size = msg->rx_len;
> > +	u8 type;
> > +
> > +	if (readl(dsi->regs + DSI_MODE_CTRL) & MODE) {
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
> > +		mtk_dsi_cmdq(dsi, msg);
> > +
> > +		dsi->irq_data &= ~LPRX_RD_RDY_INT_FLAG;
> > +
> > +		mtk_dsi_start(dsi);
> > +
> > +		/* 2s timeout*/
> > +		ret = wait_event_interruptible_timeout(_dsi_irq_wait_queue,
> > +				dsi->irq_data & LPRX_RD_RDY_INT_FLAG, timeout);
> > +		if (ret == 0) {
> > +			dev_info(dsi->dev, "Wait DSI read ready timeout!!!\n");
> > +
> > +			mtk_dsi_enable(dsi);
> > +			mtk_dsi_reset_engine(dsi);
> > +
> > +			return ret;
> > +		}
> 
> This waiting code looks like mtk_dsi_wait_for_cmd_done(). You may modify
> this function to
> 
> int mtk_dsi_wait_for_irq_flag(struct mtk_dsi *dsi, u32 flag, unsigned
> long timeout);
OK, will do.
> 
> > +
> > +		*(u32 *)(&read_data[0]) = readl(dsi->regs + DSI_RX_DATA0);
> > +		*(u32 *)(&read_data[1]) = readl(dsi->regs + DSI_RX_DATA1);
> > +		*(u32 *)(&read_data[2]) = readl(dsi->regs + DSI_RX_DATA2);
> > +		*(u32 *)(&read_data[3]) = readl(dsi->regs + DSI_RX_DATA3);
> 
> You may rewrite this as
> 
> for (i = 0; i < 16; i++)
> 	*((u8 *)read_data + i) = readb(dsi->regs + DSI_RX_DATA0 + i);
> 
OK.

> > +
> > +		type = read_data[0].byte0;
> > +
> > +		if (type == MIPI_DSI_RX_GENERIC_LONG_READ_RESPONSE ||
> > +		    type == MIPI_DSI_RX_DCS_LONG_READ_RESPONSE) {
> > +			/*
> > +			 * Data ID(1 byte) + Word Count(2 bytes) + ECC(1 byte) +
> > +			 * data 0 + ...+ data WC-1 + CHECKSUM (2 bytes)
> > +			 */
> > +			recv_cnt = read_data[0].byte1 + read_data[0].byte2 * 16;
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
> > +			memcpy(buffer, &read_data[1], recv_cnt);
> > +		} else if (type == MIPI_DSI_RX_GENERIC_SHORT_READ_RESPONSE_1BYTE ||
> > +			   type == MIPI_DSI_RX_GENERIC_SHORT_READ_RESPONSE_2BYTE ||
> > +			   type == MIPI_DSI_RX_DCS_SHORT_READ_RESPONSE_1BYTE ||
> > +			   type == MIPI_DSI_RX_DCS_SHORT_READ_RESPONSE_2BYTE) {
> > +			if (type == MIPI_DSI_RX_GENERIC_SHORT_READ_RESPONSE_1BYTE ||
> > +			    type == MIPI_DSI_RX_DCS_SHORT_READ_RESPONSE_1BYTE)
> > +				recv_cnt = 1;
> > +			else
> > +				recv_cnt = 2;
> > +
> > +			if (recv_cnt > buffer_size)
> > +				recv_cnt = buffer_size;
> > +
> > +			memcpy(buffer, &read_data[0].byte1, recv_cnt);
> 
> I think you may rewrite this 'if-else if' part as follow to make things
> more clearly.
> 
> static u32 get_recv_cnt(u8 type, struct dsi_rxtx_data *read_data)
> {
> 	switch(type) {
> 	case MIPI_DSI_RX_GENERIC_SHORT_READ_RESPONSE_1BYTE:
> 	case MIPI_DSI_RX_DCS_SHORT_READ_RESPONSE_1BYTE:
> 		return 1;
> 	case MIPI_DSI_RX_GENERIC_SHORT_READ_RESPONSE_2BYTE:
> 	case MIPI_DSI_RX_DCS_SHORT_READ_RESPONSE_2BYTE:
> 		return 2;
> 	case MIPI_DSI_RX_GENERIC_LONG_READ_RESPONSE:
> 	case MIPI_DSI_RX_DCS_LONG_READ_RESPONSE:
> 		return read_data->byte1 + read_data->byte2 * 16;
> 	}
> 
> 	return 0;
> }
> 
> recv_cnt = get_recv_cnt(type, read_data);
> 
> if (recv_cnt > 2)
> 	src_addr = &read_data[1];
> else
> 	src_addr = &read_data[0].byte1;
> 
> if (recv_cnt > 10)
> 	recv_cnt = 10;
> if (recv_cnt > buffer_size)
> 	recv_cnt = buffer_size;
> if (recv_cnt)
> 	memcpy(buffer, src_addr, recv_cnt);
> 
Thanks for the suggestions, we will follow it.

Regards,
yt.shen

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
> > +	mtk_dsi_wait_for_idle(dsi);
> > +
> > +	mtk_dsi_cmdq(dsi, msg);
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
