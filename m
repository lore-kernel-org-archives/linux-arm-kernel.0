From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 9 Mar 2012 11:29:31 +0100
Subject: [RFC] i.MX: drop secondary clocks
In-Reply-To: <20313.52782.832292.580932@ipc1.ka-ro>
References: <1331242949-22780-1-git-send-email-s.hauer@pengutronix.de>
 <20313.52782.832292.580932@ipc1.ka-ro>
Message-ID: <20120309102931.GY3852@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 09, 2012 at 10:32:30AM +0100, Lothar Wa?mann wrote:
> Hi,
> 
> Sascha Hauer writes:
> > Hi All,
> > 
> > On i.MX we currently have grouped clocks, also known as secondary clocks.
> > These are clocks that get enabled when the primary clock gets enabled.  This
> > doesn't integrate well into the generic clock framework. Also we often return
> > the rate of one clock and really enable/disable another clock. I plan to get
> > rid of these clocks by exposing the individual clocks to the drivers. The
> > following is meant as an example how this can be done. I have a more complete
> > series internally but this conflicts with Richards clk_prepare series.
> > 
> > Thanks to the nature of clk_get we can simply clk_get the individual clocks in
> > the drivers and the current clock implementation will always return the one
> > with con_id = NULL. Then with the generic clk implementation the drivers will
> > finally get the individual clocks.
> > 
> > So unless there are objections I will follow up on this after the next merge
> > window.
> > 
> I think that's a bad idea! Drivers should not have to know intimate
> details about the clock logic of the CPU core they are running on!

They don't have to. There really are different clocks connected to the
devices. If for example you have a look eSDHC Block diagram in the
reference Manual  you'll see that this has three clock inputs. All
we do is to tell the driver about these three clocks which are device
specific and not SoC specific. Which of these clocks are actually
gatetable varies from SoC to SoC. Also on some SoCs two of the three
clocks may be actually the same.

> 
> They should simply request a clock for the unit they operate on and
> the clock core code should figure out which other clocks need to be
> enabled on a specific machine to get the unit working.

Yes, that's what we want to do, except that devices do not need 'a'
clock but several. And the clock core figures out which other clocks
have to be activated, these are the parent clocks.

I also don't really like exposing this to the drivers, but it's a clean
way to do so. A framebuffer driver needs a pixel clock which must be
enabled when the display is turned on. It may also have a register clock
which has to be turned on when we want to access registers. These are
two different clocks and the driver can make use of this (not that we
currently do though...)

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
