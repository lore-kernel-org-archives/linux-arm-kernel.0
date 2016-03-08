From: vinod.koul@intel.com (Vinod Koul)
Date: Tue, 8 Mar 2016 15:29:04 +0530
Subject: [PATCH] dma: sun4i: expose block size and wait cycle
 configuration to DMA users
In-Reply-To: <20160308075131.GE8418@lukather>
References: <1457344771-12946-1-git-send-email-boris.brezillon@free-electrons.com>
 <20160307145429.GG11154@localhost>
 <20160307160857.577bb04d@bbrezillon>
 <20160307203024.GD8418@lukather> <20160308025547.GI11154@localhost>
 <20160308075131.GE8418@lukather>
Message-ID: <20160308095904.GM11154@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 08, 2016 at 08:51:31AM +0100, Maxime Ripard wrote:
> > > > > > + * struct sun4i_dma_chan_config - DMA channel config
> > > > > > + *
> > > > > > + * @para: contains information about block size and time before checking
> > > > > > + *	  DRQ line. This is device specific and only applicable to dedicated
> > > > > > + *	  DMA channels
> > > > > 
> > > > > What information, can you elobrate.. And why can't you use existing
> > > > > dma_slave_config for this?
> > > > 
> > > > Block size is related to the device FIFO size. I guess it allows the
> > > > DMA channel to launch a transfer of X bytes without having to check the
> > > > DRQ line (the line telling the DMA engine it can transfer more data
> > > > to/from the device). The wait cycles information is apparently related
> > > > to the number of clks the engine should wait before polling/checking
> > > > the DRQ line status between each block transfer. I'm not sure what it
> > > > saves to put WAIT_CYCLES() to something != 1, but in their BSP,
> > > > Allwinner tweak that depending on the device.
> > 
> > we already have block size aka src/dst_maxburst, why not use that one.
> 
> I'm not sure it's really the same thing. The DMA controller also has a
> burst parameter, that is either 1 byte or 8 bytes, and ends up being
> different from this one.

Nope that is buswidth. maxburst is words which cna be sent to device FIFO.
> 
> > Why does dmaengine need to wait? Can you explain that
> 
> We have no idea, we thought you might have one :)

Well that is hardware dependent. From DMAengine API usage we dont ahve to
wait at all. We should submit next descriptor as soon as possible.

> It doesn't really makes sense to us, but it does have a significant
> impact on the throughput.

-- 
~Vinod
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160308/d2bb0296/attachment.sig>
