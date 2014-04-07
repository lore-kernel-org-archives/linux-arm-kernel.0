From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Mon, 07 Apr 2014 11:02:35 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSF0gaTJjOiBjYWRlbmNlOiBmaXggS2NvbmZpZyBkZXBlbmRl?=
 =?UTF-8?B?bmN5?=
In-Reply-To: <20140407065657.GO29751@pengutronix.de>
References: <1396811227-8851-1-git-send-email-wsa@the-dreams.de>
 <1396852656.682914397@f273.i.mail.ru>
 <20140407065657.GO29751@pengutronix.de>
Message-ID: <1396854155.872298456@f287.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mon, 7 Apr 2014 08:56:57 +0200 ?? Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> Hello,
...
> > > On Sun, Apr 06, 2014 at 09:07:07PM +0200, Wolfram Sang wrote:
> > > > During development, the driver first really needed to depend on
> > > > COMMON_CLK only. Later, it was switched to writel_relaxed, but it was
> > > > forgotten to update the dependencies, so build errors occured:
> > > > 
> > > > config: make ARCH=i386 allyesconfig
> > > > 
> > > > All error/warnings:
> > > > 
> > > >    drivers/i2c/busses/i2c-cadence.c: In function 'cdns_i2c_clear_bus_hold':
> > > > >> drivers/i2c/busses/i2c-cadence.c:168:3: error: implicit declaration
> > > > >> of function 'writel_relaxed' [-Werror=implicit-function-declaration]
> > > > 
> > > > Use a very safe dependency for now.
> > > > 
> > > > Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> > > > ---
> > > >  drivers/i2c/busses/Kconfig | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> > > > index 93165ff453ab..3d3b9b3577c5 100644
> > > > --- a/drivers/i2c/busses/Kconfig
> > > > +++ b/drivers/i2c/busses/Kconfig
> > > > @@ -378,7 +378,7 @@ config I2C_BLACKFIN_TWI_CLK_KHZ
> > > >  
> > > >  config I2C_CADENCE
> > > >  	tristate "Cadence I2C Controller"
> > > > -	depends on COMMON_CLK
> > > > +	depends on ARCH_ZYNQ
> > > I'd suggest:
> > > 
> > > 	depends on ARM && (ARCH_ZYNC || COMPILE_TEST)
> > 
> > ARCH_ZYNC || (ARM && COMPILE_TEST)
> > 
> > Same, but more clear.
> "more clear" might be subjective, at least for me I don't see a benefit
> from one over the other.
> 
> hmm, considering a (hypothetical) driver that depends on I2C and is
> available on Zync but compiles on ARM, it would need either: 

No. Look at drivers/i2c/Kconfig:

"source drivers/i2c/busses/Kconfig" is under "if I2C" already.

---
