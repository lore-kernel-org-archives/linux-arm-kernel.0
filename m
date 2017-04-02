From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sun, 2 Apr 2017 20:54:01 +0200
Subject: [PATCH 1/1] clk: meson: meson8b: add support for the NAND clocks
In-Reply-To: <1491147496.3480.5.camel@baylibre.com>
References: <20170401131001.9988-1-martin.blumenstingl@googlemail.com>
 <20170401131001.9988-2-martin.blumenstingl@googlemail.com>
 <1491147496.3480.5.camel@baylibre.com>
Message-ID: <CAFBinCCHLk5Z6DkXEvz3iiFCWra2=Qa+OpoLrZ8R2x_wkMBy-g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jerome,

thanks for taking time to review this!

On Sun, Apr 2, 2017 at 5:38 PM, Jerome Brunet <jbrunet@baylibre.com> wrote:
> On Sat, 2017-04-01 at 15:10 +0200, Martin Blumenstingl wrote:
>> This adds the NAND clocks (from the HHI_NAND_CLK_CNTL register) to the
>> Meson8b clock driver. There are three NAND clocks: a gate which enables
>> or disables the NAND clock, a mux and a divider (which divides the mux
>> output).
>> Unfortunately the public S805 datasheet does not document the mux
>> parents. However, the vendor kernel has a few hints for us which allows
>> us to make an educated guess about the clock parents. To do this we need
>> to have a look at set_nand_core_clk() from the vendor's NAND driver (see
>> [0]):
>> - XTAL = (4<<9) | (1<<8) | 0
>> - 160MHz = (0<<9) | (1<<8) | 3)
>> - 182MHz = (3<<9) | (1<<8) | 1)
>> - 212MHz = (1<<9) | (1<<8) | 3)
>> - 255MHz = (2<<9) | (1<<8) | 1)
>>
>> should only be used for debugging) we have to do a bit of math for the
>> other parents: target_freq * divider = rate of parent clock
>> Bit 8 above is the enable bit, so we can ignore it here. Bits 11:9 are
>> the mux index and bits 6:0 are the 0-based divider (so we need to add
>> 1). This gives us:
>> - mux 0 (160MHz * 4) = fclk_div4 (actual rate = 637.5MHz, off by 2.5MHz)
>> - mux 1 (212MHz * 4) = fclk_div3 (actual rate = 850MHz, off by 2MHz)
>> - mux 2 (255MHz * 2) = fclk_div5 (matches exactly 510MHz)
>> - mux 3 (182MHz * 2) = fclk_div7 (actual rate = 346.3MHz, off by 0.3MHz)
>>
>
> Good job detective ;)
> What is strange is that amlogic seems to have change the index of these parents
> on the gxbb. I have a documentation (which I'm not at liberty to share
> unfortunately) which gives the following index on the S905:
> 0: xtal
> 1: fclk_div2
> 2: fclk_div3
> 3: flck_div5
> 4: fclk_div7
> 5: mpll2
> 6: mpll3
> 7: gp0
>
> Did they change the ids, or is the documentation wrong ? I don't know, but we'll
> to pay attention to that if you port your NAND work the gx family.
I guess they changed the IDs. on Meson8b the only NAND clock rates
that are actually used are 212MHz and 255MHz (hardcoded in their
driver).
however, on GXBB there's a tiny difference: there 200MHz and 250MHz are used.

my assumption was: if they change even the clock frequencies then it's
likely that the mux parents are different as well


