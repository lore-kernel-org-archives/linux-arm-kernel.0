From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 26 Nov 2014 18:41:06 +0100
Subject: next-20141126 build failures in wd719x
In-Reply-To: <20141126172606.GL7712@sirena.org.uk>
References: <E1XtdBa-00087r-J4@debutante> <20141126172606.GL7712@sirena.org.uk>
Message-ID: <2127125.sKMaG8tEx4@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 26 November 2014 17:26:06 Mark Brown wrote:
> On Wed, Nov 26, 2014 at 02:03:14PM +0000, Build bot for Mark Brown wrote:
> 
> The wd719x driver fails to build on at least arm and arm64 in today's
> -next since:
> 
> >       arm64-allmodconfig
> > ../drivers/scsi/wd719x.c:247:2: error: implicit declaration of function 'dma_cache_sync' [-Werror=implicit-function-declaration]
> > 
> >       arm-allmodconfig
> > ../drivers/scsi/wd719x.c:247:2: error: implicit declaration of function 'dma_cache_sync' [-Werror=implicit-function-declaration]
> 
> dma_cache_sync() is not available on these architectures.  I can't
> immediately see something to depend on that'd exclude the driver from
> these architectures, the other users seem to all have architecture
> specific dependencies.

I think the use of dma_cache_sync in this driver is just a bug:

        cmd->SCp.dma_handle = dma_map_single(&wd->pdev->dev, cmd->sense_buffer,
                        SCSI_SENSE_BUFFERSIZE, DMA_FROM_DEVICE);
        dma_cache_sync(&wd->pdev->dev, cmd->sense_buffer,
                        SCSI_SENSE_BUFFERSIZE, DMA_FROM_DEVICE);

dma_cache_sync only makes sense with buffers allocated through
dma_alloc_noncoherent(), which this one is not. I suspect we can just
remove the call to dma_cache_sync here, in particular since the
buffer is passed to the device next, and dma_map_single has
already done all the necessary synchronization.

	Arnd
