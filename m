From: tony@atomide.com (Tony Lindgren)
Date: Thu, 26 Jan 2012 18:21:12 -0800
Subject: Pinmux bindings proposal V2
In-Reply-To: <CAPnjgZ3Xhebn1x1A-Vdy78DWbDd=cp0AK6tL-R1SRzS4GdF97g@mail.gmail.com>
References: <74CDBE0F657A3D45AFBB94109FB122FF1780DAB4CE@HQMAIL01.nvidia.com>
 <CAPnjgZ3Xhebn1x1A-Vdy78DWbDd=cp0AK6tL-R1SRzS4GdF97g@mail.gmail.com>
Message-ID: <20120127022111.GK29812@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

* Simon Glass <sjg@chromium.org> [120126 09:11]:
> 
> On Fri, Jan 20, 2012 at 2:22 PM, Stephen Warren <swarren@nvidia.com> wrote:
> 
> 1. It doesn't seem to make full use of the device tree format. For example,
> 
>    <TEGRA_PMX_PG_DTD TEGRA_PMX_CONF_DRIVE_STRENGTH 5>
> 
> would be better as something like
> 
>     drive-strength = <5>;
> 
> if we could arrange it. It also reduces the need for these
> TEGRA_PMX_CONF_DRIVE_STRENGTH defines.

I agree. This is something that most pinmux/pinconf drivers need to
implement, so it's best done in a generic way.
 
> In tegra20.dtsi:
> 
> / {
> 	&tegra_pmx {
> 		#address-cells = <1>;
> 		#size-cells = <0>;
> 
> 		/*
> 		 * This is the first option for SDIO1. It comes out
> 		 * on pin groups DTA and DTD. Boards can simply use this
> 		 * phandle in the driver node to get this option. Any options
> 		 * not used could potentially be dropped from the device tree
> 		 * blob for space-constrained boot loaders.
> 		 */
> 		pmx_sdhci1_dta_dtd: sdhci1-dta-dtd at 0 {
> 			#address-cells = <1>;
> 			#size-cells = <0>;
> 			reg = <0>;
> 			label = "SDIO1 on DTA, DTD (4-bit)";
> 
> 			/*
> 			 * Here are the pin groups needed for this option.
> 			 * First DTA, then DTD.
> 			 */
> 			pmx at dta {
> 				reg = <PG_DTA>;
> 				mux = <PMX_MUX_SDIO1>;
> 				drive-strengh = <5>;
> 				slew-rate = <4>;

Using reg for the register offsets here makes sense to me. But doesn't that
mean that now we're back to having a node for each pin? And that is something
we're trying to avoid because of the bloat as most systems have one register
per pin, so this is not efficient for listing multiple pins.

So maybe we should just use what Stephen suggested for the array of registers
here:

				mux = <MUX_OFFSET1 INITIAL_MUX_VALUE1
				       MUX_OFFSET2 INITIAL_MUX_VALUE2>;

> 
> 				/*
> 				 * We support two states here, active
> 				 * and standby. Properties in these child
> 				 * nodes can override the ones at this level.
> 				 * Drivers can move between states just by
> 				 * making the changes in these nodes.
> 				 */
> 				state-active {
> 					reg = <PMX_CONF_ACTIVE>;
> 					tristate = <0>;
> 				};
> 				state-standby {
> 					reg = <PMX_CONF_STANDBY>;
> 					tristate = <1>;
> 					drive-strengh = <2>;
> 				};
> 			};

This seems like a qood way to represent the alternative mux states for
the muxes that need them. This is assuming the states have standard
bindings and not some random names. I still don't know if we need them
though. And again when we have multiple registers, we'd have to have
either multiple entries for each pin, or use the array instead of reg.

Maybe we need two bindings: A minimal subset of what Stephen is suggesting
that can handle 95% of the muxes with minimal overhead, then what you're
suggesting for the few muxes that need multiple states?

Regards,

Tony
