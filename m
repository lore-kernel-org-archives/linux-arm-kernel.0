From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 17 Feb 2017 11:22:47 +0000
Subject: [PATCH v2 4/6] spi: davinci: flush caches when performing DMA
In-Reply-To: <5fab0c33-6e1d-c63a-8758-6672236045a7@ti.com>
References: <1487327904-28311-1-git-send-email-fisaksen@baylibre.com>
 <1487327904-28311-5-git-send-email-fisaksen@baylibre.com>
 <5fab0c33-6e1d-c63a-8758-6672236045a7@ti.com>
Message-ID: <20170217112247.GE21222@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 17, 2017 at 04:27:28PM +0530, Vignesh R wrote:
> On Friday 17 February 2017 04:08 PM, Frode Isaksen wrote:
> > @@ -650,6 +651,10 @@ static int davinci_spi_bufs(struct spi_device *spi, struct spi_transfer *t)
> >  		dmaengine_slave_config(dspi->dma_rx, &dma_rx_conf);
> >  		dmaengine_slave_config(dspi->dma_tx, &dma_tx_conf);
> >  
> > +		if (is_vmalloc_addr(t->rx_buf))
> > +			/* VIVT cache: flush since addr. may be aliased */
> > +			flush_kernel_vmap_range((void *)t->rx_buf, t->len);
> > +
> >  		rxdesc = dmaengine_prep_slave_sg(dspi->dma_rx,
> >  				t->rx_sg.sgl, t->rx_sg.nents, DMA_DEV_TO_MEM,
> >  				DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
> > @@ -660,7 +665,9 @@ static int davinci_spi_bufs(struct spi_device *spi, struct spi_transfer *t)
> >  			/* use rx buffer as dummy tx buffer */
> >  			t->tx_sg.sgl = t->rx_sg.sgl;
> >  			t->tx_sg.nents = t->rx_sg.nents;
> > -		}
> > +		} else if (is_vmalloc_addr(t->tx_buf))
> > +			/* VIVT cache: flush since addr. may be aliased */
> > +			flush_kernel_vmap_range((void *)t->tx_buf, t->len);
> >  
> 
> SPI core calls dma_unmap_sg(), that is supposed to flush caches.
> If flush_kernel_vmap_range() call is required here to flush actual cache
> lines, then what does dma_unmap_* calls in SPI core end up flushing?

The DMA API deals with the _kernel_ lowmem mapping.  It has no knowledge
of any other aliases in the system.  When you have a VIVT cache (as all
old ARM CPUs have) then if you access the memory through a different
alias from the kernel lowmem mapping (iow, vmalloc) then the DMA API
can't help you.

However, the correct place to use flush_kernel_vmap_range() etc is not
in drivers - it's supposed to be done in the callers that know that
the memory is aliased.

For full details on these flushing functions, see cachetlb.txt.  This
does not remove the requirement to also use the DMA API.

=== cachetlb.txt ===

The final category of APIs is for I/O to deliberately aliased address
ranges inside the kernel.  Such aliases are set up by use of the
vmap/vmalloc API.  Since kernel I/O goes via physical pages, the I/O
subsystem assumes that the user mapping and kernel offset mapping are
the only aliases.  This isn't true for vmap aliases, so anything in
the kernel trying to do I/O to vmap areas must manually manage
coherency.  It must do this by flushing the vmap range before doing
I/O and invalidating it after the I/O returns.

  void flush_kernel_vmap_range(void *vaddr, int size)
       flushes the kernel cache for a given virtual address range in
       the vmap area.  This is to make sure that any data the kernel
       modified in the vmap range is made visible to the physical
       page.  The design is to make this area safe to perform I/O on.
       Note that this API does *not* also flush the offset map alias
       of the area.

  void invalidate_kernel_vmap_range(void *vaddr, int size) invalidates
       the cache for a given virtual address range in the vmap area
       which prevents the processor from making the cache stale by
       speculatively reading data while the I/O was occurring to the
       physical pages.  This is only necessary for data reads into the
       vmap area.


-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
