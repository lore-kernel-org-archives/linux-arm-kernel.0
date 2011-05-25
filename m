From: mika.westerberg@iki.fi (Mika Westerberg)
Date: Wed, 25 May 2011 22:54:13 +0300
Subject: [PATCH 1/5] dmaengine: add ep93xx DMA support
In-Reply-To: <BANLkTi=3z3kO5VEe2up8Mfm+bNXkY3baUw@mail.gmail.com>
References: <cover.1306082097.git.mika.westerberg@iki.fi>
	<e6777eb9f7228ee1dadec1f0c9f16c3afc44c307.1306082097.git.mika.westerberg@iki.fi>
	<BANLkTi=3z3kO5VEe2up8Mfm+bNXkY3baUw@mail.gmail.com>
Message-ID: <20110525195413.GC2996@acer>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 25, 2011 at 10:39:52AM +0200, Linus Walleij wrote:
> 
> No so much a review comment as an observation: I opposed the merge of the
> EP93xx SPI driver in drivers/spi/ep93xx_spi.c on the grounds that it was close
> enough to amba-pl022.c that it could use that driver instead.

I re-checked the specs and indeed, as discussed previously, it is clear that
Cirrus (or ARM) copied the interface from other. Even the wording in the
document is identical in many places. However, in ep93xx User's Guide, there
is no mention about SSP being AMBA PrimeCell peripheral. For UARTs it is
mentioned... go figure.

There are differences also, some of the bits in control registers are in
different places. Interrupt registers are completely different and there is no
DMA control register at all. The same things we discussed before.

> One of the arguments against was that you were going to do custom DMA
> and stuff. Now you're using the DMAengine, so can you please reconsider
> refactoring amba-pl022.c to suit your needs and you'll get DMA support for
> free mor or less.

Back then, it wasn't known how the M2M DMA interface (the one used by SSP and
IDE) was going to be implemented. Now that the dmaengine has become de facto
API, it is clear that any "new" DMA implementations should implement that
instead of some home grown API. Initially my M2M DMA experiments were just
like their M2P counterparts but Ryan suggested dmaengine approach.

IMHO it is better to have ep93xx implementation on its own driver since it is
not a real AMBA PL022 peripheral but some weird hack made by Cirrus (although
my opinions are bit biased).

Thanks,
MW
