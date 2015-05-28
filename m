From: mturquette@linaro.org (Michael Turquette)
Date: Wed, 27 May 2015 20:45:55 -0700
Subject: [PATCH v3 5/6] doc: dt: add documentation for lpc1850-ccu clk
 driver
In-Reply-To: <1431988559-23338-6-git-send-email-manabian@gmail.com>
References: <1431988559-23338-1-git-send-email-manabian@gmail.com>
 <1431988559-23338-6-git-send-email-manabian@gmail.com>
Message-ID: <20150528034555.22384.65723@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Joachim Eastwood (2015-05-18 15:35:58)
> Add DT binding documentation for lpc1850-ccu clk driver.
> 
> Signed-off-by: Joachim Eastwood <manabian@gmail.com>
> ---
>  .../devicetree/bindings/clock/lpc1850-ccu.txt      | 146 +++++++++++++++++++++
>  1 file changed, 146 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/lpc1850-ccu.txt
> 
> diff --git a/Documentation/devicetree/bindings/clock/lpc1850-ccu.txt b/Documentation/devicetree/bindings/clock/lpc1850-ccu.txt
> new file mode 100644
> index 000000000000..aca46805c10a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/lpc1850-ccu.txt
> @@ -0,0 +1,146 @@
> +* NXP LPC1850 Clock Control Unit (CCU)
> +
> +Each CGU base clock has several clock branches which can be turned on
> +or off independently by the Clock Control Units CCU1 or CCU2. The
> +branch clocks are distributed between CCU1 and CCU2.
> +
> + - Above text taken from NXP LPC1850 User Manual.
> +
> +This binding uses the common clock binding:
> +    Documentation/devicetree/bindings/clock/clock-bindings.txt
> +
> +Required properties:
> +- compatible:
> +       Should be "nxp,lpc1850-ccu"
> +- reg:
> +       Shall define the base and range of the address space
> +       containing clock control registers
> +- #clock-cells:
> +       Shall have value <1>.  The permitted clock-specifier values
> +       are the branch clock names defined in table below.
> +- clocks:
> +       Shall contain a list of phandles for the base clocks routed
> +       from the CGU to the specific CCU. See mapping of base clocks
> +       and CCU in table below.
> +
> +Which brach clocks that are available on the CCU depends on the
> +specific LPC part.
> +
> +CCU1 branch clocks:
> +Base clock     Branch clock            Description
> +BASE_APB3_CLK  CLK_APB3_BUS            APB3 bus clock.
> +               CLK_APB3_I2C1           Clock to the I2C1 register interface
> +                                       and I2C1 peripheral clock.

You don't need to make these explicit here. Just specify that the header
containing these constants is located at
nclude/dt-bindings/clock/lpc18xx-ccu.h

(DT people please correct me if this is bad etiquette)

> +
> +Not all branch clocks are available on all LPC parts. Check the user
> +manual for your specific part.

How many varieties of LPC part are there? Should these varieties each
have their own .dtsi that make it clear which branch clocks are
available on that part?

Regards,
Mike

> +
> +Note that CLK_M3_x and CLK_M4_x have been renamed to CLK_CPU_x here
> +be more generic since both LPC18xx (M3) and LPC43xx (M4) are
> +supported.
> +
> +
> +Example board file:
> +
> +soc {
> +       ccu1: clock-controller at 40051000 {
> +               compatible = "nxp,lpc1850-ccu";
> +               reg = <0x40051000 0x1000>;
> +               #clock-cells = <1>;
> +               clocks = <&cgu BASE_APB3_CLK>,   <&cgu BASE_APB1_CLK>,
> +                        <&cgu BASE_SPIFI_CLK>,  <&cgu BASE_CPU_CLK>,
> +                        <&cgu BASE_PERIPH_CLK>, <&cgu BASE_USB0_CLK>,
> +                        <&cgu BASE_USB1_CLK>,   <&cgu BASE_SPI_CLK>;
> +       };
> +
> +       ccu2: clock-controller at 40052000 {
> +               compatible = "nxp,lpc1850-ccu";
> +               reg = <0x40052000 0x1000>;
> +               #clock-cells = <1>;
> +               clocks = <&cgu BASE_AUDIO_CLK>, <&cgu BASE_UART3_CLK>,
> +                        <&cgu BASE_UART2_CLK>, <&cgu BASE_UART1_CLK>,
> +                        <&cgu BASE_UART0_CLK>, <&cgu BASE_SSP1_CLK>,
> +                        <&cgu BASE_SSP0_CLK>,  <&cgu BASE_SDIO_CLK>;
> +       };
> +
> +       /* A user of CCU brach clocks */
> +       uart1: serial at 40082000 {
> +               ...
> +               clocks = <&ccu2 CLK_APB0_UART1>, <&ccu1 CLK_CPU_UART1>;
> +               ...
> +       };
> +};
> -- 
> 1.8.0
> 
