From: broonie@kernel.org (Mark Brown)
Date: Wed, 17 Jun 2015 13:47:58 +0100
Subject: [PATCH 2/3] spi: mediatek: Add spi bus for Mediatek MT8173
In-Reply-To: <1434532083.19346.27.camel@mtksdaap41>
References: <1431434356.2128.9.camel@mhfsdcap03>
 <20150512160540.GB3066@sirena.org.uk>
 <1431675522.2128.13.camel@mhfsdcap03>
 <20150515092543.GY2761@sirena.org.uk>
 <1433758546.19786.16.camel@mtksdaap41>
 <20150608175927.GO14071@sirena.org.uk>
 <1433844321.16178.6.camel@mtksdaap41>
 <20150609103951.GA14071@sirena.org.uk>
 <1433923569.22080.1.camel@mtksdaap41>
 <1434532083.19346.27.camel@mtksdaap41>
Message-ID: <20150617124758.GE3214@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 17, 2015 at 05:08:03PM +0800, Eddie Huang wrote:

> Here comes the problem, although total length of tx, rx is the same,
> each entry in rx and tx scatterlist may not be the same (in the case
> data buffer allocate from vmalloc). Other vendor have dmaengine driver
> to send entry-by-entry automatically, so it is ok due to total length is
> the same.But mediatek hw can only send tx and rx scatterlist entry one
> by on, which means in full duplex, mediatek SPI hardware need send each
> entry separately, will cause full duplex fail because tx/rx entry size
> or entry number may not be the same.

I don't see why this is a problem - your driver is going to have to do
more work to overcome the limitations of the hardware but surely it's
just a question of how you parse the scatterlists (or rewriting them if
that's appropriate)?

> The problem is not dma map discuss earlier, it is mediatek spi hardware
> limitation that can't support scatterlist dma transfer in full-duplex
> mode. We can only support both tx and rx has the same size continuous
> memory data in full-duplex mode. I don't know whether should modify
> spi.c to support mediatek spi, or we just return can_dma() false and do
> transfer one continuous data in transfer function.

> By the way, I think maybe it is better to change can_dma() to
> can_dma_sg().

Don't you just need to handle the scatterlists in page sized chunks
here?  There's nothing about passing information about the memory that
was mapped around in a scatterlist that means you have to pass the whole
list to the hardware at once - at heart the scatterlist is just a
convenient structure for passing around where the data to be transferred
is.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150617/fac8a28e/attachment.sig>
