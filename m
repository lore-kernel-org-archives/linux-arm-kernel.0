From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sun, 17 Apr 2016 02:49:40 +0900
Subject: [Question] reset controlling
Message-ID: <CAK7LNATcVwx1q0Nb2WMSpqW3LcoRkZx3RgpMjmbt2EmffJnFvg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi.


I have wondered how to handle reset signals for my SoCs.



I notice reset controllers are less supported in Linux than clock controllers.



I grepped "clk_register" and "reset_controller_register".

I know this does not give us the precise number of
clk/reset providers, but I think it is enough for a rough estimate.

masahiro at grover:~/workspace/linux$ git grep clk_register | wc
   3520   18014  308516
masahiro at grover:~/workspace/linux$ git grep reset_controller_register | wc
     31     107    2462


Looks like we support 100 times as many clock providers as
reset providers.

In other words, 99% of SoCs support clock controllers,
but not reset controllers.

But, I think most of hardware blocks
have reset signals as well as clocks.
At least, it is true on my SoCs.


Similar tendency for consumers.

I grepped "clk_get" and "reset_control_get".


masahiro at grover:~/workspace/linux$ git grep clk_get | wc
   3362   16486  256820
masahiro at grover:~/workspace/linux$ git grep reset_control_get | wc
    142     732   12481


Most of drivers support controlling clock signals,
but do not care about reset signals.



So, how can we explain this fact?

What are recommended strategies for reset signals?

I came up with some options as follows:


[1] Reset signals should be de-asserted in a firmware (boot-loader)
    for all the hardware blocks.  Linux kernel need not touch them at all.

[2] We should really make effort to support more reset drivers,
    like we do for clock drivers.

[3] We can (ab)use clock-gate drivers for controlling reset signals.



At first, I chose [3] for my SoCs
with the analogy clk_enable/clk_disable to
reset_control_deassert/reset_control_assert.
(and also because the reset sub-system does not support tree-topology
or enable-count.)

Reset signals are sometimes cascaded.
For example, the UART blocks on my SoCs have a reset for the whole of
UART blocks
besides per-channel reset signals.

                     |---(UART ch0 reset)---> UART0
                     |
----(UART reset)-----|---(UART ch1 reset)---> UART1
                     |
                     |---(UART ch2 reset)---> UART2

I found this works well with clk-gate drivers.
Even reset_control_reset() can be implemented
with clk_disable() followed by clk_enable().



Having said that, I hesitate to distort my device trees.

In order to make a reset signal look like a clock,
we need to describe DT as follows

clkrstctrl: clkrstctrl {
        compatible = "foo-clock-and-reset-controller";
        #clock-cells = <1>;
}

uart {
         clock-names = "clock", "reset";
         clocks = <&clkctrl 0>, <&rstctrl 0>;
}


instead of


clkctrl: clkctrl {
        compatible = "foo-clock-controller";
        #clock-cells = <1>;
}

rstctrl: rstctrl {
        compatible = "foo-reset-controller";
        #reset-cells = <1>;
}

uart {
         clocks = <&clkctrl 0>;
         resets = <&rstctrl 0>;
}



The first DT fragment seems weird if we consider the concept of device tree;
as a hardware description language, DT should reflect the hardware
representation.  Clocks and resets are different things.
So, DT should not be compromised by the fact that reset driver support
is poor in Linux.




Next, I thought about [2].
It should not be so hard to implement a reset provider.

But, as I mentioned above, most of drivers handle clocks,
but not resets.

Is it worthwhile to patch drivers around
with reset_control_get_optional()?
Hmm...




[1] would be the easiest and I think makes sense to some extent
because controlling clock signals seems enough from the
power-management perspective.



Any idea?



-- 
Best Regards
Masahiro Yamada
