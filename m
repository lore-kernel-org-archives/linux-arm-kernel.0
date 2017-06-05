From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 5 Jun 2017 22:51:43 +0800
Subject: [PATCH] ARM: dts: imx6q-cm-fx6: add sdio wifi/bt nodes
In-Reply-To: <1a13681b84564bc18937eb54b8345957@rwthex-s1-b.rwth-ad.de>
References: <1a13681b84564bc18937eb54b8345957@rwthex-s1-b.rwth-ad.de>
Message-ID: <20170605145141.GJ4094@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 30, 2017 at 10:16:01PM +0200, christopher.spinrath at rwth-aachen.de wrote:
> From: Christopher Spinrath <christopher.spinrath@rwth-aachen.de>
> 
> The cm-fx6 module has an on-board AW-NH387 WiFi/BT module which is
> based on Marvell's SD8787 chip and is connected to the usdhc1
> controller.
> 
> Unfortunately, the chip gets unresponsive if the Bluetooth AMP
> (Alternate Mac/Phy) function gets probed but the loaded firmware
> doesn't support it. For instance, this is the case for the most
> recent firmware in linux-firmware (Version 14.66.35.p52).
> 
> Thus, just add the required nodes but leave the usdhc1 node disabled
> explicitly. Users who disabled the Bluetooth (AMP) support of their
> OS can then conveniently enable WiFi (or even plain Bluetooth) support
> with a simple device tree overlay/bootloader configuration.
> 
> Signed-off-by: Christopher Spinrath <christopher.spinrath@rwth-aachen.de>
> ---
> 
> Hi all,
> 
> some more information on the Bluetooth AMP dilemma: the vendor (CompuLab) just
> remove Bluetooth AMP support from the kernel. However, this is not an option
> here, since it would introduce a regression for its actual users.
> 
> Neither is degrading the firmware a good option: recent firmare (without AMP
> support) provides WiFi that is more stable (in particular, for access points).
> 
> I wrote a RFC to linux-bluetooth [1] two weeks ago about this problem and the
> only feedback I got was that Marvell has to provide information about how to
> detect whether the firmware supports AMP properly -- but this is unlikely given
> Marvell's information policy (in particular, since the sd8787 seems to be
> unsupported as of now).
> 
> IMHO this patch is currently the best option, since it allows users in a
> convenient way to enable WiFi support (e.g. no pinctrl handling in overlays),
> even when they are using distribution kernels/device trees. Furthermore, the
> hardware description is entirely accurate -- we have a driver/firmware problem
> here.

Hi Valentin, Igor,

Are you guys fine with the patch?

Shawn

> 
> Thanks,
> Christopher
> 
> [1] https://www.spinics.net/lists/linux-bluetooth/msg70493.html
> 
>  arch/arm/boot/dts/imx6q-cm-fx6.dts | 41 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6q-cm-fx6.dts b/arch/arm/boot/dts/imx6q-cm-fx6.dts
> index a8af382..fe6ab0a 100644
> --- a/arch/arm/boot/dts/imx6q-cm-fx6.dts
> +++ b/arch/arm/boot/dts/imx6q-cm-fx6.dts
> @@ -64,6 +64,14 @@
>  		};
>  	};
>  
> +	awnh387_pwrseq: pwrseq {
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_pwrseq>;
> +		compatible = "mmc-pwrseq-sd8787";
> +		powerdown-gpios = <&gpio7 12 GPIO_ACTIVE_HIGH>;
> +		reset-gpios = <&gpio6 16 GPIO_ACTIVE_HIGH>;
> +	};
> +
>  	reg_pcie_power_on_gpio: regulator-pcie-power-on-gpio {
>  		compatible = "regulator-fixed";
>  		regulator-name = "regulator-pcie-power-on-gpio";
> @@ -304,6 +312,13 @@
>  		>;
>  	};
>  
> +	pinctrl_pwrseq: pwrseqgrp {
> +		fsl,pins = <
> +			MX6QDL_PAD_GPIO_17__GPIO7_IO12		0x1b0b0
> +			MX6QDL_PAD_NANDF_CS3__GPIO6_IO16	0x1b0b0
> +		>;
> +	};
> +
>  	pinctrl_spdif: spdifgrp {
>  		fsl,pins = <
>  			MX6QDL_PAD_GPIO_16__SPDIF_IN  0x1b0b0
> @@ -330,6 +345,17 @@
>  			MX6QDL_PAD_EIM_D22__GPIO3_IO22	0x130b0
>  		>;
>  	};
> +
> +	pinctrl_usdhc1: usdhc1grp {
> +		fsl,pins = <
> +			MX6QDL_PAD_SD1_CMD__SD1_CMD	0x17071
> +			MX6QDL_PAD_SD1_CLK__SD1_CLK	0x10071
> +			MX6QDL_PAD_SD1_DAT0__SD1_DATA0	0x17071
> +			MX6QDL_PAD_SD1_DAT1__SD1_DATA1	0x17071
> +			MX6QDL_PAD_SD1_DAT2__SD1_DATA2	0x17071
> +			MX6QDL_PAD_SD1_DAT3__SD1_DATA3	0x17071
> +		>;
> +	};
>  };
>  
>  &pcie {
> @@ -382,3 +408,18 @@
>  	dr_mode = "otg";
>  	status = "okay";
>  };
> +
> +&usdhc1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_usdhc1>;
> +	mmc-pwrseq = <&awnh387_pwrseq>;
> +	non-removable;
> +	/*
> +	 * If the OS probes the Bluetooth AMP function advertised on this bus
> +	 * but the firmware in place does not support it, the WiFi/BT module
> +	 * gets unresponsive.
> +	 * Users who configured their OS properly can enable this node to gain
> +	 * WiFi and/or plain Bluetooth support.
> +	 */
> +	status = "disabled";
> +};
> -- 
> 2.10.2
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
