From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon, 05 Aug 2013 20:14:47 +0200
Subject: [PATCH RFC 00/13] Adding SPDIF support to kirkwood-i2s
In-Reply-To: <20130805165957.GT9858@sirena.org.uk>
References: <20130804192136.GK23006@n2100.arm.linux.org.uk>
 <51FECB7A.6010208@gmail.com> <20130805115947.GA9858@sirena.org.uk>
 <51FFA348.2010503@gmail.com> <20130805140729.GC9858@sirena.org.uk>
 <51FFBF03.1000507@gmail.com> <20130805165957.GT9858@sirena.org.uk>
Message-ID: <51FFEB97.30004@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/05/2013 06:59 PM, Mark Brown wrote:
> On Mon, Aug 05, 2013 at 05:04:35PM +0200, Sebastian Hesselbarth wrote:
>
>> I cannot follow you on the clocking arrangements. The binding
>> proposal was for audio controller <-> CODEC connections. For clocks
>> there are common properties ("clocks", "clock-names", "clock-frequency")
>> to pass them to drivers - for "sound cards" in general there are not.
>
> The clocking arrangements are an example of why the boards can get
> interesting enough to describe for themselves.

I understand there are complex arrangements, I still don't think that
you need a global super-node to describe them. Anyway, I am not voting
against a super-node.

>> So, having a look at the node in question:
>
>> sound {
>>    compatible = "nvidia,tegra-audio-rt5640-beaver",
>>                 "nvidia,tegra-audio-rt5640";
>>    nvidia,model = "NVIDIA Tegra Beaver";
>>
>>    nvidia,audio-routing = "Headphones", "HPOR",
>>                           "Headphones", "HPOL";
>>
>>    nvidia,i2s-controller = <&tegra_i2s1>;
>>    nvidia,audio-codec = <&rt5640>;
>>
>>    nvidia,hp-det-gpios = <&gpio TEGRA_GPIO(W, 2) GPIO_ACTIVE_HIGH>;
>>
>>    clocks = <&tegra_car TEGRA30_CLK_PLL_A>,
>>             <&tegra_car TEGRA30_CLK_PLL_A_OUT0>,
>>             <&tegra_car TEGRA30_CLK_EXTERN1>;
>>    clock-names = "pll_a", "pll_a_out0", "mclk";
>> };
>>
>> all those "nvidia," prefixed properties are not nvidia-specific at all.
>
> This is all because you have to add a prefix for DT.

Right, like we have on all the other non-standard properties like
"pinctrl-0", "bla-gpios", "clocks", ... come on, just make them generic
enough and you can omit the vendor prefix.

>> Also, all those "nvidia," properties would have fit very well into the
>> i2s controller node
>
> No, almost none of them have any place there.  For example, the audio
> routing contains only connections to the CODEC so the I2S controller
> isn't in play, the headphone detection is connected to the AP but isn't
> connected to the I2S port.

 From a quick look in tegra30_hub.h, I can see configuration registers
i2s formatting. I assume that i2s controller on Tegra can therefore
directly connected to a I2S codec, can't it? Then, with an existing i2s
node and an existing codec node - why is there no place to link both?

I can think of use cases that are hard to describe in a link-to-link
way, but none of them really requires a super-node nor special
board-specific compatible strings. With that we can just have the root
DT node be compatible with Beaver above and register all the old
platform_device way.

[...]
>> I learned to never match "device nodes" with "drivers" as there
>> is simply no relation between them.
>
> That's clearly a thinko for device node.

I assume with "thinko" you mean "thought wrong" - IMHO the above 
statement is very true. If it wouldn't, why not just have a node for
kirkwood-dma and kirkwood-i2s instead of merging the drivers?
You think that will also be accepted by DT maintainers?

>> So, back to my original node proposal, can you tell me what is so
>> different, except that I am not using "marvell,audio-codec(s)" but
>> "audio-codecs"; and hook the one available codec output by using
>> phandle/args instead of a new compatible string?
>
>  From my point of view I'd rather not be shoving vendor prefixes on all
> the properties, this is coming from DT convention requiring vendor
> prefixes on bindings.

I understand that those vendor prefixes are part of the helper
functions of ASoC. But no other subsystem has a similar approach but
though of properties generic enough to help drivers find what they
need to know. Either ASoC is mis-interpreting the vendor-prefix
requirement - or all other subsystems are.

Sebastian
