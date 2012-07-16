From: michael@walle.cc (Michael Walle)
Date: Mon, 16 Jul 2012 23:04:51 +0200
Subject: [PATCH] ARM: kirkwood: Add LS-XHL and LS-CHLv2 support
In-Reply-To: <1342472144-27703-1-git-send-email-michael@walle.cc>
References: <1342472144-27703-1-git-send-email-michael@walle.cc>
Message-ID: <201207162304.51598.michael@walle.cc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Add support for Buffalo Linkstation LS-XHL and LS-CHLv2 using the device
> tree where possible.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
> 
> This patch is based on Andrew Lunn's kirkwood devicetree branch at:
>   git://github.com/lunn/linux.git v3.5-rc7-qnap-dt
> 
>  arch/arm/boot/dts/kirkwood-lschlv2.dts |   20 +++++
>  arch/arm/boot/dts/kirkwood-lsxhl.dts   |   20 +++++
>  arch/arm/boot/dts/kirkwood-lsxl.dtsi   |   95 ++++++++++++++++++++++
>  arch/arm/mach-kirkwood/Kconfig         |    8 ++
>  arch/arm/mach-kirkwood/Makefile        |    1 +
>  arch/arm/mach-kirkwood/board-dt.c      |    4 +
>  arch/arm/mach-kirkwood/board-lsxl.c    |  137
> ++++++++++++++++++++++++++++++++ arch/arm/mach-kirkwood/common.h        | 
>   6 ++
>  8 files changed, 291 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/boot/dts/kirkwood-lschlv2.dts
>  create mode 100644 arch/arm/boot/dts/kirkwood-lsxhl.dts
>  create mode 100644 arch/arm/boot/dts/kirkwood-lsxl.dtsi
>  create mode 100644 arch/arm/mach-kirkwood/board-lsxl.c
> 
> diff --git a/arch/arm/boot/dts/kirkwood-lschlv2.dts
> b/arch/arm/boot/dts/kirkwood-lschlv2.dts new file mode 100644
> index 0000000..37649b5
> --- /dev/null
> +++ b/arch/arm/boot/dts/kirkwood-lschlv2.dts
> @@ -0,0 +1,20 @@
> +/dts-v1/;
> +
> +/include/ "kirkwood-lsxl.dtsi"
> +
> +/ {
> +	model = "Buffalo Linkstation LS-CHLv2";
> +	compatible = "buffalo,lschlv2", "buffalo,lsxl", 
"mrvl,kirkwood-88f6281",
> "mrvl,kirkwood"; +
> +	memory {
> +		device_type = "memory";
> +		reg = <0x00000000 0x4000000>;
> +	};
> +
> +	ocp at f1000000 {
> +		serial at 12000 {
> +			clock-frequency = <166666667>;
> +			status = "okay";
> +		};
> +	};
> +};
> diff --git a/arch/arm/boot/dts/kirkwood-lsxhl.dts
> b/arch/arm/boot/dts/kirkwood-lsxhl.dts new file mode 100644
> index 0000000..eb3c071
> --- /dev/null
> +++ b/arch/arm/boot/dts/kirkwood-lsxhl.dts
> @@ -0,0 +1,20 @@
> +/dts-v1/;
> +
> +/include/ "kirkwood-lsxl.dtsi"
> +
> +/ {
> +	model = "Buffalo Linkstation LS-XHL";
> +	compatible = "buffalo,lsxhl", "buffalo,lsxl", "mrvl,kirkwood-88f6281",
> "mrvl,kirkwood"; +
> +	memory {
> +		device_type = "memory";
> +		reg = <0x00000000 0x10000000>;
> +	};
> +
> +	ocp at f1000000 {
> +		serial at 12000 {
> +			clock-frequency = <200000000>;
> +			status = "okay";
> +		};
> +	};
> +};
> diff --git a/arch/arm/boot/dts/kirkwood-lsxl.dtsi
> b/arch/arm/boot/dts/kirkwood-lsxl.dtsi new file mode 100644
> index 0000000..5961d85
> --- /dev/null
> +++ b/arch/arm/boot/dts/kirkwood-lsxl.dtsi
> @@ -0,0 +1,95 @@
> +/include/ "kirkwood.dtsi"
> +
> +/ {
> +	chosen {
> +		bootargs = "console=ttyS0,115200n8 earlyprintk";
> +	};
> +
> +	ocp at f1000000 {
> +		sata at 80000 {
> +			status = "okay";
> +			nr-ports = <1>;
> +		};
> +
> +		spi at 10600 {
> +			status = "okay";
> +
> +			m25p40 at 0 {
> +				#address-cells = <1>;
> +				#size-cells = <1>;
> +				compatible = "m25p40";
> +				reg = <0>;
> +				spi-max-frequency = <25000000>;
> +				mode = <0>;
> +
> +				partition at 0 {
> +					reg = <0x0 0x60000>;
> +					label = "uboot";
> +					read-only;
> +				};
> +
> +				partition at 60000 {
> +					reg = <0x60000 0x10000>;
> +					label = "dtb";
> +					read-only;
> +				};
> +
> +				partition at 70000 {
> +					reg = <0x70000 0x10000>;
> +					label = "uboot_env";
> +				};
> +			};
> +		};
> +	};
> +
> +	gpio_keys {
> +		compatible = "gpio-keys";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		button at 1 {
> +			label = "Function Button";
> +			linux,code = <1>;
> +			gpios = <&gpio1 9 1>;
> +		};
> +		button at 2 {
> +			label = "Power-on Switch";
> +			linux,code = <2>;
> +			gpios = <&gpio1 10 1>;
> +		};
> +		button at 3 {
> +			label = "Power-auto Switch";
> +			linux,code = <3>;

sorry somehow this slipped through... i've already posted a new patch with 
some more meaningful event codes.

[..snip..]

-- 
Michael
