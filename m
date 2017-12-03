From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Sun, 3 Dec 2017 15:15:34 +0100
Subject: [PATCH v5.1 1/2] ARM64: dts: meson-gx: use stable UART bindings
 with correct gate clock
In-Reply-To: <1498056132-18508-2-git-send-email-narmstrong@baylibre.com>
References: <1498056132-18508-1-git-send-email-narmstrong@baylibre.com>
 <1498056132-18508-2-git-send-email-narmstrong@baylibre.com>
Message-ID: <4e0d1db1-6382-a4b7-d112-3e45e0c1af2d@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Am 21.06.2017 um 16:42 schrieb Neil Armstrong:
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
> index 17d3efd..ea53cc2 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
> @@ -682,6 +682,31 @@
>  	clocks = <&clkc CLKID_SPI>;
>  };
>  
> +&uart_A {
> +	clocks = <&xtal>, <&clkc CLKID_UART0>, <&xtal>;
> +	clock-names = "xtal", "pclk", "baud";
> +};
> +
> +&uart_AO {
> +	clocks = <&xtal>, <&clkc CLKID_CLK81>, <&xtal>;
> +	clock-names = "xtal", "pclk", "baud";
> +};
> +
> +&uart_AO_B {
> +	clocks = <&xtal>, <&clkc CLKID_CLK81>, <&xtal>;
> +	clock-names = "xtal", "pclk", "baud";
> +};
> +
> +&uart_B {
> +	clocks = <&xtal>, <&clkc CLKID_UART1>, <&xtal>;
> +	clock-names = "xtal", "core", "baud";

Looking at the meson_uart driver, it only looks for a "pclk" clock,
never for "core", and the only unnamed clock used should be the first.

There is no bindings documentation for "core", so I assume this was an
oversight and should be "pclk" everywhere?

> +};
> +
> +&uart_C {
> +	clocks = <&xtal>, <&clkc CLKID_UART2>, <&xtal>;
> +	clock-names = "xtal", "core", "baud";
> +};

The issue I'm facing is that uart_C on NanoPi K2 is not working in
4.14.1. To my surprise it appears to be probing okay though.

Sadly just overwriting the clock-names property via overlay does not fix
my issue. Any ideas?

> +
>  &vpu {
>  	compatible = "amlogic,meson-gxbb-vpu", "amlogic,meson-gx-vpu";
>  };
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
> index 8d4f316..9e67444 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
> @@ -623,6 +623,31 @@
>  	clocks = <&clkc CLKID_SPI>;
>  };
>  
> +&uart_A {
> +	clocks = <&xtal>, <&clkc CLKID_UART0>, <&xtal>;
> +	clock-names = "xtal", "core", "baud";

Same issue spotted here and below.

> +};
> +
> +&uart_AO {
> +	clocks = <&xtal>, <&clkc CLKID_CLK81>, <&xtal>;
> +	clock-names = "xtal", "pclk", "baud";
> +};
> +
> +&uart_AO_B {
> +	clocks = <&xtal>, <&clkc CLKID_CLK81>, <&xtal>;
> +	clock-names = "xtal", "pclk", "baud";
> +};
> +
> +&uart_B {
> +	clocks = <&xtal>, <&clkc CLKID_UART1>, <&xtal>;
> +	clock-names = "xtal", "core", "baud";
> +};
> +
> +&uart_C {
> +	clocks = <&xtal>, <&clkc CLKID_UART2>, <&xtal>;
> +	clock-names = "xtal", "core", "baud";
> +};
> +
>  &vpu {
>  	compatible = "amlogic,meson-gxl-vpu", "amlogic,meson-gx-vpu";
>  };

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
