From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Mon, 18 Feb 2013 12:20:24 +0100
Subject: [PATCH V2] ARM: dts: omap3-devkit8000: Enable audio support
In-Reply-To: <1361000036-18121-1-git-send-email-anilk4.v@gmail.com>
References: <1361000036-18121-1-git-send-email-anilk4.v@gmail.com>
Message-ID: <51220E78.5000409@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/16/2013 08:33 AM, Anil Kumar wrote:
> Add the needed sections to enable audio support on
> Devkit8000 when booted with DT blob.
> 
> Signed-off-by: Anil Kumar <anilk4.v@gmail.com>

Looks good:
Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> ---
> This patch is based on top of kernel 3.8-rc5 and
> the following patches.
> 
> Peter Ujfalusi:-
> ASoC: twl4030: Correct the support for Voice port
> ASoC: twl4030: Convert MICBIAS to SUPPLY widget
> ASoC: omap-twl4030: Add support for routing, voice port and jack detect
> 
> Anil Kumar:-
> ARM: dts: add minimal DT support for DevKit8000
> https://patchwork.kernel.org/patch/2122461/
> 
> -Tested for playback and capture on Devkit8000.
> 
>  Test process:-
> 
>  #amixer set 'PredriveR Mixer AudioR2' on
>  #amixer set 'PredriveL Mixer AudioL2' on
>  #amixer set PreDriv 100 unmute
>  #amixer set 'DAC2 Digital Fine' 100
>  #amixer cset numid=27 1
>  #arecord | aplay
> 
> For V2:
>  - Remove pin mux as done at device boot time by default.
> 
> :100644 100644 6338993... c70116f... M	arch/arm/boot/dts/omap3-devkit8000.dts
>  arch/arm/boot/dts/omap3-devkit8000.dts |   23 +++++++++++++++++++----
>  1 files changed, 19 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/omap3-devkit8000.dts b/arch/arm/boot/dts/omap3-devkit8000.dts
> index 6338993..c70116f 100644
> --- a/arch/arm/boot/dts/omap3-devkit8000.dts
> +++ b/arch/arm/boot/dts/omap3-devkit8000.dts
> @@ -42,6 +42,19 @@
>                  };
>  
>  	};
> +
> +	sound {
> +		compatible = "ti,omap-twl4030";
> +		ti,model = "devkit8000";
> +
> +		ti,mcbsp = <&mcbsp2>;
> +		ti,codec = <&twl_audio>;
> +		ti,audio-routing =
> +			"Ext Spk", "PREDRIVEL",
> +			"Ext Spk", "PREDRIVER",
> +			"MAINMIC", "Main Mic",
> +			"Main Mic", "Mic Bias 1";
> +	};
>  };
>  
>  &i2c1 {
> @@ -51,6 +64,12 @@
>  		reg = <0x48>;
>  		interrupts = <7>;	/* SYS_NIRQ cascaded to intc */
>  		interrupt-parent = <&intc>;
> +
> +		twl_audio: audio {
> +			compatible = "ti,twl4030-audio";
> +			codec {
> +			};
> +		};
>  	};
>  };
>  
> @@ -86,10 +105,6 @@
>  	status = "disabled";
>  };
>  
> -&mcbsp2 {
> -	status = "disabled";
> -};
> -
>  &mcbsp3 {
>  	status = "disabled";
>  };
> 


-- 
P?ter
