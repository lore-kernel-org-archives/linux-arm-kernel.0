From: yt.shen@mediatek.com (YT Shen)
Date: Tue, 26 Jul 2016 18:42:36 +0800
Subject: [PATCH v4 6/8] drm/mediatek: add dsi transfer function
In-Reply-To: <1468994346.11841.31.camel@mtksdaap41>
References: <1468577274-6178-1-git-send-email-yt.shen@mediatek.com>
 <1468577274-6178-7-git-send-email-yt.shen@mediatek.com>
 <1468994346.11841.31.camel@mtksdaap41>
Message-ID: <1469529756.4678.30.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi CK,

Thanks for the review.

On Wed, 2016-07-20 at 13:59 +0800, CK Hu wrote:
> Hi, YT:
> 
> Some comments inline.
> 
> On Fri, 2016-07-15 at 18:07 +0800, YT Shen wrote:
> > From: shaoming chen <shaoming.chen@mediatek.com>
> > 
> > add dsi read/write commands for transfer function
> > 
> > Signed-off-by: shaoming chen <shaoming.chen@mediatek.com>
> > ---
> >  drivers/gpu/drm/mediatek/mtk_dsi.c |  322 ++++++++++++++++++++++++++++++++++++
> >  1 file changed, 322 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
> > index de5ad7f..1f99894 100644
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
> > @@ -80,8 +81,16 @@
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
> >  #define RACK			BIT(0)
> >  
> > @@ -117,8 +126,25 @@
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
> > @@ -148,6 +174,38 @@ struct mtk_dsi {
> >  	int irq_num, irq_data;
> >  };
> >  
> > +struct dsi_cmd_t0 {
> > +	u8 config;
> > +	u8 type;
> > +	u8 data0;
> > +	u8 data1;
> > +};
> > +
> > +struct dsi_cmd_t2 {
> > +	u8 config;
> > +	u8 type;
> > +	u16 wc16;
> > +	u8 *pdata;
> > +};
> > +
> > +struct dsi_rx_data {
> > +	u8 byte0;
> > +	u8 byte1;
> > +	u8 byte2;
> > +	u8 byte3;
> > +};
> > +
> > +struct dsi_tx_cmdq {
> > +	u8 byte0;
> > +	u8 byte1;
> > +	u8 byte2;
> > +	u8 byte3;
> > +};
> > +
> > +struct dsi_tx_cmdq_regs {
> > +	struct dsi_tx_cmdq data[128];
> > +};
> > +
> >  enum {
> >  	DSI_INT_SLEEPOUT_DONE_FLAG	= BIT(6),
> >  	DSI_INT_VM_CMD_DONE_FLAG	= BIT(5),
> > @@ -858,9 +916,273 @@ static int mtk_dsi_host_detach(struct mipi_dsi_host *host,
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
> > +static ssize_t mtk_dsi_host_read_cmd(struct mtk_dsi *dsi,
> > +				     const struct mipi_dsi_msg *msg)
> > +{
> > +	u8 max_try_count = 5;
> > +	u32 recv_data_cnt, tmp_val;
> > +	u32 recv_data0, recv_data1, recv_data2, recv_data3;
> > +	struct dsi_rx_data read_data0, read_data1, read_data2, read_data3;
> > +	struct dsi_cmd_t0 t0;
> > +	s32 ret;
> > +
> > +	u8 *buffer = msg->rx_buf;
> > +	u8 buffer_size = msg->rx_len;
> > +	u8 packet_type;
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
> > +		recv_data_cnt = 0;
> > +
> > +		mtk_dsi_wait_for_idle(dsi);
> > +
> > +		t0.config = 0x04;
> > +		t0.data0 = *((u8 *)(msg->tx_buf));
> > +
> > +		if (buffer_size < 0x3)
> 
> It's better to use '3' instead of '0x3'.
OK.

> 
> > +			t0.type = MIPI_DSI_DCS_READ;
> > +		else
> > +			t0.type = MIPI_DSI_GENERIC_READ_REQUEST_1_PARAM;
> > +
> > +		t0.data1 = 0;
> > +
> > +		tmp_val = (t0.data1 << 24) | (t0.data0 << 16) | (t0.type << 8) |
> > +			t0.config;
> 
> Why need 'struct dsi_cmd_t0 t0'? I think code is more simple when get
> rid of this structure. The code looks like:
> 
> tmp_val = (data1 << 24) | (data0 << 16) | (type << 8) | config;
We will check this part.

> 
> > +
> > +		writel(tmp_val, dsi->regs + DSI_CMDQ0);
> > +		mtk_dsi_mask(dsi, DSI_CMDQ_SIZE, CMDQ_SIZE, 1);
> > +
> > +		mtk_dsi_mask(dsi, DSI_RACK, RACK, RACK);
> > +		mtk_dsi_mask(dsi, DSI_INTSTA, LPRX_RD_RDY_INT_FLAG,
> > +			     ~LPRX_RD_RDY_INT_FLAG);
> > +		mtk_dsi_mask(dsi, DSI_INTSTA, CMD_DONE_INT_FLAG,
> > +			     ~CMD_DONE_INT_FLAG);
> 
> I think interrupt status should be cleared in irq handler. So you need
> not to clear it here.
will remove.

> 
> > +		mtk_dsi_mask(dsi, DSI_INTEN, DSI_INT_LPRX_RD_RDY_FLAG,
> > +			     DSI_INT_LPRX_RD_RDY_FLAG);
> > +		mtk_dsi_mask(dsi, DSI_INTEN, DSI_INT_CMD_DONE_FLAG,
> > +			     DSI_INT_CMD_DONE_FLAG);
> 
> Why enable cmd_done interrupt? You just need interrupt of LPRX_RD_RDY.
will remove.

> 
> > +
> > +		mtk_dsi_start(dsi);
> > +
> > +		dev_info(dsi->dev, "Start polling DSI read ready!!!\n");
> > +
> > +		 /* 2s timeout*/
> > +		ret = mtk_dsi_wait_for_irq_timeout(dsi,
> > +						   DSI_INT_LPRX_RD_RDY_FLAG,
> > +						   2000);
> > +		if (ret) {
> > +			dev_info(dsi->dev, "Polling DSI read ready timeout!!!\n");
> > +
> > +			mtk_dsi_enable(dsi);
> > +			mtk_dsi_reset_engine(dsi);
> > +
> > +			return ret;
> > +		}
> > +
> > +		dev_info(dsi->dev, "End polling DSI read ready!!!\n");
> > +
> > +		mtk_dsi_mask(dsi, DSI_RACK, RACK, RACK);
> > +		mtk_dsi_mask(dsi, DSI_INTSTA, LPRX_RD_RDY_INT_FLAG,
> > +			     ~LPRX_RD_RDY_INT_FLAG);
> > +
> > +		recv_data0 = readl(dsi->regs + DSI_RX_DATA0);
> > +		recv_data1 = readl(dsi->regs + DSI_RX_DATA1);
> > +		recv_data2 = readl(dsi->regs + DSI_RX_DATA2);
> > +		recv_data3 = readl(dsi->regs + DSI_RX_DATA3);
> > +
> > +		read_data0 = *((struct dsi_rx_data *)(&recv_data0));
> > +		read_data1 = *((struct dsi_rx_data *)(&recv_data1));
> > +		read_data2 = *((struct dsi_rx_data *)(&recv_data2));
> > +		read_data3 = *((struct dsi_rx_data *)(&recv_data3));
> 
> You only use read_data0. read_data1, read_data2, and read_data3 are just
> for debug. Remove the debug only modification if they are not necessary.
> Or move them to another patch to make this patch clear.
We will remove the debug messages here.

> 
> > +
> > +		ret = readl(dsi->regs + DSI_CMDQ_SIZE);
> > +		dev_info(dsi->dev, "DSI_CMDQ_SIZE : 0x%x\n", ret & CMDQ_SIZE);
> > +
> > +		ret = readl(dsi->regs + DSI_CMDQ0);
> > +		dev_info(dsi->dev, "DSI_CMDQ_DATA0 : 0x%x\n",
> > +			 ret & 0xff);
> > +		dev_info(dsi->dev, "DSI_CMDQ_DATA1 : 0x%x\n",
> > +			 (ret >> 8) & 0xff);
> > +		dev_info(dsi->dev, "DSI_CMDQ_DATA2 : 0x%x\n",
> > +			 (ret >> 16) & 0xff);
> > +		dev_info(dsi->dev, "DSI_CMDQ_DATA3 : 0x%x\n",
> > +			 (ret >> 24) & 0xff);
> > +
> > +		dev_info(dsi->dev, "DSI_RX_DATA0: 0x%x\n", recv_data0);
> > +		dev_info(dsi->dev, "DSI_RX_DATA1: 0x%x\n", recv_data1);
> > +		dev_info(dsi->dev, "DSI_RX_DATA2: 0x%x\n", recv_data2);
> > +		dev_info(dsi->dev, "DSI_RX_DATA3: 0x%x\n", recv_data3);
> > +
> > +		dev_info(dsi->dev, "read_data0: %x,%x,%x,%x\n",
> > +			 read_data0.byte0, read_data0.byte1, read_data0.byte2,
> > +			 read_data0.byte3);
> > +		dev_info(dsi->dev, "read_data1: %x,%x,%x,%x\n",
> > +			 read_data1.byte0, read_data1.byte1, read_data1.byte2,
> > +			 read_data1.byte3);
> > +		dev_info(dsi->dev, "read_data2: %x,%x,%x,%x\n",
> > +			 read_data2.byte0, read_data2.byte1, read_data2.byte2,
> > +			 read_data2.byte3);
> > +		dev_info(dsi->dev, "read_data3: %x,%x,%x,%x\n",
> > +			 read_data3.byte0, read_data3.byte1, read_data3.byte2,
> > +			 read_data3.byte3);
> > +
> > +		packet_type = read_data0.byte0;
> > +		dev_info(dsi->dev, "DSI read packet_type is 0x%x\n",
> > +			 packet_type);
> > +
> > +		if (packet_type == 0x1a || packet_type == 0x1c) {
> > +			void *read_tmp = (void *)&recv_data1;
> > +
> > +			recv_data_cnt = read_data0.byte1 +
> > +					read_data0.byte2 * 16;
> > +			if (recv_data_cnt > 10)
> > +				recv_data_cnt = 10;
> 
> Why do you drop data over size of 10? Isn't it an error?
We will update these codes in the next version.

> 
> > +
> > +			if (recv_data_cnt > buffer_size)
> > +				recv_data_cnt = buffer_size;
> 
> Isn't it an error while you drop data over the buffer size?
We will update these codes in the next version.

> 
> > +
> > +			memcpy(buffer, read_tmp, recv_data_cnt);
> > +		} else {
> > +			/* short  packet */
> > +			recv_data_cnt = 2;
> > +			if (recv_data_cnt > buffer_size)
> > +				recv_data_cnt = buffer_size;
> 
> Isn't it an error while you drop data over the buffer size?
We will update these codes in the next version.

> 
> > +
> > +			memcpy(buffer, &read_data0.byte1, 2);
> 
> If buffer_size is 1, why do you still copy 2 bytes?
Will fix.

> 
> > +		}
> > +	} while (packet_type != 0x1c && packet_type != 0x21 &&
> > +		packet_type != 0x22 && packet_type != 0x1a);
> 
> Could you give these magic number a descriptive name?
OK.

> 
> > +
> > +	dev_info(dsi->dev, "dsi get %d byte data from the panel address(0x%x)\n",
> > +		 recv_data_cnt, *((u8 *)(msg->tx_buf)));
> > +
> > +	return recv_data_cnt;
> > +}
> > +
> > +static ssize_t mtk_dsi_host_write_cmd(struct mtk_dsi *dsi,
> > +				      const struct mipi_dsi_msg *msg)
> > +{
> > +	u32 i;
> > +	u32 goto_addr, mask_para, set_para, reg_val;
> > +	void __iomem *cmdq_reg;
> > +	struct dsi_cmd_t0 t0;
> > +	struct dsi_cmd_t2 t2;
> > +	const char *tx_buf = msg->tx_buf;
> > +	struct dsi_tx_cmdq_regs *dsi_cmd_reg;
> > +
> > +	dsi_cmd_reg = (struct dsi_tx_cmdq_regs *)(dsi->regs + DSI_CMDQ0);
> > +
> > +	mtk_dsi_wait_for_idle(dsi);
> > +
> > +	if (msg->tx_len > 2) {
> > +		t2.config = 2;
> > +		t2.type = msg->type;
> > +		t2.wc16 = msg->tx_len;
> > +
> > +		reg_val = (t2.wc16 << 16) | (t2.type << 8) | t2.config;
> 
> Why need 'struct dsi_cmd_t2 t2'? I think code is more simple when get
> rid of this structure. The code looks like:
> 
> reg_val = (wc16 << 16) | (type << 8) | config;
We will check this part.

> 
> > +
> > +		writel(reg_val, &dsi_cmd_reg->data[0]);
> > +
> > +		goto_addr = (u32)(&dsi_cmd_reg->data[1].byte0);
> > +		mask_para = (0xff << ((goto_addr & 0x3) * 8));
> > +		set_para = (tx_buf[0] << ((goto_addr & 0x3) * 8));
> > +		cmdq_reg = (void __iomem *)(goto_addr & (~0x3));
> > +		mtk_dsi_set_cmdq(cmdq_reg, mask_para, set_para);
> 
> I think you can merge this setting into 'for loop' and the loop look
> like this:
> 
> for (i = 0; i < msg->tx_len; i++) {
> 	goto_addr = (u32)(&dsi_cmd_reg->data[1].byte0) + i;
> 	mask_para = (0xff << ((goto_addr & 0x3) * 8));
> 	set_para = (tx_buf[i] << ((goto_addr & 0x3) * 8));
> 	cmdq_reg = (void __iomem *)(goto_addr & (~0x3));
> 	mtk_dsi_set_cmdq(cmdq_reg, mask_para, set_para);
> }
OK, we will merge it into the loop.

> 
> > +
> > +		for (i = 1; i < msg->tx_len; i++) {
> > +			goto_addr = (u32)(&dsi_cmd_reg->data[1].byte1) + i - 1;
> > +			mask_para = (0xff << ((goto_addr & 0x3) * 8));
> > +			set_para = (tx_buf[i] << ((goto_addr & 0x3) * 8));
> > +			cmdq_reg = (void __iomem *)(goto_addr & (~0x3));
> > +			mtk_dsi_set_cmdq(cmdq_reg, mask_para, set_para);
> > +		}
> > +
> > +		mtk_dsi_mask(dsi, DSI_CMDQ_SIZE, CMDQ_SIZE,
> > +			     2 + (msg->tx_len - 1) / 4);
> 
> I think it is better to change formula of DSI_CMDQ_SIZE to '1 +
> (msg->tx_len + 3) / 4'. The '1' means the first cmd which describe the
> size of tx_buf, and the rest means the other cmds for body of tx_buf.
OK.

Regards,
yt.shen

> 
> > +	} else {
> > +		t0.config = 0;
> > +		t0.data0 = tx_buf[0];
> > +		if (msg->tx_len == 2) {
> > +			t0.type = MIPI_DSI_DCS_SHORT_WRITE_PARAM;
> > +			t0.data1 = tx_buf[1];
> > +		} else {
> > +			t0.type = MIPI_DSI_DCS_SHORT_WRITE;
> > +			t0.data1 = 0;
> > +		}
> > +
> > +		reg_val = (t0.data1 << 24) | (t0.data0 << 16) | (t0.type << 8) |
> > +			   t0.config;
> > +
> > +		writel(reg_val, &dsi_cmd_reg->data[0]);
> > +		mtk_dsi_mask(dsi, DSI_CMDQ_SIZE, CMDQ_SIZE, 1);
> > +	}
> > +
> > +	mtk_dsi_start(dsi);
> > +	mtk_dsi_wait_for_idle(dsi);
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
> 
> Regards,
> CK
> 
