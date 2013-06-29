From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 29 Jun 2013 20:26:16 +0100
Subject: armada_drm clock selection
In-Reply-To: <CAMLZHHQZ+36g9EQhj+LOgQioj8T5VDwvUdNrkVLboT8tYi9gXQ@mail.gmail.com>
References: <20130628201133.1D6D2FAAD5@dev.laptop.org>
 <20130628211848.GJ4283@n2100.arm.linux.org.uk>
 <CAMLZHHQZ+36g9EQhj+LOgQioj8T5VDwvUdNrkVLboT8tYi9gXQ@mail.gmail.com>
Message-ID: <20130629192616.GC3353@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 29, 2013 at 09:06:47AM -0600, Daniel Drake wrote:
> MMP2 (Armada 610) and MMP3 (PXA2128, no Armada name) is even a bit
> more complex than that.
> On MMP2 the selectable clocks are written in bits 31:30 and are:
> 0 - AXI, 1 - LCD1, 2 - LCD2, 3 - HDMI
> 
> On MMP3 the selectable clocks are written in bits 31:29 and are:
> 0 - AXI or LVDS (depending on bit 12)
> 1 - LCD1
> 2 - LCD2
> 3 - HDMI
> 7 - DSI
> 
> When clock 0 is selected, bit 12 comes into effect for the final say
> on the clock selection. 0 = AXI, 1 = LVDS

Thanks for the info - I'll update my driver with that information.

> With your clear explanations I think I can come up with an
> implementation that takes all these factors into account, offering
> access to a great deal of the available functionality. Should not be
> too difficult now that we have had this discussion, and I'd be happy
> to do so. But before I do that, a question popped up into my mind: is
> this complexity really worth it?

The complexity question is something which has been bugging me as well.
I don't think we need the complexity of automatic clock selection.  If
you have a platform like the Cubox, where you have an external clock
generator tied to the LCD clock input, then you might as well just use
that.  If not, you're limited to what's provided on-board by the chip,
using whatever dividers it has.

So, I'd suggest that an initial approach would be something along the
lines of:
- if there is an external clock, can it generate the desired rate?
  if yes, use it.
- otherwise, get the clock rate from the internal clocks and calculate
  the appropriate divider.  Use which ever one gives you the best
  approximation that's better than (eg) 1%.  If not, fail the mode set.

> For OLPC, we only ever use LCD1 with divider 2 for our panel, which
> only has 1 resolution. I think we use the fast AXI clock for HDMI
> path, which has a separate SCLK register. For armada 510, it looks
> like you are quite happy with the EXT1 clock, and you mentioned that
> on the 16x most of the clocks are broken, which might mean there is
> again just one clock of preference?

I'm not sure I said that on the 16x the clocks were broken - only that
they have different bit settings and probably a different architecture.
Although I have the 16x specs, I don't have hardware for it, and I
haven't spent that long digging in to it.

> So, could we just specify per-CRTC clock preference in platform data,
> DT, or something like that? e.g. we could just specify which SCLK bits
> to set and clear, and which Linux-level struct clk is engaged as a
> result. It adds a little burden for the platform implementor, but it
> would avoid all of the complications that you have mentioned. Or do
> you have a preference for the added flexibility?

We could do that as well, but I'm not keen on encoding register bit
values into DT, especially for a register which seems to have many
different variations.


This now brings me on to another important subject with DT vs DRM.
The way DRM is setup, it expects all resources for a particular
implementation to be known at 'drm_device' creation time.  You can't
"hot-plug" additional parts of the "drm system" together.  What this
means is that at driver load time (to use DRM terms) all parts must
be known.

However, for something like Dove, you have many different parts to
the system: considering just the scan out parts, you have:
- two identical LCD controller blocks
- a display controller block which routes the LCD controller outputs
- image rotation block

The problem is that a DT description of these would list each block
separately, so they would appear as separate devices, each with the
own separate DT properties.  This means that if we have separate
struct device_driver's for each, we need some way to know when we
have collected all the necessary parts to initialize the DRM system.

Moreover, there are system considerations here: is it appropriate to
drive both LCD controller blocks as one DRM device or as two separate
DRM devices?  That could be application specific.

And then we come to another issue: what if your setup doesn't have
two LCD controller blocks but only one like on the Armada 16x.

Is it worth having a "super-device" around the parts of each system
which you want to treat separately - iow something like this if you
wish to use them together:

	display {
		compatible = "marvell,armada-510-display";
		clocks = <&axi_clk>, <&ext_clk0>, <&lcd_pll_clk>, <&ext_clk_1>;
		lcd0 {
			compatible = "marvell,armada-510-lcd";
			reg = <0xf1820000 0x1000>;
			interrupts = <47>;
			...
		};
		lcd1 {
			compatible = "marvell,armada-510-lcd";
			reg = <0xf1810000 0x1000>;
			interrupts = <46>;
			...
		};
		dcon {
			compatible = "marvell,armada-510-dcon";
			reg = <...>;
			...
		};
	};

and this to use them separately:

	display0 {
		compatible = "marvell,armada-510-display";
		clocks = <&axi_clk>, <&ext_clk0>, <&lcd_pll_clk>, <&ext_clk_1>;
		lcd0 {
			compatible = "marvell,armada-510-lcd";
			reg = <0xf1820000 0x1000>;
			interrupts = <47>;
			...
		};
	};
	display1 {
		compatible = "marvell,armada-510-display";
		clocks = <&axi_clk>, <&ext_clk0>, <&lcd_pll_clk>, <&ext_clk_1>;
		lcd1 {
			compatible = "marvell,armada-510-lcd";
			reg = <0xf1810000 0x1000>;
			interrupts = <46>;
			...
		};
	};

but I don't think that this kind of description where each part is a
separate device is particularly workable:

	lcd0 {
		compatible = "marvell,armada-510-lcd";
		reg = <0xf1820000 0x1000>;
		interrupts = <47>;
		clocks = <&axi_clk>, <&ext_clk0>, <&lcd_pll_clk>, <&ext_clk_1>;
		...
	};
	lcd1 {
		compatible = "marvell,armada-510-lcd";
		reg = <0xf1810000 0x1000>;
		interrupts = <46>;
		clocks = <&axi_clk>, <&ext_clk0>, <&lcd_pll_clk>, <&ext_clk_1>;
		...
	};
	dcon {
		compatible = "marvell,armada-510-dcon";
		reg = <...>;
		...
	};

because there's no way to know how the system is supposed to be setup or
even how many individual devices to expect to make the "complete" system.
