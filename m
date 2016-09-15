From: andy.gross@linaro.org (Andy Gross)
Date: Thu, 15 Sep 2016 16:18:42 -0500
Subject: [PATCH] ARM: dts: msm8974: Add definitions for QCE & cryptobam
In-Reply-To: <20160830153740.13275-1-voker57@gmail.com>
References: <20160830153740.13275-1-voker57@gmail.com>
Message-ID: <20160915211842.GB5431@hector.attlocal.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 30, 2016 at 06:37:40PM +0300, Iaroslav Gridin wrote:
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

Actually, on thinking about this more, the bam block itself only requires the
single clock.  The peripheral it is attached to has to keep its sanity during
the duration of the transfer (crypto).  The crypto requires 3 clocks, one of
which is the same clk the bam requires.

You can access the BAM registers with the bam_clk only, correct?


> +			#dma-cells = <1>;
> +			qcom,ee = <1>;
> +			qcom,controlled-remotely;
> +			};
> +
> +		qcom,qcrypto at fd440000 {
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

The CLK_SRC is unnecessary.  Or should be at least.  That gets turned on by
getting the CE2_CLK.  I vaguely remember a parent issue that was fixed.

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
>  			#address-cells = <1>;
>  			#size-cells = <1>;

Regards,

Andy
