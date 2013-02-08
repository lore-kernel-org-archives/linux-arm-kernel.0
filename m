From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 8 Feb 2013 16:22:48 +0000
Subject: [PATCH 2/5] spi: pl022: use generic DMA slave configuration if
 possible
In-Reply-To: <3752726.iyKukyN6sF@wuerfel>
References: <1359395857-1235-1-git-send-email-arnd@arndb.de>
 <201302071942.54642.arnd@arndb.de>
 <CACRpkdbunPGtR4p_kY4q8WEb8iwkEbdo_icDyrLZwKrCe0wXqw@mail.gmail.com>
 <3752726.iyKukyN6sF@wuerfel>
Message-ID: <20130208162248.GY17833@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 07, 2013 at 10:15:48PM +0100, Arnd Bergmann wrote:
> On Thursday 07 February 2013 21:19:04 Linus Walleij wrote:
> > On Thu, Feb 7, 2013 at 8:42 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > > On Thursday 07 February 2013, Linus Walleij wrote:
> > 
> > >> Actually I once read about a feature where the kernel provides
> > >> a static page full of zeroes or something like this, that would be
> > >> ideal to use in cases like this, then all of this dummy page
> > >> allocation and freeing can be deleted.
> > >
> > > You mean empty_zero_page? That only works if this page is
> > > read-only from the perspective of the DMA controller, but
> > > then it would be a good fit, yes.
> > 
> > That's actually how it's used.
> > 
> > SPI is symmetric, and in the DMA case we're not poking
> > data into the buffers from the CPU so the controller need
> > something - anything - to stream to the block.
> > 
> > If we can use that page we'll even save a few remaps.
> 
> I'm slightly worried about the caching effects though. The
> idea of the empty-zero page is that all user processes get
> it when they read a page before they write to it, so the
> data in it can essentially always be cache-hot.
> 
> If we do DMA from that page to a device what would be the
> overhead of flushing the (clean) cache lines?

If it's DMA _to_ a device, then we will only ever clean the lines prior to
a transfer, never invalidate them.  So that's not really a concern.  (There
better not be any dirty cache lines associated with the empty zero page
either.)
