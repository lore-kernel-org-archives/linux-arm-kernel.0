From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 27 May 2011 00:58:19 +0200
Subject: [PATCH 1/5] dmaengine: add ep93xx DMA support
In-Reply-To: <0D753D10438DA54287A00B027084269764D3319EC4@AUSP01VMBX24.collaborationhost.net>
References: <cover.1306082097.git.mika.westerberg@iki.fi>
	<e6777eb9f7228ee1dadec1f0c9f16c3afc44c307.1306082097.git.mika.westerberg@iki.fi>
	<BANLkTi=3z3kO5VEe2up8Mfm+bNXkY3baUw@mail.gmail.com>
	<20110525195413.GC2996@acer>
	<BANLkTin8Trn-44Op+GbxrgocFrnPuXUZ2w@mail.gmail.com>
	<20110526043344.GA2749@acer>
	<BANLkTikzrXRmdnv_v_nmJw7Nvsr6TY-5RQ@mail.gmail.com>
	<20110526183800.GE2957@acer>
	<0D753D10438DA54287A00B027084269764D3319EC4@AUSP01VMBX24.collaborationhost.net>
Message-ID: <BANLkTimry2+rdp=9FA-fuhJLNfkcP3Db4w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/5/26 H Hartley Sweeten <hartleys@visionengravers.com>:

> I think the biggest hurdle with using the amba-pl022 driver is that the ep93xx
> spi peripheral does not have the registers with the pid and cid id's. ?Without
> those I don't think the amba bus driver will be able to match the device to
> the driver.

This is not a problem. We have this code to dynamically create and
register a device with a specific periphid on ux500. It worked even
before my recent patches to amba's bus.c if you have only
zeroes in these registers:

struct amba_device *
dbx500_add_amba_device(const char *name, resource_size_t base,
                       int irq, void *pdata, unsigned int periphid)
{
        struct amba_device *dev;
        int ret;

        dev = kzalloc(sizeof *dev, GFP_KERNEL);
        if (!dev)
                return ERR_PTR(-ENOMEM);

        dev->dev.init_name = name;

        dev->res.start = base;
        dev->res.end = base + SZ_4K - 1;
        dev->res.flags = IORESOURCE_MEM;

        dev->dma_mask = DMA_BIT_MASK(32);
        dev->dev.coherent_dma_mask = DMA_BIT_MASK(32);

        dev->irq[0] = irq;
        dev->irq[1] = NO_IRQ;

        dev->periphid = periphid;

        dev->dev.platform_data = pdata;

        ret = amba_device_register(dev, &iomem_resource);
        if (ret) {
                kfree(dev);
                return ERR_PTR(ret);
        }

        return dev;
}

I'd recommend coming up with some clever numbering scheme
with invented vendor ID.

Yours,
Linus Walleij
