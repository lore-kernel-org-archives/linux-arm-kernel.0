From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 03 Oct 2011 16:47:07 +0200
Subject: [alsa-devel] [PATCH 2/6] ASoC: codecs: AK4641 depends on GPIOLIB
In-Reply-To: <20111003143553.GG23811@sirena.org.uk>
References: <1317587284-2776-1-git-send-email-arnd@arndb.de>
	<20111003134527.GF11710@n2100.arm.linux.org.uk>
	<20111003143553.GG23811@sirena.org.uk>
Message-ID: <1343003.MpQlxoEPa6@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 03 October 2011 15:35:53 Mark Brown wrote:
> On Mon, Oct 03, 2011 at 02:45:27PM +0100, Russell King - ARM Linux wrote:
> > On Sun, Oct 02, 2011 at 09:41:07PM +0100, Mark Brown wrote:
> 
> > > No, gpiolib is one implementation of the GPIO API but if platforms want
> > > to go and define their own that's currently OK (personally I think at
> > > this point we should just be converting all the stragglers over to
> > > gpiolib).  As things stand we shouldn't have dependencies on a
> > > particular implementation of the API.
> 
> > Then it should depend on GENERIC_GPIO (not to be confused with GPIO_GENERIC,
> > the generic gpiolib driver), which is the symbol meaning that the GPIO API
> > is provided by something.
> 
> Not for devices like this where the GPIOs are an optional thing the
> driver can use, a dependency is far too strong.  Devices like that
> should be able to rely on the stubs.

FWIW, while trying to reproduce this (I still could not), I stumbled over a
different build error with

CONFIG_ARCH_PRIMA2=y
CONFIG_SND_SOC_ALL_CODECS=m
CONFIG_SND_SOC_WM1250_EV1=m

sound/soc/codecs/wm1250-ev1.c:32:14: error: array type has incomplete element type
sound/soc/codecs/wm1250-ev1.c: In function 'wm1250_ev1_pdata':
sound/soc/codecs/wm1250-ev1.c:126:87: error: negative width in bit-field '<anonymous>'
sound/soc/codecs/wm1250-ev1.c:134:111: error: negative width in bit-field '<anonymous>'
sound/soc/codecs/wm1250-ev1.c: In function 'wm1250_ev1_free':
sound/soc/codecs/wm1250-ev1.c:155:103: error: negative width in bit-field '<anonymous>'

	Arnd
