From: broonie@kernel.org (Mark Brown)
Date: Thu, 18 Apr 2013 17:46:42 +0100
Subject: [PATCH 29/30] spi: s3c64xx: move to generic dmaengine API
In-Reply-To: <201304172205.35526.arnd@arndb.de>
References: <1365638712-1028578-1-git-send-email-arnd@arndb.de>
 <1365638712-1028578-30-git-send-email-arnd@arndb.de>
 <201304172205.35526.arnd@arndb.de>
Message-ID: <20130418164642.GM13687@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 17, 2013 at 10:05:35PM +0200, Arnd Bergmann wrote:
> On Thursday 11 April 2013, Arnd Bergmann wrote:

> > +               use_dma = 0;
> > +               if (sdd->rx_dma.ch && sdd->tx_dma.ch &&
> > +                   (xfer->len > ((FIFO_LVL_MASK(sdd) >> 1) + 1)))
> >                         use_dma = 1;

> Can you try just reverting this hunk? It's actually not required and
> comes from an earlier version of the patch. I assumed it was harmless,
> but it's the only think I see that should actually make a difference
> in my patch for the case of !CONFIG_SAMSUNG_DMADEV.

That's not it, the checks are now needed - otherwise we get a null
pointer dereference in prepare_dma() instead.  What's actually gone
wrong is that your ifdefs are for SAMSUNG_DMADEV instead of S3C_DMA
so s3c64xx is trying to use dmaengine.  The driver doesn't actually
check to see if it failed to get the channels so it then tries to do the
transfer with a missing channel which unsurprisingly fails.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130418/2458eed6/attachment-0001.sig>
