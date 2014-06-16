From: denis@eukrea.com (Denis Carikli)
Date: Mon, 16 Jun 2014 14:29:00 +0200
Subject: [PATCH v14 09/10] ARM: dts: mbimx51sd: Add display support.
In-Reply-To: <1402913484-25910-9-git-send-email-denis@eukrea.com>
References: <1402913484-25910-1-git-send-email-denis@eukrea.com>
 <1402913484-25910-9-git-send-email-denis@eukrea.com>
Message-ID: <539EE30C.4060502@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/16/2014 12:11 PM, Denis Carikli wrote:> +	reg_lcd_3v3: lcd-en {
 > +		compatible = "regulator-fixed";
 > +		pinctrl-names = "default";
 > +		pinctrl-0 = <&pinctrl_reg_lcd_3v3>;
 > +		regulator-name = "lcd-3v3";
 > +		regulator-min-microvolt = <3300000>;
 > +		regulator-max-microvolt = <3300000>;
 > +		gpio = <&gpio3 13 GPIO_ACTIVE_HIGH>;
 > +		regulator-boot-on;
 > +	};
 > +};
This is wrong, I'll fix it in the next serie.

What it really does is to make regulator-fixed think that the gpio is 
active low, the bindings documentation(fixed-regulator.txt) says:
 > - enable-active-high: Polarity of GPIO is Active high
 > If this property is missing, the default assumed is Active low.

Then regulator-boot-on will make it think that the regulator is already 
on and so the regulator will be disabled.
 From the bindings documentation (regulator.txt):
 > regulator-boot-on: bootloader/firmware enabled regulator

Which result at the lcd regulator being physically powered on at boot.
I didn't see that because powering it on at boot is what I want.

How can I do that beside doing it in userspace by issuing the following 
commands:
echo 4 > /sys/devices/display-subsystem/graphics/fb0/blank
echo 0 > /sys/devices/display-subsystem/graphics/fb0/blank

Denis.
