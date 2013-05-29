From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 29 May 2013 15:26:34 +0200
Subject: [PATCH] SPI: Unify simple platform data for some controllers
In-Reply-To: <20130529112002.GS3660@sirena.org.uk>
References: <1369809742-4220-1-git-send-email-shc_work@mail.ru>
 <1369817353.993218858@f175.mail.ru> <20130529112002.GS3660@sirena.org.uk>
Message-ID: <201305291526.35099.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 29 May 2013, Mark Brown wrote:
> On Wed, May 29, 2013 at 12:49:13PM +0400, Alexander Shiyan wrote:
> > > On Wednesday 29 May 2013 10:42:22 Alexander Shiyan wrote:
> 
> > > Wouldn't it be better to kill off the platform_data for these drivers
> > > and pass the gpio number through spi->controller_data as the
> > > spi_gpio driver does?
> 
> > Interesting way. Just one question remains, for using not-dt variant,
> > how  we should specify num_chipselect parameter for master?
> > I see only way for specify maximum constant in the driver.
> 
> We should fix that to be dynamic, having a fixed number is not sensible
> when GPIOs are usable for chip select. 

Agreed (not that I have much of a say on this matter).

> We probably also want to make
> GPIO chip select support a standard thing that's available with every
> driver rather than something the driver has to know about but that's a
> separate bit of work.

That actually seems simpler than doing it in just one driver: if
we add a cs_gpio field to spi_board_info, spi_new_device could
just copy that information into the new spi_device instead of
taking it from master->cs_gpios.

	Arnd
