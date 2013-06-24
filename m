From: agnel.joel@gmail.com (Joel A Fernandes)
Date: Mon, 24 Jun 2013 15:32:11 -0500
Subject: [PATCH v12 05/11] edma: config: Enable config options for EDMA
In-Reply-To: <201306242228.23297.arnd@arndb.de>
References: <1371762407-24544-1-git-send-email-joelagnel@ti.com>
 <201306220014.16427.arnd@arndb.de>
 <CAD=GYpabakChmN-TEJbLn6p=BwX2wsK5KWsc5gH9-cAA+yWcEA@mail.gmail.com>
 <201306242228.23297.arnd@arndb.de>
Message-ID: <CAD=GYpYwswOYGHRzZ6SeKD+sEfi-7s3HuqKr7G0OXQWFCA_EtQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 24, 2013 at 3:28 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Saturday 22 June 2013, Joel A Fernandes wrote:
>>
>> >> > config TI_EDMA
>> >> >         tristate "TI EDMA support"
>> >> >         default m if 'ARCH_DAVINCI || ARCH_OMAP1 || ARCH_OMAP2
>> >> >         select DMA_ENGINE
>> >> >         select DMA_VIRTUAL_CHANNELS
>> >>
>> >>
>> >> MMC depends on EDMA specially on AM33xx there's no PIO mode AFAIK. The
>> >> 'm' option will require some initramfs to load the module when needing
>> >> to MMC boot, I suggest lets leave it as y.
>> >>
>> >
>> > Ah, right: you still export a filter function from the edma driver
>> > and use it in slave drivers:
>> >
>> > drivers/mmc/host/davinci_mmc.c:         dma_request_slave_channel_compat(mask, edma_filter_fn,
>> > drivers/mmc/host/davinci_mmc.c:         dma_request_slave_channel_compat(mask, edma_filter_fn,
>> > drivers/spi/spi-davinci.c:      dspi->dma_rx = dma_request_channel(mask, edma_filter_fn,
>> > drivers/spi/spi-davinci.c:      dspi->dma_tx = dma_request_channel(mask, edma_filter_fn,
>> >
>> > As long as this is the case, you have to be careful with the dependencies
>> > to make sure that davinci_mmc and spi-davinci either depend on TI_EDMA, or
>> > edma_filter_fn gets defined to NULL when you are building for a DT-only platform.
>>
>> Yes sure, right now they are defined  as follows in include/linux/edma.h:
>>
>> #if defined(CONFIG_TI_EDMA) || defined(CONFIG_TI_EDMA_MODULE)
>> bool edma_filter_fn(struct dma_chan *, void *);
>> #else
>> static inline bool edma_filter_fn(struct dma_chan *chan, void *param)
>> {
>> return false;
>> }
>> #endif
>
> It's best to just define the filter function in the platform
> code and pass a pointer to it through platform data. The way you do
> it above makes the slave drivers inherently nonportable.

But with DT-only platforms, can you really do that?

Thanks,
Joel
