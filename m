From: atull@kernel.org (Alan Tull)
Date: Mon, 12 Dec 2016 10:44:36 -0600 (CST)
Subject: [PATCH 2/2] FPGA: Add TS-7300 FPGA manager
In-Reply-To: <39bc0569-81e1-8c35-0280-4ba1824b2710@gmail.com>
References: <20161211221750.27743-1-f.fainelli@gmail.com>
 <20161211221750.27743-3-f.fainelli@gmail.com>
 <alpine.DEB.2.10.1612120951520.3310@atull-730U3E-740U3E>
 <39bc0569-81e1-8c35-0280-4ba1824b2710@gmail.com>
Message-ID: <alpine.DEB.2.10.1612121040300.3310@atull-730U3E-740U3E>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 12 Dec 2016, Florian Fainelli wrote:

> On 12/12/2016 08:01 AM, Alan Tull wrote:
> > On Sun, 11 Dec 2016, Florian Fainelli wrote:
> > 
> >> Add support for loading bitstreams on the Altera Cyclone II FPGA
> >> populated on the TS-7300 board. This is done through the configuration
> >> and data registers offered through a memory interface between the EP93xx
> >> SoC and the FPGA.
> >>
> >> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> > 
> > Hi Florain,
> > 
> > Thanks for submitting!
> > 
> > How specific is this to the tx7300 board?
> > 
> > I'm unclear about the programming method here.  Are these registers
> > exposed by the EP93xx?  Is it possible that another cpu could access
> > these two registers to configure the cyclone ii?  Is this passive
> > serial?
> 
> So here is my understanding, from glancing at the TS-7300 board manual:
> 
> - there is an on-board CPLD which does a variety of services and I/O for
> the EP9302 SoC, one of these services is the configuration of the
> on-board FPGA
> 
> - the programming interface here is some kind of abstraction around a
> Cyclone II FPGA, and is by no means standard, nor directly exposed to
> the CPU
> 
> - unless you go through the CPLD, there is no other way that you could
> configure the FPGA
> 
> Does that help answer your questions?

Yes it does.  Maybe a brief comment explaining that similar to what
you just said.

> >> +static int ts73xx_fpga_write_init(struct fpga_manager *mgr, u32 flags,
> >> +				  const char *buf, size_t count)
> >> +{
> >> +	struct ts73xx_fpga_priv *priv = mgr->priv;
> >> +
> >> +	/* Reset the FPGA */
> >> +	writeb(0, priv->io_base + TS73XX_FPGA_CONFIG_REG);
> >> +	udelay(30);
> >> +	writeb(0x2, priv->io_base + TS73XX_FPGA_CONFIG_REG);
> >> +	udelay(80);
> > 
> > Could these udelay values be macros?
> 
> The bit definitions could be defined, but the delays, why would that be
> useful?

If it is helpful for someone reading the code to know what the delays
are, if some future generation of the board/cpld uses this same
driver.  So when this driver is broken for the next generation
board/cpld, people trying to fix this know what the delay is there for
and can have a better chance at adjusting the right delay.

> 
> > 
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static inline int ts73xx_fpga_can_write(struct ts73xx_fpga_priv *priv)
> >> +{
> >> +	unsigned int timeout = 1000;
> > 
> > Another macro?
> 
> The delay is just an arbitrary good timeout.
> -- 
> Florian
> 
