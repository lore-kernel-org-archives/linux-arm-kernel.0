From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 16 Sep 2014 18:21:26 +0200
Subject: [PATCH 2/4] dmaengine: device tree bindings for PL08x
In-Reply-To: <1410507442-32451-1-git-send-email-linus.walleij@linaro.org>
References: <1410507442-32451-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <201409161821.26348.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 12 September 2014, Linus Walleij wrote:
> This introduces device tree bindings for the PL08x DMA controllers
> when used with fixed signal assignment per channel, i.e. if each
> channel on the PL08x is assigned precisely one burst/single signal
> set.
> 
> In many incarnations that exist in the wild, a mux had been put
> in front of the signals so that the system has to select a subset
> of signals to handle from a larger set. This is not described in
> the current binding: instead this is assumed to be handled with
> a more elaborate binding especially for muxed signal cases.
>
> I imagine things like adding the property dma-mux = <&phandle>;
> for the DMA controller in such cases, and not specifying any
> signals for the channels, and provide a separate binding for
> the mux to enlist its signals.

If the mux handling is really simple, we could it part of the
pl08 driver and key it off the compatible string -- for any
of the known variants that use a mux, we then have the driver
implement the muxing directly.

Or it could be done the other way round: Have a binding for the
mux that implements the generic dma binding, and a driver for
it that registers with of_dma and forwards any
dma_request_slave_channel() call to the underlying driver.
That would even make the mux driver independent of pl08.

I'm not worried about it at all, I'm sure we can do it when
we want to.

> +Required properties:
> +- compatible: "arm,pl080", "arm,pl081", "arm,primecell"

I don't think you'd want both pl080 and pl081 in the same
device, so it should be one of the two, plus the primecell
one.

> +- reg: Address range of the PL08x registers
> +- interrupt: The PL08x interrupt number
> +- clocks: The clock running the IP core clock
> +- clock-names: A list with one element with the name of the core clock

This needs to list the required clock names.

> +Optional sub-nodes:
> +The slave transfer channels are assigned in consecutive order and
> +identified by one child node per channel, assuming a fixed-signal
> +per channel assignment and each with the following properties:
> +
> +Required properties:
> +- signal: the name of the on-chip signal line handled by this channel
> +- bus-interface-ahb1 or bus-interface-ahb2: tells the driver which
> +  bus interface(s) that is eligible for this specific channel. At least
> +  one of the interfaces must be specified, it is perfectly legal to
> +  specify both if the hardware supports using either interface.

I'd really like to avoid this and move all of it into the dma specifier.
I understand where you are coming from with this given the existing
code, but I'd rather change the driver code to allow a simpler binding.

> +	saa0 at dmac0 {
> +		signal = "saa0";
> +		bus-interface-ahb1;
> +	};

The main value-add this gives you is a name of the signal, but nobody else
does this, and it seems this is only an artifact of the way the driver today
matches devices that come from platform data.

If you want it just for migration purposes, we can probably put the names
in the platform, but the bus-interface-* should IMHO be expressed in the
dma specifier, the same way we do for the designware part.

	Arnd
