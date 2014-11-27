From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 27 Nov 2014 15:50:46 +0100
Subject: [PATCH 2/3] ARM: edma: Rename header file for dmaengine filter
 function definition
In-Reply-To: <547733E3.3020408@ti.com>
References: <1417084891-17990-1-git-send-email-peter.ujfalusi@ti.com>
 <8235185.7qUDHu9jso@wuerfel> <547733E3.3020408@ti.com>
Message-ID: <3300340.ou8f7H2hIc@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 27 November 2014 16:23:31 Peter Ujfalusi wrote:
> This will only work in case of legacy boot. When booting with DT we do not
> have pdata and after this patch in dt boot we are not going to be able to get
> the DMA resources either.

No, when booting with DT, the filter_fn and data are not used at all,
we get the dma channel by parsing the DT instead.

> I think if we want to do something like this, it has to be done within the
> dmaengine framework. The dma controller's of_dma_filter_info already have
> .filter_fn which could be used by the framework.

No, of_dma_filter_info/of_dma_simple_xlate was a mistake, we should never
have even introduced that. All drivers that rely on this can simply
provide their own xlate function that calls of_dma_get_slave_channel()
or one of the related functions.

edma is particularly trivial, it can just use of_dma_xlate_by_chan_id()
instead of of_dma_simple_xlate, as it looks up the channel by its number.

	Arnd
