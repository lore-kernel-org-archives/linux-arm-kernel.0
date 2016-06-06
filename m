From: clabbe.montjoie@gmail.com (LABBE Corentin)
Date: Mon, 6 Jun 2016 15:34:32 +0200
Subject: [linux-sunxi] [PATCH 1/5] ethernet: add sun8i-emac driver
In-Reply-To: <5754A86B.6050607@arm.com>
References: <1464947790-22991-1-git-send-email-clabbe.montjoie@gmail.com>
 <1464947790-22991-2-git-send-email-clabbe.montjoie@gmail.com>
 <5754A86B.6050607@arm.com>
Message-ID: <20160606133432.GA29281@Red>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 05, 2016 at 11:32:11PM +0100, Andr? Przywara wrote:
> On 03/06/16 10:56, LABBE Corentin wrote:
> 
> Hi,
> 
> first: thanks for posting this and the time and work that you spent on
> it. With the respective DT nodes this works for me on the Pine64 and
> turns this board eventually into something useful.
> 
> Some comments below:
> 
> > This patch add support for sun8i-emac ethernet MAC hardware.
> > It could be found in Allwinner H3/A83T/A64 SoCs.
> > 
> > It supports 10/100/1000 Mbit/s speed with half/full duplex.
> > It can use an internal PHY (MII 10/100) or an external PHY
> > via RGMII/RMII.
> > 
> > Signed-off-by: LABBE Corentin <clabbe.montjoie@gmail.com>
> > ---
> >  drivers/net/ethernet/allwinner/Kconfig      |   13 +
> >  drivers/net/ethernet/allwinner/Makefile     |    1 +
> >  drivers/net/ethernet/allwinner/sun8i-emac.c | 1943 +++++++++++++++++++++++++++
> >  3 files changed, 1957 insertions(+)
> >  create mode 100644 drivers/net/ethernet/allwinner/sun8i-emac.c
> > 
> > diff --git a/drivers/net/ethernet/allwinner/Kconfig b/drivers/net/ethernet/allwinner/Kconfig
> > index 47da7e7..226499d 100644
> > --- a/drivers/net/ethernet/allwinner/Kconfig
> > +++ b/drivers/net/ethernet/allwinner/Kconfig
> > @@ -33,4 +33,17 @@ config SUN4I_EMAC
> >            To compile this driver as a module, choose M here.  The module
> >            will be called sun4i-emac.
> >  
> > +config SUN8I_EMAC
> > +        tristate "Allwinner sun8i EMAC support"
> 
> nit: w/s error
> 
ok

> > +
> > +#define SUN8I_EMAC_BASIC_CTL0 0x00
> > +#define SUN8I_EMAC_BASIC_CTL1 0x04
> > +
> > +#define SUN8I_EMAC_MDIO_CMD 0x48
> > +#define SUN8I_EMAC_MDIO_DATA 0x4C
> 
> Can you align all these register offsets with tabs, so that the actual
> offset values are below each other?
> Also ordering them by address seems useful to me.
> 

ok

> > +/* Structure of DMA descriptor used by the hardware  */
> > +struct dma_desc {
> > +	u32 status; /* status of the descriptor */
> > +	u32 st; /* Information on the frame */
> > +	u32 buf_addr; /* physical address of the frame data */
> > +	u32 next; /* physical address of next dma_desc */
> > +} __packed __aligned(4);
> 
> I don't think we need this alignment attribute here:
> 1) The structure will be 4-byte aligned anyway, because the first member
> is naturally 4 bytes aligned.
> 2) The alignment requirement is on the physical DMA side. I don't see
> how the compiler should be able to guarantee this. So technically you
> have to tell the DMA allocation code about your alignment requirement.
> But due to 1), I think this is a moot discussion.
> 

ok, I have removed all __aligned

> 
> ....
> 
> > +
> > +
> > +	priv->rx_sk = kcalloc(nbdesc_rx, sizeof(struct sk_buff *), GFP_KERNEL);
> > +	if (!priv->rx_sk) {
> > +		err = -ENOMEM;
> > +		goto rx_sk_error;
> > +	}
> > +	priv->tx_sk = kcalloc(nbdesc_tx, sizeof(struct sk_buff *), GFP_KERNEL);
> > +	if (!priv->tx_sk) {
> > +		err = -ENOMEM;
> > +		goto tx_sk_error;
> > +	}
> > +	priv->tx_map = kcalloc(nbdesc_tx, sizeof(int), GFP_KERNEL);
> > +	if (!priv->tx_map) {
> > +		err = -ENOMEM;
> > +		goto tx_map_error;
> > +	}
> > +
> > +	priv->dd_rx = dma_alloc_coherent(priv->dev,
> > +			nbdesc_rx * sizeof(struct dma_desc),
> > +			&priv->dd_rx_phy,
> > +			GFP_KERNEL);
> 
> You need to be sure here to allocate 32-bit DMA memory only, since the
> hardware holds only 32 bits worth of addresses. If I am not mistaken,
> the following snippet (preferrably in the probe function below) should
> take care of this:
> 
> 	if (dma_set_mask_and_coherent(&priv->dev, DMA_BIT_MASK(32))) {
> 		dev_err(&priv->dev, "No suitable DMA available\n");
> 		return -ENOMEM;
> 	}
> 
> This isn't an issue for the SoCs we know of (they have a 32-bit bus
> anyway), but future SoCs could support more memory (the A80 does
> already!), so you have to allocate it from the low 4GB. This is a
> limitation of that particular _device_ (and not the platform), since it
> does the DMA itself and this engine is limited to 32-bit physical addresses.
> 

ok

> > +	if (!priv->dd_rx) {
> > +		dev_err(priv->dev, "ERROR: cannot DMA RX");
> > +		err = -ENOMEM;
> > +		goto dma_rx_error;
> > +	}
> 
> ....
> 
> > +
> > +static const struct of_device_id sun8i_emac_of_match_table[] = {
> > +	{ .compatible = "allwinner,sun8i-a83t-emac",
> > +	  .data = (void *)A83T_EMAC },
> > +	{ .compatible = "allwinner,sun8i-h3-emac",
> > +	  .data = (void *)H3_EMAC },
> > +	{ .compatible = "allwinner,sun50i-a64-emac",
> > +	  .data = (void *)A64_EMAC },
> > +	{}
> > +};
> 
> I am not sure this is the proper way to model the different variants of
> the device. I see two differing features here:
> 1) the H3 has an internal PHY
> 2) the A83T does not support RMII
> 
> So wouldn't it be wiser to put those two options as properties into the
> DT node? This way any future EMAC version could pick the matching
> features and we wouldn't need to add a new compatible string for each
> and every new SoC which carries this device and thus hardcode it's
> properties in this driver.
> 

Since Wens already have answered that, I have nothing more to say

Thanks for your review.

Regards
LABBE Corentin
