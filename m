From: vinod.koul@intel.com (Vinod Koul)
Date: Thu, 29 Oct 2015 10:54:13 +0900
Subject: [PATCH v2 1/3] dmaengine: virt-dma: don't always free descriptor
 upon completion
In-Reply-To: <87oafowahl.fsf@belgarion.home>
References: <1444766070-26915-1-git-send-email-robert.jarzmik@free.fr>
 <87oafowahl.fsf@belgarion.home>
Message-ID: <20151029015411.GD18368@vkoul-mobl.iind.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 24, 2015 at 11:57:53AM +0200, Robert Jarzmik wrote:
> Robert Jarzmik <robert.jarzmik@free.fr> writes:
> 
> > This patch attempts to enhance the case of a transfer submitted multiple
> > times, and where the cost of creating the descriptors chain is not
> > negligible.
> >
> > This happens with big video buffers (several megabytes, ie. several
> > thousands of linked descriptors in one scatter-gather list). In these
> > cases, a video driver would want to do :
> >  - tx = dmaengine_prep_slave_sg()
> >  - dma_engine_submit(tx);
> >  - dma_async_issue_pending()
> >  - wait for video completion
> >  - read video data (or not, skipping a frame is also possible)
> >  - dma_engine_submit(tx)
> >    => here, the descriptors chain recalculation will take time
> >    => the dma coherent allocation over and over might create holes in
> >       the dma pool, which is counter-productive.
> >  - dma_async_issue_pending()
> >  - etc ...
> >
> > In order to cope with this case, virt-dma is modified to prevent freeing
> > the descriptors upon completion if DMA_CTRL_REUSE flag is set in the
> > transfer.
> >
> > This patch is a respin of the former DMA_CTRL_ACK approach, which was
> > reverted due to a regression in audio drivers.
> >
> > Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> > ---
> > Since v1: added doxygen commit to vchan_tx_desc_free
> 
> Hi Vinod,
> 
> Is this serie good for you or do you have remaining comments to be addressed ?

Hi Robert,

This series looks good, but I am afraid we are very close to merge window I
would like this to be deffered to next one for more stabililty tests and
coverage

I have pushed this to topic/test/desc_reuse now.

This will be in -next after merge window

Thanks for fixing this up

-- 
~Vinod
