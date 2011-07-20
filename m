From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 20 Jul 2011 19:04:20 +0800
Subject: [RFC PATCH 1/5] OMAP3:I2C: Add device tree nodes for beagle board
In-Reply-To: <CACxGe6u8qq7FA7kFXbU5uCk6m_GA8GWLqsdjFCXN+NMJfFKxmA@mail.gmail.com>
References: <1309426647-31587-1-git-send-email-manjugk@ti.com>
	<1309426647-31587-2-git-send-email-manjugk@ti.com>
	<20110706185546.GJ4871@ponder.secretlab.ca>
	<74CDBE0F657A3D45AFBB94109FB122FF049E21C203@HQMAIL01.nvidia.com>
	<CACxGe6u8qq7FA7kFXbU5uCk6m_GA8GWLqsdjFCXN+NMJfFKxmA@mail.gmail.com>
Message-ID: <20110720110419.GA6999@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 06, 2011 at 06:12:49PM -0600, Grant Likely wrote:
> On Wed, Jul 6, 2011 at 5:26 PM, Stephen Warren <swarren@nvidia.com> wrote:
> > Grant Likely wrote at Wednesday, July 06, 2011 12:56 PM:
> >> On Thu, Jun 30, 2011 at 03:07:23PM +0500, G, Manjunath Kondaiah wrote:
> >> > Add I2C and it's child device nodes for beagle board.
> >> > The I2C1 controller child devices are not populated and it
> >> > should be handled along with OMAP clock changes.
> > ...
> >> > diff --git a/arch/arm/boot/dts/omap3-beagle.dts b/arch/arm/boot/dts/omap3-beagle.dts
> > ...
> >> > + ? i2c at 48070000 {
> > ...
> >> > + ? ? ? ? ? clock-frequency = <2600>;
> >> > + ? ? ? ? ? status = "disabled";
> >>
> >> Drop 'status' when you move this node definition to
> >> arch/arm/boot/dts/omap3.dtsi. ?Board overlay files that include the
> >> omap3.dtsi should explicitly disable any devices that it does not use
> >> (which is opposite to what tegra currently does, but I'm going to
> >> change that).
> >
> > Purely out of idle curiosity: What's the benefit of one way over the other?
> 
> Mostly consistency.  Most of the experience we have with the flattened
> device tree up to this point hasn't bothered with the 'status'
> property.  It is only when AMP and hypervisors cam online that it
> became important to use a status property, and that only when the
> kernel needs to be told that the device does indeed exist, but it must
> not be touched.  I'd like to continue that pattern for new DT users
> with the default assumption that a device is enabled unless the board
> .dts explicitly disables it.
> 
When going this way with my i.mx53 related dts files, I feel I like the
opposite way.

i.mx53 has many number of peripherals inside, while individual board
might only use small portion there.  For example, i.mx53 has 5 uart
controller instances inside, while quick start (aka loco) board only
uses one.  With the way you suggest here, we will have the following
in imx53.dtsi.

uart0: uart at ... {
	...
};

uart1: uart at ... {
	...
};

uart2: uart at ... {
	...
};

uart3: uart at ... {
	...
};

uart4: uart at ... {
	...
};

And we will have to tell the 4 we do not use on quick start board in
imx53-qs.dtsi


uart1: uart at ... {
	...
	status = "disabled";
};

uart2: uart at ... {
	...
	status = "disabled";
};

uart3: uart at ... {
	...
	status = "disabled";
};

uart4: uart at ... {
	...
	status = "disabled";
};

Besides the bothering that we have to list so many unused controllers
in individual board dts file, it's also hard to tell which controllers
are actually available on the board.  People have to look at imx53.dts
to get a full list and then exclude the ones in imx53-<board>.dts as
"disabled".

And if we go the way opposite, adding "disabled" status for everyone
in imx53.dts, we will only need to specify the peripherals that are
actually available on board with "okay" status in imx53-<board>.dts.
And it's much more clear for people to see what peripherals are
available on individual board.

So I'm going the way than you suggested.  Please let me know if you
strongly dislikes it.

-- 
Regards,
Shawn
