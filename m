From: liang.yang@amlogic.com (Liang Yang)
Date: Fri, 28 Sep 2018 16:31:26 +0800
Subject: [PATCH v4 2/2] mtd: rawnand: meson: add support for Amlogic NAND
 flash controller
In-Reply-To: <CAFBinCBLfoqnLK_hu6fufO4MXKKoRDPDuJgLasCNYWeuL6tCKw@mail.gmail.com>
References: <1537433449-65213-1-git-send-email-jianxin.pan@amlogic.com>
 <1537433449-65213-3-git-send-email-jianxin.pan@amlogic.com>
 <CAFBinCAaphyifUNyDQr7th2Mt=A+UQnzai0edKLCPNbxhh2w+Q@mail.gmail.com>
 <f75b6f23-6d58-2145-30f3-b23e4b69966b@amlogic.com>
 <CAFBinCBLfoqnLK_hu6fufO4MXKKoRDPDuJgLasCNYWeuL6tCKw@mail.gmail.com>
Message-ID: <6ed594d7-ca01-1b07-e68a-2998c1f9c263@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 9/27/2018 5:12 PM, Martin Blumenstingl wrote:
> Hello Liang,
> 
> On Thu, Sep 27, 2018 at 10:19 AM Liang Yang <liang.yang@amlogic.com> wrote:
>>
>> Hello Martin,
>>
>> On 9/22/2018 11:32 PM, Martin Blumenstingl wrote:
>>> Hello,
>>>
>>> On Thu, Sep 20, 2018 at 10:51 AM Jianxin Pan <jianxin.pan@amlogic.com> wrote:
>>> [snip]
>>>> +static int meson_nfc_clk_init(struct meson_nfc *nfc)
>>>> +{
>>>> +       int ret;
>>>> +
>>>> +       /* request core clock */
>>>> +       nfc->core_clk = devm_clk_get(nfc->dev, "core");
>>>> +       if (IS_ERR(nfc->core_clk)) {
>>>> +               dev_err(nfc->dev, "failed to get core clk\n");
>>>> +               return PTR_ERR(nfc->core_clk);
>>>> +       }
>>>> +
>>>> +       nfc->device_clk = devm_clk_get(nfc->dev, "device");
>>>> +       if (IS_ERR(nfc->device_clk)) {
>>>> +               dev_err(nfc->dev, "failed to get device clk\n");
>>>> +               return PTR_ERR(nfc->device_clk);
>>>> +       }
>>>> +
>>>> +       nfc->phase_tx = devm_clk_get(nfc->dev, "tx");
>>>> +       if (IS_ERR(nfc->phase_tx)) {
>>>> +               dev_err(nfc->dev, "failed to get tx clk\n");
>>>> +               return PTR_ERR(nfc->phase_tx);
>>>> +       }
>>>> +
>>>> +       nfc->phase_rx = devm_clk_get(nfc->dev, "rx");
>>>> +       if (IS_ERR(nfc->phase_rx)) {
>>>> +               dev_err(nfc->dev, "failed to get rx clk\n");
>>>> +               return PTR_ERR(nfc->phase_rx);
>>>> +       }
>>> neither the "rx" nor the "tx" clock are documented in the dt-bindings patch
>>>
>>
>> ok, i will add them later.
>>
>>>> +       /* init SD_EMMC_CLOCK to sane defaults w/min clock rate */
>>>> +       regmap_update_bits(nfc->reg_clk, 0,
>>>> +                          CLK_SELECT_NAND | CLK_ALWAYS_ON | CLK_DIV_MASK,
>>>> +                          CLK_SELECT_NAND | CLK_ALWAYS_ON | CLK_DIV_MASK);
>>> clk_set_rate also works for clocks that are not enabled yet (except if
>>> they have the flag CLK_SET_RATE_UNGATE)
>>> this should help you to remove CLK_DIV_MASK here
>>>
>>
>> if not set clk_div_mask here, the value 0x00 of divider means nand clock
>> off, even read/write nand register is forbidden.
> ah, now I see the pattern here.
> Jerome has written a "sclk-div" driver (which is currently only used
> for the audio clocks on AXG). based on reading the code it seems that
> switching the driver of the divider clock to sclk-div would allow you
> to remove setting CLK_DIV_MASK here:
> - the  "hi" parameter in struct meson_sclk_div_data is optional ->
> then the sclk-div clock won't try to change the duty cycle
> - sclk_div_init reads the divider at initialization time - if it's 0
> it takes the maximum possible divider value
> - sclk_div_enable (which you're going to call anyways, through
> clk_prepare_enable) will then set the divider to the greatest possible
> value
> 
I read the code and it makes sense.
I try ro add mmc_clkc_regmap_divider_ops in clk-regmap.c and implement 
the initial value when enable call. like this:
+static int mmc_clkc_regmap_div_enable(struct clk_hw *hw)
+{
+       struct clk_regmap *clk = to_clk_regmap(hw);
+       struct clk_regmap_div_data *div = clk_get_regmap_div_data(clk);
+       unsigned int val;
+
+       regmap_read(clk->map, div->offset, &val);
+       val &= clk_div_mask(div->width);
+       if (!val)
+               regmap_update_bits(clk->map, div->offset,
+                                  clk_div_mask(div->width) << div->shift,
+                                  clk_div_mask(div->width));

+       return 0;
+}

it works.

>>> is CLK_SELECT_NAND a bit that switches the clock output from the sdmmc
>>> controller to the NAND controller?
>>> if so: can this be modeled as a mux clock?
>>>
>>
>> it seems to like a gate. 1: nand is selected; 0: emmc is selected.
>> Is it suitable for making it as a mux clock?
> my understanding of a gate is:
> - register value X = OFF, value Y = ON
> 
> but in your case it's:
> - 0 = eMMC is ON but NAND is OFF
> - 1 = eMMC is OFF but NAND is ON
> (so both values mean "on", just for different contexts)
> 
> I believe you need to set this value for eMMC as well:
> what if the bootloader (or hardware defaults, etc.) incorrectly sets
> the value to 1 but the Linux .dts is configured to use eMMC?
> 
en , we need set 0 for emmc as well.

>>> the public S905 datasheet doesn't mention CLK_ALWAYS_ON at bit 28 but
>>> uses bit 24 instead. the description from the datasheet:
>>> Cfg_always_on:
>>> 1: Keep clock always on
>>> 0: Clock on/off controlled by activities.
>>>       Any APB3 access or descriptor execution will turn clock on.
>>> Recommended value: 0
>>>
>>> can you please explain what CLK_ALWAYS_ON does and why it has to be 1?
>>>
>>
>> em , it is the same as bit 24 in S905 datasheet, only moves to bit 28.
>> it means keeping internal clock on whether nand wroks or not.
>> it doesn't have to be 1; i have tried 0 successfully on AXG platform.
> my preference would be to use the recommended value from the datasheet
> unless there's a good argument why it has to be different
> 
>
indeed, i will adopt the recommended value.

> Regards
> Martin
> 
> .
> 
