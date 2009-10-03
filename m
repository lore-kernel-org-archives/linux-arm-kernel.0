From: nico@fluxnic.net (Nicolas Pitre)
Date: Fri, 02 Oct 2009 22:50:39 -0400 (EDT)
Subject: kirkwood openrd: random kernel crashes with git kernel
In-Reply-To: <20091002084000.7c93d634@marrow.netinsight.se>
References: <200910010904.18923.dk-arm-linux@gmx.de>
	<20091001081216.GA4941@twin.sascha.silbe.org>
	<20091001101925.50a592fd@marrow.netinsight.se>
	<alpine.LFD.2.00.0910011218410.4997@xanadu.home>
	<20091002084000.7c93d634@marrow.netinsight.se>
Message-ID: <alpine.LFD.2.00.0910022241340.4997@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2 Oct 2009, Simon Kagstrom wrote:

> On Thu, 01 Oct 2009 12:19:21 -0400 (EDT)
> Nicolas Pitre <nico@fluxnic.net> wrote:
> 
> > > I should add that I've seen this error even without openocd connected,
> > > so this seems to be a real error. Anyway, I guess this will sooner or
> > > later be applied (in some form) upstream, so openrd should benefit
> > > "automatically" from it.
> > > 
> > > However, with OpenOCD there are other type of crashes which look very
> > > random, so I believe those will stay even with this.
> > 
> > Please send me information about those when you can.
> 
> The nohlt argument seems to fix them, thanks! Without it I get random
> memory corruption errors such as this:
[...]

Good.  Just so that you know the reason: the nohlt argument tells the 
kernel not to use the wait-for-interrupt instruction when idle.  This 
basically turns the idle loop into a busy loop.

The WFI instruction is normally used because it turns the CPU clock off 
to save power. Unfortunately, the clock to the JTAG unit is also turned 
off in that case and JTAG communication goes down the drain when that 
occurs.  Depending on exactly when the WFI mode is entered, if that 
happens in the middle of a JTAG communication then strange things may 
happen.  With nohlt the CPU clock is never stopped.


Nicolas
