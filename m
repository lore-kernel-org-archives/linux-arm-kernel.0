From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 23 May 2017 16:20:55 +0200
Subject: [PATCH] arm64: dts: marvell: mcbin: add sdhci
In-Reply-To: <E1dAcn4-0004z2-Fl@rmk-PC.armlinux.org.uk> (Russell King's
 message of "Tue, 16 May 2017 14:45:30 +0100")
References: <E1dAcn4-0004z2-Fl@rmk-PC.armlinux.org.uk>
Message-ID: <874lwby7qw.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,
 
 On mar., mai 16 2017, Russell King <rmk+kernel@armlinux.org.uk> wrote:

> Add sdhci support for MACCHIATOBin boards.  This uses the AP806 SDHCI
> for eMMC and CP110 master for the SD card slot.


Applied on mvebu/dt64

Thanks,

Gregory

>
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> ---
>
> This version labels up the uSD connector, adds the vqmmc regulator for
> the uSD (the regulator itself already present in the DT), and supports
> the card detect signal.
>
> For eMMC, this version adds the vqmmc regulator, which again is already
> present in the DT, marks it as not supporting SD or SDIO, and also
> includes "slow mode" since testing with previous versions of the driver
> have shown that selecting faster speeds results in errors.
>
>  arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts |   23 ++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
> index cc167e05941a..60111ed3234a 100644
> --- a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
> @@ -95,6 +95,21 @@
>  	status = "okay";
>  };
>  
> +&ap_sdhci0 {
> +	bus-width = <8>;
> +	/*
> +	 * Not stable in HS modes - phy needs "more calibration", so add
> +	 * the "slow-mode" and disable SDR104, SDR50 and DDR50 modes.
> +	 */
> +	marvell,xenon-phy-slow-mode;
> +	no-1-8-v;
> +	no-sd;
> +	no-sdio;
> +	non-removable;
> +	status = "okay";
> +	vqmmc-supply = <&v_vddo_h>;
> +};
> +
>  &cpm_i2c0 {
>  	clock-frequency = <100000>;
>  	status = "okay";
> @@ -105,6 +120,14 @@
>  	status = "okay";
>  };
>  
> +&cpm_sdhci0 {
> +	/* U6 */
> +	broken-cd;
> +	bus-width = <4>;
> +	status = "okay";
> +	vqmmc-supply = <&v_3_3>;
> +};
> +
>  &cpm_usb3_0 {
>  	/* J38? - USB2.0 only */
>  	status = "okay";
> -- 
> 2.7.4
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
