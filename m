From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 20 Jan 2011 13:02:46 +0000
Subject: [PATCH] mmc: msm: fix dma usage not to use internal APIs
In-Reply-To: <1295522421.4366.34.camel@m0nster>
References: <1295391805-15251-1-git-send-email-dwalker@codeaurora.org>
	<1295522421.4366.34.camel@m0nster>
Message-ID: <20110120130246.GA23941@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 20, 2011 at 03:20:21AM -0800, Daniel Walker wrote:
> On Tue, 2011-01-18 at 15:03 -0800, Daniel Walker wrote:
> > Remove parts of this driver which use internal API calls. This
> > replaces the calls as suggested by Russell King.
> > 
> > Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>
> > Signed-off-by: Daniel Walker <dwalker@codeaurora.org>
> > ---
> >  drivers/mmc/host/msm_sdcc.c |   49 +++++++++++++++++++-----------------------
> >  1 files changed, 22 insertions(+), 27 deletions(-)
> > 
> > diff --git a/drivers/mmc/host/msm_sdcc.c b/drivers/mmc/host/msm_sdcc.c
> > index 5decfd0..733d233 100644
> > --- a/drivers/mmc/host/msm_sdcc.c
> > +++ b/drivers/mmc/host/msm_sdcc.c
> > @@ -383,14 +383,30 @@ static int msmsdcc_config_dma(struct msmsdcc_host *host, struct mmc_data *data)
> >  	host->curr.user_pages = 0;
> >  
> >  	box = &nc->cmd[0];
> > -	for (i = 0; i < host->dma.num_ents; i++) {
> > -		box->cmd = CMD_MODE_BOX;
> >  
> > -	/* Initialize sg dma address */
> > -	sg->dma_address = page_to_dma(mmc_dev(host->mmc), sg_page(sg))
> > -				+ sg->offset;
> 
> It would seem there was a reason for this change.. The person that added
> this was Brent Degraaf (who is CC'd) ..
> 
> Quoting him below speaking about why dma_map_sg() isn't just used,
> 
> "Previous version of msm_sdcc.c had a cache coherency problem for
> precisely this reason. The dma_map_sg is what cleans the caches for
> these commands and so must be done AFTER the commands are populated. If
> this entry is left until the map function is called, the
> box->dst_row_addr will not be filled properly for reads."

It would be nice if problems such as this were discussed on the
linux-arm-kernel mailing list when they appear.

My response to this is:

dma_map_sg() does two things.  For each scatterlist entry:

* it converts the entry to a DMA address for the device and puts
  this in sg_dma_address().  The length of the entry is sg_dma_len().

* for each of the buffers described by the scatterlist, it ensures
  that the DMA device can see the data for DMA_TO_DEVICE transfers.
  for DMA_FROM_DEVICE transfers, it ensures that there are no dirty
  cache lines.  For some implementations the cache lines are
  invalidated to achieve this.

It is not guaranteed (and implementations do not predictably) cause any
other cache lines to be evicted or written back which are not described
by the scatterlist.

On dma_unmap_sg(), for each scatterlist entry:

* for DMA_FROM_DEVICE, some implementations cause the cache lines
  described by the scatterlist to be invalidated.

So, for anything _outside_ of the scatterlist, it is *unpredictable*
whether anything happens to them by way of the DMA API, and writing a
driver to rely on any behaviour observed is invalid.

The driver uses the passed scatterlist from the MMC layer to map, so the
only thing that the DMA API is going to touch is the pages which it's
performing IO on.

Therefore, it is entirely wrong for this driver to expect this box->blah
data to be written back by the DMA scatterlist mapping code.

Now, looking at the code a little more closely, host->dma.nc is allocated
via dma_alloc_coherent().  This returns either strongly ordered memory
for architectures prior to ARMv6, or 'normal non-cacheable' for ARMv6
onwards.

Strongly ordered requires no additional maintainence to ensure that writes
to it are immediately visible to hardware.  However, ARMv6 and later
requires a data synchronization barrier to ensure that writes to 'normal
non-cachable' memory are visible before writes to 'device' memory complete.
