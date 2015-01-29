From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 29 Jan 2015 23:24:32 +0100
Subject: [PATCH] crypto: atmel: remove bogus select
In-Reply-To: <20150129073328.GC1097@odux.rfo.atmel.com>
References: <1780191.gdgDmCPaN0@wuerfel>
 <20150129073328.GC1097@odux.rfo.atmel.com>
Message-ID: <2762861.1qAcXXChEF@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 29 January 2015 08:33:28 Ludovic Desroches wrote:
> On Wed, Jan 28, 2015 at 09:09:16PM +0100, Arnd Bergmann wrote:
> > The Atmel at91 crypto driver unconditionally selects AT_HDMAC,
> > which results in a Kconfig warning if that driver is not enabled:
> > 
> > warning: (CRYPTO_DEV_ATMEL_AES) selects AT_HDMAC which has unmet direct dependencies (DMADEVICES && ARCH_AT91)
> > 
> > The crypty driver itself does not actually have a dependency
> > on a particular dma engine, other than this being the one that
> > is used in at91.
> > 
> > Removing the 'select' gets rid of the warning, with no apparent
> > downsides.
> 
> This driver doesn't work without DMA. I think it is the reason why the
> select AT_HDMAC was used.
> 

I understand the intention, but this what was written in Kconfig is
not the correct way to express it.

A lot of drivers require DMA_ENGINE support, but the linux/dmaengine.h
header file provides static inline helpers to make sure that things
still compile if that is disabled, and in the example I mentioned
above, it does build, but clearly cannot work as the real dmaengine
interfaces are not provided by the kernel.

What we could do to express the runtime dependency correctly is to add

	depends on (ARCH_AT91 && AT_HDMAC) || COMPILE_TEST

which would let the driver only be enabled in cases that have a
reasonable chance of working, but still allow it to be built
everywhere else.

	Arnd
