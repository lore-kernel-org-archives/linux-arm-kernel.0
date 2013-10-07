From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 7 Oct 2013 13:53:43 +0800
Subject: [PATCH RFC 1/2] ARM: imx6qdl: provide pinctrl configurations for
 DAT3 pull-down
In-Reply-To: <E1VSPw9-0004Ug-BF@rmk-PC.arm.linux.org.uk>
References: <20131005112147.GX12758@n2100.arm.linux.org.uk>
 <E1VSPw9-0004Ug-BF@rmk-PC.arm.linux.org.uk>
Message-ID: <20131007055340.GB3739@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 05, 2013 at 12:22:17PM +0100, Russell King wrote:
> DAT3 needs to be pulled down if the USDHC card detection facility is
> used rather than GPIO mode.  This is due to there being two methods
> to detect a card - one via the card detect signal, and the other via
> DAT3 being pulled up by the inserted card via an internal 50k resistor.
> 
> This requires DAT3 to be pulled down to hold the signal in the "no
> card" state, using a 100k pull down setting.
> 
> Provide pinctrl settings for this for all USDHC controllers.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  arch/arm/boot/dts/imx6qdl.dtsi |  104 ++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 104 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
> index ccd55c2..199fdab 100644
> --- a/arch/arm/boot/dts/imx6qdl.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl.dtsi
> @@ -1138,6 +1138,32 @@
>  							MX6QDL_PAD_SD1_DAT3__SD1_DATA3 0x17059
>  						>;
>  					};
> +
> +					pinctrl_usdhc1_1_dat3cd: usdhc1grp-3 {
> +						fsl,pins = <
> +							MX6QDL_PAD_SD1_CMD__SD1_CMD    0x17059
> +							MX6QDL_PAD_SD1_CLK__SD1_CLK    0x10059
> +							MX6QDL_PAD_SD1_DAT0__SD1_DATA0 0x17059
> +							MX6QDL_PAD_SD1_DAT1__SD1_DATA1 0x17059
> +							MX6QDL_PAD_SD1_DAT2__SD1_DATA2 0x17059
> +							MX6QDL_PAD_SD1_DAT3__SD1_DATA3 0x13059
> +							MX6QDL_PAD_NANDF_D0__SD1_DATA4 0x17059
> +							MX6QDL_PAD_NANDF_D1__SD1_DATA5 0x17059
> +							MX6QDL_PAD_NANDF_D2__SD1_DATA6 0x17059
> +							MX6QDL_PAD_NANDF_D3__SD1_DATA7 0x17059
> +						>;
> +					};

I think we can redefine only pad DAT3 in pinctrl_usdhc1_1_dat3cd, and
overwrite the DAT3 configuration in pinctrl_usdhc1_1 to save the
redundant data of other pads, something like the following.

pinctrl_usdhc1_1_dat3cd: usdhc1grp-3 {
	fsl,pins = <
		MX6QDL_PAD_SD1_DAT3__SD1_DATA3 0x13059
	>;
};

&usdhc1 {
	pinctrl-names = "default";
	pinctrl-0 = <&pinctrl_usdhc1_1 &pinctrl_usdhc1_1_dat3cd>;
	...
	status = "okay";
};

Shawn

