From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Sat, 11 May 2013 09:54:22 -0700
Subject: [PATCH RFC] clk: Introduce userspace clock driver
In-Reply-To: <20130510212422.GY3200@sirena.org.uk>
References: <1368207091-32538-1-git-send-email-soren.brinkmann@xilinx.com>
 <1368207091-32538-2-git-send-email-soren.brinkmann@xilinx.com>
 <20130510212422.GY3200@sirena.org.uk>
Message-ID: <7e18bed3-ae6b-4aa0-bf23-b6c61ba8b85b@CO9EHSMHS030.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 10, 2013 at 10:24:22PM +0100, Mark Brown wrote:
> On Fri, May 10, 2013 at 10:31:31AM -0700, Soren Brinkmann wrote:
> 
> > +Example:
> > +	usclk: usclk {
> > +		compatible = "clk-userspace";
> > +		clocks = <&foo 15>, <&bar>;
> > +		clock-count = <2>;
> > +	};
> 
> This is clearly *very* Linux specific so needs to be a linux vendor
> thing (everything should have a namespaced name anyway).  It's not at
> all obvious to me that this should be in device tree, though, since it's
> not hardware description but a detail of how the OS is currently
> implemented.
> 
> For your use case should these things be exposed by the FPGA device
> asking for that rather than by having the clocks available separately?
> Or is this part of the DT blob that's loaded incrementally along with
> the FPGA (which does make things more interesting of course...).
Here may be some misunderstanding.
The clocks are not in the FPGA. The clocks are always there and part of
the processing system (PS), they are just routed to the FPGA where they
can be used as clocks for the FPGA design.

So, hopefully, in most cases there will be a "normal" device drivers for the
IP in the FPGA. E.g. if there is a soft IP Ethernet core in the FPGA an
appropriate device driver will use clk_get() to claim the appropriate
clock from its provider, which can be one of these FPGA clocks.
In this case there is no userspace exposure needed at all and the here
proposed driver is not used.

But if your design isn't that complex or there is no device driver
available for it (yet), there is the desire to have simple userspace
controls to adjust the frequency easily during runtime. In this case the
proposed driver can be used to expose the clock controls for the wanted
clocks through sysfs.

I hope that will be the way it used. I didn't intent to provide a
userspace API people rely on for more than some simple adjustments.
The more complex the IP in the FPGA becomes, the requirements and
limitations on clocking become more complex too. Then people will have
to write/use a proper dedicated driver for the IP, IMHO.

> 
> > + * Expose clock controls through sysfs to userspace.
> 
> > + * By writing 0/1 to 'enable' the clock can be disabled/enabled. Reading
> > + * that file returns the current state - 0 = disabled, 1 = enabled.
> 
> > + * Reading 'set_rate' returns the current clock frequency in Hz. Writing
> > + * the file requests setting a new frequency in Hz.
> 
> This needs to be covered in Documentation/ABI since it's adding new
> sysfs stuff.
I wanted to avoid becoming the provider of a stable userspace API. We'll
see how this goes.

> 
> > +	if (enable)
> > +		ret = clk_prepare_enable(pdata->clk);
> > +	else
> > +		clk_disable_unprepare(pdata->clk);
> 
> > +	if (ret)
> > +		return -EBUSY;
> 
> Why not pass back the actual error?
Good question. Was there some spec saying, that these sysfs callbacks
should return this error? Otherwise this will be fixed.

> 
> > +	pdata = kzalloc(clock_count * sizeof(*pdata), GFP_KERNEL);
> > +	if (!pdata)
> > +		return -ENOMEM;
> 
> devm?
In the current state, there is no real device and devices aren't
destroyed either. If this changes the managed framework may become an
option.

> 
> > +late_initcall(usclk_setup);
> 
> Why not just a regular driver?
Looks like I'll go that way. I didn't want it originally, since there
is no physical HW for this driver. I wanted to use the clock probing
mechanism, but ran into problems with that because it takes place too
early during boot.


	S?ren
