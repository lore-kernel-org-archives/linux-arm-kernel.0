From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 18 Jun 2013 09:38:49 +0200
Subject: [PATCH v4 7/7] ARM: hi3xxx: enable hi4511 with device tree
In-Reply-To: <1370702843-27172-8-git-send-email-haojian.zhuang@linaro.org>
References: <1370702843-27172-1-git-send-email-haojian.zhuang@linaro.org>
 <1370702843-27172-8-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <CACRpkdbbjKQ-Ghs79F9wvefi-4LVfU9SZYk9YmoAPudNu+QLhQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 8, 2013 at 4:47 PM, Haojian Zhuang
<haojian.zhuang@linaro.org> wrote:

> +                       uart0_mux: uart0_mux {
> +                               compatible = "hisilicon,hi3620-clk-mux";
> +                               #clock-cells = <0>;
> +                               clocks = <&osc26m &pclk>;
> +                               clock-output-names = "uart0_mux";
> +                               /* reg_offset, mask bits */
> +                               hisilicon,clkmux-reg = <0x100 0x80>;
> +                               /* each item value */
> +                               hisilicon,clkmux-table = <0 0x80>;
> +                       };
> +                       uart1_mux: uart1_mux {
> +                               compatible = "hisilicon,hi3620-clk-mux";
> +                               #clock-cells = <0>;
> +                               clocks = <&osc26m &pclk>;
> +                               clock-output-names = "uart1_mux";
> +                               hisilicon,clkmux-reg = <0x100 0x100>;
> +                               hisilicon,clkmux-table = <0x0 0x100>;
> +                       };

hisilicon,clkmux-reg and hisilicon,clkmux-table looks like
a ladder of power of two.

If the -reg part is register offsets I think it is wrong, I think
drivers should know register offsets, instead I would encode
a clock ID in the device tree and look up these from a
table in the driver. (However this is Mike's decision.)

In any case, #define all these constants with symbolic names
using the <dt-bindings/clock/hisilicon.h> or something like
that so they are not just magic power of two numbers.

#define HILSILICON_CLOCK_MUX_UART0 (1 << 7)
#define HILSILICON_CLOCK_MUX_UART1 (1 << 8)

hisilicon,clkmux-table = <0x0 HISLICON_CLOCK_MUX_UART0>;

(or similar etc)

> +               timer0: timer at fc800000 {
> +                       compatible = "arm,sp804", "arm,primecell";
> +                       reg = <0xfc800000 0x1000>;
> +                       /* timer00 & timer01 */
> +                       interrupts = <0 0 4>, <0 1 4>;

Use

#include <dt-bindings/interrupt-controller/arm-gic.h>
#include <dt-bindings/interrupt-controller/irq.h>

And you can write
interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>, <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;

> +                               pinctrl-single,bias-pulldown = <0 2 0 2>;
> +                               pinctrl-single,bias-pullup = <1 1 0 1>;
> +                               pinctrl-single,drive-strength = <0x30 0xf0>;

I think you should invent a
<dt-bindings/pinctrl/pinctrl-single.h>
defining all of these magic values in the same manner as
the flags above. It will make everything more readable.

Maybe single should simply be switched over to using the new
generic pinconfig DT bindings we have in for -next?
There we don't use magic cells at all, just string specifiers.

Yours,
Linus Walleij
