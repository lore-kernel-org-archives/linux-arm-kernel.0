From: wsa@the-dreams.de (Wolfram Sang)
Date: Mon, 18 May 2015 08:37:42 +0200
Subject: [PATCH v7 2/3] I2C: mediatek: Add driver for MediaTek I2C
 controller
In-Reply-To: <1431928701.22349.22.camel@mtksdaap41>
References: <1430901427-65146-1-git-send-email-eddie.huang@mediatek.com>
 <1430901427-65146-3-git-send-email-eddie.huang@mediatek.com>
 <20150512125832.GB4447@schokonusskuchen.bad>
 <1431928701.22349.22.camel@mtksdaap41>
Message-ID: <20150518063742.GA1545@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > > +		rpaddr = dma_map_single(i2c->adap.dev.parent, msgs->buf,
> > > +						msgs->len, DMA_FROM_DEVICE);
> > 
> > I think you shouldn't use the adapter device here and later, but the dma
> > channel device.
> > 
> In MTK SoC, each I2C controller has its own DMA, and this DMA can't be
> used by other hardware.
> So I tend to use DMA directly, not through DMA channel.
> Even so, "i2c->adap.dev.parent" is not suitable here. I will change to
> use i2c->dev here. (Reference i2c-at91.c).

The better reference would be i2c-sh_mobile.c, especially commit
8cfcae9f0595bf0d145a67cfaa1051804a301d7c ("i2c: sh_mobile: use proper
device for mapping DMA memory") ;) The request to use the DMA channel
device came from the DMA folks, so if there is no real reason for an
exception, please use the channel device.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150518/2d5b42dc/attachment.sig>
