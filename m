From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 17 Sep 2012 11:59:27 +0000
Subject: [PATCH V6 2/2] dmaengine: add helper function to request a slave
 DMA channel
In-Reply-To: <1347852805.1943.130.camel@vkoul-udesk3>
References: <1347662517-4210-1-git-send-email-jon-hunter@ti.com>
 <1347662517-4210-3-git-send-email-jon-hunter@ti.com>
 <1347852805.1943.130.camel@vkoul-udesk3>
Message-ID: <201209171159.27359.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 17 September 2012, Vinod Koul wrote:
> On Fri, 2012-09-14 at 17:41 -0500, Jon Hunter wrote:
> > +/**
> > + * dma_request_slave_channel - try to allocate an exclusive slave
> > channel
> > + * @dev:       pointer to client device structure
> > + * @name:      slave channel name
> > + */
> > +struct dma_chan *dma_request_slave_channel(struct device *dev, char *name)
> > +{
> > +       /* If device-tree is present get slave info from here */
> > +       if (dev->of_node)
> > +               return of_dma_request_slave_channel(dev->of_node, name);
> > +
> Shouldn't this be conditionally compiled only when OF is built. I think
> this might be problematic for systems which doesn't have device tree.
> Or perhaps you can declare these symbols as dummy in of_dma.h when
> device tree is not selected.

Right, good point. I'd prefer the dummy functions, since that is in line
with what a lot of other subsystems do:

#ifdef CONFIG_OF
extern int of_dma_controller_register(struct device_node *np,
               struct dma_chan *(*of_dma_xlate)
               (struct of_phandle_args *, struct of_dma *),
               void *data);
extern void of_dma_controller_free(struct device_node *np);
extern struct dma_chan *of_dma_request_slave_channel(struct device_node *np,
                                                    char *name);
extern struct dma_chan *of_dma_simple_xlate(struct of_phandle_args *dma_spec,
               struct of_dma *ofdma);
#else
static inline int of_dma_controller_register(struct device_node *np,
               struct dma_chan *(*of_dma_xlate)
               (struct of_phandle_args *, struct of_dma *),
               void *data)
{
	return -ENODEV;
}
static inline void of_dma_controller_free(struct device_node *np)
{
}
static inline struct dma_chan *of_dma_request_slave_channel(struct device_node *np,
                                                    char *name)
{
	return NULL;
}
static inline struct dma_chan *of_dma_simple_xlate(struct of_phandle_args *dma_spec,
               struct of_dma *ofdma)
{
	return NULL;
}
#endif

I believe that Jon is on vacation this week, so if this is the only issue
holding up the merge, maybe you can change this in his patch directly, or
I can send an updated version if you prefer.

	Arnd
