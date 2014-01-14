From: broonie@kernel.org (Mark Brown)
Date: Tue, 14 Jan 2014 21:55:48 +0000
Subject: [PATCH v2 1/2] spi: spi-imx: enable dma support for escpi
 controller
In-Reply-To: <201401142238.32262.marex@denx.de>
References: <1388789632-12238-1-git-send-email-Frank.Li@freescale.com>
 <201401142238.32262.marex@denx.de>
Message-ID: <20140114215548.GD15567@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 14, 2014 at 10:38:32PM +0100, Marek Vasut wrote:

> I know the MXC SPI controller works in full-duplex mode, thus must have two 
> equally big buffers (one for RX and one for TX) even if used in half-duplex 
> mode, right?

We should factor this stuff out into the core, a bunch of controllers
have that limitation.

> The problem I perceive here is that when I do for example 4 MB long continuous 
> half-duplex transfer with the IMX SPI, your code will happily allocate 4MB big 
> buffer, right ?

Or try to - the other trick here is getting 4MB of contiguous memory in
the first place (unless there's an IOMMU making everything pretty).

> Hence my suggestion, won't it be better to split such long transfers into a 
> chain of DMA descriptors AND use a small (say, 16KiB) buffer for the unwanted 
> direction ? This way, you would allocate the small 16KiB block only once (heck, 
> you can even allocate it in probe() ), and each descriptor would point to this 
> block, overwriting it or sourcing zeroes from it .

Yes, indeed.  I've half started working on some dmaengine code and was
going to do something like this as part of it - the idea was to have the
core generate a sg_list to pass to devices with DMAable transfers which
would enable this sort of rewriting and would also mean we could do
things like scatter/gather more effectively.  Not got as far as actually
getting things into a nice shape for that though.  There's a lot of
common patterns here which we shouldn't be open coding.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140114/8e412fb9/attachment.sig>
