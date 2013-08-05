From: broonie@kernel.org (Mark Brown)
Date: Mon, 5 Aug 2013 17:59:57 +0100
Subject: [PATCH RFC 00/13] Adding SPDIF support to kirkwood-i2s
In-Reply-To: <51FFBF03.1000507@gmail.com>
References: <20130804192136.GK23006@n2100.arm.linux.org.uk>
 <51FECB7A.6010208@gmail.com> <20130805115947.GA9858@sirena.org.uk>
 <51FFA348.2010503@gmail.com> <20130805140729.GC9858@sirena.org.uk>
 <51FFBF03.1000507@gmail.com>
Message-ID: <20130805165957.GT9858@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 05, 2013 at 05:04:35PM +0200, Sebastian Hesselbarth wrote:

> I cannot follow you on the clocking arrangements. The binding
> proposal was for audio controller <-> CODEC connections. For clocks
> there are common properties ("clocks", "clock-names", "clock-frequency")
> to pass them to drivers - for "sound cards" in general there are not.

The clocking arrangements are an example of why the boards can get
interesting enough to describe for themselves.

> So, having a look at the node in question:

> sound {
>   compatible = "nvidia,tegra-audio-rt5640-beaver",
>                "nvidia,tegra-audio-rt5640";
>   nvidia,model = "NVIDIA Tegra Beaver";
> 
>   nvidia,audio-routing = "Headphones", "HPOR",
>                          "Headphones", "HPOL";
> 
>   nvidia,i2s-controller = <&tegra_i2s1>;
>   nvidia,audio-codec = <&rt5640>;
> 
>   nvidia,hp-det-gpios = <&gpio TEGRA_GPIO(W, 2) GPIO_ACTIVE_HIGH>;
> 
>   clocks = <&tegra_car TEGRA30_CLK_PLL_A>,
>            <&tegra_car TEGRA30_CLK_PLL_A_OUT0>,
>            <&tegra_car TEGRA30_CLK_EXTERN1>;
>   clock-names = "pll_a", "pll_a_out0", "mclk";
> };
> 
> all those "nvidia," prefixed properties are not nvidia-specific at all.

This is all because you have to add a prefix for DT.

> Also, all those "nvidia," properties would have fit very well into the
> i2s controller node

No, almost none of them have any place there.  For example, the audio
routing contains only connections to the CODEC so the I2S controller
isn't in play, the headphone detection is connected to the AP but isn't
connected to the I2S port.

>                     - there may be more complex SoCs requiring an extra
> "sound card" node, Tegra is not.

This is nothing to do with the SoC and all to do with the rest of the
board - Tegra systems will frequently have these issues since Tegra is
frequently deployed in smartphones which tend to push the limits on
these things.

The smartphone use case will typically have a separate digital clock
domain for the baseband, there will usually also be a bluetooth SCO link
slaved to one of the other digital domains.  Start drilling down into
the details and you'll usually find a bit more complexity and usually a
bunch of device specific constraints too.

> Even those foo-gpios properties can be generalized and moved to ASoC;
> have a look at MMC drivers using one common "cd-gpios" property for
> very different drivers. What is so special with Tegra and this gpio
> that it needs a vendor-specific property?

This is mostly just a function of the DT convention requiring a vendor
prefix be shoved on everything.

> I was asking for generalizing those exact properties to generic ones
> and them move support for them to the ASoC/ALSA framework. With all
> that DT binding re-review coming up, I doubt that the tegra binding
> will be accepted again anyway.

Sure it would.

> >> i2s1: audio-controller at b0000 {
> >> 	compatible = "marvell,dove-i2s";
> >> 	reg = <0xb0000 0x2345>;
> >> 	audio-codecs = <&spdif 0>;
> >> };

> > No, things are glued together using the machine driver - again, look at
> > how all the other systems work.  The wiring on the board can get
> > interesting enough to need a binding of its own, for very simple
> > bindings that should just be pointing to a generic driver.

> I learned to never match "device nodes" with "drivers" as there
> is simply no relation between them.

That's clearly a thinko for device node.

> So, back to my original node proposal, can you tell me what is so
> different, except that I am not using "marvell,audio-codec(s)" but
> "audio-codecs"; and hook the one available codec output by using
> phandle/args instead of a new compatible string?

>From my point of view I'd rather not be shoving vendor prefixes on all
the properties, this is coming from DT convention requiring vendor
prefixes on bindings.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130805/caef9b73/attachment.sig>
