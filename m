From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Mon, 12 Sep 2016 20:51:03 -0700
Subject: [PATCH] ARM: dts: msm8974: Add definitions for QCE & cryptobam
In-Reply-To: <20160830153740.13275-1-voker57@gmail.com>
References: <20160830153740.13275-1-voker57@gmail.com>
Message-ID: <20160913035103.GA21438@tuxbot>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue 30 Aug 08:37 PDT 2016, Iaroslav Gridin wrote:

> From: Voker57 <voker57@gmail.com>
> 
> Add device tree definitions for Qualcomm Cryptography engine and its BAM
> Signed-off-by: Iaroslav Gridin <voker57@gmail.com>
> ---
>  arch/arm/boot/dts/qcom-msm8974.dtsi | 42 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
> index 561d4d1..c0da739 100644
> --- a/arch/arm/boot/dts/qcom-msm8974.dtsi
> +++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
> @@ -287,6 +287,48 @@
>  			reg = <0xf9011000 0x1000>;
>  		};
>  
> +		cryptobam: dma at fd444000 {
> +			compatible = "qcom,bam-v1.4.0";
> +			reg = <0xfd444000 0x15000>;
> +			interrupts = <0 236 0>;
> +			clocks = <&gcc GCC_CE2_AHB_CLK>,
> +				 <&gcc GCC_CE2_AXI_CLK>,
> +				 <&gcc GCC_CE2_CLK>;
> +			clock-names = "bam_clk", "axi_clk", "core_clk";
> +			#dma-cells = <1>;
> +			qcom,ee = <1>;
> +			qcom,controlled-remotely;
> +			};

As Stan noted, please shift this '}' one step left (the rest looks well
indented.

> +
> +		qcom,qcrypto at fd440000 {

Rename this "qcrypto" and make sure the address matches the reg
property.

> +			compatible = "qcom,crypto-v5.1";
> +			reg = <0xfd45a000 0x6000>;
> +			reg-names = "crypto-base";
> +			interrupts = <0 236 0>;
> +			qcom,bam-pipe-pair = <2>;
> +			qcom,ce-hw-instance = <1>;
> +			qcom,ce-device = <0>;
> +			clocks = <&gcc GCC_CE2_CLK>,
> +				 <&gcc GCC_CE2_AHB_CLK>,
> +				 <&gcc GCC_CE2_AXI_CLK>,
> +				 <&gcc CE2_CLK_SRC>;
> +
> +			dmas = <&cryptobam 2>, <&cryptobam 3>;
> +			dma-names = "rx", "tx";
> +			clock-names = "core", "iface", "bus", "core_src";
> +			qcom,clk-mgmt-sus-res;
> +			qcom,msm-bus,name = "qcrypto-noc";
> +
> +			qcom,msm-bus,num-cases = <2>;
> +			qcom,msm-bus,num-paths = <1>;
> +			qcom,use-sw-aes-cbc-ecb-ctr-algo;
> +			qcom,use-sw-aes-xts-algo;
> +			qcom,use-sw-ahash-algo;
> +			qcom,msm-bus,vectors-KBps = <56 512 0 0>,
> +						    <56 512 3936000 393600>;
> +			};
> +
> +
>  		timer at f9020000 {

It's nice to keep the nodes within a group ordered by address.

Regards,
Bjorn
