From: bayi.cheng@mediatek.com (bayi.cheng)
Date: Wed, 16 Sep 2015 00:37:46 +0800
Subject: [PATCH 2/3] mtd: mtk-nor: mtk serial flash controller driver
In-Reply-To: <20150909150050.44d2b197@ipc1.ka-ro>
References: <1441705796-11365-1-git-send-email-bayi.cheng@mediatek.com>
 <1441705796-11365-3-git-send-email-bayi.cheng@mediatek.com>
 <20150909063701.GD18700@pengutronix.de>
 <20150909150050.44d2b197@ipc1.ka-ro>
Message-ID: <1442335066.27250.25.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2015-09-09 at 15:00 +0200, Lothar Wa?mann wrote:
> Hi,
> 
> > > +	writeb(len, mt8173_nor->base + MTK_NOR_CNT_REG);
> > > +	return mt8173_nor_execute_cmd(mt8173_nor, MTK_NOR_PRG_CMD);
> > > +}
> > > +
> > > +static int mt8173_nor_get_para(struct mt8173_nor *mt8173_nor, u8 *buf, int len)
> > > +{
> > > +	if (len > 1) {
> > > +		/* read JEDEC ID need 4 bytes commands */
> > > +		mt8173_nor_set_cmd(mt8173_nor, 0, 32, SPINOR_OP_RDID);
> > > +		buf[2] = readb(mt8173_nor->base + MTK_NOR_SHREG0_REG);
> > > +		buf[1] = readb(mt8173_nor->base + MTK_NOR_SHREG1_REG);
> > > +		buf[0] = readb(mt8173_nor->base + MTK_NOR_SHREG2_REG);
> > > +	} else {
> > > +		if (mt8173_nor_execute_cmd(mt8173_nor, MTK_NOR_RDSR_CMD)) {
> > > +			dev_err(mt8173_nor->dev, "read status failed!\n");
> > > +			return -EINVAL;
> > > +		}
> > > +		*buf = readb(mt8173_nor->base + MTK_NOR_RDSR_REG);
> > > +	}
> > > +	return 0;
> > > +}
> > > +
> > > +/* cmd1 sent to nor flash, cmd2 write to nor controller */
> > > +static int mt8173_nor_set_para(struct mt8173_nor *mt8173_nor, int cmd1,
> > > +			       int cmd2)
> > > +{
> > > +	if (mt8173_nor_set_cmd(mt8173_nor, 0, 8, SPINOR_OP_WREN)) {
> > > +		dev_err(mt8173_nor->dev,
> > > +			"write enable failed in write protect!\n");
> > > +		return -EINVAL;
> > > +	}
> > > +	writeb(cmd1, mt8173_nor->base + MTK_NOR_PRGDATA5_REG);
> > > +	writeb(8, mt8173_nor->base + MTK_NOR_CNT_REG);
> > > +	if (mt8173_nor_execute_cmd(mt8173_nor, cmd2)) {
> > > +		dev_err(mt8173_nor->dev, "execute cmd failed!\n");
> > 
> > mt8173_nor_execute_cmd() will already have printed an error message.
> > 
> And mt8173_nor_execute_cmd()/mt8173_nor_set_cmd() returned an error
> code which should be promoted to the caller rather than
> inventing a new one.
> The same for other instances of this code fragment.
Sorry for later reply ,and Thanks for your instruct, and I will promote
the error code to the caller. 
> 
> 
> Lothar Wa?mann
> 
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
