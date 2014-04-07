From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Mon, 7 Apr 2014 09:18:10 -0700
Subject: [PATCH] i2c: cadence: fix Kconfig dependency
In-Reply-To: <1396854155.872298456@f287.i.mail.ru>
References: <1396811227-8851-1-git-send-email-wsa@the-dreams.de>
 <1396852656.682914397@f273.i.mail.ru>
 <20140407065657.GO29751@pengutronix.de>
 <1396854155.872298456@f287.i.mail.ru>
Message-ID: <4c4d2ba5-f5f6-4589-8a48-6a88d1c16098@VA3EHSMHS046.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2014-04-07 at 11:02AM +0400, Alexander Shiyan wrote:
> Mon, 7 Apr 2014 08:56:57 +0200 ?? Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> > Hello,
> ...
> > > > On Sun, Apr 06, 2014 at 09:07:07PM +0200, Wolfram Sang wrote:
> > > > > During development, the driver first really needed to depend on
> > > > > COMMON_CLK only. Later, it was switched to writel_relaxed, but it was
> > > > > forgotten to update the dependencies, so build errors occured:
> > > > > 
> > > > > config: make ARCH=i386 allyesconfig
> > > > > 
> > > > > All error/warnings:
> > > > > 
> > > > >    drivers/i2c/busses/i2c-cadence.c: In function 'cdns_i2c_clear_bus_hold':
> > > > > >> drivers/i2c/busses/i2c-cadence.c:168:3: error: implicit declaration
> > > > > >> of function 'writel_relaxed' [-Werror=implicit-function-declaration]
> > > > > 
> > > > > Use a very safe dependency for now.
> > > > > 
> > > > > Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> > > > > ---
> > > > >  drivers/i2c/busses/Kconfig | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> > > > > index 93165ff453ab..3d3b9b3577c5 100644
> > > > > --- a/drivers/i2c/busses/Kconfig
> > > > > +++ b/drivers/i2c/busses/Kconfig
> > > > > @@ -378,7 +378,7 @@ config I2C_BLACKFIN_TWI_CLK_KHZ
> > > > >  
> > > > >  config I2C_CADENCE
> > > > >  	tristate "Cadence I2C Controller"
> > > > > -	depends on COMMON_CLK
> > > > > +	depends on ARCH_ZYNQ
> > > > I'd suggest:
> > > > 
> > > > 	depends on ARM && (ARCH_ZYNC || COMPILE_TEST)
> > > 
> > > ARCH_ZYNC || (ARM && COMPILE_TEST)
> > > 
> > > Same, but more clear.
> > "more clear" might be subjective, at least for me I don't see a benefit
> > from one over the other.
> > 
> > hmm, considering a (hypothetical) driver that depends on I2C and is
> > available on Zync but compiles on ARM, it would need either: 
> 
> No. Look at drivers/i2c/Kconfig:

I'd propose the below fix. The relaxed IO helpers are currently
available on ARM only and the clock notifier used, depends on
COMMON_CLK. I2C-related dependencies should be okay due to the location in
Kconfig of this option.

	Thanks,
	S?ren

---------------8<---------------8<----------------8<-----------------8<-----------8<-------
Date: Sun, 6 Apr 2014 15:19:34 -0700
Subject: [PATCH] i2c: cadence: Add dependency on ARM

Due to switching to the (read|write)l_relaxed IO helpers, building this
driver fails on non-ARM architectures, which don't provide these helpers
with the following error:
  All error/warnings:

     drivers/i2c/busses/i2c-cadence.c: In function 'cdns_i2c_clear_bus_hold':
  >> drivers/i2c/busses/i2c-cadence.c:168:3: error: implicit declaration of function 'writel_relaxed' [-Werror=implicit-function-declaration]
        cdns_i2c_writereg(reg & ~CDNS_I2C_CR_HOLD, CDNS_I2C_CR_OFFSET);
        ^
     cc1: some warnings being treated as errors

Make the driver additionally depend on CONFIG_ARM to fix this.

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---
 drivers/i2c/busses/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 66e68e48218f..9f546eecd322 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -377,7 +377,7 @@ config I2C_BLACKFIN_TWI_CLK_KHZ
 
 config I2C_CADENCE
 	tristate "Cadence I2C Controller"
-	depends on COMMON_CLK
+	depends on ARM && COMMON_CLK
 	help
 	  Say yes here to select Cadence I2C Host Controller. This controller is
 	  e.g. used by Xilinx Zynq.
-- 
1.9.1.1.gbb9f595
