From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Sun, 29 Jan 2017 00:17:32 +0200
Subject: [PATCH 1/2] spi: When no dma_chan map buffers with spi_master's
 parent
In-Reply-To: <20170126162154.124287-1-djkurtz@chromium.org>
References: <20170126162154.124287-1-djkurtz@chromium.org>
Message-ID: <CAHp75Vfzz7U3=R4dFSgr-eXuOfH1_eLDKcPSWmWdUcTS_tggdw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 26, 2017 at 6:21 PM, Daniel Kurtz <djkurtz@chromium.org> wrote:
> Back before commit 1dccb598df54 ("arm64: simplify dma_get_ops"), for
> arm64, devices for which dma_ops were not explicitly set were automatically
> configured to use swiotlb_dma_ops, since this was hard-coded as the
> global "dma_ops" in arm64_dma_init().
>
> Now that global "dma_ops" has been removed, all devices much have their
> dma_ops explicitly set by a call to arch_setup_dma_ops(), otherwise the
> device is assigned dummy_dma_ops, and thus calls to map_sg for such a
> device will fail (return 0).
>
> Mediatek SPI uses DMA but does not use a dma channel.  Support for this
> was added by commit c37f45b5f1cd ("spi: support spi without dma channel
> to use can_dma()"), which uses the master_spi dev to DMA map buffers.
>
> The master_spi device is not a platform device, rather it is created
> in spi_alloc_device(), and therefore its dma_ops are never set.
>
> Therefore, when the mediatek SPI driver when it does DMA (for large SPI
> transactions > 32 bytes), SPI will use spi_map_buf()->dma_map_sg() to
> map the buffer for use in DMA.  But dma_map_sg()->dma_map_sg_attrs() returns
> 0, because ops->map_sg is dummy_dma_ops->__dummy_map_sg, and hence
> spi_map_buf() returns -ENOMEM (-12).
>
> Fix this by using the real spi_master's parent device which should be a
> real physical device with DMA properties.

Wouldn't be better to copy necessary stuff from parent device to its
child? Like DMA mask propagation (I dunno if there are such in SPI,
but at least many other drivers are doing that).

-- 
With Best Regards,
Andy Shevchenko
