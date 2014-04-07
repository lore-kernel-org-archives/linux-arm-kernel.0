From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Mon, 7 Apr 2014 08:37:28 -0700
Subject: [PATCH] i2c: cadence: fix Kconfig dependency
In-Reply-To: <5342481B.6020600@monstr.eu>
References: <1396811227-8851-1-git-send-email-wsa@the-dreams.de>
 <20140407063100.GN29751@pengutronix.de>
 <5342481B.6020600@monstr.eu>
Message-ID: <ee442030-88af-4cad-ab5c-fa7ec2b51ac2@TX2EHSMHS037.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2014-04-07 at 08:39AM +0200, Michal Simek wrote:
> On 04/07/2014 08:31 AM, Uwe Kleine-K?nig wrote:
> > Hello,
> > 
> > On Sun, Apr 06, 2014 at 09:07:07PM +0200, Wolfram Sang wrote:
> >> During development, the driver first really needed to depend on
> >> COMMON_CLK only. Later, it was switched to writel_relaxed, but it was
> >> forgotten to update the dependencies, so build errors occured:
> >>
> >> config: make ARCH=i386 allyesconfig
> >>
> >> All error/warnings:
> >>
> >>    drivers/i2c/busses/i2c-cadence.c: In function 'cdns_i2c_clear_bus_hold':
> >>>> drivers/i2c/busses/i2c-cadence.c:168:3: error: implicit declaration
> >>>> of function 'writel_relaxed' [-Werror=implicit-function-declaration]
> >>
> >> Use a very safe dependency for now.
> >>
> >> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> >> ---
> >>  drivers/i2c/busses/Kconfig | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> >> index 93165ff453ab..3d3b9b3577c5 100644
> >> --- a/drivers/i2c/busses/Kconfig
> >> +++ b/drivers/i2c/busses/Kconfig
> >> @@ -378,7 +378,7 @@ config I2C_BLACKFIN_TWI_CLK_KHZ
> >>  
> >>  config I2C_CADENCE
> >>  	tristate "Cadence I2C Controller"
> >> -	depends on COMMON_CLK
> >> +	depends on ARCH_ZYNQ
> > I'd suggest:
> > 
> > 	depends on ARM && (ARCH_ZYNC || COMPILE_TEST)
> > 
> > This way it's available for compile testing but still it doesn't appear
> > when configuring a kernel for a real machine.
> 
> I would suggest to add relaxed IO helper function to asm-generic/io.h
> to be available for all archs. Then we can avoid this type of errors.

ACK

	S?ren
