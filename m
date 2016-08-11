From: ck.hu@mediatek.com (CK Hu)
Date: Thu, 11 Aug 2016 15:10:12 +0800
Subject: [PATCH v6 07/10] drm/mediatek: add dsi transfer function
In-Reply-To: <1470813866.27526.14.camel@mtksdaap41>
References: <1470308844-20895-1-git-send-email-yt.shen@mediatek.com>
 <1470308844-20895-8-git-send-email-yt.shen@mediatek.com>
 <1470391697.16554.60.camel@mtksdaap41>
 <1470813866.27526.14.camel@mtksdaap41>
Message-ID: <1470899412.16554.72.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, YT:

On Wed, 2016-08-10 at 15:24 +0800, YT Shen wrote:
> Hi CK,
> 
> On Fri, 2016-08-05 at 18:08 +0800, CK Hu wrote:
> > Hi, YT:
> > 
> > On Thu, 2016-08-04 at 19:07 +0800, YT Shen wrote:
> > > From: shaoming chen <shaoming.chen@mediatek.com>
> > > 
> > > add dsi read/write commands for transfer function
> > > 
> > > Signed-off-by: shaoming chen <shaoming.chen@mediatek.com>
> > > ---
> > >  drivers/gpu/drm/mediatek/mtk_dsi.c |  261 ++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 261 insertions(+)
> > > 

[snip...]

> > > +
> > > +static void mtk_dsi_cmdq(struct mtk_dsi *dsi, const struct mipi_dsi_msg *msg)
> > > +{
> > > +	const char *tx_buf = msg->tx_buf;
> > > +	u32 reg_val, i;
> > > +	u16 wc16;
> > > +	u8 config, data0, data1, type;
> > > +
> > > +	if (MTK_DSI_HOST_IS_READ(type)) {
> > 
> > 'type' is used before assigned.
> Will fix.
> 
> > 
> > > +		config = 4;
> > > +		data0 = tx_buf[0];
> > > +
> > > +		if (msg->rx_len < 3)
> > > +			type = MIPI_DSI_DCS_READ;
> > > +		else
> > > +			type = MIPI_DSI_GENERIC_READ_REQUEST_1_PARAM;
> > > +
> > > +		data1 = 0;
> > > +		reg_val = (data1 << 24) | (data0 << 16) | (type << 8) | config;
> > > +
> > > +		writel(reg_val, dsi->regs + DSI_CMDQ0);
> > > +		mtk_dsi_mask(dsi, DSI_CMDQ_SIZE, CMDQ_SIZE, 1);
> > 
> > I think this part looks like 'else' part. The difference is type and
> > config. I think type should be msg->type and you can independently set
> > BIT(2) of config.
> msg->type only tells about read or write, for the details we need to
> check other parameters.  This part is for read, the else part is for
> write short packet.  Not only BIT(2) of config is different, but also
> type and data1 is changed.  Such a change would lead to difficult to
> understand.
> 
> > 
> > > +	} else if (msg->tx_len > 2) {	/* send long packet */
> > > +		config = 2;
> > > +		type = msg->type;
> > > +		wc16 = msg->tx_len;
> > > +
> > > +		reg_val = (wc16 << 16) | (type << 8) | config;
> > > +
> > > +		writel(reg_val, dsi->regs + DSI_CMDQ0);
> > > +
> > > +		for (i = 0; i < msg->tx_len; i++)
> > > +			writeb(tx_buf[i], dsi->regs + DSI_CMDQ0 + 4 + i);
> > > +
> > > +		mtk_dsi_mask(dsi, DSI_CMDQ_SIZE, CMDQ_SIZE,
> > > +			     1 + (msg->tx_len + 3) / 4);
> > > +	} else {	/* send short packet */
> > > +		config = 0;
> > > +		data0 = tx_buf[0];
> > > +
> > > +		if (msg->tx_len == 2) {
> > > +			type = MIPI_DSI_DCS_SHORT_WRITE_PARAM;
> > 
> > Why do you not set type as msg->type? This behavior looks like you
> > modify transfer type, but is this acceptable?
> msg->type only tells about read or write, for the details we need to
> check other parameters.

I think you could rewrite mtk_dsi_cmdq() as follow:

static void mtk_dsi_cmdq(struct mtk_dsi *dsi, const struct mipi_dsi_msg
*msg)
{
	u32 i;
	u32 src_off = (msg->tx_len > 2) ? 4 : 2;
	u32 cmdq_size = (msg->tx_len > 2) ? 1 + (msg->tx_len + 3) / 4 : 1;
	u32 config = (msg->tx_len > 2) ? BIT(1) : 0;
	u32 type = msg->type;

	if (MTK_DSI_HOST_IS_READ(type))
		config |= BIT(2);

	writel((type << 8) || config, dsi->regs + DSI_CMDQ0);
	for (i = 0; i < msg->tx_len; i++)
		writeb(msg->tx_buf[i], dsi->regs + DSI_CMDQ0 + src_off + i);
	mtk_dsi_mask(dsi, DSI_CMDQ_SIZE, CMDQ_SIZE, cmdq_size);
}

If DSI HW does not support some type and it can be transferred to other
type, you could add a transfer function like this

static u8 mtk_dsi_map_to_supported_type(u8 type)
{
	switch(type) {
	case MIPI_DSI_DCS_SHORT_WRITE:
		return MIPI_DSI_DCS_SHORT_WRITE_PARAM;
	}

	return type;
}

and then

u32 type = mtk_dsi_map_to_supported_type(msg->type);

> 
> > 
> > > +			data1 = tx_buf[1];
> > > +		} else {
> > > +			type = MIPI_DSI_DCS_SHORT_WRITE;
> > > +			data1 = 0;
> > > +		}
> > > +
> > > +		reg_val = (data1 << 24) | (data0 << 16) | (type << 8) | config;
> > > +
> > > +		writel(reg_val, dsi->regs + DSI_CMDQ0);
> > > +		mtk_dsi_mask(dsi, DSI_CMDQ_SIZE, CMDQ_SIZE, 1);
> > > +	}
> > > +}
> > > +

[snip...]

> > 
> > Regards,
> > CK
> > 
> 
> 

Regards,
CK
