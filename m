From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sun, 17 Apr 2016 17:16:58 +0900
Subject: [Question] reset controlling
In-Reply-To: <5910310.IeFB0QAt6Q@wuerfel>
References: <CAK7LNATcVwx1q0Nb2WMSpqW3LcoRkZx3RgpMjmbt2EmffJnFvg@mail.gmail.com>
 <5910310.IeFB0QAt6Q@wuerfel>
Message-ID: <CAK7LNARJo-xDkkwZ0qA+DaKmQ0SixxGytNSKWBZMZ_N_6eWWow@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd.

2016-04-17 4:23 GMT+09:00 Arnd Bergmann <arnd@arndb.de>:

> Better count the files:
>
> $ git grep -wl clk_register | wc -l
> 179
>
> $ git grep -wl reset_controller_register | wc -l
> 25
>
> This is more like seven times as many, which seems about right.

Ah, right.  I exaggerated too much.



>> Reset signals are sometimes cascaded.
>> For example, the UART blocks on my SoCs have a reset for the whole of
>> UART blocks
>> besides per-channel reset signals.
>>
>>                      |---(UART ch0 reset)---> UART0
>>                      |
>> ----(UART reset)-----|---(UART ch1 reset)---> UART1
>>                      |
>>                      |---(UART ch2 reset)---> UART2
>>
>> I found this works well with clk-gate drivers.
>> Even reset_control_reset() can be implemented
>> with clk_disable() followed by clk_enable().
>>
>
> Interesting. My feeling from your description is that this is something
> that should be added to the reset controller subsystem. It has probably
> not been a serious issue for anyone else, but it's also likely that you
> are not the only one that would benefit from having support for nested
> resets in the API.

I want reset sub-system to support (1) nesting,  (2) enable_count.

To get these two features supported, the reset frame-work
would be similar implementation to the clock subsystem.
(In other words, we would duplicate effort
between clock and reset.)

Moreover, it is very common to control resets and clocks
from one hardware block.

So, I am looking for some idea that perhaps can unify the clock
and reset subsystems.


I found some SoCs implement reset drivers in drivers/clk.


masahiro at grover:~/workspace/linux/drivers/clk$ git grep
reset_controller_register
mediatek/reset.c:       ret = reset_controller_register(&data->rcdev);
mmp/reset.c:    reset_controller_register(&unit->rcdev);
qcom/common.c:  ret = reset_controller_register(&reset->rcdev);
rockchip/softrst.c:     ret = reset_controller_register(&softrst->rcdev);
sirf/clk-atlas7.c:      reset_controller_register(&atlas7_rst_ctlr);
sunxi/clk-a10-ve.c:     err = reset_controller_register(&reset_data->rcdev);
sunxi/clk-sun9i-mmc.c:  ret = reset_controller_register(&data->rcdev);
sunxi/clk-usb.c:        reset_controller_register(&reset_data->rcdev);
tegra/clk.c:    reset_controller_register(&rst_ctlr);


I asked about this in the following thread.
https://lkml.org/lkml/2015/11/10/724



>> Next, I thought about [2].
>> It should not be so hard to implement a reset provider.
>>
>> But, as I mentioned above, most of drivers handle clocks,
>> but not resets.
>>
>> Is it worthwhile to patch drivers around
>> with reset_control_get_optional()?
>> Hmm...
>
> I think it is. All of the 'generic' drivers for devices that are
> licensed from e.g. designware or ARM will sooner or later get it,
> and devices that are vendor specific are even easier to change
> as needed.

We can do that if needed.

I guess most of drivers would do similar things;
call devm_reset_control_get() && reset_control_deassert() in their
probe methods,
and reset_control_assert() in their remove methods.

I am wondering if we can do that somewhat automatically,
like the driver model framework automatically sets the pinctrl state
to "default"
(and low-level drivers are still able to change pinctrl state for the case
where multiple pinctrl states are supported.)


Another idea might be,
we can support "hogging" in DT just for de-asserting reset signals,


reset_ctrl: reset_ctrl {
        .compatible = "foo-reset-controller";
         #reset-cells = <1>;

         uart_deassert {   /* deassert UART reset automatically */
                reset-hog;
                resets = <0>;   /* index for UART reset line */
                deassert;
         };

         i2c_deassert {   /* deassert I2C reset automatically */
                reset-hog;
                resets = <1>;   /* index for I2C reset line */
                deassert;
         };
};


-- 
Best Regards
Masahiro Yamada
