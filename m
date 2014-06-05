From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 05 Jun 2014 13:24:16 +0200
Subject: [PATCH] i2c: mux: pca954x needs gpiolib
In-Reply-To: <6840846.92XabYdCA4@avalon>
References: <17059569.EZXzqhtzTf@wuerfel> <6840846.92XabYdCA4@avalon>
Message-ID: <4499715.bEb4MNR8Tt@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 05 June 2014 12:56:08 Laurent Pinchart wrote:
> 
> On Thursday 05 June 2014 12:44:47 Arnd Bergmann wrote:
> > commit 4807e8459bce ("i2c: mux: pca954x: Use the descriptor-based GPIO
> > API") moved this driver over to the gpio descriptor API, which means
> > we now have a dependency on GPIOLIB and get this build error when
> > it is disabled:
> > 
> > i2c/muxes/i2c-mux-pca954x.c: In function 'pca954x_probe':
> > i2c/muxes/i2c-mux-pca954x.c:204:2: error: implicit declaration of function
> > 'devm_gpiod_get' [-Werror=implicit-function-declaration] gpio =
> > devm_gpiod_get(&client->dev, "reset");
> >   ^
> > i2c/muxes/i2c-mux-pca954x.c:204:7: warning: assignment makes pointer from
> > integer without a cast [enabled by default] gpio =
> > devm_gpiod_get(&client->dev, "reset");
> >        ^
> > i2c/muxes/i2c-mux-pca954x.c:206:3: error: implicit declaration of function
> > 'gpiod_direction_output' [-Werror=implicit-function-declaration]
> > gpiod_direction_output(gpio, 0);
> >    ^
> > 
> > This adds the dependency in Kconfig as we do for other similar drivers.
> 
> I've sent "i2c: pca954x: Fix compilation without CONFIG_GPIOLIB" yesterday, 
> which fixes the compilation issue by including <linux/gpio/consumer.h>. When 
> CONFIG_GPIOLIB isn't set the header defines stub functions, keeping the driver 
> usable without GPIOLIB support.

Ok, makes sense. Should we remove the 'depends on GPIOLIB' from other
drivers doing the same, too?

	Arnd
