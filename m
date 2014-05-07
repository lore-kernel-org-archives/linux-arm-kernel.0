From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Wed, 07 May 2014 09:40:12 +0200
Subject: [PATCH] ARM: Kirkwood: DT versions of OpenRD boards
In-Reply-To: <1399416504-19140-1-git-send-email-andrew@lunn.ch>
References: <1399416504-19140-1-git-send-email-andrew@lunn.ch>
Message-ID: <5369E35C.2020006@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/07/2014 12:48 AM, Andrew Lunn wrote:
> Create DTS files to describe the Marvell OpenRD boards.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> Tested-by: Francois Lorrain <francois.lorrain@gmail.com>
> ---
[...]
> diff --git a/arch/arm/boot/dts/kirkwood-openrd-base.dts b/arch/arm/boot/dts/kirkwood-openrd-base.dts
> new file mode 100644
> index 000000000000..03cb87cd4bbe
> --- /dev/null
> +++ b/arch/arm/boot/dts/kirkwood-openrd-base.dts
> @@ -0,0 +1,42 @@
> +/*
> + * Marvell OpenRD Base Board descrition

s/descrition/description/

> + * Andrew Lunn <andrew@lunn.ch>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2.  This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + *
> + * This file contains the definitions that are specific to OpenRD
> + * base variant of the Marvell Kirkwood Development Board.
> + */
> +
> +/dts-v1/;
> +
> +#include "kirkwood-openrd.dtsi"
> +
> +/ {
> +	model = "OpenRD Base";
> +	compatible = "marvell,openrd-base", "marvell,openrd", "marvell,kirkwood-88f6281", "marvell,kirkwood";
> +
> +	ocp at f1000000 {
> +		serial at 12100 {
> +			status = "okay";

Andrew,

I see you used the "good template" this time ;) I again have some nits,
that either you can take care of or me in the cleanup patches. I guess
it depends on whatever goes in first. ;)

> +		};
> +	};
> +};
> +
> +&mdio {
> +	status = "okay";
> +
> +	ethphy0: ethernet-phy at 8 {
> +		reg = <8>;
> +	};
> +};
> +
> +&eth0 {
> +	status = "okay";
> +	ethernet0-port at 0 {
> +		phy-handle = <&ethphy0>;
> +	};
> +};
> diff --git a/arch/arm/boot/dts/kirkwood-openrd-client.dts b/arch/arm/boot/dts/kirkwood-openrd-client.dts
> new file mode 100644
> index 000000000000..6179542c860f
> --- /dev/null
> +++ b/arch/arm/boot/dts/kirkwood-openrd-client.dts
> @@ -0,0 +1,75 @@
> +/*
> + * Marvell OpenRD Client Board descrition

s/descrition/description/

> + * Andrew Lunn <andrew@lunn.ch>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2.  This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + *
> + * This file contains the definitions that are specific to OpenRD
> + * client variant of the Marvell Kirkwood Development Board.
> + */
> +
> +/dts-v1/;
> +
> +#include "kirkwood-openrd.dtsi"
> +
> +/ {
> +	model = "OpenRD Client";
> +	compatible = "marvell,openrd-client", "marvell,openrd", "marvell,kirkwood-88f6281", "marvell,kirkwood";
> +
> +	ocp at f1000000 {
> +		i2c at 11000 {
> +			status = "okay";
> +			clock-frequency = <400000>;
> +			pinctrl-0 = <&pmx_twsi0>;
> +			pinctrl-names = "default";

The default pinctrl should have been set by the SoC dtsi already.

> +			cs42l51: cs42l51 at 4a {
> +				compatible = "cirrus,cs42l51";
> +				reg = <0x4a>;
> +			};
> +		};
> +	};
> +
> +	sound {
> +		compatible = "simple-audio-card";
> +		simple-audio-card,format = "i2s";
> +		simple-audio-card,mclk-fs = <256>;
> +
> +		simple-audio-card,cpu {
> +			sound-dai = <&audio0>;
> +		};
> +
> +		simple-audio-card,codec {
> +			sound-dai = <&cs42l51>;
> +		};
> +	};
> +};
> +
> +&mdio {
> +	status = "okay";
> +
> +	ethphy0: ethernet-phy at 8 {
> +		reg = <8>;
> +	};
> +	ethphy1: ethernet-phy at 24 {
> +		reg = <24>;
> +	};
> +};
> +
> +&eth0 {
> +	status = "okay";
> +	ethernet0-port at 0 {
> +		phy-handle = <&ethphy0>;
> +	};
> +};
> +
> +&eth1 {
> +	status = "okay";
> +	ethernet1-port at 0 {
> +		phy-handle = <&ethphy1>;
> +	};
> +};
> +
> diff --git a/arch/arm/boot/dts/kirkwood-openrd-ultimate.dts b/arch/arm/boot/dts/kirkwood-openrd-ultimate.dts
> new file mode 100644
> index 000000000000..7a233d7f4701
> --- /dev/null
> +++ b/arch/arm/boot/dts/kirkwood-openrd-ultimate.dts
> @@ -0,0 +1,60 @@
> +/*
> + * Marvell OpenRD Ultimate Board descrition

s/descrition/description/

> + * Andrew Lunn <andrew@lunn.ch>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2.  This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + *
> + * This file contains the definitions that are specific to OpenRD
> + * ultimate variant of the Marvell Kirkwood Development Board.
> + */
> +
> +/dts-v1/;
> +
> +#include "kirkwood-openrd.dtsi"
> +
> +/ {
> +	model = "OpenRD Ultimate";
> +	compatible = "marvell,openrd-ultimate", "marvell,openrd", "marvell,kirkwood-88f6281", "marvell,kirkwood";
> +
> +	ocp at f1000000 {
> +		i2c at 11000 {
> +			status = "okay";
> +			clock-frequency = <400000>;
> +			pinctrl-0 = <&pmx_twsi0>;
> +			pinctrl-names = "default";

ditto.

> +			cs42l51: cs42l51 at 4a {
> +				compatible = "cirrus,cs42l51";
> +				reg = <0x4a>;
> +			};
> +		};
> +	};
> +};
> +
> +&mdio {
> +	status = "okay";
> +
> +	ethphy0: ethernet-phy at 0 {
> +		reg = <0>;
> +	};
> +	ethphy1: ethernet-phy at 1 {
> +		reg = <1>;
> +	};
> +};
> +
> +&eth0 {
> +	status = "okay";
> +	ethernet0-port at 0 {
> +		phy-handle = <&ethphy0>;
> +	};
> +};
> +
> +&eth1 {
> +	status = "okay";
> +	ethernet1-port at 0 {
> +		phy-handle = <&ethphy1>;
> +	};
> +};
> diff --git a/arch/arm/boot/dts/kirkwood-openrd.dtsi b/arch/arm/boot/dts/kirkwood-openrd.dtsi
> new file mode 100644
> index 000000000000..30e0f38a1a37
> --- /dev/null
> +++ b/arch/arm/boot/dts/kirkwood-openrd.dtsi
> @@ -0,0 +1,91 @@
> +/*
> + * Marvell OpenRD (Base|Client|Ultimate) Board descrition

s/descrition/description/

> + *
> + * Andrew Lunn <andrew@lunn.ch>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2.  This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + *
> + * This file contains the definitions that are common between the three
> + * variants of the Marvell Kirkwood Development Board.
> + */
> +
> +#include "kirkwood.dtsi"
> +#include "kirkwood-6281.dtsi"
> +
> +/ {
> +	memory {
> +		device_type = "memory";
> +		reg = <0x00000000 0x20000000>;
> +	};
> +
> +	chosen {
> +		bootargs = "console=ttyS0,115200n8";
> +		stdout-path = &uart0;
> +	};
> +
> +	mbus {
> +		pcie-controller {
> +			status = "okay";
> +
> +			pcie at 1,0 {
> +				status = "okay";
> +			};
> +		};
> +	};
> +
> +	ocp at f1000000 {
> +		pinctrl: pin-controller at 10000 {
> +			pinctrl-0 = <&pmx_select28 &pmx_sdio_cd &pmx_select34>;
> +			pinctrl-names = "default";
> +
> +			pmx_select28: pmx-select-uart-sd {
> +				marvell,pins = "mpp28";
> +				marvell,function = "gpio";
> +			};
> +			pmx_sdio_cd: pmx-sdio-cd {
> +				marvell,pins = "mpp29";
> +				marvell,function = "gpio";
> +			};
> +			pmx_select34: pmx-select-rs232-rs484 {
> +				marvell,pins = "mpp34";
> +				marvell,function = "gpio";
> +			};
> +		};
> +		serial at 12000 {
> +			status = "okay";
> +
> +		};
> +		sata at 80000 {
> +			status = "okay";
> +			nr-ports = <2>;
> +		};
> +		mvsdio at 90000 {
> +			status = "okay";
> +			cd-gpios = <&gpio0 29 9>;
> +			status = "disabled";

Any reason not to enable sdio?

Besides the nits above,

Acked-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

> +		};
> +	};
> +};
> +
> +&nand {
> +	status = "okay";
> +	pinctrl-0 = <&pmx_nand>;
> +	pinctrl-names = "default";
> +
> +	partition at 0 {
> +		label = "u-boot";
> +		reg = <0x0000000 0x100000>;
> +	};
> +
> +	partition at 100000 {
> +		label = "uImage";
> +		reg = <0x0100000 0x400000>;
> +	};
> +
> +	partition at 600000 {
> +		label = "root";
> +		reg = <0x0600000 0x1FA00000>;
> +	};
> +};
> 
