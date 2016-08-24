From: xuwei5@hisilicon.com (Wei Xu)
Date: Wed, 24 Aug 2016 16:14:57 +0100
Subject: [PATCH 1/4] arm64: dts: Add display subsystem DT nodes for
 hi6220-hikey
In-Reply-To: <1471906085-16682-1-git-send-email-john.stultz@linaro.org>
References: <1471906085-16682-1-git-send-email-john.stultz@linaro.org>
Message-ID: <57BDB9F1.7020103@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi John,

On 22/08/2016 23:48, John Stultz wrote:
> From: Xinliang Liu <xinliang.liu@linaro.org>
> 
> Add ade and dsi DT nodes for hikey board.
> 
> Cc: Guodong Xu <guodong.xu@linaro.org>
> Cc: Wei Xu <xuwei5@hisilicon.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: devicetree at vger.kernel.org
> Signed-off-by: Xinliang Liu <xinliang.liu@linaro.org>
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> ---

Series applied to the hisilicon soc tree.
Thanks!

Best Regards,
Wei

>  arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts |  8 ++++
>  arch/arm64/boot/dts/hisilicon/hi6220.dtsi      | 55 ++++++++++++++++++++++++++
>  2 files changed, 63 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
> index 593c7e4..c2f014e 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
> +++ b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
> @@ -372,3 +372,11 @@
>  &uart3 {
>  	label = "LS-UART1";
>  };
> +
> +&ade {
> +	status = "ok";
> +};
> +
> +&dsi {
> +	status = "ok";
> +};
> diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> index 4f27041..d0b887a 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> @@ -262,6 +262,11 @@
>  			#clock-cells = <1>;
>  		};
>  
> +		medianoc_ade: medianoc_ade at f4520000 {
> +			compatible = "syscon";
> +			reg = <0x0 0xf4520000 0x0 0x4000>;
> +		};
> +
>  		stub_clock: stub_clock {
>  			compatible = "hisilicon,hi6220-stub-clk";
>  			hisilicon,hi6220-clk-sram = <&sram>;
> @@ -850,5 +855,55 @@
>  				};
>  			};
>  		};
> +
> +		ade: ade at f4100000 {
> +			compatible = "hisilicon,hi6220-ade";
> +			reg = <0x0 0xf4100000 0x0 0x7800>;
> +			reg-names = "ade_base";
> +			hisilicon,noc-syscon = <&medianoc_ade>;
> +			resets = <&media_ctrl MEDIA_ADE>;
> +			interrupts = <0 115 4>; /* ldi interrupt */
> +
> +			clocks = <&media_ctrl HI6220_ADE_CORE>,
> +				 <&media_ctrl HI6220_CODEC_JPEG>,
> +				 <&media_ctrl HI6220_ADE_PIX_SRC>;
> +			/*clock name*/
> +			clock-names  = "clk_ade_core",
> +				       "clk_codec_jpeg",
> +				       "clk_ade_pix";
> +
> +			assigned-clocks = <&media_ctrl HI6220_ADE_CORE>,
> +				<&media_ctrl HI6220_CODEC_JPEG>;
> +			assigned-clock-rates = <360000000>, <288000000>;
> +			dma-coherent;
> +			status = "disabled";
> +
> +			port {
> +				ade_out: endpoint {
> +					remote-endpoint = <&dsi_in>;
> +				};
> +			};
> +		};
> +
> +		dsi: dsi at f4107800 {
> +			compatible = "hisilicon,hi6220-dsi";
> +			reg = <0x0 0xf4107800 0x0 0x100>;
> +			clocks = <&media_ctrl  HI6220_DSI_PCLK>;
> +			clock-names = "pclk";
> +			status = "disabled";
> +
> +			ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				/* 0 for input port */
> +				port at 0 {
> +					reg = <0>;
> +					dsi_in: endpoint {
> +						remote-endpoint = <&ade_out>;
> +					};
> +				};
> +			};
> +		};
>  	};
>  };
> 
