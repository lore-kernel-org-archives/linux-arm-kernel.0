From: stern@rowland.harvard.edu (Alan Stern)
Date: Thu, 9 Jan 2014 10:47:51 -0500 (EST)
Subject: [PATCH v2 2/2] ehci-platform: Add support for clks and phy passed
 through devicetree
In-Reply-To: <52CEA386.6060103@redhat.com>
Message-ID: <Pine.LNX.4.44L0.1401091043380.1493-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 9 Jan 2014, Hans de Goede wrote:

> >> +Optional properties:
> >> +- clocks : a list of phandle + clock specifier pairs, one for each entry
> >> +   in clock-names.
> >> +- clock-names : "clk0", "clk1", ...
> >> +- phys : phy
> >> +- phy-names : "phy0"
> >> +
> >> +Example:
> >> +
> >> +	ehci at d8007900 {
> >> +		compatible = "via,vt8500-ehci";
> >> +		reg = <0xd8007900 0x200>;
> >> +		interrupts = <43>;
> >> +		clocks = <&usb_clk 6>, <&ahb_gates 2>;
> >> +		clock-names = "clk0", "clk1";
> >
> > I'm really not convinced by this either. It prevents you from doing
> > anything useful out of these clocks, and the only thing you can
> > actually do with it is calling clk_get, and that's pretty much it.
> >
> > What if you some platform needs to adjust the rate of one of the two?
> 
> Then it needs its own driver. This is intended as a binding for a
> *generic* driver, which is meant to cover simple straight forward
> non-pci ohci cases. For more complex cases a separate driver will
> need to be written.
> 
> I must say I'm becoming a bit unhappy with how the reviews of devicetree
> bindings are being done. In one case it is not generic enough (ahci-sunxi).
> 
> If I then try to make it more generic in a case where that can actually
> be done as the hardware is pretty straight forward, it is not specific enough.
> You can simply not have both!
> 
> > Or wants to cut one but not the other for any reason?
> 
> This is another example of non generic behavior, requiring a separate
> (small using the existing ohci core) platform glue driver, like the *19* we
> already have.

Would DT allow ehci-platform.c to access the clocks by their index in
the array, rather than by name?  After all, you don't really care about
the names at all, since the driver knows nothing about the clocks' 
functions.

The same is true of the phy entry.

Alan Stern
