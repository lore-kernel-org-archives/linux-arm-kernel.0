From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 7 Feb 2013 21:19:04 +0100
Subject: [PATCH 2/5] spi: pl022: use generic DMA slave configuration if
 possible
In-Reply-To: <201302071942.54642.arnd@arndb.de>
References: <1359395857-1235-1-git-send-email-arnd@arndb.de>
 <201301291313.03511.arnd@arndb.de>
 <CACRpkdZNpCJwp-uaH6feTcaPesNouwpHt-hO-M9v52G=Ux+Hqw@mail.gmail.com>
 <201302071942.54642.arnd@arndb.de>
Message-ID: <CACRpkdbunPGtR4p_kY4q8WEb8iwkEbdo_icDyrLZwKrCe0wXqw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 7, 2013 at 8:42 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 07 February 2013, Linus Walleij wrote:

>> Actually I once read about a feature where the kernel provides
>> a static page full of zeroes or something like this, that would be
>> ideal to use in cases like this, then all of this dummy page
>> allocation and freeing can be deleted.
>
> You mean empty_zero_page? That only works if this page is
> read-only from the perspective of the DMA controller, but
> then it would be a good fit, yes.

That's actually how it's used.

SPI is symmetric, and in the DMA case we're not poking
data into the buffers from the CPU so the controller need
something - anything - to stream to the block.

If we can use that page we'll even save a few remaps.

Yours,
Linus Walleij
