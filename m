From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 9 Mar 2012 17:09:22 +0100
Subject: [RFC] i.MX: drop secondary clocks
In-Reply-To: <20314.5967.278184.187691@ipc1.ka-ro>
References: <1331242949-22780-1-git-send-email-s.hauer@pengutronix.de>
 <20313.52782.832292.580932@ipc1.ka-ro>
 <20120309102931.GY3852@pengutronix.de>
 <20313.60910.420339.905973@ipc1.ka-ro>
 <20120309142205.GF3852@pengutronix.de>
 <20314.5967.278184.187691@ipc1.ka-ro>
Message-ID: <20120309160922.GG3852@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 09, 2012 at 03:44:31PM +0100, Lothar Wa?mann wrote:
> Hi,
> 
> Sascha Hauer writes:
> > On Fri, Mar 09, 2012 at 12:47:58PM +0100, Lothar Wa?mann wrote:
> > > Hi,
> > > 
> > > Sascha Hauer writes:
> > > > On Fri, Mar 09, 2012 at 10:32:30AM +0100, Lothar Wa?mann wrote:
> > > > > Hi,
> > > > > 
> > > > > Sascha Hauer writes:
> > > > > > Hi All,
> > > > > > 
> > > [...]
> > > > > I think that's a bad idea! Drivers should not have to know intimate
> > > > > details about the clock logic of the CPU core they are running on!
> > > > 
> > > > They don't have to. There really are different clocks connected to the
> > > > devices. If for example you have a look eSDHC Block diagram in the
> > > > reference Manual  you'll see that this has three clock inputs. All
> > > > we do is to tell the driver about these three clocks which are device
> > > > specific and not SoC specific. Which of these clocks are actually
> > > > gatetable varies from SoC to SoC. Also on some SoCs two of the three
> > > > clocks may be actually the same.
> > > > 
> > > At least this should be done in a way that is independent from the
> > > name of the clock on a specific SoC, but is related to the function of
> > > the clock for the driver. Thus instead of e.g. CLK_IPG and CLK_PER use
> > > CLK_REG and CLK_BITRATE.
> > 
> > 'per', 'ipg' and 'ahb' seems to be a common pattern with all i.MXs. Only
> > ahb is sometimes refered to as hclk. Do you also have a name for
> > ahb/hclk? I don't insist on specific names, in the end they are just
> > names and the pattern I used at least seems mostly consistent.
> > 
> CLK_BUS?
> 
> > I assume that any given device has a set of clocks as inputs which
> > should get device specific names. It's the job of the clock tree
> > to know which SoC clocks map to which device clocks. If now a newer
> > UART block has an additional clock, then we would depending on the
> > device id (fsl,imx7-uart) know that it requires the additional clock
> > and request it.
> > 
> It's also not the business of a device driver to know any details
> about clock dependencies on a specific SoC.
> We probably really need a bus layer that can hide the details of the
> bus architecture and their corresponding clocks from the device
> drivers.

I agree there's room for improvements, but I don't want to make that a
dependency for the generic clock support.

Does anyone know which clocks are really worth to be turned off for
powermanement? I have no idea whether we really save power when we for
example turn off aips_tz1_clk.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
