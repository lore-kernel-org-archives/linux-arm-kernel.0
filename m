From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 23 Mar 2015 15:07:14 +0800
Subject: [PATCH 4/6] clk: sunxi: Make divs clocks specify which output is
 the parent clock
In-Reply-To: <20150321105309.GD2774@lukather>
References: <1426785548-5932-1-git-send-email-wens@csie.org>
 <1426785548-5932-5-git-send-email-wens@csie.org>
 <20150321105309.GD2774@lukather>
Message-ID: <CAGb2v65NWqZ323KRWEwm7C9FGC+8=K8WHzNiYY5tBH0p8Om0Eg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 21, 2015 at 6:53 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Fri, Mar 20, 2015 at 01:19:06AM +0800, Chen-Yu Tsai wrote:
>> The current sunxi clock driver has the parent of divs clocks as the
>> last clock output of the clock node. This makes it rather difficult
>> to add new outputs, such as fixed dividers, which were previously
>> unknown.
>>
>> This patch makes the divs clocks data structure specify which output
>> is the parent clock, and updates all current divs clocks accordingly.
>>
>> We can then add new outputs after the parent clocks, at least not
>> breaking backward compatibility with regards to the devicetree bindings.
>>
>> Also replace kzalloc with kcalloc in sunxi_divs_clk_setup().
>>
>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>> ---
>>  drivers/clk/sunxi/clk-sunxi.c | 31 +++++++++++++++++++------------
>>  1 file changed, 19 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
>> index d92e30371d8a..d28acdde364e 100644
>> --- a/drivers/clk/sunxi/clk-sunxi.c
>> +++ b/drivers/clk/sunxi/clk-sunxi.c
>> @@ -1046,13 +1046,14 @@ static void __init sunxi_gates_clk_setup(struct device_node *node,
>>   * sunxi_divs_clk_setup() helper data
>>   */
>>
>> -#define SUNXI_DIVS_MAX_QTY   2
>> +#define SUNXI_DIVS_MAX_QTY   4
>>  #define SUNXI_DIVISOR_WIDTH  2
>>
>>  struct divs_data {
>>       const struct factors_data *factors; /* data for the factor clock */
>> -     int ndivs; /* number of children */
>> +     int ndivs; /* number of outputs */
>>       struct {
>> +             u8 parent; /* is it the parent? (only one please) */
>
> I really don't get what this "parent" is about. Is it a clock passed
> through to the users.

It is the PLL itself (the rate doubled one if you will),
which then has the separate divided outputs. Or:

    sun6i: PLL6x2 -> PLL6
    sun7i: PLL6 -> {PLL6 SATA, PLL6 other}

> Do we have even have users for these?

The mbus clocks use the doubled PLL6 as one of it's inputs.
There are no users of the parent PLL5 clock. This can be seen
in the .dtsi files, where PLL6 has a clock-output-name for
itself, while PLL5 does not. However the clock driver has
always exported the parent clock as the last clock for the
node.

ChenYu
