From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 10 Sep 2014 15:26:58 -0600
Subject: [PATCH v2 1/2] ARM: tegra: apalis/colibri t30: integrate audio
 support
In-Reply-To: <00f249b3d648d3a8d550c5db0737f3aa6d93f07e.1410362950.git.marcel@ziswiler.com>
References: <cover.1410362950.git.marcel@ziswiler.com>
 <00f249b3d648d3a8d550c5db0737f3aa6d93f07e.1410362950.git.marcel@ziswiler.com>
Message-ID: <5410C222.2020602@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/10/2014 02:54 PM, Marcel Ziswiler wrote:
> Integrate Freescale SGTL5000 analogue audio codec support.
>
> Signed-off-by: Marcel Ziswiler <marcel@ziswiler.com>
> Reviewed-by: Stephen Warren <swarren@nvidia.com>

No, definitely not; this patch has significant semantic changes since I 
reviewed it.

> diff --git a/arch/arm/boot/dts/tegra30-apalis.dtsi b/arch/arm/boot/dts/tegra30-apalis.dtsi


> +	sound {
> +		compatible = "simple-audio-card";
...
> +		simple-audio-card,codec {
> +			bitclock-master;
> +			clocks = <&tegra_car TEGRA30_CLK_EXTERN1>;
> +			frame-master;
> +			sound-dai = <&sgtl5000>;
> +		};
> +
> +		simple-audio-card,cpu {
> +			bitclock-master;
> +			clocks = <&tegra_car TEGRA30_CLK_PLL_A>,
> +				 <&tegra_car TEGRA30_CLK_PLL_A_OUT0>;
> +			frame-master;
> +			master-clkdir-out;
> +			sound-dai = <&tegra_i2s2>;
> +		};
> +	};

I'm not sure how this can work. Certainly all 3 clocks that are required 
for audio are mentioned here. However, the PLL_A clock (which then 
trickles down to the other 2) needs to have its rate changed based on 
whether the sample rate is 44.1KHz- or 48KHz-based. Semantically, this 
can't be something that "simple-audio-card" can imply, since 
"simple-audio-card" is something agnostic to any HW, whereas this 
clocking requirement is something specific to Tegra HW.

To see the problem, try encoding some audio stream as both 44.1KHz and 
48KHz, then play a few seconds of each and keep switching back and 
forth. You'll likely find either the playback pitch is wrong, or you get 
drop-outs or stuttering.

I also wonder how "simple-audio-card" can know what rate the EXTERN1 
clock to the CODEC should be set to; each CODEC has a different 
requirement for the minimum clock input and the Fs multiple usually 
varies for different sample rates. See for example 
sound/soc/tegra/tegra_wm8903.c:tegra_wm8903_hw_params(). This could be a 
solved problem though: Perhaps some API has been added to CODECs to 
report this information (or perhaps CODEC drivers now clk_set_rate() on 
their input clocks themselves) since I last looked.
