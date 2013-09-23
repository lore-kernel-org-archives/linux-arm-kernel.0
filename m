From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 23 Sep 2013 15:06:54 -0600
Subject: [PATCH 1/4] i2c: busses: i2c-st: Add ST I2C controller
In-Reply-To: <1379498483-4236-2-git-send-email-maxime.coquelin@st.com>
References: <1379498483-4236-1-git-send-email-maxime.coquelin@st.com>
 <1379498483-4236-2-git-send-email-maxime.coquelin@st.com>
Message-ID: <5240AD6E.4090905@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/18/2013 04:01 AM, Maxime COQUELIN wrote:
> This patch adds support to SSC (Synchronous Serial Controller)
> I2C driver. This IP also supports SPI protocol, but this is not
> the aim of this driver.
> 
> This IP is embedded in all ST SoCs for Set-top box platorms, and
> supports I2C Standard and Fast modes.

> diff --git a/Documentation/devicetree/bindings/i2c/i2c-st.txt b/Documentation/devicetree/bindings/i2c/i2c-st.txt

> +I2C for ST platforms

If the HW block supports both I2C and SPI, the DT binding ought to
support that too. It's be best to create a single DT binding that
represents the IP block, and include a property that indicates whether
the device should operate in I2C or SPI mode.

I suppose you could reasonably define different compatible values for
those two cases. However, the binding should be titled something more
like "ST SSC binding, for I2C mode operation" and "ST SSC binding, for
SPI mode operation", rather than "I2C for ST platforms", since the HW
includes an SSC block, not an I2C block.

> +Required properties :
> +- compatible : Must be "st,comms-i2c"
> +- reg : Offset and length of the register set for the device
> +- interrupts : the interrupt number

It's an interrupt specifier, not an interrupt number. The format is
defined by the interrupt controller, not this binding.

> +- clocks : phandle to the I2C clock source

What about clock-names?

> +Recommended (non-standard) properties :

Usually you'd just say "Optional properties:", or perhaps "Recommended
properties:". I don't think adding "(non-standard)" serves any purpose.

> +- clock-frequency : Desired I2C bus clock frequency in Hz. Otherwise
> +  the default 100 kHz frequency will be used. As only Normal and Fast modes
> +  are supported, possible values are 100000 and 400000.
> +
> +Optional (non-standard) properties:

Same here.

> +- st,glitches : Enable timing glitch suppression support.

That property name doesn't really convey the "enables" that appears in
the property description to me...

> +- st,glitch-clk : SCL line timinig glitch suppression value in ns.
> +- st,glitch-dat : SDA line timinig glitch suppression value in ns.

s/timinig/timing/

> +- st,hw-glitches : Enable filter glitch suppression support.
> +- st,hw-glitch-clk : SCL line filter glitch suppression value in us.
> +- st,hw-glitch-dat : SDA line filter glitch suppression value in us.

Those sound more like runtime configuration rather than HW description.
Can you rephrase the descriptions (and property names) more along the
lines of HW properties? Perhaps e.g.:

st,needs-glitch-suppression: The board design needs timing glitch
suppression enabled to operate reliably.

st,min-scl-pulse-width: The minimum valid SCL pulse width that is
allowed through the deglitch circuit. In units of ns.

(I just made up those descriptions to give a feel for the flavor of
description that I expect. They likely need some adjustment to reflect
whatever they're actually intended to represent in HW).

What is the difference between "glitch" and "hw-glitch"?
