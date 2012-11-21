From: cavokz@gmail.com (Domenico Andreoli)
Date: Wed, 21 Nov 2012 01:43:09 +0100
Subject: [PATCH] S3C24XX: Fix console baud rate guessing
In-Reply-To: <20121114173453.GJ3290@n2100.arm.linux.org.uk>
References: <k809hq$1q3$1@ger.gmane.org>
 <20121114173453.GJ3290@n2100.arm.linux.org.uk>
Message-ID: <20121121004309.GA29633@glitch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Domenico Andreoli <domenico.andreoli@linux.com>

On Wed, Nov 14, 2012 at 05:34:53PM +0000, Russell King - ARM Linux wrote:
> On Wed, Nov 14, 2012 at 10:23:55PM +0800, woody wrote:
> > I just built a 3.2.x ARM kernel and tried to have it boot by a boot  
> > loader (vivi) on my s3c2410a ARM board.  The kernel was built with  
> > default configuration s3c2410.
> 
> I reported that S3C2410 is totally dead with 3.x kernels about a month
> ago and got no response what so ever from anyone.  I guess S3C2410 is
> just not cared for anymore.
> 
> When I get sufficient motivation, I'll try and track down what's going
> wrong, but it means taking the old mailing list server (and now list
> archive) offline for a while.

I found something also on my S3C2440. The board doesn't die but prints
garbage on the console. Indeed the baud rate guessing is broken (it's ok
if specified manually on the cmdline),
	
commit c3310fbbeb9db6967900ed22eb3d0bd0bb0e892c
Author: Thomas Abraham <thomas.abraham@linaro.org>
Date:   Mon Oct 24 11:47:57 2011 +0200

    serial: samsung: remove all uses of get_clksrc and set_clksrc
    
    With clkdev based clock lookup support, the clock set and get operation
    using clock names communicated between the samsung uart driver and the
    SoC specific extension can be removed.
    
    In addition to that, for each platform specific extension, add the
    default clock selection, number of clock options for uart baud generator,
    clock selection bit mask and shift values which is required by the
    clkdev support in samsung uart driver.
    
    The default clock selection value 'def_clk_sel' specifies the default clock
    to be used as the source clock for baud rate generator in case the platform
    code does not specify the same.
    
    Cc: Ben Dooks <ben-linux@fluff.org>
    Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
    Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>


To restore previous functionality I had to change the default UCON clock
back to UCLK.

Signed-off-by: Domenico Andreoli <domenico.andreoli@linux.com>
--
diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
index 7f04717..316b703 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -1572,7 +1572,7 @@ static struct s3c24xx_serial_drv_data s3c2440_serial_drv_data = {
                .tx_fifofull    = S3C2440_UFSTAT_TXFULL,
                .tx_fifomask    = S3C2440_UFSTAT_TXMASK,
                .tx_fifoshift   = S3C2440_UFSTAT_TXSHIFT,
-               .def_clk_sel    = S3C2410_UCON_CLKSEL2,
+               .def_clk_sel    = S3C2410_UCON_CLKSEL1,
                .num_clks       = 4,
                .clksel_mask    = S3C2412_UCON_CLKMASK,
                .clksel_shift   = S3C2412_UCON_CLKSHIFT,





The additional condition is that board file does not specify a 

the clocks being properly configured. 

 Something that doesn't happen if
the baud rate is specified onthe command line.

detection and goes unnoticed if you manually specify it on the cmdline
(like I do).

On my S3C2440 

I've a few observation
