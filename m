From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 9 Mar 2012 15:22:05 +0100
Subject: [RFC] i.MX: drop secondary clocks
In-Reply-To: <20313.60910.420339.905973@ipc1.ka-ro>
References: <1331242949-22780-1-git-send-email-s.hauer@pengutronix.de>
 <20313.52782.832292.580932@ipc1.ka-ro>
 <20120309102931.GY3852@pengutronix.de>
 <20313.60910.420339.905973@ipc1.ka-ro>
Message-ID: <20120309142205.GF3852@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 09, 2012 at 12:47:58PM +0100, Lothar Wa?mann wrote:
> Hi,
> 
> Sascha Hauer writes:
> > On Fri, Mar 09, 2012 at 10:32:30AM +0100, Lothar Wa?mann wrote:
> > > Hi,
> > > 
> > > Sascha Hauer writes:
> > > > Hi All,
> > > > 
> [...]
> > > I think that's a bad idea! Drivers should not have to know intimate
> > > details about the clock logic of the CPU core they are running on!
> > 
> > They don't have to. There really are different clocks connected to the
> > devices. If for example you have a look eSDHC Block diagram in the
> > reference Manual  you'll see that this has three clock inputs. All
> > we do is to tell the driver about these three clocks which are device
> > specific and not SoC specific. Which of these clocks are actually
> > gatetable varies from SoC to SoC. Also on some SoCs two of the three
> > clocks may be actually the same.
> > 
> At least this should be done in a way that is independent from the
> name of the clock on a specific SoC, but is related to the function of
> the clock for the driver. Thus instead of e.g. CLK_IPG and CLK_PER use
> CLK_REG and CLK_BITRATE.

'per', 'ipg' and 'ahb' seems to be a common pattern with all i.MXs. Only
ahb is sometimes refered to as hclk. Do you also have a name for
ahb/hclk? I don't insist on specific names, in the end they are just
names and the pattern I used at least seems mostly consistent.

> 
> > > They should simply request a clock for the unit they operate on and
> > > the clock core code should figure out which other clocks need to be
> > > enabled on a specific machine to get the unit working.
> > 
> > Yes, that's what we want to do, except that devices do not need 'a'
> > clock but several. And the clock core figures out which other clocks
> > have to be activated, these are the parent clocks.
> > 
> What about devices which have multiple 'parent' clocks that are
> completely unrelated wrt. each other? In the current clock system you
> can model this by having secondary clocks.
> How would you represent the current structure on i.MX53:
> uart_ipg_clk <- aips_tz1_clk <-+- ahb_clk
>                                +-> ahb_max_clk
> in the new model?
> Should every driver have to request the ahb_max_clk in addition to the
> uart_ipg_clk?

No.

The dependeny to the aips_tz1_clk comes in because the UART is behind
the AIPS bridge. That's a dependency on bus topology level but not on clock
topology level. If we really have to handle this then on bus level. The
i.MX5 devicetree already shows this bus topology, it should be doable
to hook drivers on fsl,aips-bus which handle the clock.

Unfortunately the documentation where these clocks are really used goes
to zero and the FSL sourcecode is rather confusing in this area. I think
we will learn more about it once we have something in the generic clock
framework which disables the unused clocks.

> 
> What, if you have a device on a number of SoCs with a certain set of
> clocks, but on a later SoC another clock is required for the device?

I assume that any given device has a set of clocks as inputs which
should get device specific names. It's the job of the clock tree
to know which SoC clocks map to which device clocks. If now a newer
UART block has an additional clock, then we would depending on the
device id (fsl,imx7-uart) know that it requires the additional clock
and request it.

> You would not only have to change the driver to add the new clock but
> also would have to add that clock as a dummy clock in the core clock
> code for all previous SoCs that did not provide that clock.
> 
> > I also don't really like exposing this to the drivers, but it's a clean
> > way to do so. A framebuffer driver needs a pixel clock which must be
> > enabled when the display is turned on. It may also have a register clock
> > which has to be turned on when we want to access registers. These are
> > two different clocks and the driver can make use of this (not that we
> > currently do though...)
> > 
> But we could do so without any problem.

Not without exposing the individual clocks to the devices.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
