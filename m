From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 27 Jan 2012 14:57:54 +0800
Subject: Pinmux bindings proposal V2
In-Reply-To: <20120127020832.GJ29812@atomide.com>
References: <74CDBE0F657A3D45AFBB94109FB122FF1780DAB4CE@HQMAIL01.nvidia.com>
 <20120123210052.GS22818@atomide.com>
 <74CDBE0F657A3D45AFBB94109FB122FF178CB81C0D@HQMAIL01.nvidia.com>
 <20120124012038.GT22818@atomide.com>
 <74CDBE0F657A3D45AFBB94109FB122FF178CB81EDB@HQMAIL01.nvidia.com>
 <20120125000407.GU22818@atomide.com>
 <74CDBE0F657A3D45AFBB94109FB122FF178CB82433@HQMAIL01.nvidia.com>
 <20120127020832.GJ29812@atomide.com>
Message-ID: <20120127065752.GB32740@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 26, 2012 at 06:08:33PM -0800, Tony Lindgren wrote:
> * Stephen Warren <swarren@nvidia.com> [120126 11:03]:
...
> > Second, as I mentioned before, while some of the states are certainly
> > PM-related, I don't think all will be, e.g. the case of running an SD
> > controller at different clock rates to the SD card, and needing to
> > set different pin parameters based on the clock rate. Is runtime PM
> > intended cover that kind of thing? The idea here is that the common
> > pinctrl binding can allow the driver to require different named states
> > for those different clock rate cases.
> 
> For the PM related states, those should be Linux generic. For rate
> setting sounds like that's really something you should set up as clocks
> in the Tegra wrapper driver for SDHCI?
> 
That's right.

> Ideally the SDHCI driver would be completely arch independent, and
> then the SoC specific wrapper driver would know how to communicate to
> the pinmux/pinconf framwork or clock framework what it needs using
> Linux generic APIs.

But that wrapper driver should not be bothered to call pinmux/pinconf
APIs on pin basis to change the pinctrl configuration.  The elegant
way would be something like the following in case that it switches
the bus frequency from 50 MHz to 100 MHz.

	pmx = pinmux_get(dev, "esdhc_50mhz");
	...
	pinmux_put(pmx);
	pmx = pinmux_get(dev, "esdhc_100mhz");
	...

The specific mux and config settings of states esdhc_50mhz and
esdhc_100mhz would be retrieved from device tree.

> So I'd rather stay out of random named states for
> the pins coming from device tree; If we still need them, they should
> be common bindings rather than things like "xyz_clock_hack".
> 
The binding defines the syntax, and I do not see the necessity to
force the particular state name, which is really pinctrl client
device specific.

-- 
Regards,
Shawn
