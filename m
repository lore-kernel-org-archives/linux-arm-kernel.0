From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 12 Sep 2015 15:08:34 +0200
Subject: [PATCH 1/3] dmaengine: virt-dma: don't always free descriptor
 upon completion
In-Reply-To: <1441539654-19055-1-git-send-email-robert.jarzmik@free.fr>
 (Robert Jarzmik's message of "Sun, 6 Sep 2015 13:40:52 +0200")
References: <1441539654-19055-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <878u8bu6nh.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Robert Jarzmik <robert.jarzmik@free.fr> writes:

> This patch attempts to enhance the case of a transfer submitted multiple
> times, and where the cost of creating the descriptors chain is not
> negligible.
>
> This happens with big video buffers (several megabytes, ie. several
> thousands of linked descriptors in one scatter-gather list). In these
> cases, a video driver would want to do :
>  - tx = dmaengine_prep_slave_sg()
>  - dma_engine_submit(tx);
>  - dma_async_issue_pending()
>  - wait for video completion
>  - read video data (or not, skipping a frame is also possible)
>  - dma_engine_submit(tx)
>    => here, the descriptors chain recalculation will take time
>    => the dma coherent allocation over and over might create holes in
>       the dma pool, which is counter-productive.
>  - dma_async_issue_pending()
>  - etc ...
>
> In order to cope with this case, virt-dma is modified to prevent freeing
> the descriptors upon completion if DMA_CTRL_REUSE flag is set in the
> transfer.
>
> This patch is a respin of the former DMA_CTRL_ACK approach, which was
> reverted due to a regression in audio drivers.
>
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>

Hi Jun, Lars-Peter and Vinod,

The revert of the former patch of this type, 8c8fe97b2b8a ("Revert "dmaengine:
virt-dma: don't always free descriptor upon completion"") broke pxa_dma driver.

The reason behind is that pxa_dma was designed, upon transfer submission (in
pxad_tx_submit()), to "move" the virtual descriptor to the submitted list,
rather than adding it at its tail (because it was previously on the allocated
list).

As a consequence, the list_head is not initialized, pxa_dma fails, and the
current status is that pxa_dma Oopses in linux-next, and therefore in Linus's
tree once the merge window is closed.

I'd really like to have this patch as the fix, ie. that at transfer preparation
in vchan_tx_prep(), the virtual descriptor is added on "allocated" list tail.

But to be sure there is no regression on other platforms, I need a test,
especially from someone who suffered from the former version of this patch
(where we had DMA_CTRL_ACK instead of DMA_CTRL_REUSE).

Could anybody give it a try, as I need a fix to go in the early -rc of v4.3
please ?

Cheers.

-- 
Robert
