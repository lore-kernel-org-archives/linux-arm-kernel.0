From: afaerber@suse.de (=?ISO-8859-15?Q?Andreas_F=E4rber?=)
Date: Wed, 27 Aug 2014 00:53:53 +0200
Subject: [PATCH v2 1/3] ARM: dts: Add Peach Pit dts entry for Atmel
 touchpad
In-Reply-To: <1409066937-3574-2-git-send-email-javier.martinez@collabora.co.uk>
References: <1409066937-3574-1-git-send-email-javier.martinez@collabora.co.uk>
 <1409066937-3574-2-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <53FD1001.30701@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Javier,

Am 26.08.2014 17:28, schrieb Javier Martinez Canillas:
> From: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
> 
> The Peach Pit board has an Atmel maXTouch trackpad device.
> Add the needed Device Tree nodes to support it.
> 
> This Device Tree change is based on the Chrome OS 3.8 tree
> but adapted to use the mainline Atmel maXTouch DT binding.
> 
> Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
> [javier.martinez: added linux,gpio-keymap property and changed IRQ type]
> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> ---
> 
> Changes since v1:
>  - Change trackpad IRQ pad function from 0x0 (GPIO input) to 0xf (GPIO IRQ).
>    suggested by Tomasz Figa.
>  - Remove BTN_TOOL_* from "linux,gpio-keymap" property since those are set
>    by input mt core if INPUT_MT_POINTER is set. Suggested by Nick Dyer.
>  - Use correct values for "linux,gpio-keymap" property. Suggested by Nick Dyer.
>  - Remove support for Peach Pi board since it uses a different Atmel touchpad
>    that requires an Atmel object protocol  (T100) not supported by the driver.
>  - Use IRQ type constants from <dt-bindings/interrupt-controller/irq.h> instead
>    of magic numbers. Suggested by Andreas Farber.
> ---
>  arch/arm/boot/dts/exynos5420-peach-pit.dts | 31 ++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/exynos5420-peach-pit.dts b/arch/arm/boot/dts/exynos5420-peach-pit.dts
> index 228a6b1..e4f82d5 100644
> --- a/arch/arm/boot/dts/exynos5420-peach-pit.dts
> +++ b/arch/arm/boot/dts/exynos5420-peach-pit.dts
> @@ -11,6 +11,7 @@
>  /dts-v1/;
>  #include <dt-bindings/input/input.h>
>  #include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
>  #include "exynos5420.dtsi"
>  
>  / {
> @@ -157,6 +158,29 @@
>  	};
>  };
>  
> +&hsi2c_8 {
> +	status = "okay";
> +	clock-frequency = <333000>;
> +
> +	trackpad at 4b {
> +		compatible="atmel,maxtouch";
> +		reg=<0x4b>;
> +		interrupt-parent=<&gpx1>;
> +		interrupts=<1 IRQ_TYPE_EDGE_FALLING>;

Nit: Here's a style break (4x spaces around '=' missing).

> +		wakeup-source;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&trackpad_irq>;
> +		linux,gpio-keymap = < KEY_RESERVED
> +				      KEY_RESERVED
> +				      0		/* GPIO 0 */
> +				      0		/* GPIO 1 */
> +				      0		/* GPIO 2 */
> +				      BTN_LEFT 	/* GPIO 3 */
> +				      KEY_RESERVED
> +				      KEY_RESERVED >;
> +	};

Coincidentally, I experimentally came up with a very similar DT node for
Spring the weekend:

+	trackpad at 4b {
+		compatible = "atmel,maxtouch";
+		reg = <0x4b>;
+		interrupt-parent = <&gpx1>;
+		interrupts = <2 IRQ_TYPE_NONE>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&trackpad_irq>;
+		linux,gpio-keymap = <KEY_RESERVED
+		                     KEY_RESERVED
+		                     KEY_RESERVED
+		                     KEY_RESERVED
+		                     KEY_RESERVED
+		                     BTN_LEFT>;
+		wakeup-source;
+	};

0 == KEY_RESERVED, so you can consistently use it for GPIO 0-2, too. :)

I probably should add the two trailing _RESERVEDs, too?

With my above snippet I got an awful lot of "Interrupt triggered but
zero messages" warnings (which I simply commented out as quickfix).
Is that why you are using _EDGE_FALLING? Or pin-function 0xf?
(In my case the ChromeOS DT had IRQ_TYPE_NONE and pin-function 0x0.)

Regards,
Andreas

> +};
> +
>  &hsi2c_9 {
>  	status = "okay";
>  	clock-frequency = <400000>;
> @@ -249,6 +273,13 @@
>  		samsung,pin-drv = <0>;
>  	};
>  
> +	trackpad_irq: trackpad-irq {
> +		samsung,pins = "gpx1-1";
> +		samsung,pin-function = <0xf>;
> +		samsung,pin-pud = <0>;
> +		samsung,pin-drv = <0>;
> +	};
> +
>  	power_key_irq: power-key-irq {
>  		samsung,pins = "gpx1-2";
>  		samsung,pin-function = <0>;

-- 
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend?rffer; HRB 16746 AG N?rnberg
