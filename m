From: mturquette@linaro.org (Michael Turquette)
Date: Thu, 21 May 2015 14:17:27 -0700
Subject: [PATCH v2 2/4] doc: dt: add documentation for lpc1850-cgu clk
 driver
In-Reply-To: <CAGhQ9VyRjugLxscdL_wELbjMiDD3CFYJmsJAC_34wQeBmuxWjQ@mail.gmail.com>
References: <1430170693-28303-1-git-send-email-manabian@gmail.com>
 <1430170693-28303-3-git-send-email-manabian@gmail.com>
 <20150512221202.16410.2827@quantum>
 <CAGhQ9VyRjugLxscdL_wELbjMiDD3CFYJmsJAC_34wQeBmuxWjQ@mail.gmail.com>
Message-ID: <20150521211727.9817.5989@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Joachim Eastwood (2015-05-13 00:57:18)
> On 13 May 2015 at 00:12, Michael Turquette <mturquette@linaro.org> wrote:
> > Quoting Joachim Eastwood (2015-04-27 14:38:11)
> >> Add DT binding documentation for lpc1850-cgu driver.
> >>
> >> Signed-off-by: Joachim Eastwood <manabian@gmail.com>
> >> ---
> >>  .../devicetree/bindings/clock/lpc1850-cgu.txt      | 138 +++++++++++++++++++++
> >>  1 file changed, 138 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/clock/lpc1850-cgu.txt
> >>
> >> diff --git a/Documentation/devicetree/bindings/clock/lpc1850-cgu.txt b/Documentation/devicetree/bindings/clock/lpc1850-cgu.txt
> >> new file mode 100644
> >> index 000000000000..0b278ca6aee7
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/clock/lpc1850-cgu.txt
> >> @@ -0,0 +1,138 @@
> >> +* NXP LPC1850 Clock Generation Unit (CGU)
> >> +
> >> +The CGU generates multiple independent clocks for the core and the
> >> +peripheral blocks of the LPC18xx. Each independent clock is called
> >> +a base clock and itself is one of the inputs to the two Clock
> >> +Control Units (CCUs) which control the branch clocks to the
> >> +individual peripherals.
> >> +
> >> +The CGU selects the inputs to the clock generators from multiple
> >> +clock sources, controls the clock generation, and routes the outputs
> >> +of the clock generators through the clock source bus to the output
> >> +stages. Each output stage provides an independent clock source and
> >> +corresponds to one of the base clocks for the LPC18xx.
> >> +
> >> + - Above text taken from NXP LPC1850 User Manual.
> >> +
> >> +
> >> +This binding uses the common clock binding:
> >> +    Documentation/devicetree/bindings/clock/clock-bindings.txt
> >> +
> >> +Required properties:
> >> +- compatible:
> >> +       Should be "nxp,lpc1850-cgu"
> >> +- reg:
> >> +       Shall define the base and range of the address space
> >> +       containing clock control registers
> >> +- #clock-cells:
> >> +       Shall have value <1>.  The permitted clock-specifier values
> >> +       are the base clock numbers defined below.
> >> +- clocks:
> >> +       Shall contain a list of phandles for the external input
> >> +       sources to the CGU. The list shall be in the following
> >> +       order: xtal, 32khz, enet_rx_clk, enet_tx_clk, gp_clkin.
> >> +- clock-indices:
> >> +       Shall be an ordered list of numbers defining the base clock
> >> +       number provided by the CGU.
> >> +- clock-output-names:
> >> +       Shall be an ordered list of strings defining the names of
> >> +       the clocks provided by the CGU.
> >> +
> >> +Which base clocks that are available on the CGU depends on the
> >> +specific LPC part. Base cloks are numbered from 0 to 27.
> >
> > s/cloks/clocks/
> >
> >> +
> >> +Number:                Name:                   Description:
> >> + 0             BASE_SAFE_CLK           Base safe clock (always on) for WWDT
> >> + 1             BASE_USB0_CLK           Base clock for USB0
> >> + 2             BASE_PERIPH_CLK         Base clock for Cortex-M0SUB subsystem,
> >> +                                       SPI, and SGPIO
> >> + 3             BASE_USB1_CLK           Base clock for USB1
> >> + 4             BASE_CPU_CLK            System base clock for ARM Cortex-M core
> >> +                                       and APB peripheral blocks #0 and #2
> >> + 5             BASE_SPIFI_CLK          Base clock for SPIFI
> >> + 6             BASE_SPI_CLK            Base clock for SPI
> >> + 7             BASE_PHY_RX_CLK         Base clock for Ethernet PHY Receive clock
> >> + 8             BASE_PHY_TX_CLK         Base clock for Ethernet PHY Transmit clock
> >> + 9             BASE_APB1_CLK           Base clock for APB peripheral block # 1
> >> +10             BASE_APB3_CLK           Base clock for APB peripheral block # 3
> >> +11             BASE_LCD_CLK            Base clock for LCD
> >> +12             BASE_ADCHS_CLK          Base clock for ADCHS
> >> +13             BASE_SDIO_CLK           Base clock for SD/MMC
> >> +14             BASE_SSP0_CLK           Base clock for SSP0
> >> +15             BASE_SSP1_CLK           Base clock for SSP1
> >> +16             BASE_UART0_CLK          Base clock for UART0
> >> +17             BASE_UART1_CLK          Base clock for UART1
> >> +18             BASE_UART2_CLK          Base clock for UART2
> >> +19             BASE_UART3_CLK          Base clock for UART3
> >> +20             BASE_OUT_CLK            Base clock for CLKOUT pin
> >> +24-21          -                       Reserved
> >> +25             BASE_AUDIO_CLK          Base clock for audio system (I2S)
> >> +26             BASE_CGU_OUT0_CLK       Base clock for CGU_OUT0 clock output
> >> +27             BASE_CGU_OUT1_CLK       Base clock for CGU_OUT1 clock output
> >> +
> >> +BASE_PERIPH_CLK and BASE_SPI_CLK is only available on LPC43xx.
> >> +BASE_ADCHS_CLK is only available on LPC4370.
> >> +
> >> +
> >> +Example board file:
> >> +
> >> +/ {
> >> +       clocks {
> >> +               xtal: xtal {
> >> +                       compatible = "fixed-clock";
> >> +                       #clock-cells = <0>;
> >> +                       clock-frequency = <12000000>;
> >> +               };
> >> +
> >> +               xtal32: xtal32 {
> >> +                       compatible = "fixed-clock";
> >> +                       #clock-cells = <0>;
> >> +                       clock-frequency = <32768>;
> >> +               };
> >> +
> >> +               enet_rx_clk: enet_rx_clk {
> >> +                       compatible = "fixed-clock";
> >> +                       #clock-cells = <0>;
> >> +                       clock-frequency = <0>;
> >> +                       clock-output-names = "enet_rx_clk";
> >> +               };
> >> +
> >> +               enet_tx_clk: enet_tx_clk {
> >> +                       compatible = "fixed-clock";
> >> +                       #clock-cells = <0>;
> >> +                       clock-frequency = <0>;
> >> +                       clock-output-names = "enet_tx_clk";
> >> +               };
> >> +
> >> +               gp_clkin: gp_clkin {
> >> +                       compatible = "fixed-clock";
> >> +                       #clock-cells = <0>;
> >> +                       clock-frequency = <0>;
> >> +                       clock-output-names = "gp_clkin";
> >> +               };
> >> +       };
> >> +
> >> +       soc {
> >> +               cgu: cgu at 40050000 {
> >> +                       compatible = "nxp,lpc1850-cgu";
> >> +                       reg = <0x40050000 0x1000>;
> >> +                       #clock-cells = <1>;
> >> +                       clocks = <&xtal>, <&creg_clk 1>, <&enet_rx_clk>, <&enet_tx_clk>, <&gp_clkin>;
> >> +                       clock-indices =  <0>,  <1>,  <2>,  <3>,  <4>,  <5>,  <6>,  <7>,
> >> +                                        <8>,  <9>, <10>, <11>, <12>, <13>, <14>, <15>,
> >> +                                       <16>, <17>, <18>, <19>, <20>, <25>, <26>, <27>;
> >> +                       clock-output-names = "base_safe_clk",    "base_usb0_clk",
> >> +                                            "base_periph_clk",  "base_usb1_clk",
> >> +                                            "base_cpu_clk",     "base_spifi_clk",
> >> +                                            "base_spi_clk",     "base_phy_rx_clk",
> >> +                                            "base_phy_tx_clk",  "base_apb1_clk",
> >> +                                            "base_apb3_clk",    "base_lcd_clk",
> >> +                                            "base_adchs_clk",   "base_sdio_clk",
> >> +                                            "base_ssp0_clk",    "base_ssp1_clk",
> >> +                                            "base_uart0_clk",   "base_uart1_clk",
> >> +                                            "base_uart2_clk",   "base_uart3_clk",
> >> +                                            "base_out_clk",     "base_audio_clk",
> >> +                                            "base_cgu_out0_clk","base_cgu_out1_clk";
> >
> > Why do you need to use clock-indices?
> 
> Since the CGU can have up to 27 clock lines, but in this device not
> all are used. So I use clock-indices so I don't need to have empty
> entries in the clock-output-names array. I thought this was the
> intended usage(?)
> 
> > Why do you need to use clock-output-names? If all of your clock
> > consumers have nodes in DT then you can skip this and name them on the
> > consuming side. See a further explanation here:
> > http://lkml.kernel.org/r/<20150416192014.19585.9663@quantum>
> 
> Most of the clocks from the CGU goes to a CCU, but the CCU isn't the
> real consumer. It's more like a clock router with a bunch of gates.
> 
> If you take a close look at the CCU driver you will notice that it
> doesn't do clk_get on any of the clocks. My reason for doing this is
> to not increase the usage counter on the CGU clock so that if there
> are no consumer after a CCU the entire clock line up to the CGU can be
> disabled. So this is the reason that the CCU driver uses a "special"
> way to grab the clock output names from the CGU.

A call to clk_get will not enable/ungate the clock signal. It seems that
there might be some confusion around that. It is always OK to get the
clk. This will not increase the enable_count or prepare_count values.

If the CCU is a separate IP block then it might make sense for it to
call clk_get on the CGU clocks. On the other hand it might make more
sense for the CCU clocks to simply use the CGU clocks as parent clock
signal inputs.

None of the points above have anything to do with my original comment.
The use of the clock-output-names property is unnecessary if all of the
consumer devices have DT nodes of their own. Please look at the thread I
linked to and let me know what you think about getting rid of the
clock-output-names property.

> 
> Hope this makes sense.
> 
> > Also note that providing a clock consumer node in the examples section
> > of the binding is helpful when reviewing.
> 
> I'll add a consumer example in the next version.

Great.

Thanks,
Mike

> 
> regards,
> Joachim Eastwood
