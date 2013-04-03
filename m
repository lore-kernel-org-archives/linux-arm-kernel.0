From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 3 Apr 2013 12:49:37 +0100
Subject: [PATCH V3 2/5] spi: s3c64xx: added support for polling mode
In-Reply-To: <CAKrE-KdWe6aCg0p99BFEeQP-P2nwvdhs2itH3XnHsJMCUjWPAA@mail.gmail.com>
References: <1363157014-9615-1-git-send-email-ks.giri@samsung.com>
 <1363157014-9615-3-git-send-email-ks.giri@samsung.com>
 <20130401131207.GI18636@opensource.wolfsonmicro.com>
 <CAKrE-KdWe6aCg0p99BFEeQP-P2nwvdhs2itH3XnHsJMCUjWPAA@mail.gmail.com>
Message-ID: <20130403114935.GA11305@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 03, 2013 at 05:00:04PM +0530, Girish KS wrote:
> On Mon, Apr 1, 2013 at 6:42 PM, Mark Brown

> >> -     if (!sdd->pdev->dev.of_node) {
> >> +     if (!sdd->pdev->dev.of_node && !is_polling(sdd)) {
> >>               res = platform_get_resource(pdev, IORESOURCE_DMA,  0);
> >>               if (!res) {
> >>                       dev_err(&pdev->dev, "Unable to get SPI tx dma "

> > It seems like it'd be sensible to also handle failure to get the DMA
> > resource by going into polling mode.

> There are 2 cases currently i have identified and handled,
> 1. The SoC's dont have DMA support for spi controller. For such SoC's we
>  would not add the dma resource in the spi dts node. In this case the probe
>  would return error if failure for DMA resuorce is handled.

That's not what the code currently does...

> 2. The SoC has a DMA support for SPI controller, but due to some x
> reason(H/W bug),
>  the driver would force polling mode by enabling
> S3C64XX_SPI_QUIRK_POLL in driver
>  data. For such SoC's there would be a dma entry in the spi controller
> dts node, and
>  probe can handle failure for DMA resource successfully.

> To handle above both situations successfully if
> (!sdd->pdev->dev.of_node && !is_polling(sdd)) is used.

Right, that's what the code currently does but what I'm suggesting is
that this isn't the most helpful thing to do and that printing a big
warning then soldiering on in polling mode might be more useful.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130403/2f42c448/attachment.sig>
