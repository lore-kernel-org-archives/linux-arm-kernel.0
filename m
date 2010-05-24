From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 24 May 2010 22:32:37 +0100
Subject: Should we pass amba device peripheral id with device structure
	or not?
In-Reply-To: <4BFA02DC.6090906@st.com>
References: <4BECF57A.4050802@st.com>
	<20100521193802.GG11042@n2100.arm.linux.org.uk>
	<4BFA02DC.6090906@st.com>
Message-ID: <20100524213237.GH21117@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 24, 2010 at 10:08:52AM +0530, Viresh KUMAR wrote:
> On 5/22/2010 1:08 AM, Russell King - ARM Linux wrote:
> > On Fri, May 14, 2010 at 12:32:18PM +0530, Viresh KUMAR wrote:
> >> amba_device_register function reads and updates peripheral id from
> >> hardware registers, whenever we register any amba device. If clock
> >> to device is disabled, then amba_device_register will not be able
> >> to read and update this value.
> > 
> > This is a potential problem - if the drivers are already initialized
> > in the kernel, then the drivers will try to initialize as soon as
> > amba_device_register() is called.  If the registers aren't accessible
> > at amba_device_register() time, the driver initialization could fail.
> > 
> > I think it's better to understand what's going on here before making
> > suggestions.
> > 
> > The clks in the primecell drivers are for the external side clocks
> > only; these drivers all make the assumption that the AMBA bus clock
> > is always enabled.  Does your SoC turn the AMBA bus clock to peripherals
> > on and off?
> 
> There is only one bit per peripheral to enable/disable clock.
> So with clocks disabled, we get 0x00000000 on read from device registers.

So... that must mean your hardware gates both the peripheral clock and
the per-primecell bus clock together.  Let's hope that the bus clock
control takes notice of any in-progress bus transaction...

However, I'm still concerned - the driver's use of clk_enable/clk_disable
is based on the assumption that these calls do not affect the bus clock -
we expect to be able to write to registers before the first clk_enable()
call.

And as I've said (and you cut off of the quote) if we have SoCs where the
bus clock is controllable, we need amba/bus.c to deal with that situation.

Okay, I'll look at addressing that _after_ this merge window has closed.
