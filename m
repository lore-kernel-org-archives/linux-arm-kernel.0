From: mturquette@linaro.org (Mike Turquette)
Date: Thu, 09 Jan 2014 21:44:24 -0800
Subject: [PATCH v4 02/15] clk: Allow drivers to pass in a regmap
In-Reply-To: <52CE055C.5030103@codeaurora.org>
References: <1387847559-18330-1-git-send-email-sboyd@codeaurora.org>
 <1387847559-18330-3-git-send-email-sboyd@codeaurora.org>
 <20140109015158.7168.60274@quantum> <52CE055C.5030103@codeaurora.org>
Message-ID: <20140110054424.7168.46289@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Stephen Boyd (2014-01-08 18:11:40)
> On 01/08/14 17:51, Mike Turquette wrote:
> > Quoting Stephen Boyd (2013-12-23 17:12:26)
> >> Add support to the clock core so that drivers can pass in a
> >> regmap. If no regmap is specified try to query the device that's
> >> registering the clock for its regmap. This should allow drivers
> >> to use the core regmap helpers. This is based on a similar design
> >> in the regulator framework.
> >>
> >> Cc: Mark Brown <broonie@kernel.org>
> >> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> >> ---
> >>  drivers/clk/clk.c            | 8 ++++++++
> >>  include/linux/clk-provider.h | 7 +++++++
> >>  2 files changed, 15 insertions(+)
> >>
> >> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> >> index 9ad7b71..5e71f5c 100644
> >> --- a/drivers/clk/clk.c
> >> +++ b/drivers/clk/clk.c
> >> @@ -20,6 +20,7 @@
> >>  #include <linux/device.h>
> >>  #include <linux/init.h>
> >>  #include <linux/sched.h>
> >> +#include <linux/regmap.h>
> >>  
> >>  static DEFINE_SPINLOCK(enable_lock);
> >>  static DEFINE_MUTEX(prepare_lock);
> >> @@ -1834,6 +1835,13 @@ static int _clk_register(struct device *dev, struct clk_hw *hw, struct clk *clk)
> >>         clk->num_parents = hw->init->num_parents;
> >>         hw->clk = clk;
> >>  
> >> +       if (hw->init->regmap)
> >> +               hw->regmap = hw->init->regmap;
> > Hi Stephen,
> >
> > The whole series looks good to me except for the placement of the regmap
> > details inside struct clk_hw. That structure exists only to hide struct
> > clk from the hardware-specific clock structure and I'd not like to set
> > the precedent of shoving per-clock data into it.
> >
> > As an alternative, how about finding a way to put these per-clock regmap
> > details into the hardware-specific clock structure? I understand that
> > you want to make these ops available to others, which is why they are in
> > the public struct clk_hw. I'm just wondering if that is the right way to
> > do it...
> 
> The regulator framework has gone this way. It seemed like a similar
> approach in the clock framework would be the right way to go too.
> 
> >
> > Patch #3 illustrates the sort of struct-member-creep that worries me.
> > What is to stop someone from putting "unsigned int divider_reg" or
> > "unsigned int mux_reg", and then the thing just keeps growing.
> >
> 
> I see two ways forward if you don't want these members in struct clk_hw.
> 
> 1) Inheritance: struct clk_regmap wrapper struct and
> clk_register_regmap() and devm_clk_register_regmap() and then another
> wrapper struct around that.
> 
>  example:
> 
> struct clk_regmap {
>         struct clk_hw hw;
>         struct regmap *regmap;
>         unsigned int enable_reg;
>         unsigned int enable_mask;
>         bool enable_is_inverted;
> };
> 
> struct clk_branch {
>         u32     hwcg_reg;
>         u32     halt_reg;
>         u8      hwcg_bit;
>         u8      halt_bit;
>         u8      halt_check;
> 
>         struct clk_regmap       clkr;
> };
> 
> static struct clk_branch gsbi1_uart_clk = {
>         .halt_reg = 0x2fcc,
>         .halt_bit = 10,
>         .clkr = {
>                 .enable_reg = 0x29d4,
>                 .enable_mask = BIT(9),
>                 .hw.init = &(struct clk_init_data){
>                         .name = "gsbi1_uart_clk",
>                         .parent_names = (const char *[]){
>                                 "gsbi1_uart_src",
>                         },
>                         .num_parents = 1,
>                         .ops = &clk_branch_ops,
>                         .flags = CLK_SET_RATE_PARENT,
>                 },
>         },
> };

If we're going to use these wrappers, why make it regmap specific? The
struct clk_desc patches[1][2] can achieve this, but in a more generic
way.

> 
> 
> 2) Interfaces: Add a void *data in struct clk_hw that can point to
> whatever I want and still have the same clk_regmap_register() and
> devm_clk_regmap_register()
> 
> Example:
> 
> struct clk_hw {
>         struct clk *clk;
>         const struct clk_init_data *init;
>         void *data;
> };
> 
> struct clk_regmap {
>         struct regmap *regmap;
>         unsigned int enable_reg;
>         unsigned int enable_mask;
>         bool enable_is_inverted;
> };
> 
> struct clk_branch {
>         u32     hwcg_reg;
>         u32     halt_reg;
>         u8      hwcg_bit;
>         u8      halt_bit;
>         u8      halt_check;
> 
>         struct clk_hw;
> };
> 
> static struct clk_branch gsbi1_uart_clk = {
>         .halt_reg = 0x2fcc,
>         .halt_bit = 10,
>         .hw = {
>                 .data = &(struct clk_regmap){
>                         .enable_reg = 0x29d4,
>                         .enable_mask = BIT(9),
>                  };
>                 .init = &(struct clk_init_data){
>                         .name = "gsbi1_uart_clk",
>                         .parent_names = (const char *[]){
>                                 "gsbi1_uart_src",
>                         },
>                         .num_parents = 1,
>                         .ops = &clk_branch_ops,
>                         .flags = CLK_SET_RATE_PARENT,
>                 },
>         },
> };
> 
> I guess option 2 is less likely given your comment about clk_hw being
> nothing more than a traversal mechanism.

Instead of private data, how about a .register() callback function that
can point to anything you like? The clk_desc patches implement this and
it would suffice for registering regmap ops or anything else, without
polluting struct clk_hw.

[1] http://www.spinics.net/lists/linux-omap/msg101822.html
[2] http://www.spinics.net/lists/linux-omap/msg101698.html

So you could statically define gsbi1_uart_clk with:

static struct clk_branch_desc gsbi1_uart_clk_desc = {
	.halt_reg = 0x2fcc,
	.halt_bit = 10,
	.enable_reg = 0x29d4,
	.enable_mask = BIT(9),
	.desc = {
		.name = "gsbi1_uart_clk",
		.parent_names = (const char *[]){
			"gsbi1_uart_src",
		},
		.num_parents = 1,
		.ops = &clk_branch_ops,
		.flags = CLK_SET_RATE_PARENT,
	},
};

And then register it with:

clk_register_desc(NULL, &gsbi1_uart_clk_desc.desc);

This is very analogous to the way that you use use &gsbi1_uart_clk.hw
but it is more generic and also doesn't pollute clk_hw any further. I
also think your static data is quite a bit prettier using this method.

Thoughts?

Regards,
Mike

> 
> -- 
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> hosted by The Linux Foundation
> 
