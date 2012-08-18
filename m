From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Sat, 18 Aug 2012 09:42:16 +0200
Subject: [alsa-devel] Lockups reading from i.MX51 SSI registers
In-Reply-To: <20120817222738.GH18871@opensource.wolfsonmicro.com>
References: <20120810195005.GP24328@opensource.wolfsonmicro.com>
 <20120810195638.GF1451@pengutronix.de>
 <20120810201456.GL25520@pengutronix.de>
 <20120810210647.GG1451@pengutronix.de>
 <CAOMZO5DAs=jm-08tWdfdLG_nm=gdi-Q_RReiUKGM_RCgB82dwA@mail.gmail.com>
 <20120817222738.GH18871@opensource.wolfsonmicro.com>
Message-ID: <20120818074216.GG2232@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 17, 2012 at 11:27:38PM +0100, Mark Brown wrote:
> On Fri, Aug 17, 2012 at 04:08:47PM -0300, Fabio Estevam wrote:
> 
> > Also, for the playback to work you need to install the SDMA firmware.
> 
> This is deadlocking during boot, I'm getting nowhere near trying
> playback.
You're on i.MX35, right. I had to add

	clk_register_clkdev(clk[ssi1_gate], NULL, "imx-ssi.0");

to arch/arm/mach-imx/clk-imx35.c to be able to access the codec.
(Obviously this is a hack, and to do it better, you'd need to change

	clk_register_clkdev(clk[ssi1_div_post], "per", "imx-ssi.0");

to use ssi1_gate and fix the ssi-driver to be aware that there are two
clocks to handle.)

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
