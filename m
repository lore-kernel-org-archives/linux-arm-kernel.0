From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 9 Mar 2016 15:30:36 +0100
Subject: Kirkwood dts spi-gpio
In-Reply-To: <O3RWO7$37CF1BBB1164539CA7B18E9E6A340454@sintau.it>
References: <O3RO1V$CF721D4D7AC56BB19237E5BFE0260DB6@sintau.it>
 <O3RWO7$37CF1BBB1164539CA7B18E9E6A340454@sintau.it>
Message-ID: <20160309143036.GC31963@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 09, 2016 at 02:12:07PM +0100, a.lombardinilo wrote:
> I added dts files in the following section:
> 
> ??????? spi_gpio {
> ??????????????? #address-cells = <1>;
> ??????????????? #size-cells = <1>;
> 
> ??????????????? compatible = "spi-gpio";
> 
> ??????????????? status = "okay";
> ??????????????? gpio-sck = <&gpio1 40 GPIO_ACTIVE_LOW>;

40 is invalid. It should be in the range 0-31.

Try gpio-sck = <&gpio1 8 GPIO_ACTIVE_LOW>;

Also, why are you doing spi-gpio?

Looking at the pinctrl driver, these pins can be used by a real SPI
core:

        MPP_MODE(39,
                MPP_VAR_FUNCTION(0x0, "gpio", NULL,      V(0, 0, 0, 1, 1, 1)),
                MPP_VAR_FUNCTION(0x1, "ts", "mp3",       V(0, 0, 0, 1, 1, 0)),
                MPP_VAR_FUNCTION(0x2, "tdm", "spi-cs0",  V(0, 0, 0, 1, 1, 0)),
                MPP_VAR_FUNCTION(0x4, "audio", "bclk",   V(0, 0, 0, 1, 1, 0)),
                MPP_VAR_FUNCTION(0xb, "lcd", "d19",      V(0, 0, 0, 0, 1, 0))),
        MPP_MODE(40,
                MPP_VAR_FUNCTION(0x0, "gpio", NULL,      V(0, 0, 0, 1, 1, 1)),
                MPP_VAR_FUNCTION(0x1, "ts", "mp4",       V(0, 0, 0, 1, 1, 0)),
                MPP_VAR_FUNCTION(0x2, "tdm", "spi-sck",  V(0, 0, 0, 1, 1, 0)),
                MPP_VAR_FUNCTION(0x4, "audio", "sdo",    V(0, 0, 0, 1, 1, 0)),
                MPP_VAR_FUNCTION(0xb, "lcd", "d20",      V(0, 0, 0, 0, 1, 0))),
        MPP_MODE(41,
                MPP_VAR_FUNCTION(0x0, "gpio", NULL,      V(0, 0, 0, 1, 1, 1)),
                MPP_VAR_FUNCTION(0x1, "ts", "mp5",       V(0, 0, 0, 1, 1, 0)),
                MPP_VAR_FUNCTION(0x2, "tdm", "spi-miso", V(0, 0, 0, 1, 1, 0)),
                MPP_VAR_FUNCTION(0x4, "audio", "lrclk",  V(0, 0, 0, 1, 1, 0)),
                MPP_VAR_FUNCTION(0xb, "lcd", "d21",      V(0, 0, 0, 0, 1, 0))),
        MPP_MODE(42,
                MPP_VAR_FUNCTION(0x0, "gpio", NULL,      V(0, 0, 0, 1, 1, 1)),
                MPP_VAR_FUNCTION(0x1, "ts", "mp6",       V(0, 0, 0, 1, 1, 0)),
                MPP_VAR_FUNCTION(0x2, "tdm", "spi-mosi", V(0, 0, 0, 1, 1, 0)),
                MPP_VAR_FUNCTION(0x4, "audio", "mclk",   V(0, 0, 0, 1, 1, 0)),
                MPP_VAR_FUNCTION(0xb, "lcd", "d22",      V(0, 0, 0, 0, 1, 0))),

Andrew