>> [0]
>> https://github.com/khadas/linux/blob/9587681285cb/drivers/amlogic/amlnf/dev/am
>> lnf_ctrl.c#L314
>>
>> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>> ---
>>  drivers/clk/meson/meson8b.c | 53
>> +++++++++++++++++++++++++++++++++++++++++++++
>>  drivers/clk/meson/meson8b.h |  6 ++++-
>>  2 files changed, 58 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
>> index e9985503165c..b7f3cf8ed386 100644
>> --- a/drivers/clk/meson/meson8b.c
>> +++ b/drivers/clk/meson/meson8b.c
>> @@ -403,6 +403,53 @@ struct clk_gate meson8b_clk81 = {
>>       },
>>  };
>>
>> +static u32 mux_table_nand[]  = { 0, 1, 2, 3, 4 };
> You can drop this table, you don't need it.
>
>> +
>> +struct clk_mux meson8b_nand_clk_sel = {
>> +     .reg = (void *)HHI_NAND_CLK_CNTL,
>> +     .mask = 0x7,
>> +     .shift = 9,
>> +     .table = mux_table_nand,
>> +     .flags = CLK_MUX_ROUND_CLOSEST,
>
> If you go for CLK_SET_RATE_NO_REPARENT, I think this flag is not really useful.
yep, I'd rather leave it and remove CLK_SET_RATE_NO_REPARENT below

>> +     .lock = &clk_lock,
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "nand_clk_sel",
>> +             .ops = &clk_mux_ops,
>> +             /* FIXME all other parents are unknown: */
>> +             .parent_names = (const char *[]){ "fclk_div4", "fclk_div3",
>> +                     "fclk_div5", "fclk_div7", "xtal" },
>> +             .num_parents = 5,
>> +             .flags = CLK_SET_RATE_NO_REPARENT,
>
> PSB
>
>> +     },
>> +};
>> +
>> +struct clk_divider meson8b_nand_clk_div = {
>> +     .reg = (void *)HHI_NAND_CLK_CNTL,
>> +     .shift = 0,
>> +     .width = 6,
>> +     .flags = CLK_DIVIDER_ROUND_CLOSEST,
>> +     .lock = &clk_lock,
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "nand_clk_div",
>> +             .ops = &clk_divider_ops,
>> +             .parent_names = (const char *[]){ "nand_clk_sel" },
>> +             .num_parents = 1,
>
> I think you are trying to tightly control all those elements in your nand
> driver, aren't you ? To mimic the vendor driver settings, maybe ?
>
> While it would surely work, another way is possible. You could give the flag
> CLK_SET_RATE_PARENT (and drop the CLK_SET_RATE_NO_REPARENT) to all those
> elements and let the CCF do the work for you.
>
> There is a good chance it will come with same settings anyway (if that's the
> best math can provide)
>
> The good thing about it is that it hides those quirks from your driver. So if
> the gxbb has slighly different clock setup for the nand, you won't have to deal
> with it in your driver, just call clk_set_rate on the gate and be done with it.
>
> Could you give it try ?
it seems that I missed this:
at first I thought that I have to set the mux parent manually.
but after playing around with my NAND driver code I figured out that
(like you suggested) I could probably get away by only setting the
rate on the gate and let the framework do the rest.

I'll send an update as soon as I have time

>> +     },
>> +};
>> +
>> +struct clk_gate meson8b_nand_clk_gate = {
>> +     .reg = (void *)HHI_NAND_CLK_CNTL,
>> +     .bit_idx = 8,
>> +     .lock = &clk_lock,
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "nand_clk_gate",
>> +             .ops = &clk_gate_ops,
>> +             .parent_names = (const char *[]){ "nand_clk_div" },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>>  /* Everything Else (EE) domain gates */
>>
>>  static MESON_GATE(meson8b_ddr, HHI_GCLK_MPEG0, 0);
>> @@ -584,6 +631,9 @@ static struct clk_hw_onecell_data meson8b_hw_onecell_data
>> = {
>>               [CLKID_MPLL0]               = &meson8b_mpll0.hw,
>>               [CLKID_MPLL1]               = &meson8b_mpll1.hw,
>>               [CLKID_MPLL2]               = &meson8b_mpll2.hw,
>> +             [CLKID_NAND_SEL]            = &meson8b_nand_clk_sel.hw,
>> +             [CLKID_NAND_DIV]            = &meson8b_nand_clk_div.hw,
>> +             [CLKID_NAND_CLK]            = &meson8b_nand_clk_gate.hw,
>>       },
>>       .num = CLK_NR_CLKS,
>>  };
>> @@ -679,14 +729,17 @@ static struct clk_gate *const meson8b_clk_gates[] = {
>>       &meson8b_ao_ahb_sram,
>>       &meson8b_ao_ahb_bus,
>>       &meson8b_ao_iface,
>> +     &meson8b_nand_clk_gate,
>>  };
>>
>>  static struct clk_mux *const meson8b_clk_muxes[] = {
>>       &meson8b_mpeg_clk_sel,
>> +     &meson8b_nand_clk_sel,
>>  };
>>
>>  static struct clk_divider *const meson8b_clk_dividers[] = {
>>       &meson8b_mpeg_clk_div,
>> +     &meson8b_nand_clk_div,
>>  };
>>
>>  static int meson8b_clkc_probe(struct platform_device *pdev)
>> diff --git a/drivers/clk/meson/meson8b.h b/drivers/clk/meson/meson8b.h
>> index 3881defc8644..cbb8001b5fe8 100644
>> --- a/drivers/clk/meson/meson8b.h
>> +++ b/drivers/clk/meson/meson8b.h
>> @@ -37,6 +37,7 @@
>>  #define HHI_GCLK_AO                  0x154 /* 0x55 offset in data sheet
>> */
>>  #define HHI_SYS_CPU_CLK_CNTL1                0x15c /* 0x57 offset in data
>> sheet */
>>  #define HHI_MPEG_CLK_CNTL            0x174 /* 0x5d offset in data sheet
>> */
>> +#define HHI_NAND_CLK_CNTL            0x25c /* 0x97 offset in data sheet
>> */
>>  #define HHI_MPLL_CNTL                        0x280 /* 0xa0 offset in data
>> sheet */
>>  #define HHI_SYS_PLL_CNTL             0x300 /* 0xc0 offset in data sheet */
>>  #define HHI_VID_PLL_CNTL             0x320 /* 0xc8 offset in data sheet */
>> @@ -160,8 +161,11 @@
>>  #define CLKID_MPLL0          93
>>  #define CLKID_MPLL1          94
>>  #define CLKID_MPLL2          95
>> +#define CLKID_NAND_SEL               96
>> +#define CLKID_NAND_DIV               97
>> +#define CLKID_NAND_CLK               98
>>
>> -#define CLK_NR_CLKS          96
>> +#define CLK_NR_CLKS          99
>>
>>  /* include the CLKIDs that have been made part of the stable DT binding */
>>  #include <dt-bindings/clock/meson8b-clkc.h>
