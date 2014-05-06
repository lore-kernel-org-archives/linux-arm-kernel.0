From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 6 May 2014 14:58:22 +0200
Subject: [GIT PULL] Versatile LEDs conversion
In-Reply-To: <20140505041156.GB11035@quad.lixom.net>
References: <CACRpkdb4VhN5Dt6ZoUNgwphxUD7Q69waF9vfO_=SenbvA=WSeA@mail.gmail.com>
 <20140505041156.GB11035@quad.lixom.net>
Message-ID: <201405061458.22231.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 05 May 2014, Olof Johansson wrote:
> On Fri, Mar 28, 2014 at 11:02:57AM +0100, Linus Walleij wrote:
> > Hi ARM SoC folks,
> > 
> > here is a Versatile LEDs patch stack, it has been finished for a while,
> > but delayed waiting for an ACK from the LEDs subsystem maintainer
> > which arrived today. (My bad for not hunting it more actively.)
> > 
> > I pretty sure the patches are safe and they need some rotation in linux-next,
> > but I understand if you want to wait until after v3.15-rc1 before pulling this
> > in. (I'll nag you later in that case.)
> 
> Merged into next/cleanup.

I got a build error today, since LEDS_VERSATILE can be built-in while LEDS_CLASS
is a module:

drivers/built-in.o: In function `versatile_leds_probe':
:(.text+0x155020): undefined reference to `led_classdev_register'

I suggest we turn this option into 'tristate' so that the dependency
tracking works correctly.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index 1e81d7a..6784c17 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -477,7 +477,7 @@ config LEDS_BLINKM
 	  through I2C. Say Y to enable support for the BlinkM LED.
 
 config LEDS_VERSATILE
-	bool "LED support for the ARM Versatile and RealView"
+	tristate "LED support for the ARM Versatile and RealView"
 	depends on ARCH_REALVIEW || ARCH_VERSATILE
 	depends on LEDS_CLASS
 	help
