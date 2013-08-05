From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 05 Aug 2013 16:47:12 -0600
Subject: [alsa-devel] [PATCH RFC 00/13] Adding SPDIF support to
 kirkwood-i2s
In-Reply-To: <51FFBF03.1000507@gmail.com>
References: <20130804192136.GK23006@n2100.arm.linux.org.uk>
 <51FECB7A.6010208@gmail.com> <20130805115947.GA9858@sirena.org.uk>
 <51FFA348.2010503@gmail.com> <20130805140729.GC9858@sirena.org.uk>
 <51FFBF03.1000507@gmail.com>
Message-ID: <52002B70.5050109@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/05/2013 09:04 AM, Sebastian Hesselbarth wrote:
...
> So, having a look at the node in question:
> 
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

Indeed. I do still have a desire to do a more encompassing generic
binding that could use generic property names. However, I'm pulled in
many directions and never manage to get around to that:-( Months or even
years ago I did get as far as posting a binding with my ideas, but it
needs a lot more work to correctly separate out what can be generic and
what still needs to be SoC-/board-specific, how to represent it all in
DT, and how to code stuff up into useful utility code that ASoC machine
drivers will find useful, since custom machine drivers will almost
certainly be required to do the last pieces of integration of
SoC-specific control, even with a relatively complete generic DT
representation (unless you start putting Forth into DT for the last bits!)

> Also, all those "nvidia," properties would have fit very well into the
> i2s controller node - there may be more complex SoCs requiring an extra
> "sound card" node, Tegra is not.

That's certainly not true. It only looks like that because the DTs we
currently have upstream expose only a subset of the whole functionality
of the system. It's certainly not possible to move all the properties
into e.g. the I2S controller node in general, because the audio system
as a whole spans far more devices than just a single I2S controller.

> Even those foo-gpios properties can be generalized and moved to ASoC;
> have a look at MMC drivers using one common "cd-gpios" property for
> very different drivers. What is so special with Tegra and this gpio
> that it needs a vendor-specific property?
> 
> I was asking for generalizing those exact properties to generic ones
> and them move support for them to the ASoC/ALSA framework. With all
> that DT binding re-review coming up, I doubt that the tegra binding
> will be accepted again anyway.

I don't agree. It's not *generic*, but I don't see any requirement to
only accept completely generic bindings. If there was such a
requirement, we'd probably never get any more bindings for
embedded-style audio HW... The only thing that might change is removing
some of the prefixes from the property names.
