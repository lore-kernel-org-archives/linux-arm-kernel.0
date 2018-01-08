From: yixun.lan@amlogic.com (Yixun Lan)
Date: Mon, 8 Jan 2018 14:07:43 +0800
Subject: [PATCH v2 3/5] ARM64: dts: meson-axg: uart: Add the pinctrl info
 description
In-Reply-To: <CAFBinCCuQ-NK747+GHDkhZty_UMMgzCYOYFcNTrRDJgU8OM=Gw@mail.gmail.com>
References: <20180106001044.108163-1-yixun.lan@amlogic.com>
 <20180106001044.108163-4-yixun.lan@amlogic.com>
 <CAFBinCCuQ-NK747+GHDkhZty_UMMgzCYOYFcNTrRDJgU8OM=Gw@mail.gmail.com>
Message-ID: <b2571e30-d543-9288-68cf-1af86bb5f4bc@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Martin

On 01/08/18 04:19, Martin Blumenstingl wrote:
> Hi Yixun,
> 
> On Sat, Jan 6, 2018 at 1:10 AM, Yixun Lan <yixun.lan@amlogic.com> wrote:
>> Describe the pinctrl info for the UART controller which is found
>> in the Meson-AXG SoCs.
>>
>> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
>> ---
>>  arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 97 ++++++++++++++++++++++++++++++
>>  1 file changed, 97 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
>> index 644d0f9eaf8c..1eb45781c850 100644
>> --- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
>> +++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
>> @@ -448,6 +448,70 @@
>>                                                 function = "spi1";
>>                                         };
>>                                 };
>> +
>> +                               uart_a_pins: uart_a {
>> +                                       mux {
>> +                                               groups = "uart_tx_a",
>> +                                                       "uart_rx_a";
>> +                                               function = "uart_a";
>> +                                       };
>> +                               };
>> +
>> +                               uart_a_cts_rts_pins: uart_a_cts_rts {
>> +                                       mux {
>> +                                               groups = "uart_cts_a",
>> +                                                       "uart_rts_a";
>> +                                               function = "uart_a";
>> +                                       };
>> +                               };
>> +
>> +                               uart_b_x_pins: uart_b_x {
>> +                                       mux {
>> +                                               groups = "uart_tx_b_x",
>> +                                                       "uart_rx_b_x";
>> +                                               function = "uart_b";
>> +                                       };
>> +                               };
>> +
>> +                               uart_b_x_cts_rts_pins: uart_b_x_cts_rts {
>> +                                       mux {
>> +                                               groups = "uart_cts_b_x",
>> +                                                       "uart_rts_b_x";
>> +                                               function = "uart_b";
>> +                                       };
>> +                               };
>> +
>> +                               uart_b_z_pins: uart_b_z {
>> +                                       mux {
>> +                                               groups = "uart_tx_b_z",
>> +                                                       "uart_rx_b_z";
>> +                                               function = "uart_b";
>> +                                       };
>> +                               };
>> +
>> +                               uart_b_z_cts_rts_pins: uart_b_z_cts_rts {
>> +                                       mux {
>> +                                               groups = "uart_cts_b_z",
>> +                                                       "uart_rts_b_z";
>> +                                               function = "uart_b";
>> +                                       };
>> +                               };
>> +
>> +                               uart_ao_b_z_pins: uart_ao_b_z {
>> +                                       mux {
>> +                                               groups = "uart_ao_tx_b_z",
>> +                                                       "uart_ao_rx_b_z";
>> +                                               function = "uart_ao_b_gpioz";
> (the following question just came up while I was looking at this
> patch, but I guess it's more a question towards the pinctrl driver)
> the name of the function looks a bit "weird" since below you are also
> using "uart_ao_b"
you right here, it's a question related to pinctrl subsystem.
from my point of view, it's even weird from the hardware perspective:
 that, the UART function of AO domain route the pin of EE domain..

> did you choose "uart_ao_b_gpioz" here because we cannot have the same
> function name for the periphs and AO pinctrl or is there some other
> reason?
> 
Current there is a conflict in the code level which both two pinctrl
tree (EE, AO) are using the same macro[1] to expand the definitions, so
there would be conflict symbol if we name both as 'uart_ao_b'

I think your idea of having an uniform function 'uart_ao_b' for both
pinctrl subsystem is actually possible/positive..

I will think about your suggestion and come up with a patch later,
thanks a lot!


[1] drivers/pinctrl/meson/pinctrl-meson.h

#define FUNCTION(fn)                                                    \
        {                                                               \
                .name = #fn,                                            \
                .groups = fn ## _groups,                                \
                .num_groups = ARRAY_SIZE(fn ## _groups),                \
        }




> I am asking because I would have expected it to look like this:
>     groups = "uart_ao_tx_b_z", "uart_ao_rx_b_z";
>     function = "uart_ao_b";
> 
> (same for the cts/rts pins below)
> 
>> +                                       };
>> +                               };
>> +
>> +                               uart_ao_b_z_cts_rts_pins: uart_ao_b_z_cts_rts {
>> +                                       mux {
>> +                                               groups = "uart_ao_cts_b_z",
>> +                                                       "uart_ao_rts_b_z";
>> +                                               function = "uart_ao_b_gpioz";
>> +                                       };
>> +                               };
>>                         };
>>                 };
>>
>> @@ -492,12 +556,45 @@
>>                                         gpio-ranges = <&pinctrl_aobus 0 0 15>;
>>                                 };
>>
>> +
> did you add this additional newline on purpose?
>>                                 remote_input_ao_pins: remote_input_ao {
>>                                         mux {
>>                                                 groups = "remote_input_ao";
>>                                                 function = "remote_input_ao";
>>                                         };
>>                                 };
>> +
>> +                               uart_ao_a_pins: uart_ao_a {
>> +                                       mux {
>> +                                               groups = "uart_ao_tx_a",
>> +                                                       "uart_ao_rx_a";
>> +                                               function = "uart_ao_a";
>> +                                       };
>> +                               };
>> +
>> +                               uart_ao_a_cts_rts_pins: uart_ao_a_cts_rts {
>> +                                       mux {
>> +                                               groups = "uart_ao_cts_a",
>> +                                                       "uart_ao_rts_a";
>> +                                               function = "uart_ao_a";
>> +                                       };
>> +                               };
>> +
>> +                               uart_ao_b_pins: uart_ao_b {
>> +                                       mux {
>> +                                               groups = "uart_ao_tx_b",
>> +                                                       "uart_ao_rx_b";
>> +                                               function = "uart_ao_b";
>> +                                       };
>> +                               };
>> +
>> +                               uart_ao_b_cts_rts_pins: uart_ao_b_cts_rts {
>> +                                       mux {
>> +                                               groups = "uart_ao_cts_b",
>> +                                                       "uart_ao_rts_b";
>> +                                               function = "uart_ao_b";
>> +                                       };
>> +                               };
>>                         };
>>
>>                         pwm_AO_ab: pwm at 7000 {
>> --
>> 2.15.1
>>
>>
>> _______________________________________________
>> linux-amlogic mailing list
>> linux-amlogic at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-amlogic
> 
> Regards
> Martin
> 
> .
> 
