From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 29 Oct 2014 22:05:40 -0600
Subject: [RFC] pinctrl: Provide a generic device tree binding for per-pin
 pin controllers
In-Reply-To: <20141023132305.GG14443@pengutronix.de>
References: <20141023132305.GG14443@pengutronix.de>
Message-ID: <5451B914.6020300@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/23/2014 07:23 AM, Sascha Hauer wrote:
> Most iomux controllers allow a configuration per pin. These currently
> have no common device tree binding. There are many different SoC
> specific bindings for this class of iomux controllers. Some controllers
> artificially group pins together where in hardware no groups exist (for
> example lantiq). Other controllers just put each pin into a separate
> group which explodes to many many strings to parse (Tegra30).
> 
> 
> A pin controller has n pins, each muxable to m different positions.

I assume that sentence is meant to say something more specific:

This binding is intended to apply to pin controllers where each pin has
an independently selectable mux function.

"A pin controller ..." sounds like a general statement that is intended
to apply to any pin controller. If that were intended, the statement you
made certainly wouldn't be true.

> There exists a logical numbering for all pins, for most SoCs this will
> be defined by the register ordering so that the pin number can directly
> be translated to a register offset without the need of tables in the
> driver. The register usually takes m different numbers to specify the
> function the pin should have. Both the pin and its function can be
> described as a single 32bit number:
> 
> #define PINMUX_PIN(no, fn) (((no) & 0xffffff) << 8) | (fn) & 0xff)
> 
> This allows to put multiple pins into a single device tree property
> which is very efficiently parsable by the driver (or the pinmux core).
> We suggest to name this property 'pins' and to put it next to the
> generic pinconf binding.  This allows to describe multiple pins with the
> same pinconf settings in a single device tree node. Multiple of these
> nodes can be grouped under a pinctrl state node. This allows to put pins
> with different pinconf settings to a single state.
> 
> Example:
> 
> 	uart2 {
> 		uart2_default_mode: uart2_default {
> 			pins1 {
> 				pins = <PINMUX_PIN(127, 3), PINMUX_PIN(128, 3)>;

Within each of the nodes, the binding for pinmux is defined
independently by each pin controller. I don't have any /strong/
objection to any particular pin controller using this binding, or even
it being re-used across many similar pin controllers, or even being
the/a default binding style for new pin controllers.

I'm not totally sure whether blending the pin ID and mux function ID
into the same value is a good idea. That said, it does have advantages
as you state, and shouldn't cause any significant issues. In any case
where it would be a bad idea, the binding for the pin controller in
question can still choose to use some more appropriate binding, so
allowing this binding for some controllers won't force issues onto other
controllers. So, it seems fine.

Note however that we can't change existing bindings. Well, I suppose
certain bindings could be enhanced to support either a string-based or
an integer-base binding, but I don't think that'd be a good idea.
