From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 8 May 2017 23:41:38 +0200
Subject: [PATCH 1/2 v2] clk: Add bindings for the Gemini Clock Controller
In-Reply-To: <CAL_JsqLAMObobPrBDdA8bjaKTX4rEo2=_qd86ibbA2kQP6AvBg@mail.gmail.com>
References: <20170508201159.31634-1-linus.walleij@linaro.org>
 <CAL_JsqLAMObobPrBDdA8bjaKTX4rEo2=_qd86ibbA2kQP6AvBg@mail.gmail.com>
Message-ID: <CACRpkdY+EzbbTy6PzN5-YhCnSxPoKej2z=t-7eC3CPqDa6Q4_w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 8, 2017 at 11:24 PM, Rob Herring <robh+dt@kernel.org> wrote:

>> +Example:
>> +
>> +syscon: syscon at 40000000 {
>> +       compatible = "cortina,gemini-syscon", "cortina,gemini-clock-controller",
>> +                    "syscon", "simple-mfd";
>
> There are no child nodes, so you don't need simple-mfd.

The example is taken from an actual device tree (look below),
where there are child nodes, I can trim it down.

>> +       reg = <0x40000000 0x1000>;
>
> Looks like you have 2 nodes pointing to the same address with your
> reset binding? You shouldn't have overlapping resources. It's allowed
> for historical reasons but breaks resource creation in Linux.

No... they are all in the same node, just sharing the same
resource by way of regmap (syscon).

In the end, as I think you requested, when you said:

>> +     clock-controller {
>> +             compatible = "cortina,gemini-clock-controller";
>> +             #clock-cells = <1>;
(...)
> There's not really much reason to have a child node here. The parent can
> be the clock provider.
(...)
> Same comment as clocks. The parent can be the provider.

So as you say, no specific child is needed and syscon provides
clocks and resets:

                syscon: syscon at 40000000 {
                        compatible = "cortina,gemini-syscon",
                                     "cortina,gemini-clock-controller",
                                     "cortina,gemini-reset",
                                     "syscon", "simple-mfd";
                        reg = <0x40000000 0x1000>;
                        #clock-cells = <1>;
                        #reset-cells = <1>;

                        syscon-reboot {
                                compatible = "syscon-reboot";
                                regmap = <&syscon>;
                                /* GLOBAL_RESET register */
                                offset = <0x0c>;
                                /* RESET_GLOBAL | RESET_CPU1 */
                                mask = <0xC0000000>;
                        };
                };

Before your (as I percieved it) requested changes to avoid
surplus children in the syscon it looked like this:

                syscon: syscon at 40000000 {
                        compatible = "cortina,gemini-syscon",
"syscon", "simple-mfd";
                        reg = <0x40000000 0x1000>;

                        syscon-reboot {
                                compatible = "syscon-reboot";
                                regmap = <&syscon>;
                                /* GLOBAL_RESET register */
                                offset = <0x0c>;
                                /* RESET_GLOBAL | RESET_CPU1 */
                                mask = <0xC0000000>;
                        };

                        rcon: reset-controller {
                                compatible = "cortina,gemini-reset";
                                #reset-cells = <1>;
                        };

                        gcc: clock-controller {
                                compatible = "cortina,gemini-clock-controller";
                                #clock-cells = <1>;
                        };
                };


Yours,
Linus Walleij
