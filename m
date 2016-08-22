From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 22 Aug 2016 14:40:34 +0200
Subject: [PATCH v3 04/12] firmware: tegra: Add IVC library
In-Reply-To: <90222c3a-7c69-6fa3-d161-4ed0c5759f34@nvidia.com>
References: <20160819173233.13260-1-thierry.reding@gmail.com>
 <20160819173233.13260-5-thierry.reding@gmail.com>
 <90222c3a-7c69-6fa3-d161-4ed0c5759f34@nvidia.com>
Message-ID: <20160822124034.GA17367@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 22, 2016 at 11:46:49AM +0100, Jon Hunter wrote:
> 
> On 19/08/16 18:32, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> > 
> > The Inter-VM communication (IVC) is a communication protocol which is
> > designed for interprocessor communication (IPC) or the communication
> > between the hypervisor and the virtual machine with a guest OS.
> > 
> > Message channels are used to communicate between processors. They are
> > backed by DRAM or SRAM, so care must be taken to maintain coherence of
> > data.
> > 
> > The IVC library maintains memory-based descriptors for the transmission
> > and reception channels as well as the data coherence of the counter and
> > payload. Clients, such as the driver for the BPMP firmware, can use the
> > library to exchange messages with remote processors.
> > 
> > Based on work by Peter Newman <pnewman@nvidia.com> and Joseph Lo
> > <josephl@nvidia.com>.
> > 
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > ---
> > Changes in v3:
> > - use a more object oriented design
> > 
> >  drivers/firmware/Kconfig        |   1 +
> >  drivers/firmware/Makefile       |   1 +
> >  drivers/firmware/tegra/Kconfig  |  13 +
> >  drivers/firmware/tegra/Makefile |   1 +
> >  drivers/firmware/tegra/ivc.c    | 683 ++++++++++++++++++++++++++++++++++++++++
> >  include/soc/tegra/ivc.h         | 109 +++++++
> >  6 files changed, 808 insertions(+)
> >  create mode 100644 drivers/firmware/tegra/Kconfig
> >  create mode 100644 drivers/firmware/tegra/Makefile
> >  create mode 100644 drivers/firmware/tegra/ivc.c
> >  create mode 100644 include/soc/tegra/ivc.h
> 
> [snip]
> 
> > +static void *tegra_ivc_frame_virt(struct tegra_ivc *ivc,
> > +				  struct tegra_ivc_header *header,
> > +				  unsigned int frame)
> > +{
> > +	BUG_ON(frame >= ivc->num_frames);
> 
> WARN_ON and return an error pointer?

I think I'll actually drop these. Or move them one layer up. The only
parameters passed into as frame are ivc->{rx,tx}.position, and all the
code that modifies these will properly wrap them at ivc->num_frames. I
think the only way that this condition could become true is if someone
were to directly access the structure and modify the position. That's
technically possible, so I guess the checks could stay in for extra
paranoia.

> > +
> > +	return (void *)(header + 1) + ivc->frame_size * frame;
> > +}
> > +
> > +static inline dma_addr_t tegra_ivc_frame_phys(struct tegra_ivc *ivc,
> > +					      dma_addr_t phys,
> > +					      unsigned int frame)
> > +{
> > +	unsigned long offset;
> > +
> > +	BUG_ON(!ivc->peer);
> > +	BUG_ON(frame >= ivc->num_frames);
> 
> WARN_ON?

I've moved this up one layer since it's a little cumbersome to return an
error via dma_addr_t and the !ivc->peer check is present in all callers
of this function anyway.

> > +	offset = sizeof(struct tegra_ivc_header) + ivc->frame_size * frame;
> > +
> > +	return phys + offset;
> > +}
> 
> [snip]
> 
> > +static int check_ivc_params(unsigned long base1, unsigned long base2,
> > +			    unsigned int num_frames, size_t frame_size)
> > +{
> > +	BUG_ON(offsetof(struct tegra_ivc_header, tx.count) & (TEGRA_IVC_ALIGN - 1));
> > +	BUG_ON(offsetof(struct tegra_ivc_header, rx.count) & (TEGRA_IVC_ALIGN - 1));
> > +	BUG_ON(sizeof(struct tegra_ivc_header) & (TEGRA_IVC_ALIGN - 1));
> 
> WARN_ON?

I've turned all of these into BUILD_BUG_ON() because the parameters are
all statically known at build time. I've also switched to the IS_ALIGNED
macro here and the checks below because it's easier to read.

> > +int tegra_ivc_init(struct tegra_ivc *ivc, struct device *peer,
> > +		   void __iomem *rx_virt, dma_addr_t rx_phys,
> > +		   void __iomem *tx_virt, dma_addr_t tx_phys,
> > +		   unsigned int num_frames, size_t frame_size,
> > +		   void (*notify)(struct tegra_ivc *ivc, void *data),
> > +		   void *data)
> > +{
> > +	size_t queue_size;
> > +	int err;
> > +
> > +	err = check_ivc_params((unsigned long)rx_virt, (unsigned long)tx_virt,
> > +			       num_frames, frame_size);
> > +	if (err < 0)
> > +		return err;
> > +
> > +	BUG_ON(!ivc);
> > +	BUG_ON(!notify);
> 
> We should check this first and just return -EINVAL.

Yes, done. I've wrapped these in a single WARN_ON() with a -EINVAL
return.

> > +/**
> > + * tegra_ivc_read_get_next_frame - Peek at the next frame to receive
> > + * @ivc		pointer of the IVC channel
> > + *
> > + * Peek at the next frame to be received, without removing it from
> > + * the queue.
> > + *
> > + * Returns a pointer to the frame, or an error encoded pointer.
> > + */
> > +void *tegra_ivc_read_get_next_frame(struct tegra_ivc *ivc);
> 
> Is it odd to return a void * pointer here and not a pointer to a
> specific structure type?

I think that's by design. IVC is a generic library to implement an IPC
mechanism on top. There is no specific structure to return a pointer to
here. The caller determines what type it wants to put into frames.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160822/663fe482/attachment-0001.sig>
