From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Tue, 16 Aug 2016 16:27:37 +0200
Subject: [PATCH 2/3] arm64: dts: Add ZTE ZX296718 SoC dts and Makefile
In-Reply-To: <1471335734-26893-2-git-send-email-jun.nie@linaro.org>
References: <1471335734-26893-1-git-send-email-jun.nie@linaro.org>
 <1471335734-26893-2-git-send-email-jun.nie@linaro.org>
Message-ID: <4e041508-9d1c-a4c5-5f24-2fe8da87e729@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 16/08/16 10:22, Jun Nie wrote:
> Add device tree support for ZX296718 SoC and evaluation board based on it.
> Also document new values.
>
> Signed-off-by: Jun Nie <jun.nie@linaro.org>
> ---
>  Documentation/devicetree/bindings/arm/zte.txt |  24 +++
>  arch/arm64/boot/dts/Makefile                  |   1 +
>  arch/arm64/boot/dts/zte/Makefile              |   5 +
>  arch/arm64/boot/dts/zte/zx296718.dts          |  21 +++
>  arch/arm64/boot/dts/zte/zx296718.dtsi         | 256 ++++++++++++++++++++++++++
>  5 files changed, 307 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/zte/Makefile
>  create mode 100644 arch/arm64/boot/dts/zte/zx296718.dts
>  create mode 100644 arch/arm64/boot/dts/zte/zx296718.dtsi
>
> diff --git a/Documentation/devicetree/bindings/arm/zte.txt b/Documentation/devicetree/bindings/arm/zte.txt
> index 3ff5c9e..b80790a 100644
> --- a/Documentation/devicetree/bindings/arm/zte.txt
> +++ b/Documentation/devicetree/bindings/arm/zte.txt
> @@ -13,3 +13,27 @@ Low power management required properties:
>
>  Bus matrix required properties:
>        - compatible = "zte,zx-bus-matrix"
> +
> +
> +---------------------------------------
> +-  ZX296718 SoC:
> +    Required root node properties:
> +      - compatible = "zte,zx296718"
> +
> +ZX296718 EVB board:
> +      - "zte,zx296718-evb"
> +
> +System management required properties:
> +      - compatible = "zte,zx296718-aon-sysctrl"
> +      - compatible = "zte,zx296718-sysctrl"
> +
> +Example:
> +aon_sysctrl: aon-sysctrl at 116000 {
> +	compatible = "zte,zx296718-aon-sysctrl", "syscon";
> +	reg = <0x116000 0x1000>;
> +};
> +
> +sysctrl: sysctrl at 0x1463000 {
> +	compatible = "zte,zx296718-sysctrl", "syscon";
> +	reg = <0x1463000 0x1000>;
> +};
> diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
> index 6e199c9..6684f97 100644
> --- a/arch/arm64/boot/dts/Makefile
> +++ b/arch/arm64/boot/dts/Makefile
> @@ -19,6 +19,7 @@ dts-dirs += socionext
>  dts-dirs += sprd
>  dts-dirs += xilinx
>  dts-dirs += lg
> +dts-dirs += zte
>
>  subdir-y	:= $(dts-dirs)
>
> diff --git a/arch/arm64/boot/dts/zte/Makefile b/arch/arm64/boot/dts/zte/Makefile
> new file mode 100644
> index 0000000..a99640b
> --- /dev/null
> +++ b/arch/arm64/boot/dts/zte/Makefile
> @@ -0,0 +1,5 @@
> +dtb-$(CONFIG_ARCH_ZX) += zx296718.dtb
> +
> +always		:= $(dtb-y)
> +subdir-y	:= $(dts-dirs)
> +clean-files	:= *.dtb
> diff --git a/arch/arm64/boot/dts/zte/zx296718.dts b/arch/arm64/boot/dts/zte/zx296718.dts
> new file mode 100644
> index 0000000..046cee3
> --- /dev/null
> +++ b/arch/arm64/boot/dts/zte/zx296718.dts
> @@ -0,0 +1,21 @@
> +/*
> + * ZTE Ltd. zx296718 Plaform
> + *
> + */
> +/dts-v1/;
> +#include "zx296718.dtsi"
> +
> +/ {
> +	model = "ZTE zx296718 evaluation board";
> +	compatible = "zte,zx296718-evb", "zte,zx296718";
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	memory at 40000000 {
> +		device_type = "memory";
> +		reg = <0x40000000 0x40000000>;
> +	};
> +
> +};
> diff --git a/arch/arm64/boot/dts/zte/zx296718.dtsi b/arch/arm64/boot/dts/zte/zx296718.dtsi
> new file mode 100644
> index 0000000..666596f
> --- /dev/null
> +++ b/arch/arm64/boot/dts/zte/zx296718.dtsi
> @@ -0,0 +1,256 @@
> +/*
> + * DTS File for ZTE ZX296718 Plaform
> + *
> + * Copyright (c) 2016 ZTE Semiconductor Co., Ltd.
> + */
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/gpio/gpio.h>
> +
> +/ {
> +	compatible = "zte,zx296718";
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +
> +	aliases {
> +		serial0 = &uart0;
> +	};
> +
> +	cpus {
> +		#address-cells = <2>;
> +		#size-cells = <0>;
> +
> +		cpu-map {
> +			cluster0 {
> +				core0 {
> +					cpu = <&cpu0>;
> +				};
> +				core1 {
> +					cpu = <&cpu1>;
> +				};
> +				core2 {
> +					cpu = <&cpu2>;
> +				};
> +				core3 {
> +					cpu = <&cpu3>;
> +				};
> +			};
> +		};
> +		cpu0: cpu at 0 {

Nit: Missing newline here.
