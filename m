From: robin.murphy@arm.com (Robin Murphy)
Date: Mon, 30 Jan 2017 11:44:30 +0000
Subject: [PATCH 1/2] spi: When no dma_chan map buffers with spi_master's
 parent
In-Reply-To: <CAHp75Vfzz7U3=R4dFSgr-eXuOfH1_eLDKcPSWmWdUcTS_tggdw@mail.gmail.com>
References: <20170126162154.124287-1-djkurtz@chromium.org>
 <CAHp75Vfzz7U3=R4dFSgr-eXuOfH1_eLDKcPSWmWdUcTS_tggdw@mail.gmail.com>
Message-ID: <81ab617f-95fb-17d1-88d2-5cf5f74bab03@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28/01/17 22:17, Andy Shevchenko wrote:
> On Thu, Jan 26, 2017 at 6:21 PM, Daniel Kurtz <djkurtz@chromium.org> wrote:
>> Back before commit 1dccb598df54 ("arm64: simplify dma_get_ops"), for
>> arm64, devices for which dma_ops were not explicitly set were automatically
>> configured to use swiotlb_dma_ops, since this was hard-coded as the
>> global "dma_ops" in arm64_dma_init().
>>
>> Now that global "dma_ops" has been removed, all devices much have their
>> dma_ops explicitly set by a call to arch_setup_dma_ops(), otherwise the
>> device is assigned dummy_dma_ops, and thus calls to map_sg for such a
>> device will fail (return 0).
>>
>> Mediatek SPI uses DMA but does not use a dma channel.  Support for this
>> was added by commit c37f45b5f1cd ("spi: support spi without dma channel
>> to use can_dma()"), which uses the master_spi dev to DMA map buffers.
>>
>> The master_spi device is not a platform device, rather it is created
>> in spi_alloc_device(), and therefore its dma_ops are never set.
>>
>> Therefore, when the mediatek SPI driver when it does DMA (for large SPI
>> transactions > 32 bytes), SPI will use spi_map_buf()->dma_map_sg() to
>> map the buffer for use in DMA.  But dma_map_sg()->dma_map_sg_attrs() returns
>> 0, because ops->map_sg is dummy_dma_ops->__dummy_map_sg, and hence
>> spi_map_buf() returns -ENOMEM (-12).
>>
>> Fix this by using the real spi_master's parent device which should be a
>> real physical device with DMA properties.
> 
> Wouldn't be better to copy necessary stuff from parent device to its
> child? Like DMA mask propagation (I dunno if there are such in SPI,
> but at least many other drivers are doing that).

Absolutely not. The "necessary stuff" includes arch-specific things
which would require filling the SPI code with arch-specific #ifdefs, and
may go as far as private data structures held by other drivers (e.g.
IOMMUs) which the SPI code cannot even touch, let alone know what to do
with. The "parent device" here *is* the real DMA master device (as
described by firmware and configured by the arch code accordingly), so
using any other device for DMA is just plain wrong.

Robin.
