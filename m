From: LW@KARO-electronics.de (=?utf-8?Q?Lothar_Wa=C3=9Fmann?=)
Date: Fri, 9 Mar 2012 12:47:58 +0100
Subject: [RFC] i.MX: drop secondary clocks
In-Reply-To: <20120309102931.GY3852@pengutronix.de>
References: <1331242949-22780-1-git-send-email-s.hauer@pengutronix.de>
 <20313.52782.832292.580932@ipc1.ka-ro>
 <20120309102931.GY3852@pengutronix.de>
Message-ID: <20313.60910.420339.905973@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Sascha Hauer writes:
> On Fri, Mar 09, 2012 at 10:32:30AM +0100, Lothar Wa?mann wrote:
> > Hi,
> > 
> > Sascha Hauer writes:
> > > Hi All,
> > > 
[...]
> > I think that's a bad idea! Drivers should not have to know intimate
> > details about the clock logic of the CPU core they are running on!
> 
> They don't have to. There really are different clocks connected to the
> devices. If for example you have a look eSDHC Block diagram in the
> reference Manual  you'll see that this has three clock inputs. All
> we do is to tell the driver about these three clocks which are device
> specific and not SoC specific. Which of these clocks are actually
> gatetable varies from SoC to SoC. Also on some SoCs two of the three
> clocks may be actually the same.
> 
At least this should be done in a way that is independent from the
name of the clock on a specific SoC, but is related to the function of
the clock for the driver. Thus instead of e.g. CLK_IPG and CLK_PER use
CLK_REG and CLK_BITRATE.

> > They should simply request a clock for the unit they operate on and
> > the clock core code should figure out which other clocks need to be
> > enabled on a specific machine to get the unit working.
> 
> Yes, that's what we want to do, except that devices do not need 'a'
> clock but several. And the clock core figures out which other clocks
> have to be activated, these are the parent clocks.
> 
What about devices which have multiple 'parent' clocks that are
completely unrelated wrt. each other? In the current clock system you
can model this by having secondary clocks.
How would you represent the current structure on i.MX53:
uart_ipg_clk <- aips_tz1_clk <-+- ahb_clk
                               +-> ahb_max_clk
in the new model?
Should every driver have to request the ahb_max_clk in addition to the
uart_ipg_clk?

What, if you have a device on a number of SoCs with a certain set of
clocks, but on a later SoC another clock is required for the device?
You would not only have to change the driver to add the new clock but
also would have to add that clock as a dummy clock in the core clock
code for all previous SoCs that did not provide that clock.

> I also don't really like exposing this to the drivers, but it's a clean
> way to do so. A framebuffer driver needs a pixel clock which must be
> enabled when the display is turned on. It may also have a register clock
> which has to be turned on when we want to access registers. These are
> two different clocks and the driver can make use of this (not that we
> currently do though...)
> 
But we could do so without any problem.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
