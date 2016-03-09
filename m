From: a.lombardinilo@sintau.it (a.lombardinilo)
Date: Wed,  9 Mar 2016 16:45:18 +0100
Subject: Kirkwood dts spi-gpio
In-Reply-To: <20160309143036.GC31963@lunn.ch>
References: =?iso-8859-1?q?=3CO3RO1V=24CF721D4D7AC56BB19237E5BFE0260DB6=40sintau?=
 =?iso-8859-1?q?=2Eit=3E_=3CO3RWO7=2437CF1BBB1164539CA7B18E9E6A340454?=
 =?iso-8859-1?q?=40sintau=2Eit=3E_=3C20160309143036=2EGC31963=40lunn?=
 =?iso-8859-1?q?=2Ech=3E?=
Message-ID: <O3S3RI$A08ECF24DFB5BFF577DDD05BAD4E3E09@sintau.it>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I modified the dts as follows:

  ocp at f1000000 {
    pinctrl: pin-controller at 10000 {
      pmx_spi_gpio: pmx-spi-gpio {
        marvell,pins = "mpp39", "mpp40", "mpp41", "mpp42", "mpp43", "mpp44";
        marvell,function = "gpio";
      };
??? ??serial at 12000 {
??? ??  status = "okay";
??? ??};
  };

??spi_gpio {
????? #address-cells = <1>;
????? #size-cells = <1>;
????? pinctrl-0 = <&pmx_spi_gpio>;
????? pinctrl-names = "default";

????? compatible = "spi-gpio";
? ??? status = "okay";
? ??? gpio-sck = <&gpio1 8 GPIO_ACTIVE_LOW>;
? ??? gpio-miso = <&gpio1 9 GPIO_ACTIVE_LOW>;
? ??? gpio-mosi = <&gpio1 10 GPIO_ACTIVE_LOW>;
? ??? cs-gpios = <&gpio1 7 GPIO_ACTIVE_LOW>;
? ??? num-chipselects = <1>;

? ??? can0: can at 0 {
? ??? ??? compatible = "microchip,mcp2515";
? ??? ??? reg = <0>;
? ??? ??? interrupts = <&gpio1 11 GPIO_ACTIVE_LOW>;
? ??? ??? spi-max-frequency = <10000000>;
? ??? };
  };

and I see the following kernel messages:
root at gropius:/# dmesg | grep gpio
[    0.187002] gpiochip_add: registered GPIOs 0 to 31 on device: f1010100.gpio
[    0.187454] gpiochip_add: registered GPIOs 32 to 49 on device: f1010140.gpio
[    0.187815] of_get_named_gpiod_flags: can't parse 'reset-gpios' property of node '/mbus/pcie-controll'
[    1.046456] of_get_named_gpiod_flags: parsed 'gpio-sck' property of node '/spi_gpio[0]' - status (0)
[    1.046472] of_get_named_gpiod_flags: parsed 'gpio-miso' property of node '/spi_gpio[0]' - status (0)
[    1.046486] of_get_named_gpiod_flags: parsed 'gpio-mosi' property of node '/spi_gpio[0]' - status (0)
[    1.046545] of_get_named_gpiod_flags: parsed 'cs-gpios' property of node '/spi_gpio[0]' - status (0)
[    1.046564] of_get_named_gpiod_flags: parsed 'cs-gpios' property of node '/spi_gpio[0]' - status (0)
[    1.046651] spi_gpio spi_gpio: registered master spi32766 (dynamic)
[    1.072575] spi_gpio spi_gpio: registered child spi32766.0
root at gropius:/# 
root at gropius:/# 
root at gropius:/# dmesg | grep spi
[    1.046456] of_get_named_gpiod_flags: parsed 'gpio-sck' property of node '/spi_gpio[0]' - status (0)
[    1.046472] of_get_named_gpiod_flags: parsed 'gpio-miso' property of node '/spi_gpio[0]' - status (0)
[    1.046486] of_get_named_gpiod_flags: parsed 'gpio-mosi' property of node '/spi_gpio[0]' - status (0)
[    1.046545] of_get_named_gpiod_flags: parsed 'cs-gpios' property of node '/spi_gpio[0]' - status (0)
[    1.046564] of_get_named_gpiod_flags: parsed 'cs-gpios' property of node '/spi_gpio[0]' - status (0)
[    1.046651] spi_gpio spi_gpio: registered master spi32766 (dynamic)
[    1.072461] spi spi32766.0: spi_bitbang_setup, 100 nsec/bit
[    1.072481] spi spi32766.0: setup mode 0, 8 bits/w, 10000000 Hz max --> 0
[    1.072575] spi_gpio spi_gpio: registered child spi32766.0
[    1.076614] mcp251x: probe of spi32766.0 failed with error -2
root at gropius:/# 
root at gropius:/# 
root at gropius:/# dmesg | grep mcp
[    1.076614] mcp251x: probe of spi32766.0 failed with error -2
root at gropius:/# 

I now understand why mcp2510 probe fail.
I try also to use the real spi

>40 is invalid. It should be in the range 0-31.
>?
>Try gpio-sck = <&gpio1 8 GPIO_ACTIVE_LOW>;
>?
>Also, why are you doing spi-gpio?
>?
>Looking at the pinctrl driver, these pins can be used by a real SPI core:
>?
>        MPP_MODE(39,
>                MPP_VAR_FUNCTION(0x0, "gpio", NULL,      V(0, 0, 0, 1, 1, 1)),
>                MPP_VAR_FUNCTION(0x1, "ts", "mp3",       V(0, 0, 0, 1, 1, 0)),
>                MPP_VAR_FUNCTION(0x2, "tdm", "spi-cs0",  V(0, 0, 0, 1, 1, 0)),
>                MPP_VAR_FUNCTION(0x4, "audio", "bclk",   V(0, 0, 0, 1, 1, 0)),
>                MPP_VAR_FUNCTION(0xb, "lcd", "d19",      V(0, 0, 0, 0, 1, 0))),
>        MPP_MODE(40,
>                MPP_VAR_FUNCTION(0x0, "gpio", NULL,      V(0, 0, 0, 1, 1, 1)),
>                MPP_VAR_FUNCTION(0x1, "ts", "mp4",       V(0, 0, 0, 1, 1, 0)),
>                MPP_VAR_FUNCTION(0x2, "tdm", "spi-sck",  V(0, 0, 0, 1, 1, 0)),
>                MPP_VAR_FUNCTION(0x4, "audio", "sdo",    V(0, 0, 0, 1, 1, 0)),
>                MPP_VAR_FUNCTION(0xb, "lcd", "d20",      V(0, 0, 0, 0, 1, 0))),
>        MPP_MODE(41,
>                MPP_VAR_FUNCTION(0x0, "gpio", NULL,      V(0, 0, 0, 1, 1, 1)),
>                MPP_VAR_FUNCTION(0x1, "ts", "mp5",       V(0, 0, 0, 1, 1, 0)),
>                MPP_VAR_FUNCTION(0x2, "tdm", "spi-miso", V(0, 0, 0, 1, 1, 0)),
>                MPP_VAR_FUNCTION(0x4, "audio", "lrclk",  V(0, 0, 0, 1, 1, 0)),
>                MPP_VAR_FUNCTION(0xb, "lcd", "d21",      V(0, 0, 0, 0, 1, 0))),
>        MPP_MODE(42,
>                MPP_VAR_FUNCTION(0x0, "gpio", NULL,      V(0, 0, 0, 1, 1, 1)),
>                MPP_VAR_FUNCTION(0x1, "ts", "mp6",       V(0, 0, 0, 1, 1, 0)),
>                MPP_VAR_FUNCTION(0x2, "tdm", "spi-mosi", V(0, 0, 0, 1, 1, 0)),
>                MPP_VAR_FUNCTION(0x4, "audio", "mclk",   V(0, 0, 0, 1, 1, 0)),
>                MPP_VAR_FUNCTION(0xb, "lcd", "d22",      V(0, 0, 0, 0, 1, 0))),
>
>Andrew
