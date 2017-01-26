From: dtor@chromium.org (Dmitry Torokhov)
Date: Thu, 26 Jan 2017 08:35:54 -0800
Subject: [PATCH] spi: mediatek: Manually set dma_ops for spi_master device
In-Reply-To: <CAGS+omDexcrnWL6v4bAQ3K2QSHKcwCs-WRCC+BUbGbXgVYbK9w@mail.gmail.com>
References: <20170124132519.13271-1-djkurtz@chromium.org>
 <b1180920-8ead-40e8-6155-8510226e719b@arm.com>
 <CAGS+omBV3o1hergAjU3_9ok5NTmk8Z315zo3yW9jU_jA+reZCQ@mail.gmail.com>
 <0548db75-042b-4bef-02db-767ea9ccd7e4@arm.com>
 <CAGS+omDexcrnWL6v4bAQ3K2QSHKcwCs-WRCC+BUbGbXgVYbK9w@mail.gmail.com>
Message-ID: <CAE_wzQ8ChZtLait3WWin1nyRY5CQCzs8VHTeAcP8y2DqSGmb7Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 26, 2017 at 8:29 AM, Daniel Kurtz <djkurtz@chromium.org> wrote:
> Hi Robin,
>
> On Thu, Jan 26, 2017 at 1:59 AM, Robin Murphy <robin.murphy@arm.com> wrote:
>>
>> On 25/01/17 10:24, Daniel Kurtz wrote:
>> > Hi Robin,
>> >
>> > On Tue, Jan 24, 2017 at 11:14 PM, Robin Murphy <robin.murphy@arm.com> wrote:
>> >> Hi Dan,
>> >
>> > [snip...]
>> >
>> >>> And I really don't know why we needed to set the coherent_dma_mask to 0 to
>> >>> avoid SPI transaction errors.
>> >>
>> >> Following what I mentioned above, "git grep dma_alloc drivers/spi" makes
>> >> it seem like coherent DMA isn't used anywhere relevant, which is rather
>> >> puzzling. Unless of course somewhere along the line somebody's done the
>> >> dev->dma_mask = &dev->dma_coherent_mask hack, with the result that
>> >> writing one mask hits both, making *all* DMA fail and big transfers fall
>> >> back to PIO.
>> >
>> > You mean this last line?
>> >
>> >>> @@ -575,6 +576,10 @@ static int mtk_spi_probe(struct platform_device *pdev)
>> >>>               goto err_put_master;
>> >>>       }
>> >>>
>> >>> +     /* Call of_dma_configure to set up spi_master's dma_ops */
>> >>> +     of_dma_configure(&master->dev, master->dev.of_node);
>> >>> +     /* But explicitly set the coherent_dma_mask to 0 */
>> >>> +     master->dev.coherent_dma_mask = 0;
>> >>>       if (!pdev->dev.dma_mask)
>> >>>               pdev->dev.dma_mask = &pdev->dev.coherent_dma_mask;
>> >                                   ^^^^^
>>
>> Ha, I totally failed to spot that!
>>
>> > As predicted, setting the dma_mask = 0 causes "all DMA to fail".  In
>> > particular, dma_capable() always returns false, so
>> > swiotlb_map_sg_attrs() takes the map_single() path, instead of just
>> > assigning:
>> >
>> >    sg->dma_address = dev_addr;
>> >
>> > swiotlb_map_sg_attrs(struct device *hwdev, struct scatterlist *sgl, int nelems,
>> >                      enum dma_data_direction dir, unsigned long attrs)
>> > {
>> >         struct scatterlist *sg;
>> >         int i;
>> >
>> >         BUG_ON(dir == DMA_NONE);
>> >
>> >         for_each_sg(sgl, sg, nelems, i) {
>> >                 phys_addr_t paddr = sg_phys(sg);
>> >                 dma_addr_t dev_addr = phys_to_dma(hwdev, paddr);
>> >
>> >                 if (swiotlb_force == SWIOTLB_FORCE ||
>> >                     !dma_capable(hwdev, dev_addr, sg->length)) {
>> >                         phys_addr_t map = map_single(hwdev, sg_phys(sg),
>> >                                                      sg->length, dir, attrs);
>> >                         ...
>> >                         }
>> >                         sg->dma_address = phys_to_dma(hwdev, map);
>> >                 } else
>> >                         sg->dma_address = dev_addr;
>> >                 sg_dma_len(sg) = sg->length;
>> >         }
>> >         return nelems;
>> > }
>> >
>> > So, I think this means that the only reason the MTK SPI driver ever
>> > worked before was that it was tested on an older kernel, so the
>> > spi_master was defaulting to swiotlb_dma_ops with a 0 dma_mask, and
>> > therefore it was using SWIOTLB bounce buffers (via 'map_single'), and
>> > not actually ever doing real DMA.
>>
>> Well, it's still "real DMA" if the device is able to slurp data out of
>> the bounce buffer. That suggests there might be some mismatch between
>> the default DMA mask it's getting given and the actual hardware
>> capability (i.e. the bounce buffer happens to fall somewhere accessible,
>> but other addresses may not be) - is crazy 33-bit mode involved here?
>
> AFAICT, the Mediatek SPI does not have a 33-bit mode.  The Mediatek
> SPI DMA registers are only 32-bits wide, so the default 0xffffffff
> dma_mask is correct.  For larger addresses, swiotlb properly falls
> back to using a bounce buffer.
>
> However, I did discover what the real problem was.  The Mediatek SPI
> DMA does not like un-aligned addresses.

Nobody doing DMA likes unaligned buffers. In fact, memory used for DMA
must be cacheline aligned, or you going to have trouble. What
component supplies unaligned buffers to SPI core for transfers?

Thanks,
Dmitry
