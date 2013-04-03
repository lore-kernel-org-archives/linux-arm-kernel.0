From: prabhakar.csengg@gmail.com (Prabhakar Lad)
Date: Wed, 3 Apr 2013 14:46:02 +0530
Subject: Query on pinctrl usage for DT nodes
Message-ID: <CA+V-a8uiPwsAD--OHFAE=i2ed+-wbXm4p2deZXr92+Zv6GDS1w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus/Stephen,

I am working adding  DT nodes for DA850.

Following is the pin control snippet of da850.dtsi:-

		pmx_core: pinmux at 1c14120 {
			compatible = "pinctrl-single";
			reg = <0x14120 0x50>;
			#address-cells = <1>;
			#size-cells = <0>;
			pinctrl-single,bit-per-mux;
			pinctrl-single,register-width = <32>;
			pinctrl-single,function-mask = <0xffffffff>;
			status = "disabled"

                        i2c0_pins: pinmux_i2c0_pins {
                                pinctrl-single,bits = <
                                        /* I2C0_SDA,I2C0_SCL */
                                        0x10 0x00002200 0x0000ff00
                                >;
                        };
                        mdio_pins: pinmux_mdio_pins {
                                pinctrl-single,bits = <
                                        /* MDIO_CLK, MDIO_D */
                                        0x10 0x00000088 0x000000ff
                                >;
                        };
                }

And following is the code snippet for dts:-

		i2c0: i2c at 1c22000 {
			status = "okay";
			clock-frequency = <100000>;
			pinctrl-names = "default";
			pinctrl-0 = <&i2c0_pins>;
		};
		mdio: mdio at 1e24000 {
			status = "okay";
			bus_freq = <2200000>;
			pinctrl-names = "default";
              };
		
But while booting I see the following boot log:-
...
cpuidle: using governor menu
TCP: cubic registered
NET: Registered protocol family 17
pinctrl-single 1c14120.pinmux: pin 1c14130 already requested by
davinci_mdio.0; cannot claim for i2c_davinci.1
pinctrl-single 1c14120.pinmux: pin-4 (i2c_davinci.1) status -22
pinctrl-single 1c14120.pinmux: could not request pin 4 on device pinctrl-single
console [netcon0] enabled
....

This is because the mdio and i2c are using same pin 0x10, Is there any
alternative way to handle if the two node's are using same pins any
pointers could be very much helpful ?

Regards,
--Prabhakar
