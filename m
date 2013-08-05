From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon, 05 Aug 2013 17:04:35 +0200
Subject: [PATCH RFC 00/13] Adding SPDIF support to kirkwood-i2s
In-Reply-To: <20130805140729.GC9858@sirena.org.uk>
References: <20130804192136.GK23006@n2100.arm.linux.org.uk>
 <51FECB7A.6010208@gmail.com> <20130805115947.GA9858@sirena.org.uk>
 <51FFA348.2010503@gmail.com> <20130805140729.GC9858@sirena.org.uk>
Message-ID: <51FFBF03.1000507@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/05/13 16:07, Mark Brown wrote:
> On Mon, Aug 05, 2013 at 03:06:16PM +0200, Sebastian Hesselbarth wrote:
>
>> looking at e.g. nvidia,tegra-audio-*.txt bindings, I guess you are
>> proposing to have a new binding for every SoC/codec/board combination?
>> Also, you should have seen "ASoC: fsl: Add S/PDIF machine driver", which
>> is - again - proposing a new binding for fsl with spdif "codec".
>
>> You really want me to go the same way or is there any "other board
>> binding" I should follow?
>
> Yes, go that way.  There is the simple-card driver which should be able
> to grow to consume most of these things for simple stereo CODECs, having
> the common clock API more widely available so we can create a hard
> requirement that clocks be described using the clock API would help a
> lot with that.
>
>> That will be one machine driver for possibly all Marvell boards, not
>> what e.g. tegra is doing with one machine driver for each board they
>> can find. I understand that the exact wiring on each board may get
>> complicated, but I don't see why a (well thought) binding should not
>> be able to describe it?
>
> The clocking arrangements for a smartphone are not that trivial and we
> need to be able to cope with things like having more than two devices on
> the bus.
>

Mark,

I cannot follow you on the clocking arrangements. The binding
proposal was for audio controller <-> CODEC connections. For clocks
there are common properties ("clocks", "clock-names", "clock-frequency")
to pass them to drivers - for "sound cards" in general there are not.

I am not referring to ASoC or ALSA here, but describing device 
inter-connection. And that can be done in a generic way to allow all those
SoC/codec/board specific DT bindings to become very obsolete. The
device nodes in question can still contain clocks properties of course,
but you do not need a special compatible for e.g.
"nvidia,tegra-audio-rt5640-beaver".

So, having a look at the node in question:

sound {
   compatible = "nvidia,tegra-audio-rt5640-beaver",
                "nvidia,tegra-audio-rt5640";
   nvidia,model = "NVIDIA Tegra Beaver";

   nvidia,audio-routing = "Headphones", "HPOR",
                          "Headphones", "HPOL";

   nvidia,i2s-controller = <&tegra_i2s1>;
   nvidia,audio-codec = <&rt5640>;

   nvidia,hp-det-gpios = <&gpio TEGRA_GPIO(W, 2) GPIO_ACTIVE_HIGH>;

   clocks = <&tegra_car TEGRA30_CLK_PLL_A>,
            <&tegra_car TEGRA30_CLK_PLL_A_OUT0>,
            <&tegra_car TEGRA30_CLK_EXTERN1>;
   clock-names = "pll_a", "pll_a_out0", "mclk";
};

all those "nvidia," prefixed properties are not nvidia-specific at all.
Also, all those "nvidia," properties would have fit very well into the
i2s controller node - there may be more complex SoCs requiring an extra
"sound card" node, Tegra is not.

Even those foo-gpios properties can be generalized and moved to ASoC;
have a look at MMC drivers using one common "cd-gpios" property for
very different drivers. What is so special with Tegra and this gpio
that it needs a vendor-specific property?

I was asking for generalizing those exact properties to generic ones
and them move support for them to the ASoC/ALSA framework. With all
that DT binding re-review coming up, I doubt that the tegra binding
will be accepted again anyway.

 >> i2s1: audio-controller at b0000 {
 >> 	compatible = "marvell,dove-i2s";
 >> 	reg = <0xb0000 0x2345>;
 >> 	audio-codecs = <&spdif 0>;
 >> };
 > No, things are glued together using the machine driver - again, look at
 > how all the other systems work.  The wiring on the board can get
 > interesting enough to need a binding of its own, for very simple
 > bindings that should just be pointing to a generic driver.

I learned to never match "device nodes" with "drivers" as there
is simply no relation between them.

So, back to my original node proposal, can you tell me what is so
different, except that I am not using "marvell,audio-codec(s)" but
"audio-codecs"; and hook the one available codec output by using
phandle/args instead of a new compatible string?

Sebastian

(Note: The above i2s1 node will contains "clocks" for sure, but that is
not related to sound-specific properties.)
