From: t-kristo@ti.com (Tero Kristo)
Date: Tue, 22 Dec 2015 22:10:41 +0200
Subject: [PATCH v2] ARM: dts: Add clocks for dm814x ADPLL
In-Reply-To: <1450799607-9334-1-git-send-email-tony@atomide.com>
References: <1450799607-9334-1-git-send-email-tony@atomide.com>
Message-ID: <5679AE41.2080409@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/22/2015 05:53 PM, Tony Lindgren wrote:
> These use the standard clock bindings and now we can make some
> of the fixed clocks into real clocks.
>
> Cc: Tero Kristo <t-kristo@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
> Changes since v1:
>
> - Updated for changed clock names for "dcoclkldo"
> - Merged in the dra62x changes
>
> ---
>   arch/arm/boot/dts/dm814x-clocks.dtsi | 256 ++++++++++++++++++++++++++++++-----
>   arch/arm/boot/dts/dra62x-clocks.dtsi |  26 ++++
>   2 files changed, 251 insertions(+), 31 deletions(-)
>
> diff --git a/arch/arm/boot/dts/dm814x-clocks.dtsi b/arch/arm/boot/dts/dm814x-clocks.dtsi
> index e0ea6a9..b75ca91 100644
> --- a/arch/arm/boot/dts/dm814x-clocks.dtsi
> +++ b/arch/arm/boot/dts/dm814x-clocks.dtsi
> @@ -4,6 +4,170 @@
>    * published by the Free Software Foundation.
>    */
>
> +&pllss {
> +	/*
> +	 * See TRM "2.6.10 Connected outputso DPLLS" and
> +	 * "2.6.11 Connected Outputs of DPLLJ". Only clkout is
> +	 * connected except for hdmi and usb.
> +	 */
> +	adpll_mpu_ck: adpll at 40 {
> +		#clock-cells = <1>;
> +		compatible = "ti,dm814-adpll-s-clock";
> +		reg = <0x40 0x40>;
> +		clocks = <&devosc_ck &devosc_ck &devosc_ck>;
> +		clock-names = "clkinp", "clkinpulow", "clkinphif";
> +		clock-indices = <0>, <1>, <2>, <3>;
> +		clock-output-names = "481c5040.adpll.dcoclkldo",
> +				     "481c5040.adpll.clkout",
> +				     "481c5040.adpll.clkoutx2",
> +				     "481c5040.adpll.clkouthif";

Discussed this offline, but looks like most of the clock output names 
can probably be generated runtime, as they seem duplicate across adplls? 
Including the address component.

Based on the offline discussion though:

Acked-by: Tero Kristo <t-kristo@ti.com>

-Tero


> +	};
> +
> +	adpll_dsp_ck: adpll at 80 {
> +		#clock-cells = <1>;
> +		compatible = "ti,dm814-adpll-lj-clock";
> +		reg = <0x80 0x30>;
> +		clocks = <&devosc_ck &devosc_ck>;
> +		clock-names = "clkinp", "clkinpulow";
> +		clock-indices = <0>, <1>, <2>;
> +		clock-output-names = "481c5080.adpll.dcoclkldo",
> +				     "481c5080.adpll.clkout",
> +				     "481c5080.adpll.clkoutldo";
> +	};
> +
> +	adpll_sgx_ck: adpll at b0 {
> +		#clock-cells = <1>;
> +		compatible = "ti,dm814-adpll-lj-clock";
> +		reg = <0xb0 0x30>;
> +		clocks = <&devosc_ck &devosc_ck>;
> +		clock-names = "clkinp", "clkinpulow";
> +		clock-indices = <0>, <1>, <2>;
> +		clock-output-names = "481c50b0.adpll.dcoclkldo",
> +				     "481c50b0.adpll.clkout",
> +				     "481c50b0.adpll.clkoutldo";
> +	};
> +
> +	adpll_hdvic_ck: adpll at e0 {
> +		#clock-cells = <1>;
> +		compatible = "ti,dm814-adpll-lj-clock";
> +		reg = <0xe0 0x30>;
> +		clocks = <&devosc_ck &devosc_ck>;
> +		clock-names = "clkinp", "clkinpulow";
> +		clock-indices = <0>, <1>, <2>;
> +		clock-output-names = "481c50e0.adpll.dcoclkldo",
> +				     "481c50e0.adpll.clkout",
> +				     "481c50e0.adpll.clkoutldo";
> +	};
> +
> +	adpll_l3_ck: adpll at 110 {
> +		#clock-cells = <1>;
> +		compatible = "ti,dm814-adpll-lj-clock";
> +		reg = <0x110 0x30>;
> +		clocks = <&devosc_ck &devosc_ck>;
> +		clock-names = "clkinp", "clkinpulow";
> +		clock-indices = <0>, <1>, <2>;
> +		clock-output-names = "481c5110.adpll.dcoclkldo",
> +				     "481c5110.adpll.clkout",
> +				     "481c5110.adpll.clkoutldo";
> +	};
> +
> +	adpll_isp_ck: adpll at 140 {
> +		#clock-cells = <1>;
> +		compatible = "ti,dm814-adpll-lj-clock";
> +		reg = <0x140 0x30>;
> +		clocks = <&devosc_ck &devosc_ck>;
> +		clock-names = "clkinp", "clkinpulow";
> +		clock-indices = <0>, <1>, <2>;
> +		clock-output-names = "481c5140.adpll.dcoclkldo",
> +				     "481c5140.adpll.clkout",
> +				     "481c5140.adpll.clkoutldo";
> +	};
> +
> +	adpll_dss_ck: adpll at 170 {
> +		#clock-cells = <1>;
> +		compatible = "ti,dm814-adpll-lj-clock";
> +		reg = <0x170 0x30>;
> +		clocks = <&devosc_ck &devosc_ck>;
> +		clock-names = "clkinp", "clkinpulow";
> +		clock-indices = <0>, <1>, <2>;
> +		clock-output-names = "481c5170.adpll.dcoclkldo",
> +				     "481c5170.adpll.clkout",
> +				     "481c5170.adpll.clkoutldo";
> +	};
> +
> +	adpll_video0_ck: adpll at 1a0 {
> +		#clock-cells = <1>;
> +		compatible = "ti,dm814-adpll-lj-clock";
> +		reg = <0x1a0 0x30>;
> +		clocks = <&devosc_ck &devosc_ck>;
> +		clock-names = "clkinp", "clkinpulow";
> +		clock-indices = <0>, <1>, <2>;
> +		clock-output-names = "481c51a0.adpll.dcoclkldo",
> +				     "481c51a0.adpll.clkout",
> +				     "481c51a0.adpll.clkoutldo";
> +	};
> +
> +	adpll_video1_ck: adpll at 1d0 {
> +		#clock-cells = <1>;
> +		compatible = "ti,dm814-adpll-lj-clock";
> +		reg = <0x1d0 0x30>;
> +		clocks = <&devosc_ck &devosc_ck>;
> +		clock-names = "clkinp", "clkinpulow";
> +		clock-indices = <0>, <1>, <2>;
> +		clock-output-names = "481c51d0.adpll.dcoclkldo",
> +				     "481c51d0.adpll.clkout",
> +				     "481c51d0.adpll.clkoutldo";
> +	};
> +
> +	adpll_hdmi_ck: adpll at 200 {
> +		#clock-cells = <1>;
> +		compatible = "ti,dm814-adpll-lj-clock";
> +		reg = <0x200 0x30>;
> +		clocks = <&devosc_ck &devosc_ck>;
> +		clock-names = "clkinp", "clkinpulow";
> +		clock-indices = <0>, <1>, <2>;
> +		clock-output-names = "481c5200.adpll.dcoclkldo",
> +				     "481c5200.adpll.clkout",
> +				     "481c5200.adpll.clkoutldo";
> +	};
> +
> +	adpll_audio_ck: adpll at 230 {
> +		#clock-cells = <1>;
> +		compatible = "ti,dm814-adpll-lj-clock";
> +		reg = <0x230 0x30>;
> +		clocks = <&devosc_ck &devosc_ck>;
> +		clock-names = "clkinp", "clkinpulow";
> +		clock-indices = <0>, <1>, <2>;
> +		clock-output-names = "481c5230.adpll.dcoclkldo",
> +				     "481c5230.adpll.clkout",
> +				     "481c5230.adpll.clkoutldo";
> +	};
> +
> +	adpll_usb_ck: adpll at 260 {
> +		#clock-cells = <1>;
> +		compatible = "ti,dm814-adpll-lj-clock";
> +		reg = <0x260 0x30>;
> +		clocks = <&devosc_ck &devosc_ck>;
> +		clock-names = "clkinp", "clkinpulow";
> +		clock-indices = <0>, <1>, <2>;
> +		clock-output-names = "481c5260.adpll.dcoclkldo",
> +				     "481c5260.adpll.clkout",
> +				     "481c5260.adpll.clkoutldo";
> +	};
> +
> +	adpll_ddr_ck: adpll at 290 {
> +		#clock-cells = <1>;
> +		compatible = "ti,dm814-adpll-lj-clock";
> +		reg = <0x290 0x30>;
> +		clocks = <&devosc_ck &devosc_ck>;
> +		clock-names = "clkinp", "clkinpulow";
> +		clock-indices = <0>, <1>, <2>;
> +		clock-output-names = "481c5290.adpll.dcoclkldo",
> +				     "481c5290.adpll.clkout",
> +				     "481c5290.adpll.clkoutldo";
> +	};
> +};
> +
>   &pllss_clocks {
>   	timer1_fck: timer1_fck {
>   		#clock-cells = <0>;
> @@ -23,6 +187,24 @@
>   		reg = <0x2e0>;
>   	};
>
> +	/* CPTS_RFT_CLK in RMII_REFCLK_SRC, usually sourced from auiod */
> +	cpsw_cpts_rft_clk: cpsw_cpts_rft_clk {
> +		#clock-cells = <0>;
> +		compatible = "ti,mux-clock";
> +		clocks = <&adpll_video0_ck 1
> +			  &adpll_video1_ck 1
> +			  &adpll_audio_ck 1>;
> +		ti,bit-shift = <1>;
> +		reg = <0x2e8>;
> +	};
> +
> +	/* REVISIT: Set up with a proper mux using RMII_REFCLK_SRC */
> +	cpsw_125mhz_gclk: cpsw_125mhz_gclk {
> +		#clock-cells = <0>;
> +		compatible = "fixed-clock";
> +		clock-frequency = <125000000>;
> +	};
> +
>   	sysclk18_ck: sysclk18_ck {
>   		#clock-cells = <0>;
>   		compatible = "ti,mux-clock";
> @@ -79,37 +261,6 @@
>   		compatible = "fixed-clock";
>   		clock-frequency = <1000000000>;
>   	};
> -
> -	sysclk4_ck: sysclk4_ck {
> -		#clock-cells = <0>;
> -		compatible = "fixed-clock";
> -		clock-frequency = <222000000>;
> -	};
> -
> -	sysclk6_ck: sysclk6_ck {
> -		#clock-cells = <0>;
> -		compatible = "fixed-clock";
> -		clock-frequency = <100000000>;
> -	};
> -
> -	sysclk10_ck: sysclk10_ck {
> -		#clock-cells = <0>;
> -		compatible = "fixed-clock";
> -		clock-frequency = <48000000>;
> -	};
> -
> -        cpsw_125mhz_gclk: cpsw_125mhz_gclk {
> -		#clock-cells = <0>;
> -		compatible = "fixed-clock";
> -		clock-frequency = <125000000>;
> -	};
> -
> -	cpsw_cpts_rft_clk: cpsw_cpts_rft_clk {
> -		#clock-cells = <0>;
> -		compatible = "fixed-clock";
> -		clock-frequency = <250000000>;
> -	};
> -
>   };
>
>   &prcm_clocks {
> @@ -138,6 +289,49 @@
>   		clock-div = <78125>;
>   	};
>
> +	/* L4_HS 220 MHz*/
> +	sysclk4_ck: sysclk4_ck {
> +		#clock-cells = <0>;
> +		compatible = "ti,fixed-factor-clock";
> +		clocks = <&adpll_l3_ck 1>;
> +		ti,clock-mult = <1>;
> +		ti,clock-div = <1>;
> +	};
> +
> +	/* L4_FWCFG */
> +	sysclk5_ck: sysclk5_ck {
> +		#clock-cells = <0>;
> +		compatible = "ti,fixed-factor-clock";
> +		clocks = <&adpll_l3_ck 1>;
> +		ti,clock-mult = <1>;
> +		ti,clock-div = <2>;
> +	};
> +
> +	/* L4_LS 110 MHz */
> +	sysclk6_ck: sysclk6_ck {
> +		#clock-cells = <0>;
> +		compatible = "ti,fixed-factor-clock";
> +		clocks = <&adpll_l3_ck 1>;
> +		ti,clock-mult = <1>;
> +		ti,clock-div = <2>;
> +	};
> +
> +	sysclk8_ck: sysclk8_ck {
> +		#clock-cells = <0>;
> +		compatible = "ti,fixed-factor-clock";
> +		clocks = <&adpll_usb_ck 1>;
> +		ti,clock-mult = <1>;
> +		ti,clock-div = <1>;
> +	};
> +
> +	sysclk10_ck: sysclk10_ck {
> +		compatible = "ti,divider-clock";
> +		reg = <0x324>;
> +		ti,max-div = <7>;
> +		#clock-cells = <0>;
> +		clocks = <&adpll_usb_ck 1>;
> +	};
> +
>   	aud_clkin0_ck: aud_clkin0_ck {
>   		#clock-cells = <0>;
>   		compatible = "fixed-clock";
> diff --git a/arch/arm/boot/dts/dra62x-clocks.dtsi b/arch/arm/boot/dts/dra62x-clocks.dtsi
> index 6f98dc8..0e49741 100644
> --- a/arch/arm/boot/dts/dra62x-clocks.dtsi
> +++ b/arch/arm/boot/dts/dra62x-clocks.dtsi
> @@ -6,6 +6,32 @@
>
>   #include "dm814x-clocks.dtsi"
>
> +/* Compared to dm814x, dra62x does not have hdic, l3 or dss PLLs */
> +&adpll_hdvic_ck {
> +	status = "disabled";
> +};
> +
> +&adpll_l3_ck {
> +	status = "disabled";
> +};
> +
> +&adpll_dss_ck {
> +	status = "disabled";
> +};
> +
> +/* Compared to dm814x, dra62x has interconnect clocks on isp PLL */
> +&sysclk4_ck {
> +	clocks = <&adpll_isp_ck 1>;
> +};
> +
> +&sysclk5_ck {
> +	clocks = <&adpll_isp_ck 1>;
> +};
> +
> +&sysclk6_ck {
> +	clocks = <&adpll_isp_ck 1>;
> +};
> +
>   /*
>    * Compared to dm814x, dra62x has different shifts and more mux options.
>    * Please add the extra options for ysclk_14 and 16 if really needed.
>
