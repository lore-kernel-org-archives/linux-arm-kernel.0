From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 8 May 2014 11:40:59 +0800
Subject: [PATCH v2 7/7] ARM: sunxi: dt: add PRCM clk and reset controller
 subdevices
In-Reply-To: <20140508031700.GO7047@lukather>
References: <1399483554-8824-1-git-send-email-boris.brezillon@free-electrons.com>
 <1399483554-8824-8-git-send-email-boris.brezillon@free-electrons.com>
 <20140508031700.GO7047@lukather>
Message-ID: <CAGb2v664vFwezKVp+C1UYdsUktRhrZDxjsyf9L=kwVHGCUV=HA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 8, 2014 at 11:17 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Wed, May 07, 2014 at 07:25:54PM +0200, Boris BREZILLON wrote:
>> Add DT definitions for PRCM (Power/Reset/Clock Management) clock and reset
>> controller subdevices.
>>
>> Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
>> ---
>>  arch/arm/boot/dts/sun6i-a31.dtsi | 39 ++++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 38 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
>> index ec3253a..b69be0b 100644
>> --- a/arch/arm/boot/dts/sun6i-a31.dtsi
>> +++ b/arch/arm/boot/dts/sun6i-a31.dtsi
>> @@ -498,9 +498,46 @@
>>                       reg = <0x01f01c00 0x300>;
>>               };
>>
>> -             prcm at 01f01c00 {
>> +             prcm at 01f01400 {
>
> This has already been fixed by Hans.
>
>>                       compatible = "allwinner,sun6i-a31-prcm";
>>                       reg = <0x01f01400 0x200>;
>> +
>> +                     ar100: ar100_clk {
>> +                             compatible = "allwinner,sun6i-a31-ar100-clk";
>> +                             #clock-cells = <0>;
>> +                             clocks = <&osc32k>, <&osc24M>, <&pll6>, <&pll6>;
>> +                     };
>> +
>> +                     ahb0: ahb0_clk {
>> +                             compatible = "fixed-factor-clock";
>> +                             #clock-cells = <0>;
>> +                             clock-div = <1>;
>> +                             clock-mult = <1>;
>> +                             clocks = <&ar100>;
>> +                             clock-output-names = "ahb0";
>> +                     };
>> +
>> +                     apb0: apb0_clk {
>> +                             compatible = "allwinner,sun6i-a31-apb0-clk";
>> +                             #clock-cells = <0>;
>> +                             clocks = <&ahb0>;
>> +                             clock-output-names = "apb0";
>> +                     };
>> +
>> +                     apb0_gates: apb0_gates_clk {
>> +                             compatible = "allwinner,sun6i-a31-apb0-gates-clk";
>> +                             #clock-cells = <1>;
>> +                             clocks = <&apb0>;
>> +                             clock-output-names = "apb0_pio", "apb0_ir",
>> +                                             "apb0_timer01", "apb0_p2wi",
>
> timer01 ? is this a typo?

A23 manual lists the clock gate as "r_timer0_1", so I put the name on the wiki.
Allwinner sun6i code uses "r_tmr" or just "tmr". I see no problem naming this
clock output as "apb0_timer" though.

>> +                                             "apb0_uart", "apb0_1wire",
>> +                                             "apb0_i2c";
>> +                     };
>> +
>> +                     apb0_rst: apb0_rst {
>> +                             compatible = "allwinner,sun6i-a31-clock-reset";
>> +                             #reset-cells = <1>;
>> +                     };
>>               };
>>       };
>>  };
>> --
>> 1.8.3.2
>>
