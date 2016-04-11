From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 11 Apr 2016 22:31:50 +0800
Subject: [PATCH v4] ARM: dts: imx: add Boundary Devices Nitrogen6_SoloX
 board
In-Reply-To: <1460037168-23292-1-git-send-email-gary.bisson@boundarydevices.com>
References: <1459614351-16731-7-git-send-email-gary.bisson@boundarydevices.com>
 <1460037168-23292-1-git-send-email-gary.bisson@boundarydevices.com>
Message-ID: <20160411143150.GA15818@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 07, 2016 at 03:52:48PM +0200, Gary Bisson wrote:

<snip>

> +&ecspi1 {
> +	fsl,spi-num-chipselects = <1>;
> +	cs-gpios = <&gpio2 16 GPIO_ACTIVE_LOW>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_ecspi1>;
> +	status = "okay";
> +
> +	flash: m25p80 at 0 {
> +		compatible = "microchip,sst25vf016b";
> +		spi-max-frequency = <20000000>;
> +		reg = <0>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;

Have a new line between properties and sub-nodes.

> +		partition at 0 {
> +			label = "U-Boot";
> +			reg = <0x0 0xC0000>;

Please use lowercase for all hex values in device tree source.

> +			read-only;
> +		};

Have a new line between nodes.

> +		partition at C0000 {
> +			label = "env";
> +			reg = <0xC0000 0x2000>;
> +			read-only;
> +		};
> +		partition at C2000 {
> +			label = "Kernel";
> +			reg = <0xC2000 0x11e000>;
> +		};
> +		partition at 1E0000 {
> +			label = "M4";
> +			reg = <0x1E0000 0x20000>;
> +		};
> +	};
> +};

<snip>

> +&ssi1 {
> +	fsl,mode = "i2s-master";

Take a look at Documentation/devicetree/bindings/sound/fsl,ssi.txt.
fsl,mode is only for AC97 interface now.

> +	status = "okay";
> +};

<snip>

> +&usdhc2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_usdhc2>;
> +	bus-width = <4>;
> +	cd-gpios = <&gpio2 12 GPIO_ACTIVE_LOW>;
> +	keep-power-in-suspend;
> +	enable-sdio-wakeup;

Use wakeup-source instead, as enable-sdio-wakeup is deprecated.  See
details in bindings/power/wakeup-source.txt.

> +	status = "okay";
> +};
> +
> +&usdhc3 {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_usdhc3>;
> +	bus-width = <4>;
> +	non-removable;
> +	keep-power-in-suspend;
> +	vmmc-supply = <&reg_wlan>;
> +	cap-power-off-card;
> +	cap-sdio-irq;
> +	vqmmc-1-8-v;

Your change log says this non-existent property is removed.

> +	status = "okay";
> +
> +	brcmf: bcrmf at 1 {
> +		reg = <1>;
> +		compatible = "brcm,bcm4329-fmac";
> +		interrupt-parent = <&gpio7>;
> +		interrupts = <7 IRQ_TYPE_LEVEL_LOW>;
> +	};

Have a new line between nodes.

Shawn

> +	wlcore: wlcore at 2 {
> +		compatible = "ti,wl1271";
> +		reg = <2>;
> +		interrupt-parent = <&gpio7>;
> +		interrupts = <7 IRQ_TYPE_LEVEL_LOW>;
> +		ref-clock-frequency = <38400000>;
> +	};
> +};
