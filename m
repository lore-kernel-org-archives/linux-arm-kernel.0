From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 8 Feb 2013 23:10:02 +0100
Subject: [PATCH 2/5] spi: pl022: use generic DMA slave configuration if
 possible
In-Reply-To: <11938235.WbhQmuClDR@wuerfel>
References: <1359395857-1235-1-git-send-email-arnd@arndb.de>
 <3752726.iyKukyN6sF@wuerfel>
 <20130208162248.GY17833@n2100.arm.linux.org.uk>
 <11938235.WbhQmuClDR@wuerfel>
Message-ID: <CACRpkdYOB=XX+Ogs8SVrrwVdMw+xZ9u3BBwwhsKYJKu4tTdDOg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 8, 2013 at 5:28 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Friday 08 February 2013 16:22:48 Russell King - ARM Linux wrote:
>> If it's DMA _to_ a device, then we will only ever clean the lines prior to
>> a transfer, never invalidate them.  So that's not really a concern.  (There
>> better not be any dirty cache lines associated with the empty zero page
>> either.)
>
> Right, makes sense. I thought I had read about a CPU that
> could not flush a cache line without also invalidating
> it, but that must have been something other than ARM,
> or maybe I'm misremembering it.

I don't think it matters one bit. The page can contain a bitmap
of Donald Duck or zero FWIW. It's just that the DMA
controller just neeeds to read *something* that does not cause
a bus stall.

It's due to the syncronous nature of the SPI protocol, to get
something out you need to put something in. So when reading,
this is a way to feed in some junk.

So this goes on my TODO...

Yours,
Linus Walleij
