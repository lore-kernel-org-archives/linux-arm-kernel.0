From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 07 Feb 2013 22:15:48 +0100
Subject: [PATCH 2/5] spi: pl022: use generic DMA slave configuration if
 possible
In-Reply-To: <CACRpkdbunPGtR4p_kY4q8WEb8iwkEbdo_icDyrLZwKrCe0wXqw@mail.gmail.com>
References: <1359395857-1235-1-git-send-email-arnd@arndb.de>
 <201302071942.54642.arnd@arndb.de>
 <CACRpkdbunPGtR4p_kY4q8WEb8iwkEbdo_icDyrLZwKrCe0wXqw@mail.gmail.com>
Message-ID: <3752726.iyKukyN6sF@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 07 February 2013 21:19:04 Linus Walleij wrote:
> On Thu, Feb 7, 2013 at 8:42 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Thursday 07 February 2013, Linus Walleij wrote:
> 
> >> Actually I once read about a feature where the kernel provides
> >> a static page full of zeroes or something like this, that would be
> >> ideal to use in cases like this, then all of this dummy page
> >> allocation and freeing can be deleted.
> >
> > You mean empty_zero_page? That only works if this page is
> > read-only from the perspective of the DMA controller, but
> > then it would be a good fit, yes.
> 
> That's actually how it's used.
> 
> SPI is symmetric, and in the DMA case we're not poking
> data into the buffers from the CPU so the controller need
> something - anything - to stream to the block.
> 
> If we can use that page we'll even save a few remaps.

I'm slightly worried about the caching effects though. The
idea of the empty-zero page is that all user processes get
it when they read a page before they write to it, so the
data in it can essentially always be cache-hot.

If we do DMA from that page to a device what would be the
overhead of flushing the (clean) cache lines?

	Arnd
