From: mturquette@linaro.org (Michael Turquette)
Date: Wed, 27 May 2015 20:44:24 -0700
Subject: [PATCH v3 4/6] clk: add lpc18xx ccu clk driver
In-Reply-To: <1431988559-23338-5-git-send-email-manabian@gmail.com>
References: <1431988559-23338-1-git-send-email-manabian@gmail.com>
 <1431988559-23338-5-git-send-email-manabian@gmail.com>
Message-ID: <20150528034424.22384.83956@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joachim,

Quoting Joachim Eastwood (2015-05-18 15:35:57)
<snip>
> +static void lpc18xx_ccu_register_branch_clks(void __iomem *reg_base,
> +                                            int base_clk_id,
> +                                            const char *parent)
> +{
> +       int i;
> +
> +       for (i = 0; i < ARRAY_SIZE(clk_branches); i++) {
> +               if (clk_branches[i].base_id != base_clk_id)
> +                       continue;
> +
> +               lpc18xx_ccu_register_branch_gate_div(&clk_branches[i], reg_base,
> +                                                    parent);
> +
> +               if (clk_branches[i].flags & CCU_BRANCH_IS_BUS)
> +                       parent = clk_branches[i].name;
> +       }
> +}
> +
> +static void __init lpc18xx_ccu_init(struct device_node *np)
> +{
> +       struct lpc18xx_branch_clk_data *clk_data;
> +       int num_base_ids, *base_ids;
> +       void __iomem *reg_base;
> +       const char *parent;
> +       int base_clk_id;
> +       int i;
> +
> +       reg_base = of_iomap(np, 0);
> +       if (!reg_base) {
> +               pr_warn("%s: failed to map address range\n", __func__);
> +               return;
> +       }
> +
> +       clk_data = kzalloc(sizeof(*clk_data), GFP_KERNEL);
> +       if (!clk_data)
> +               return;
> +
> +       num_base_ids = of_clk_get_parent_count(np);
> +
> +       base_ids = kcalloc(num_base_ids, sizeof(int), GFP_KERNEL);
> +       if (!base_ids) {
> +               kfree(clk_data);
> +               return;
> +       }
> +
> +       clk_data->base_ids = base_ids;
> +       clk_data->num_base_ids = num_base_ids;
> +
> +       for (i = 0; i < num_base_ids; i++) {
> +               struct clk *clk = of_clk_get(np, i);
> +               if (IS_ERR(clk)) {
> +                       pr_warn("%s: failed to get clock at idx %d\n",
> +                               __func__, i);
> +                       continue;
> +               }
> +
> +               parent = __clk_get_name(clk);
> +               base_clk_id = of_clk_get_index(np, i);
> +
> +               clk_data->base_ids[i] = base_clk_id;
> +               lpc18xx_ccu_register_branch_clks(reg_base, base_clk_id,
> +                                                parent);

Thanks for sending V3. This driver is getting close!

So the main thing I don't understand is why you do not encode the CGU
clock parent string names into this CCU driver. If I understand your
approach correctly, you do the following in lpc18xx_ccu_init:

1) count the number of parent clocks (ostensibly CGU clocks)
2) iterate through all of those CGU clocks, extracting a base_id value
(loop #1)
3) using this base_id as a key you walk through an array in the CCU
driver trying to find a matching base_id value
(loop #2)
4) after finding the corresponding CCU clocks you get the parent clock
with of_clk_get
5) using of_clk_get you fetch its name with __clk_get_name
6) you pass this parent name into a fairly typical looking registration
function

Assuming I got all of that right, I hope we can simplify it
considerably.

You already have an array of CCU clock information in this driver,
clk_branches[]. Why not encode the parent string name here? This would
involve adding a "parent_name" member to struct lpc18xx_clk_branch.

Doing the above, your O(n^2)-ish registration function becomes O(n):

1) iterate through the array of the CCU clocks (clk_branchs[])
2) register them
3) profit

I'm starting to think any reference to base_id is sign that things are
wrong in your driver. I am unconvinced that you need to "share" this
base_id across CGU and CCU drivers in the way you do. If I'm wrong
please help me to understand.

As a wild thought, if you do not want to encode parent string names into
this driver, have you tried to use the clock-names property in the CCU
blob? You do not need clock-output-names in the CGU blob either. But
this is just an idea. It is far for straightforward for you t encode the
parent names in your clk_branches[] array.

Thanks,
Mike
