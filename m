From: mturquette@linaro.org (Mike Turquette)
Date: Wed, 30 Oct 2013 12:44:00 -0700
Subject: [PATCH v10 1/7] clk: hi3xxx: add clock support
In-Reply-To: <1381828577-27998-2-git-send-email-haojian.zhuang@linaro.org>
References: <1381828577-27998-1-git-send-email-haojian.zhuang@linaro.org>
 <1381828577-27998-2-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <20131030194400.11662.9100@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Haojian Zhuang (2013-10-15 02:16:11)
> Add clock support with device tree on Hisilicon SoC.
> 
> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
> Cc: Mike Turquette <mturquette@linaro.org>

Hello Haojian,

This patch looks mostly good to me but I have a few comments on the
binding below.

> ---
>  .../devicetree/bindings/clock/hisilicon.txt        |  99 +++++++++
>  drivers/clk/Makefile                               |   1 +
>  drivers/clk/hisilicon/Makefile                     |   2 +
>  drivers/clk/hisilicon/clk-hi3xxx.c                 | 221 +++++++++++++++++++++
>  drivers/clk/hisilicon/clk-hi3xxx.h                 |  34 ++++
>  drivers/clk/hisilicon/clkgate-seperated.c          | 129 ++++++++++++
>  6 files changed, 486 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/hisilicon.txt
>  create mode 100644 drivers/clk/hisilicon/Makefile
>  create mode 100644 drivers/clk/hisilicon/clk-hi3xxx.c
>  create mode 100644 drivers/clk/hisilicon/clk-hi3xxx.h
>  create mode 100644 drivers/clk/hisilicon/clkgate-seperated.c
> 
> diff --git a/Documentation/devicetree/bindings/clock/hisilicon.txt b/Documentation/devicetree/bindings/clock/hisilicon.txt
> new file mode 100644
> index 0000000..c29b9ef
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/hisilicon.txt
> @@ -0,0 +1,99 @@
> +Device Tree Clock bindings for arch-hi3xxx
> +
> +This binding uses the common clock binding[1].
> +
> +[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
> +
> +Required properties for mux clocks:
> + - compatible : shall be "hisilicon,clk-mux".
> + - clocks : shall be the input parent clock phandle for the clock. This should
> +       be the reference clock.
> + - clock-output-names : shall be reference name.
> + - #clock-cells : from common clock binding; shall be set to 0.
> + - reg : the mux register address. It should be the offset of the container.
> + - clkmux-mask : mask bits of the mux register.
> + - clkmux-table : array of mux select bits.
> +
> +Optional properties for mux clocks:
> + - clkmux-hiword-mask : indicates that the bit[31:16] are the hiword mask
> +       of mux selected bits (bit[15:0]). The bit[15:0] is valid only when
> +       bit[31:16] is set.

The masks are enumerated in clkmux-table. Can these masks include the
hiword-mask bits as well? This will mean that you can eliminate the
clkmux-hiword-mask property entirely. As an example:


	reg = <0xfc802000 0x4>;
	clkmux-table = <0x80000000 0x80008000>;

> +
> +
> +
> +Required properties for gate clocks:
> + - compatible : shall be "hisilicon,clk-gate".
> + - clocks : shall be the input parent clock phandle for the clock. This should
> +       be the reference clock.
> + - clock-output-names : shall be reference name.
> + - #clock-cells : from common clock binding; shall be set to 0.
> + - reg : the mux register address. It should be the offset of the container.
> + - clkgate : bit index to control the clock gate in the gate register.
> +
> +Optional properties for gate clocks:
> + - clkgate-inverted : it indicates that setting 0 could enable the clock gate
> +       and setting 1 could disable the clock gate.
> + - clkgate-seperated-reg : it indicates that there're three continuous
> +       registers (enable, disable & status) for the same clock gate.
> +
> +
> +
> +Required properties for divider clocks:
> + - compatible : shall be "hisilicon,clk-div".
> + - clocks : shall be the input parent clock phandle for the clock. This should
> +       be the reference clock.
> + - clock-output-names : shall be reference name.
> + - reg : the divider register address. It should be the offset of the
> +       container.
> + - clkdiv-mask : mask bits of the divider register.
> + - clkdiv-min : the minimum divider of the clock divider.
> + - clkdiv-max : the maximum divider of the clock divider.
> +
> +Optional properties for divider clocks:
> + - clkdiv-hiword-mask : indicates that the bit[31:16] are the hiword mask
> +       of divider selected bits (bit[15:0]). The bit[15:0] is valid only when
> +       bit[31:16] is set.
> +
> +
> +
> +For example:
> +               timer0_mux: timer0_mux at fc802000 {
> +                       compatible = "hisilicon,clk-mux";
> +                       #clock-cells = <0>;
> +                       clocks = <&osc32k &timerclk01>;
> +                       clock-output-names = "timer0_mux";
> +                       reg = <0xfc802000 0x4>;
> +                       clkmux-mask = <0x8000>;
> +                       clkmux-table = <0 0x8000>;

Can you eliminate the clkmux-mask property as well? Since you enumerate
the clkmux-table property you should be able to derive the mask from the
entries in that table.

Regards,
Mike
