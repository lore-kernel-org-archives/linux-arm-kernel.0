From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 25 Apr 2013 14:44:02 +0100
Subject: [PATCH 6/9] crypto: ux500/cryp - Set DMA configuration though
 dma_slave_config()
In-Reply-To: <CACRpkdbFgW6bGYt59WtN4r2izuN09AJw4J1cqir82uzFsuMmWQ@mail.gmail.com>
References: <1366280825-31136-1-git-send-email-lee.jones@linaro.org>
 <1366280825-31136-7-git-send-email-lee.jones@linaro.org>
 <CACRpkdbFgW6bGYt59WtN4r2izuN09AJw4J1cqir82uzFsuMmWQ@mail.gmail.com>
Message-ID: <20130425134402.GN4623@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 25 Apr 2013, Linus Walleij wrote:

> On Thu, Apr 18, 2013 at 12:27 PM, Lee Jones <lee.jones@linaro.org> wrote:
> 
> > The DMA controller currently takes configuration information from
> > information passed though dma_channel_request(), but it shouldn't.
> > Using the API, the DMA channel should only be configured during
> > a dma_slave_config() call.
> >
> > Cc: Herbert Xu <herbert@gondor.apana.org.au>
> > Cc: David S. Miller <davem@davemloft.net>
> > Cc: Andreas Westin <andreas.westin@stericsson.com>
> > Cc: linux-crypto at vger.kernel.org
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> 
> (...)
> >  /* Cryp DMA interface */
> > +#define HASH_DMA_TX_FIFO       0x08
> > +#define HASH_DMA_RX_FIFO       0x10
> 
> Yes, this is nice address notation :-)
> 
> >  /**
> >   * struct cryp_device_data - structure for a cryp device.
> > - * @base: Pointer to the hardware base address.
> > + * @base: Pointer to virtual base address of the cryp device.
> > + * @phybase: Pointer to physical memory location of the cryp device.
> >   * @dev: Pointer to the devices dev structure.
> >   * @clk: Pointer to the device's clock control.
> >   * @pwr_regulator: Pointer to the device's power control.
> > @@ -232,6 +236,7 @@ struct cryp_dma {
> >   */
> >  struct cryp_device_data {
> >         struct cryp_register __iomem *base;
> > +       phys_addr_t phybase;
> 
> Use dma_addr_t. Maybe "phybase" is misleading,
> "dmabase" is probably better. (Also applies to the
> cryp patch).

Accept it's not the dmabase.

It's the phybase (U8500_CRYP1_BASE) i.e. the physical base address of
the device's regs.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
