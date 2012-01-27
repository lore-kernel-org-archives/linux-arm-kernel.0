From: tony@atomide.com (Tony Lindgren)
Date: Fri, 27 Jan 2012 09:16:53 -0800
Subject: Pinmux bindings proposal V2
In-Reply-To: <20120127071944.GC32740@S2101-09.ap.freescale.net>
References: <74CDBE0F657A3D45AFBB94109FB122FF1780DAB4CE@HQMAIL01.nvidia.com>
 <20120123210052.GS22818@atomide.com>
 <20120126093610.GD2287@S2101-09.ap.freescale.net>
 <20120126175122.GX22818@atomide.com>
 <20120127071944.GC32740@S2101-09.ap.freescale.net>
Message-ID: <20120127171653.GI13504@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Shawn Guo <shawn.guo@linaro.org> [120126 22:37]:
> On Thu, Jan 26, 2012 at 09:51:23AM -0800, Tony Lindgren wrote:
> > Hi,
> > 
> > * Shawn Guo <shawn.guo@linaro.org> [120126 00:53]:
> > > 
> > > On Mon, Jan 23, 2012 at 01:00:52PM -0800, Tony Lindgren wrote:
> > > ...
> > > > So to summarize: I suggest we'll just stick to basics to get the system
> > > > booting and devices working using device tree. In most cases the device
> > > > drivers should be able to configure the suspend and off states in a generic
> > > > way using pinctrl API. Everything else, like debugging, we can probably
> > > > do with userspace tools.
> > > > 
> > > > This would mean just using a minimal subset of your binding, probably
> > > > very close to what you originally suggested.
> > > > 
> > > IMHO, as a generic device tree binding, it should be able to cope with
> > > different use cases.  It's really free for you to use the minimal
> > > subset of the binding as your need, but we should not make the binding
> > > design just be that minimal subset to force that everyone else can
> > > only use the minimal subset.
> > 
> > The main issue I have is that the example posted in this thread repeats
> > the same registers five times for one driver entry alone in the device
> > tree data. The repeated registers are TEGRA_PMX_PG_DTA and TEGRA_PMX_PG_DTD
> > in the example.
> > 
> > The alternative values are something that the pinmux/pinconf driver can
> > set based on state changes communicated from the driver using these pins.
> 
> I'm against the idea that requires client device drivers call pinctrl
> APIs on pin basis.  They do not even know or care about the pins that
> they are using.  That's all pinctrl driver's business.  All client
> driver needs to do when it wants to change pinctrl setup should just
> be calling pinmux/pinconf_get/put[enable/disable](dev, "state").

That should work fine too. As long as the states are generic, such as
PMX_STATE_ENABLED, PMX_STATE_IDLE, PMX_STATE_SUSPEND, PMX_STATE_OFF
and so on. You really don't want to change states with some string
names if you need to toggle something every time your enter and exit
idle. And it should be possible to set it on per pin or pingroup basis.
For wake-up events you typically just toggle one pin for the device,
such as serial rx line.

I guess the analog we should follow here is clk_get and clk_set_rate,
except we would have pinconf_set_state with predefined states.

Regards,

Tony
