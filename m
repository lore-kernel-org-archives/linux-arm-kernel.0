From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 4 Jan 2011 13:41:54 +0800
Subject: [PATCH] ARM: mxs: Change duart device to use amba-pl011
In-Reply-To: <20110103103913.GE26785@n2100.arm.linux.org.uk>
References: <1292857064-5032-1-git-send-email-shawn.guo@freescale.com>
	<1292937130-32155-1-git-send-email-shawn.guo@freescale.com>
	<20101222202542.GT14221@pengutronix.de>
	<20101227114938.GA13154@freescale.com>
	<20110103103913.GE26785@n2100.arm.linux.org.uk>
Message-ID: <20110104054153.GA13140@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Mon, Jan 03, 2011 at 10:39:13AM +0000, Russell King - ARM Linux wrote:
> On Mon, Dec 27, 2010 at 07:49:40PM +0800, Shawn Guo wrote:
> > I did not see this problem. It's true that the clock is turned off
> > in amba_device_register. But later, the clock will be turned on
> > again by amba_probe -> amba_get_enable_pclk very soon.
> > 
> > But we should add something like below in mx28_clocks_init to reflect
> > the clock status and get usecount updated.
> > 
> > 	clk_enable(&uart_clk)
> > 
> > I ran into similar problem with fec driver, and would cover that in
> > fec patch set.
> 
> This sounds like entirely the wrong approach.  Please take some time to
> understand that there are different clocks which do different things.
> 
> The PCLK is the name ARM Ltd give to the APB bus clock.  This we name
> apb_pclk, and we expect platforms to provide it where possible.  This
> name will be looked up for every primecell device on the system.
> 
> If you don't provide an apb_pclk, it will find the device specific
> function clock.  This in itself is no bad thing, unless you use the
> device outside of the AMBA driver (iow, before probe or after remove)
> and helps identify when you've forgotten to provide an apb_pclk.
> 
I intended to let the amba bus driver get duart clock. But you are
right, I should provide an apb_pclk since it actually exists on mxs
processors. In case of duart, it is xbus (apbx) clock.

	_REGISTER_CLOCK("duart", "apb_pclk", xbus_clk)

Thanks for the comment. 

-- 
Regards,
Shawn
