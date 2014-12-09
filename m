From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 9 Dec 2014 11:26:22 +0800
Subject: [PATCH 1/4] clk: sunxi: Rework MMC phase clocks
In-Reply-To: <CAGb2v65Q17qacuV0bxWyCyweAPiUCwapqmiYCtYME6ONNN-Jug@mail.gmail.com>
References: <1417972868-12055-1-git-send-email-maxime.ripard@free-electrons.com>
 <1417972868-12055-2-git-send-email-maxime.ripard@free-electrons.com>
 <CAGb2v65Q17qacuV0bxWyCyweAPiUCwapqmiYCtYME6ONNN-Jug@mail.gmail.com>
Message-ID: <CAGb2v65zd47HTMmpnC_PW=JTOTOqvuvM_3KKUNDKyLRbfHni7Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 9, 2014 at 12:53 AM, Chen-Yu Tsai <wens@csie.org> wrote:
> On Mon, Dec 8, 2014 at 1:21 AM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
>> Instead of having three different clocks for the main MMC clock and the two
>> phase sub-clocks, which involved having three different drivers sharing the
>> same register, rework it to have the same single driver registering three
>> different clocks.
>>
>> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
>> ---
>>  drivers/clk/sunxi/clk-mod0.c | 129 ++++++++++++++++++++++---------------------
>>  1 file changed, 67 insertions(+), 62 deletions(-)
>>
>> diff --git a/drivers/clk/sunxi/clk-mod0.c b/drivers/clk/sunxi/clk-mod0.c
>> index 658d74f39451..24522c5b94ae 100644
>> --- a/drivers/clk/sunxi/clk-mod0.c
>> +++ b/drivers/clk/sunxi/clk-mod0.c
>> @@ -115,19 +115,17 @@ static void __init sun5i_a13_mbus_setup(struct device_node *node)
>>  }
>>  CLK_OF_DECLARE(sun5i_a13_mbus, "allwinner,sun5i-a13-mbus-clk", sun5i_a13_mbus_setup);
>>
>> -struct mmc_phase_data {
>> -       u8      offset;
>> -};
>> -
>>  struct mmc_phase {
>>         struct clk_hw           hw;
>> +       u8                      offset;
>>         void __iomem            *reg;
>> -       struct mmc_phase_data   *data;
>>         spinlock_t              *lock;
>>  };
>>
>>  #define to_mmc_phase(_hw) container_of(_hw, struct mmc_phase, hw)
>>
>> +static DEFINE_SPINLOCK(sun4i_a10_mmc_lock);
>> +
>
> I'd move this to just above the setup function.
> The get/set_phase callbacks don't need it.
>
>>  static int mmc_get_phase(struct clk_hw *hw)
>>  {
>>         struct clk *mmc, *mmc_parent, *clk = hw->clk;
>> @@ -138,7 +136,7 @@ static int mmc_get_phase(struct clk_hw *hw)
>>         u8 delay;
>>
>>         value = readl(phase->reg);
>> -       delay = (value >> phase->data->offset) & 0x3;
>> +       delay = (value >> phase->offset) & 0x3;
>>
>>         if (!delay)
>>                 return 180;
>> @@ -226,8 +224,8 @@ static int mmc_set_phase(struct clk_hw *hw, int degrees)
>>
>>         spin_lock_irqsave(phase->lock, flags);
>>         value = readl(phase->reg);
>> -       value &= ~GENMASK(phase->data->offset + 3, phase->data->offset);
>> -       value |= delay << phase->data->offset;
>> +       value &= ~GENMASK(phase->offset + 3, phase->offset);
>> +       value |= delay << phase->offset;
>>         writel(value, phase->reg);
>>         spin_unlock_irqrestore(phase->lock, flags);
>>
>> @@ -239,66 +237,73 @@ static const struct clk_ops mmc_clk_ops = {
>>         .set_phase      = mmc_set_phase,
>>  };
>>
>> -static void __init sun4i_a10_mmc_phase_setup(struct device_node *node,
>> -                                            struct mmc_phase_data *data)
>> +static void __init sun4i_a10_mmc_setup(struct device_node *node)
>>  {
>> -       const char *parent_names[1] = { of_clk_get_parent_name(node, 0) };
>> -       struct clk_init_data init = {
>> -               .num_parents    = 1,
>> -               .parent_names   = parent_names,
>> -               .ops            = &mmc_clk_ops,
>> -       };
>> -
>> -       struct mmc_phase *phase;
>> -       struct clk *clk;
>> -
>> -       phase = kmalloc(sizeof(*phase), GFP_KERNEL);
>> -       if (!phase)
>> -               return;
>> -
>> -       phase->hw.init = &init;
>> -
>> -       phase->reg = of_iomap(node, 0);
>> -       if (!phase->reg)
>> -               goto err_free;
>> +       struct clk_onecell_data *clk_data;
>> +       const char *parent;
>> +       void __iomem *reg;
>> +       int i;
>>
>> -       phase->data = data;
>> -       phase->lock = &sun4i_a10_mod0_lock;
>> +       reg = of_io_request_and_map(node, 0, of_node_full_name(node));
>> +       if (IS_ERR(reg)) {
>> +               pr_err("Couldn't map the %s clock registers\n", node->name);
>> +               return;
>> +       }
>>
>> -       if (of_property_read_string(node, "clock-output-names", &init.name))
>> -               init.name = node->name;
>> +       clk_data = kmalloc(sizeof(*clk_data), GFP_KERNEL);
>> +       if (!clk_data)
>> +               return;
>>
>> -       clk = clk_register(NULL, &phase->hw);
>> -       if (IS_ERR(clk))
>> -               goto err_unmap;
>> +       clk_data->clks = kcalloc(3, sizeof(*clk_data->clks), GFP_KERNEL);
>> +       if (!clk_data->clks)
>> +               goto err_free_data;
>> +
>> +       clk_data->clk_num = 3;
>> +       clk_data->clks[0] = sunxi_factors_register(node,
>> +                                                  &sun4i_a10_mod0_data,
>> +                                                  &sun4i_a10_mmc_lock, reg);
>> +       if (!clk_data->clks[0])
>> +               goto err_free_clks;
>> +
>> +       parent = __clk_get_name(clk_data->clks[0]);
>> +
>> +       for (i = 1; i < 3; i++) {
>> +               struct clk_init_data init = {
>> +                       .num_parents    = 1,
>> +                       .parent_names   = &parent,
>> +                       .ops            = &mmc_clk_ops,
>> +               };
>> +               struct mmc_phase *phase;
>> +
>> +               phase = kmalloc(sizeof(*phase), GFP_KERNEL);
>> +               if (!phase)
>> +                       continue;
>> +
>> +               phase->hw.init = &init;
>> +               phase->reg = reg;
>> +               phase->lock = &sun4i_a10_mmc_lock;
>> +
>> +               if (i == 1)
>> +                       phase->offset = 8;
>> +               else
>> +                       phase->offset = 20;
>> +
>> +               if (of_property_read_string_index(node, "clock-output-names",
>> +                                                 i, &init.name))
>> +                       init.name = node->name;
>
> You could assign first, then call of_property_read_string_index.
> It won't touch the string unless a valid string is found.
>
>> +
>> +               clk_data->clks[i] = clk_register(NULL, &phase->hw);
>> +               if (IS_ERR(clk_data->clks[i]))
>> +                       continue;
>
> I'm a bit skeptical about partial success/failure, though I don't
> have a strong argument for or against it yet.
>
> ChenYu
>
>> +       }
>>
>> -       of_clk_add_provider(node, of_clk_src_simple_get, clk);
>> +       of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
>>
>>         return;
>>
>> -err_unmap:
>> -       iounmap(phase->reg);
>> -err_free:
>> -       kfree(phase);
>> -}
>> -
>> -
>> -static struct mmc_phase_data mmc_output_clk = {
>> -       .offset = 8,
>> -};
>> -
>> -static struct mmc_phase_data mmc_sample_clk = {
>> -       .offset = 20,
>> -};
>> -
>> -static void __init sun4i_a10_mmc_output_setup(struct device_node *node)
>> -{
>> -       sun4i_a10_mmc_phase_setup(node, &mmc_output_clk);
>> -}
>> -CLK_OF_DECLARE(sun4i_a10_mmc_output, "allwinner,sun4i-a10-mmc-output-clk", sun4i_a10_mmc_output_setup);
>> -
>> -static void __init sun4i_a10_mmc_sample_setup(struct device_node *node)
>> -{
>> -       sun4i_a10_mmc_phase_setup(node, &mmc_sample_clk);
>> +err_free_clks:
>> +       kfree(clk_data->clks);
>> +err_free_data:
>> +       kfree(clk_data);
>>  }
>> -CLK_OF_DECLARE(sun4i_a10_mmc_sample, "allwinner,sun4i-a10-mmc-sample-clk", sun4i_a10_mmc_sample_setup);
>> +CLK_OF_DECLARE(sun4i_a10_mmc, "allwinner,sun4i-a10-mmc-clk", sun4i_a10_mmc_setup);

You should also update the DT bindings. :)
