From: yibin.gong@nxp.com (Robin Gong)
Date: Fri, 20 Jul 2018 09:40:51 +0000
Subject: [PATCH v2 2/3] dmaengine: imx-sdma: add memcpy interface
In-Reply-To: <20180713061604.tza3udckmyaoq5wh@pengutronix.de>
References: <1531487327-21879-1-git-send-email-yibin.gong@nxp.com>
 <1531487327-21879-3-git-send-email-yibin.gong@nxp.com>
 <20180713061604.tza3udckmyaoq5wh@pengutronix.de>
Message-ID: <DB6PR04MB3223F5A07E59F173D5BD0B6D89510@DB6PR04MB3223.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Sascha Hauer [mailto:s.hauer at pengutronix.de]
> Sent: 2018?7?13? 14:16
> To: Robin Gong <yibin.gong@nxp.com>
> Cc: vkoul at kernel.org; dan.j.williams at intel.com; shawnguo at kernel.org; Fabio
> Estevam <fabio.estevam@nxp.com>; linux at armlinux.org.uk;
> linux-arm-kernel at lists.infradead.org; kernel at pengutronix.de;
> dmaengine at vger.kernel.org; linux-kernel at vger.kernel.org; dl-linux-imx
> <linux-imx@nxp.com>
> Subject: Re: [PATCH v2 2/3] dmaengine: imx-sdma: add memcpy interface
> 
> On Fri, Jul 13, 2018 at 09:08:46PM +0800, Robin Gong wrote:
> > Add MEMCPY capability for imx-sdma driver.
> >
> > Signed-off-by: Robin Gong <yibin.gong@nxp.com>
> > ---
> >  drivers/dma/imx-sdma.c | 95
> > ++++++++++++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 92 insertions(+), 3 deletions(-)
> >
> > @@ -1318,6 +1347,63 @@ static struct sdma_desc
> *sdma_transfer_init(struct sdma_channel *sdmac,
> >  	return NULL;
> >  }
> >
> > +static struct dma_async_tx_descriptor *sdma_prep_memcpy(
> > +		struct dma_chan *chan, dma_addr_t dma_dst,
> > +		dma_addr_t dma_src, size_t len, unsigned long flags) {
> > +	struct sdma_channel *sdmac = to_sdma_chan(chan);
> > +	struct sdma_engine *sdma = sdmac->sdma;
> > +	int channel = sdmac->channel;
> > +	size_t count;
> > +	int i = 0, param;
> > +	struct sdma_buffer_descriptor *bd;
> > +	struct sdma_desc *desc;
> > +
> > +	if (!chan || !len)
> > +		return NULL;
> > +
> > +	dev_dbg(sdma->dev, "memcpy: %pad->%pad, len=%zu, channel=%d.\n",
> > +		&dma_src, &dma_dst, len, channel);
> > +
> > +	desc = sdma_transfer_init(sdmac, DMA_MEM_TO_MEM,
> > +					len / SDMA_BD_MAX_CNT + 1);
> > +	if (!desc)
> > +		return NULL;
> > +
> > +	do {
> > +		count = min_t(size_t, len, SDMA_BD_MAX_CNT);
> > +		bd = &desc->bd[i];
> > +		bd->buffer_addr = dma_src;
> > +		bd->ext_buffer_addr = dma_dst;
> > +		bd->mode.count = count;
> > +		desc->chn_count += count;
> > +		/* align with sdma->dma_device.copy_align: 4bytes */
> > +		bd->mode.command = 0;
> > +
> > +		dma_src += count;
> > +		dma_dst += count;
> > +		len -= count;
> > +		i++;
> 
> NACK.
> 
> Please actually look at your code and find out where you do unaligned DMA
> accesses. Hint: What happens when this loop body is executed more than
> once?
> 
> Sascha
Actually internal sdma script has already take such 'align' matter like below:
Burst with words if source/dest address and data length are all aligned with words, burst with
Byte if not. So I will remove the comment '/* align with sdma->dma_device.copy_align: 4bytes */'
In v3. Besides, I have found another bug which introduced by my virt-dma patch. Will send
V3 later.
> 
> > +
> > +		param = BD_DONE | BD_EXTD | BD_CONT;
> > +		/* last bd */
> > +		if (!len) {
> > +			param |= BD_INTR;
> > +			param |= BD_LAST;
> > +			param &= ~BD_CONT;
> > +		}
> > +
> > +		dev_dbg(sdma->dev, "entry %d: count: %zd dma: 0x%x %s%s\n",
> > +				i, count, bd->buffer_addr,
> > +				param & BD_WRAP ? "wrap" : "",
> > +				param & BD_INTR ? " intr" : "");
> > +
> > +		bd->mode.status = param;
> > +	} while (len);
> > +
> 
> --
> Pengutronix e.K.                           |
> |
> Industrial Linux Solutions                 |
> https://emea01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fwww.
> pengutronix.de%2F&amp;data=02%7C01%7Cyibin.gong%40nxp.com%7Cf78f9
> 91028e64b45cf7508d5e888310d%7C686ea1d3bc2b4c6fa92cd99c5c301635%7
> C0%7C0%7C636670594003030732&amp;sdata=zyDkLHVl4VneD05f4VvaY82m
> ZITkybewrXyCj2YRu%2FI%3D&amp;reserved=0  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:
> +49-5121-206917-5555 |
