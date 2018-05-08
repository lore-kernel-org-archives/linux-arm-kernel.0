From: robin.murphy@arm.com (Robin Murphy)
Date: Tue, 8 May 2018 11:37:38 +0100
Subject: [PATCH 7/7] ARM: dts: Fix DTC warnings
In-Reply-To: <20180506134352.2637-8-linus.walleij@linaro.org>
References: <20180506134352.2637-1-linus.walleij@linaro.org>
 <20180506134352.2637-8-linus.walleij@linaro.org>
Message-ID: <f1aa27c4-8a59-fc32-fdf8-218d9d2d6e97@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/05/18 14:43, Linus Walleij wrote:
> The DTC was warning a lot about unit names etc, I think I fixed
> them all. One warning remains:
> 
> arch/arm/boot/dts/gemini-rut1xx.dtb: Warning (unit_address_vs_reg):
>   /memory: node has a reg or ranges property, but no unit name
> 
> This comes up all the time even though memory is stated as
> memory at 0 for all boards, I guess this is a bug in the DTC
> syntax checker, like it cannot really differentiate between
> @0 and no unit name at all for the memory node.

That might be because it's pulling in skeleton.dtsi, since I think 
"memory at 0" and "memory" are treated as distinct nodes, such that the 
former from the board DTS no longer overrides the latter from skeleton 
and you end up with both.

Robin.

> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>   arch/arm/boot/dts/gemini-dlink-dir-685.dts |  5 ++---
>   arch/arm/boot/dts/gemini-dlink-dns-313.dts |  5 ++---
>   arch/arm/boot/dts/gemini-nas4220b.dts      | 12 +++++-------
>   arch/arm/boot/dts/gemini-rut1xx.dts        | 10 ++++------
>   arch/arm/boot/dts/gemini-sq201.dts         | 10 ++++------
>   arch/arm/boot/dts/gemini-wbd111.dts        | 15 +++++++--------
>   arch/arm/boot/dts/gemini-wbd222.dts        | 14 ++++++--------
>   7 files changed, 30 insertions(+), 41 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/gemini-dlink-dir-685.dts b/arch/arm/boot/dts/gemini-dlink-dir-685.dts
> index 89ce0d1916e3..fb5c954ab95a 100644
> --- a/arch/arm/boot/dts/gemini-dlink-dir-685.dts
> +++ b/arch/arm/boot/dts/gemini-dlink-dir-685.dts
> @@ -13,7 +13,7 @@
>   	#address-cells = <1>;
>   	#size-cells = <1>;
>   
> -	memory {
> +	memory at 0 {
>   		/* 128 MB SDRAM in 2 x Hynix HY5DU121622DTP-D43 */
>   		device_type = "memory";
>   		reg = <0x00000000 0x8000000>;
> @@ -26,8 +26,7 @@
>   
>   	gpio_keys {
>   		compatible = "gpio-keys";
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> +
>   		button-esc {
>   			debounce-interval = <50>;
>   			wakeup-source;
> diff --git a/arch/arm/boot/dts/gemini-dlink-dns-313.dts b/arch/arm/boot/dts/gemini-dlink-dns-313.dts
> index da78a0aa389a..d1329322b968 100644
> --- a/arch/arm/boot/dts/gemini-dlink-dns-313.dts
> +++ b/arch/arm/boot/dts/gemini-dlink-dns-313.dts
> @@ -15,7 +15,7 @@
>   	#address-cells = <1>;
>   	#size-cells = <1>;
>   
> -	memory {
> +	memory at 0 {
>   		/* 64 MB SDRAM in a Nanya NT5DS32M16BS-6K package */
>   		device_type = "memory";
>   		reg = <0x00000000 0x4000000>;
> @@ -32,8 +32,7 @@
>   
>   	gpio_keys {
>   		compatible = "gpio-keys";
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> +
>   		button-esc {
>   			debounce-interval = <50>;
>   			wakeup-source;
> diff --git a/arch/arm/boot/dts/gemini-nas4220b.dts b/arch/arm/boot/dts/gemini-nas4220b.dts
> index 9f78803b2456..963ea890c87f 100644
> --- a/arch/arm/boot/dts/gemini-nas4220b.dts
> +++ b/arch/arm/boot/dts/gemini-nas4220b.dts
> @@ -14,7 +14,7 @@
>   	#address-cells = <1>;
>   	#size-cells = <1>;
>   
> -	memory { /* 128 MB */
> +	memory at 0 { /* 128 MB */
>   		device_type = "memory";
>   		reg = <0x00000000 0x8000000>;
>   	};
> @@ -26,10 +26,8 @@
>   
>   	gpio_keys {
>   		compatible = "gpio-keys";
> -		#address-cells = <1>;
> -		#size-cells = <0>;
>   
> -		button at 29 {
> +		button-setup {
>   			debounce-interval = <50>;
>   			wakeup-source;
>   			linux,code = <KEY_SETUP>;
> @@ -37,7 +35,7 @@
>   			/* Conflict with TVC */
>   			gpios = <&gpio1 29 GPIO_ACTIVE_LOW>;
>   		};
> -		button at 31 {
> +		button-restart {
>   			debounce-interval = <50>;
>   			wakeup-source;
>   			linux,code = <KEY_RESTART>;
> @@ -49,13 +47,13 @@
>   
>   	leds {
>   		compatible = "gpio-leds";
> -		led at 28 {
> +		led-orange-hdd {
>   			label = "nas4220b:orange:hdd";
>   			/* Conflict with TVC */
>   			gpios = <&gpio1 28 GPIO_ACTIVE_HIGH>;
>   			default-state = "on";
>   		};
> -		led at 30 {
> +		led-green-os {
>   			label = "nas4220b:green:os";
>   			/* Conflict with TVC */
>   			gpios = <&gpio1 30 GPIO_ACTIVE_HIGH>;
> diff --git a/arch/arm/boot/dts/gemini-rut1xx.dts b/arch/arm/boot/dts/gemini-rut1xx.dts
> index a2f14ee37599..eb4f0bf074da 100644
> --- a/arch/arm/boot/dts/gemini-rut1xx.dts
> +++ b/arch/arm/boot/dts/gemini-rut1xx.dts
> @@ -14,7 +14,7 @@
>   	#address-cells = <1>;
>   	#size-cells = <1>;
>   
> -	memory { /* 128 MB */
> +	memory at 0 { /* 128 MB */
>   		device_type = "memory";
>   		reg = <0x00000000 0x8000000>;
>   	};
> @@ -26,10 +26,8 @@
>   
>   	gpio_keys {
>   		compatible = "gpio-keys";
> -		#address-cells = <1>;
> -		#size-cells = <0>;
>   
> -		button at 28 {
> +		button-setup {
>   			debounce-interval = <50>;
>   			wakeup-source;
>   			linux,code = <KEY_SETUP>;
> @@ -41,14 +39,14 @@
>   
>   	leds {
>   		compatible = "gpio-leds";
> -		led at 7 {
> +		led-gsm {
>   			/* FIXME: add the LED color */
>   			label = "rut1xx::gsm";
>   			/* Conflict with ICE */
>   			gpios = <&gpio0 7 GPIO_ACTIVE_HIGH>;
>   			default-state = "on";
>   		};
> -		led at 31 {
> +		led-power {
>   			/* FIXME: add the LED color */
>   			label = "rut1xx::power";
>   			/* Conflict with NAND CE0 */
> diff --git a/arch/arm/boot/dts/gemini-sq201.dts b/arch/arm/boot/dts/gemini-sq201.dts
> index 229c0267617a..e5cf9d1a98cd 100644
> --- a/arch/arm/boot/dts/gemini-sq201.dts
> +++ b/arch/arm/boot/dts/gemini-sq201.dts
> @@ -14,7 +14,7 @@
>   	#address-cells = <1>;
>   	#size-cells = <1>;
>   
> -	memory { /* 128 MB */
> +	memory at 0 { /* 128 MB */
>   		device_type = "memory";
>   		reg = <0x00000000 0x8000000>;
>   	};
> @@ -26,10 +26,8 @@
>   
>   	gpio_keys {
>   		compatible = "gpio-keys";
> -		#address-cells = <1>;
> -		#size-cells = <0>;
>   
> -		button at 18 {
> +		button-setup {
>   			debounce-interval = <50>;
>   			wakeup-source;
>   			linux,code = <KEY_SETUP>;
> @@ -41,14 +39,14 @@
>   
>   	leds {
>   		compatible = "gpio-leds";
> -		led at 20 {
> +		led-green-info {
>   			label = "sq201:green:info";
>   			/* Conflict with parallel flash */
>   			gpios = <&gpio0 20 GPIO_ACTIVE_HIGH>;
>   			default-state = "on";
>   			linux,default-trigger = "heartbeat";
>   		};
> -		led at 31 {
> +		led-green-usb {
>   			label = "sq201:green:usb";
>   			/* Conflict with parallel and NAND flash */
>   			gpios = <&gpio0 31 GPIO_ACTIVE_HIGH>;
> diff --git a/arch/arm/boot/dts/gemini-wbd111.dts b/arch/arm/boot/dts/gemini-wbd111.dts
> index b31a9189083f..29af86cd10f7 100644
> --- a/arch/arm/boot/dts/gemini-wbd111.dts
> +++ b/arch/arm/boot/dts/gemini-wbd111.dts
> @@ -14,7 +14,8 @@
>   	#address-cells = <1>;
>   	#size-cells = <1>;
>   
> -	memory { /* 128 MB */
> +	memory at 0 {
> +		/* 128 MB */
>   		device_type = "memory";
>   		reg = <0x00000000 0x8000000>;
>   	};
> @@ -26,10 +27,8 @@
>   
>   	gpio_keys {
>   		compatible = "gpio-keys";
> -		#address-cells = <1>;
> -		#size-cells = <0>;
>   
> -		button at 5 {
> +		button-setup {
>   			debounce-interval = <50>;
>   			wakeup-source;
>   			linux,code = <KEY_SETUP>;
> @@ -42,25 +41,25 @@
>   	leds {
>   		compatible = "gpio-leds";
>   
> -		led at 1 {
> +		led-red-l3 {
>   			label = "wbd111:red:L3";
>   			/* Conflict with TVC and extended parallel flash */
>   			gpios = <&gpio0 1 GPIO_ACTIVE_HIGH>;
>   			default-state = "off";
>   		};
> -		led at 2 {
> +		led-green-l4 {
>   			label = "wbd111:green:L4";
>   			/* Conflict with TVC and extended parallel flash */
>   			gpios = <&gpio0 2 GPIO_ACTIVE_HIGH>;
>   			default-state = "off";
>   		};
> -		led at 3 {
> +		led-red-l4 {
>   			label = "wbd111:red:L4";
>   			/* Conflict with TVC and extended parallel flash */
>   			gpios = <&gpio0 3 GPIO_ACTIVE_HIGH>;
>   			default-state = "off";
>   		};
> -		led at 5 {
> +		led-greeb-l3 {
>   			label = "wbd111:green:L3";
>   			/* Conflict with TVC and extended parallel flash */
>   			gpios = <&gpio0 5 GPIO_ACTIVE_HIGH>;
> diff --git a/arch/arm/boot/dts/gemini-wbd222.dts b/arch/arm/boot/dts/gemini-wbd222.dts
> index 0be867fbfc69..24e6ae3616f7 100644
> --- a/arch/arm/boot/dts/gemini-wbd222.dts
> +++ b/arch/arm/boot/dts/gemini-wbd222.dts
> @@ -14,7 +14,7 @@
>   	#address-cells = <1>;
>   	#size-cells = <1>;
>   
> -	memory { /* 128 MB */
> +	memory at 0 { /* 128 MB */
>   		device_type = "memory";
>   		reg = <0x00000000 0x8000000>;
>   	};
> @@ -26,10 +26,8 @@
>   
>   	gpio_keys {
>   		compatible = "gpio-keys";
> -		#address-cells = <1>;
> -		#size-cells = <0>;
>   
> -		button at 5 {
> +		button-setup {
>   			debounce-interval = <50>;
>   			wakeup-source;
>   			linux,code = <KEY_SETUP>;
> @@ -42,25 +40,25 @@
>   	leds {
>   		compatible = "gpio-leds";
>   
> -		led at 1 {
> +		led-red-l3 {
>   			label = "wbd111:red:L3";
>   			/* Conflict with TVC and extended parallel flash */
>   			gpios = <&gpio0 1 GPIO_ACTIVE_HIGH>;
>   			default-state = "off";
>   		};
> -		led at 2 {
> +		led-green-l4 {
>   			label = "wbd111:green:L4";
>   			/* Conflict with TVC and extended parallel flash */
>   			gpios = <&gpio0 2 GPIO_ACTIVE_HIGH>;
>   			default-state = "off";
>   		};
> -		led at 3 {
> +		led-red-l4 {
>   			label = "wbd111:red:L4";
>   			/* Conflict with TVC and extended parallel flash */
>   			gpios = <&gpio0 3 GPIO_ACTIVE_HIGH>;
>   			default-state = "off";
>   		};
> -		led at 5 {
> +		led-green-l3 {
>   			label = "wbd111:green:L3";
>   			/* Conflict with TVC and extended parallel flash */
>   			gpios = <&gpio0 5 GPIO_ACTIVE_HIGH>;
> 
