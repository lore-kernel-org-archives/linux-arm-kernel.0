From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 25 Feb 2010 10:35:12 +0100
Subject: [PATCH] Bugfixing and improvement of the AT91 MCI driver
In-Reply-To: <201002250859.49804.wolfgang.mues@auerswald.de>
References: <201002250859.49804.wolfgang.mues@auerswald.de>
Message-ID: <4B864450.7090805@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 25/02/2010 08:59, Wolfgang M?es :
> Nicolas,

Hi Wolfgang,

Thanks a lot for your hard work on this driver and your patch.

> as we are working on a project regarding AT91SAM9260 and using the 
> MCI interface for SD/SDHC data transfer, we are forced to make a
> series of bugfixes and improvements to the AT91 MCI driver:
> 
> - Fix a buf in the dmabuf pointer calculation.
> - Use a fixed DMA buffer instead of allocating a DMA buffer
>   each time a data transfer is requested.
> - Fix address error in kunmap_atomic().
> - Use the dma buffer also for reads, because we found
>   that double buffering PDC was NOT working, and we need
>   a solution which allows bigger stream sizes.
> - Use dmac_flush_range() because flush_dcache_page()
>   was not OK if more than one page is transferred.
> - Extend card timeout to 2s because some cards need it.
> - Extend card detect time to 500ms (usefull if the user
>   is inserting the card gentle into the slot).
> - Fill in the mmc->max_ variables to allow the IO elevator
>   to do the job. Without these variables filled in,
>   each IO transfer is limited to 4096 bytes, which is limiting
>   transfer speed and - most important - is triggering
>   ACCELLERATED WEAR-OUT of the flash sectors of the card
>   (because the card has to do a lot of partial sector
>    erases).

A big amount of updates, indeed !

> We have tested this driver which a lot of SD and SDHC cards
> and we think the driver is ready for production use now.
> 
> For reads, we get about 90% of the expected maximum calculated
> speed (from the clock frequency). For writes, we get about 50%.


This is a precious feedback. Thanks.

> As we are using a slightly older kernel, I have ported this
> patch to latest 2.6.33 by hand. So please take care to compile
> and look for compile-time errors. I've done my very best.
> 
> Signed-off-by: Wolfgang Muees <wolfgang.mues@auerswald.de>

The problem is that we should change this big patch into a patch series
for integrating one enhancement at a time...

As you say that you are working on an old kernel release, I guess that
you may not have time to rework this patch and split it into a patch series?

In short, I see at least four patches:
- pointer calculation fixes
- timeouts and detect time
- use of dma buffer for read
- mmc->max_ variables update

So, tell me, and I will see how we can move forward together with those
very interesting enhancements...

Best regards,
-- 
Nicolas Ferre