> +
> +					pinctrl_usdhc1_2_dat3cd: usdhc1grp-4 {
> +						fsl,pins = <
> +							MX6QDL_PAD_SD1_CMD__SD1_CMD    0x17059
> +							MX6QDL_PAD_SD1_CLK__SD1_CLK    0x10059
> +							MX6QDL_PAD_SD1_DAT0__SD1_DATA0 0x17059
> +							MX6QDL_PAD_SD1_DAT1__SD1_DATA1 0x17059
> +							MX6QDL_PAD_SD1_DAT2__SD1_DATA2 0x17059
> +							MX6QDL_PAD_SD1_DAT3__SD1_DATA3 0x13059
> +						>;
> +					};
>  				};
>  
>  				usdhc2 {
> @@ -1166,6 +1192,32 @@
>  							MX6QDL_PAD_SD2_DAT3__SD2_DATA3 0x17059
>  						>;
>  					};
> +
> +					pinctrl_usdhc2_1_dat3cd: usdhc2grp-3 {
> +						fsl,pins = <
> +							MX6QDL_PAD_SD2_CMD__SD2_CMD    0x17059
> +							MX6QDL_PAD_SD2_CLK__SD2_CLK    0x10059
> +							MX6QDL_PAD_SD2_DAT0__SD2_DATA0 0x17059
> +							MX6QDL_PAD_SD2_DAT1__SD2_DATA1 0x17059
> +							MX6QDL_PAD_SD2_DAT2__SD2_DATA2 0x17059
> +							MX6QDL_PAD_SD2_DAT3__SD2_DATA3 0x13059
> +							MX6QDL_PAD_NANDF_D4__SD2_DATA4 0x17059
> +							MX6QDL_PAD_NANDF_D5__SD2_DATA5 0x17059
> +							MX6QDL_PAD_NANDF_D6__SD2_DATA6 0x17059
> +							MX6QDL_PAD_NANDF_D7__SD2_DATA7 0x17059
> +						>;
> +					};
> +
> +					pinctrl_usdhc2_2_dat3cd: usdhc2grp-4 {
> +						fsl,pins = <
> +							MX6QDL_PAD_SD2_CMD__SD2_CMD    0x17059
> +							MX6QDL_PAD_SD2_CLK__SD2_CLK    0x10059
> +							MX6QDL_PAD_SD2_DAT0__SD2_DATA0 0x17059
> +							MX6QDL_PAD_SD2_DAT1__SD2_DATA1 0x17059
> +							MX6QDL_PAD_SD2_DAT2__SD2_DATA2 0x17059
> +							MX6QDL_PAD_SD2_DAT3__SD2_DATA3 0x13059
> +						>;
> +					};
>  				};
>  
>  				usdhc3 {
> @@ -1194,6 +1246,32 @@
>  							MX6QDL_PAD_SD3_DAT3__SD3_DATA3 0x17059
>  						>;
>  					};
> +
> +					pinctrl_usdhc3_1_dat3cd: usdhc3grp-3 {
> +						fsl,pins = <
> +							MX6QDL_PAD_SD3_CMD__SD3_CMD    0x17059
> +							MX6QDL_PAD_SD3_CLK__SD3_CLK    0x10059
> +							MX6QDL_PAD_SD3_DAT0__SD3_DATA0 0x17059
> +							MX6QDL_PAD_SD3_DAT1__SD3_DATA1 0x17059
> +							MX6QDL_PAD_SD3_DAT2__SD3_DATA2 0x17059
> +							MX6QDL_PAD_SD3_DAT3__SD3_DATA3 0x13059
> +							MX6QDL_PAD_SD3_DAT4__SD3_DATA4 0x17059
> +							MX6QDL_PAD_SD3_DAT5__SD3_DATA5 0x17059
> +							MX6QDL_PAD_SD3_DAT6__SD3_DATA6 0x17059
> +							MX6QDL_PAD_SD3_DAT7__SD3_DATA7 0x17059
> +						>;
> +					};
> +
> +					pinctrl_usdhc3_2_dat3cd: usdhc3grp-4 {
> +						fsl,pins = <
> +							MX6QDL_PAD_SD3_CMD__SD3_CMD    0x17059
> +							MX6QDL_PAD_SD3_CLK__SD3_CLK    0x10059
> +							MX6QDL_PAD_SD3_DAT0__SD3_DATA0 0x17059
> +							MX6QDL_PAD_SD3_DAT1__SD3_DATA1 0x17059
> +							MX6QDL_PAD_SD3_DAT2__SD3_DATA2 0x17059
> +							MX6QDL_PAD_SD3_DAT3__SD3_DATA3 0x13059
> +						>;
> +					};
>  				};
>  
>  				usdhc4 {
> @@ -1222,6 +1300,32 @@
>  							MX6QDL_PAD_SD4_DAT3__SD4_DATA3 0x17059
>  						>;
>  					};
> +
> +					pinctrl_usdhc4_1_dat3cd: usdhc4grp-3 {
> +						fsl,pins = <
> +							MX6QDL_PAD_SD4_CMD__SD4_CMD    0x17059
> +							MX6QDL_PAD_SD4_CLK__SD4_CLK    0x10059
> +							MX6QDL_PAD_SD4_DAT0__SD4_DATA0 0x17059
> +							MX6QDL_PAD_SD4_DAT1__SD4_DATA1 0x17059
> +							MX6QDL_PAD_SD4_DAT2__SD4_DATA2 0x17059
> +							MX6QDL_PAD_SD4_DAT3__SD4_DATA3 0x13059
> +							MX6QDL_PAD_SD4_DAT4__SD4_DATA4 0x17059
> +							MX6QDL_PAD_SD4_DAT5__SD4_DATA5 0x17059
> +							MX6QDL_PAD_SD4_DAT6__SD4_DATA6 0x17059
> +							MX6QDL_PAD_SD4_DAT7__SD4_DATA7 0x17059
> +						>;
> +					};
> +
> +					pinctrl_usdhc4_2_dat3cd: usdhc4grp-4 {
> +						fsl,pins = <
> +							MX6QDL_PAD_SD4_CMD__SD4_CMD    0x17059
> +							MX6QDL_PAD_SD4_CLK__SD4_CLK    0x10059
> +							MX6QDL_PAD_SD4_DAT0__SD4_DATA0 0x17059
> +							MX6QDL_PAD_SD4_DAT1__SD4_DATA1 0x17059
> +							MX6QDL_PAD_SD4_DAT2__SD4_DATA2 0x17059
> +							MX6QDL_PAD_SD4_DAT3__SD4_DATA3 0x13059
> +						>;
> +					};
>  				};
>  
>  				weim {
> -- 
> 1.7.4.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
