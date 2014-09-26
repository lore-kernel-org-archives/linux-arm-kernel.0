From: bjorn@kryo.se (Bjorn Andersson)
Date: Fri, 26 Sep 2014 06:41:09 -0700
Subject: [PATCH 1/2] ARM: DT: apq8064: create
 qcom-apq8064-board-common.dtsi
In-Reply-To: <1411718851-17436-2-git-send-email-mike.rapoport@gmail.com>
References: <1411718851-17436-1-git-send-email-mike.rapoport@gmail.com>
 <1411718851-17436-2-git-send-email-mike.rapoport@gmail.com>
Message-ID: <CAJAp7Ohdi2+M0LC+a3BT6++17b2DST8RgjJddKNEVwL9Ltqrdg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 26, 2014 at 1:07 AM, Mike Rapoport <mike.rapoport@gmail.com> wrote:

Cool to see the addition of dt for additional devices. I do however
not think it is correct to put all these things in common...

> diff --git a/arch/arm/boot/dts/qcom-apq8064-board-common.dtsi b/arch/arm/boot/dts/qcom-apq8064-board-common.dtsi
> new file mode 100644
> index 0000000..c92d3e9
> --- /dev/null
> +++ b/arch/arm/boot/dts/qcom-apq8064-board-common.dtsi
> @@ -0,0 +1,57 @@
> +#include "qcom-apq8064-v2.0.dtsi"
> +
> +/ {
> +
> +       soc {
> +               pinctrl at 800000 {
> +                       i2c1_pins: i2c1 {
> +                               mux {
> +                                       pins = "gpio20", "gpio21";
> +                                       function = "gsbi1";
> +                               };

The muxing is common, but you probably want to be able to set drive
strength and bias as well and handle active vs sleep mode and then I'm
not sure if it is common anymore...

> +                       };
> +               };
> +
> +               gsbi at 12440000 {
> +                       status = "okay";
> +                       qcom,mode = <GSBI_PROT_I2C>;
> +
> +                       i2c at 12460000 {
> +                               status = "okay";
> +                               clock-frequency = <200000>;
> +                               pinctrl-0 = <&i2c1_pins>;
> +                               pinctrl-names = "default";
> +
> +                               eeprom: eeprom at 52 {
> +                                       compatible = "atmel,24c128";
> +                                       reg = <0x52>;
> +                                       pagesize = <32>;
> +                               };

Not all apq8064 boards have this eeprom.

> +                       };
> +               };
> +
> +               gsbi at 16600000 {
> +                       status = "ok";
> +                       qcom,mode = <GSBI_PROT_I2C_UART>;
> +                       serial at 16640000 {
> +                               status = "ok";
> +                       };
> +               };
> +
> +               amba {
> +                       /* eMMC */
> +                       sdcc1: sdcc at 12400000 {
> +                               status = "okay";
> +                       };
> +
> +                       /* External micro SD card */
> +                       sdcc3: sdcc at 12180000 {
> +                               status = "okay";
> +                       };
> +                       /* WLAN */
> +                       sdcc4: sdcc at 121c0000 {
> +                               status = "okay";
> +                       };

I'm not sure if all boards are using sdcc4 for WiFi.

Regards,
Bjorn
