From: yurovsky@gmail.com (Andrey Yurovsky)
Date: Tue, 25 Oct 2016 10:49:01 -0700
Subject: arm/boot/dts/at91sam9260.dtsi USB clock divisors and AT91SAM9G20
Message-ID: <CAAkeqgVrCEAtX+Tujjqe4admkhnn1746kL4_d8Z1NjCwVwUGcA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I'm working at an AT91SAM9G20 on which the USB clock divisor was wrong
and traced the issue down to arm/boot/dts/at91sam9260.dtsi which is
included like this:

at91sam9g20ek_common.dtsi
    at91sam9g20.dtsi
        at91sam9260.dtsi

This has a node:

                usb: usbck {
                    compatible = "atmel,at91rm9200-clk-usb";
                    #clock-cells = <0>;
                    atmel,clk-divisors = <1 2 4 0>;
                    clocks = <&pllb>;
                };

However the G20 parts seem to need a different divisor, for me this works:

                usb: usbck {
                    compatible = "atmel,at91rm9200-clk-usb";
                    #clock-cells = <0>;
                    atmel,clk-divisors = <4 2 0 0>;
                    clocks = <&pllb>;
                };

Should the USB clock node be moved to a separate .dtsi file to account
for this difference?
