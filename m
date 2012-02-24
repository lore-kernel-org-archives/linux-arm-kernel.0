From: jason@lakedaemon.net (Jason)
Date: Fri, 24 Feb 2012 10:55:57 -0500
Subject: [PATCH 2/3 v4] arm: kirkwood: add dreamplug (fdt) support.
In-Reply-To: <20120224075753.GA24858@lunn.ch>
References: <20120224075753.GA24858@lunn.ch>
Message-ID: <20120224155557.GR23524@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 24, 2012 at 08:57:53AM +0100, Andrew Lunn wrote:
> Hi Jason
> 
> Great to see this work going forward. I hope we can cooperating in the
> future. I have an out of tree kirkwood board i would like to supported
> via DT, and i also have a QNAP T119+ i can use for testing.

Awesome, I don't have one of those.

> I have some patches under development which will help. I've been
> porting the different Orion machines to use Mike Turquette generic CLK
> and clkdev...

It appears that changing core platform code across an entire
architecture is quite difficult.  ;-)  I hope it gets merged, but I'm
not going to hold my breath.

> ...so that the device drivers can determine for themselves
> what the clock is. tclk is then removed from the platform data
> structures, making DT a little bit simpler. This work should also
> solve the kirkwood clock gating which is going to be an issue for
> DT. For example, your board file is probably currently calling
> kirkwood_spi_init(), in order to use SPI. This does:
> 
> kirkwood_clk_ctrl |= CGC_RUNIT;
> 
> and so ensures that the RUNIT clock does not get turned off in a
> lateinit call. Once you have DT, this flag is not going to be set, and
> so you have the danger of the clock to the SPI core gets turned
> off. The clk framework should solve this, since the SPI device driver
> will claim the clock and ensure it keeps running.

Why not convert kirkwood_clock_gate() (mach-kirkwood/common.c:480) to
make use of of_device_is_available() ?  That would eliminate one global
variable.  That wouldn't even require a change to the devicetrees, since
it returns 1 if 'status' doesn't exist (or is set to "okay" or "ok").

I don't even see where CGC_RUNIT is used in kirkwood_clock_gate(),
except at line 528.  Maybe I'm missing something, a lot of this is new
to me.


thx,

Jason.
