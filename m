From: liang.yang@amlogic.com (Liang Yang)
Date: Thu, 27 Sep 2018 16:16:31 +0800
Subject: [PATCH v4 2/2] mtd: rawnand: meson: add support for Amlogic NAND
 flash controller
In-Reply-To: <CAFBinCAaphyifUNyDQr7th2Mt=A+UQnzai0edKLCPNbxhh2w+Q@mail.gmail.com>
References: <1537433449-65213-1-git-send-email-jianxin.pan@amlogic.com>
 <1537433449-65213-3-git-send-email-jianxin.pan@amlogic.com>
 <CAFBinCAaphyifUNyDQr7th2Mt=A+UQnzai0edKLCPNbxhh2w+Q@mail.gmail.com>
Message-ID: <f75b6f23-6d58-2145-30f3-b23e4b69966b@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Martin,

On 9/22/2018 11:32 PM, Martin Blumenstingl wrote:
> Hello,
> 
> On Thu, Sep 20, 2018 at 10:51 AM Jianxin Pan <jianxin.pan@amlogic.com> wrote:
> [snip]
>> +static int meson_nfc_clk_init(struct meson_nfc *nfc)
>> +{
>> +       int ret;
>> +
>> +       /* request core clock */
>> +       nfc->core_clk = devm_clk_get(nfc->dev, "core");
>> +       if (IS_ERR(nfc->core_clk)) {
>> +               dev_err(nfc->dev, "failed to get core clk\n");
>> +               return PTR_ERR(nfc->core_clk);
>> +       }
>> +
>> +       nfc->device_clk = devm_clk_get(nfc->dev, "device");
>> +       if (IS_ERR(nfc->device_clk)) {
>> +               dev_err(nfc->dev, "failed to get device clk\n");
>> +               return PTR_ERR(nfc->device_clk);
>> +       }
>> +
>> +       nfc->phase_tx = devm_clk_get(nfc->dev, "tx");
>> +       if (IS_ERR(nfc->phase_tx)) {
>> +               dev_err(nfc->dev, "failed to get tx clk\n");
>> +               return PTR_ERR(nfc->phase_tx);
>> +       }
>> +
>> +       nfc->phase_rx = devm_clk_get(nfc->dev, "rx");
>> +       if (IS_ERR(nfc->phase_rx)) {
>> +               dev_err(nfc->dev, "failed to get rx clk\n");
>> +               return PTR_ERR(nfc->phase_rx);
>> +       }
> neither the "rx" nor the "tx" clock are documented in the dt-bindings patch
> 

ok, i will add them later.

>> +       /* init SD_EMMC_CLOCK to sane defaults w/min clock rate */
>> +       regmap_update_bits(nfc->reg_clk, 0,
>> +                          CLK_SELECT_NAND | CLK_ALWAYS_ON | CLK_DIV_MASK,
>> +                          CLK_SELECT_NAND | CLK_ALWAYS_ON | CLK_DIV_MASK);
> clk_set_rate also works for clocks that are not enabled yet (except if
> they have the flag CLK_SET_RATE_UNGATE)
> this should help you to remove CLK_DIV_MASK here
> 

if not set clk_div_mask here, the value 0x00 of divider means nand clock 
off, even read/write nand register is forbidden.

> is CLK_SELECT_NAND a bit that switches the clock output from the sdmmc
> controller to the NAND controller?
> if so: can this be modeled as a mux clock?
> 

it seems to like a gate. 1: nand is selected; 0: emmc is selected.
Is it suitable for making it as a mux clock?

> the public S905 datasheet doesn't mention CLK_ALWAYS_ON at bit 28 but
> uses bit 24 instead. the description from the datasheet:
> Cfg_always_on:
> 1: Keep clock always on
> 0: Clock on/off controlled by activities.
>      Any APB3 access or descriptor execution will turn clock on.
> Recommended value: 0
> 
> can you please explain what CLK_ALWAYS_ON does and why it has to be 1?
> 

em , it is the same as bit 24 in S905 datasheet, only moves to bit 28.
it means keeping internal clock on whether nand wroks or not.
it doesn't have to be 1; i have tried 0 successfully on AXG platform.

> 
> Regards
> Martin
> 
> .
> 
