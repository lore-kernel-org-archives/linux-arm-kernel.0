From: mturquette@linaro.org (Mike Turquette)
Date: Thu, 30 May 2013 12:42:27 -0700
Subject: [PATCHv4 3/6] ARM: socfpga: Add support to gate peripheral clocks
In-Reply-To: <1369410080-436-3-git-send-email-dinguyen@altera.com>
References: <1369410080-436-1-git-send-email-dinguyen@altera.com>
 <1369410080-436-3-git-send-email-dinguyen@altera.com>
Message-ID: <20130530194227.4470.3741@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting dinguyen at altera.com (2013-05-24 08:41:17)
> From: Dinh Nguyen <dinguyen@altera.com>
> 
> Add support to gate the clocks that directly feed peripherals. For clocks
> with multiple parents, add the ability to determine the correct parent,
> and also set parents. Also add support to calculate and set the clocks'
> rate.
> 
> Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
> Reviewed-by: Pavel Machek <pavel@denx.de>
> CC: Mike Turquette <mturquette@linaro.org>
> CC: Arnd Bergmann <arnd@arndb.de>
> CC: Olof Johansson <olof@lixom.net>
> Cc: Pavel Machek <pavel@denx.de>
> CC: <linux@arm.linux.org.uk>
> 

Looks OK to me.  Lots of conditionals in socfpga_gate_clk_init, which
some day might be better to break out into separate clk types.  Not a
big deal for now:

Acked-by: Mike Turquette <mturquette@linaro.org>

> v3:
> - Addressed comments from Pavel
> 
> v2:
> - Fix space/indent errors
> - Add streq for strcmp == 0
> ---
>  drivers/clk/socfpga/clk.c |  194 ++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 185 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/clk/socfpga/clk.c b/drivers/clk/socfpga/clk.c
> index bd11315..5bb848c 100644
> --- a/drivers/clk/socfpga/clk.c
> +++ b/drivers/clk/socfpga/clk.c
> @@ -24,15 +24,17 @@
>  #include <linux/of.h>
>  
>  /* Clock Manager offsets */
> -#define CLKMGR_CTRL    0x0
> -#define CLKMGR_BYPASS 0x4
> +#define CLKMGR_CTRL    0x0
> +#define CLKMGR_BYPASS  0x4
> +#define CLKMGR_L4SRC   0x70
> +#define CLKMGR_PERPLL_SRC      0xAC
>  
>  /* Clock bypass bits */
> -#define MAINPLL_BYPASS (1<<0)
> -#define SDRAMPLL_BYPASS (1<<1)
> -#define SDRAMPLL_SRC_BYPASS (1<<2)
> -#define PERPLL_BYPASS (1<<3)
> -#define PERPLL_SRC_BYPASS (1<<4)
> +#define MAINPLL_BYPASS         (1<<0)
> +#define SDRAMPLL_BYPASS                (1<<1)
> +#define SDRAMPLL_SRC_BYPASS    (1<<2)
> +#define PERPLL_BYPASS          (1<<3)
> +#define PERPLL_SRC_BYPASS      (1<<4)
>  
>  #define SOCFPGA_PLL_BG_PWRDWN          0
>  #define SOCFPGA_PLL_EXT_ENA            1
> @@ -41,6 +43,17 @@
>  #define SOCFPGA_PLL_DIVF_SHIFT 3
>  #define SOCFPGA_PLL_DIVQ_MASK          0x003F0000
>  #define SOCFPGA_PLL_DIVQ_SHIFT 16
> +#define SOCFGPA_MAX_PARENTS    3
> +
> +#define SOCFPGA_L4_MP_CLK              "l4_mp_clk"
> +#define SOCFPGA_L4_SP_CLK              "l4_sp_clk"
> +#define SOCFPGA_NAND_CLK               "nand_clk"
> +#define SOCFPGA_NAND_X_CLK             "nand_x_clk"
> +#define SOCFPGA_MMC_CLK                        "mmc_clk"
> +#define SOCFPGA_DB_CLK                 "gpio_db_clk"
> +
> +#define div_mask(width)        ((1 << (width)) - 1)
> +#define streq(a, b) (strcmp((a), (b)) == 0)
>  
>  extern void __iomem *clk_mgr_base_addr;
>  
> @@ -49,6 +62,9 @@ struct socfpga_clk {
>         char *parent_name;
>         char *clk_name;
>         u32 fixed_div;
> +       void __iomem *div_reg;
> +       u32 width;      /* only valid if div_reg != 0 */
> +       u32 shift;      /* only valid if div_reg != 0 */
>  };
>  #define to_socfpga_clk(p) container_of(p, struct socfpga_clk, hw.hw)
>  
> @@ -132,8 +148,9 @@ static __init struct clk *socfpga_clk_init(struct device_node *node,
>  
>         socfpga_clk->hw.hw.init = &init;
>  
> -       if (strcmp(clk_name, "main_pll") || strcmp(clk_name, "periph_pll") ||
> -                       strcmp(clk_name, "sdram_pll")) {
> +       if (streq(clk_name, "main_pll") ||
> +               streq(clk_name, "periph_pll") ||
> +               streq(clk_name, "sdram_pll")) {
>                 socfpga_clk->hw.bit_idx = SOCFPGA_PLL_EXT_ENA;
>                 clk_pll_ops.enable = clk_gate_ops.enable;
>                 clk_pll_ops.disable = clk_gate_ops.disable;
> @@ -148,6 +165,159 @@ static __init struct clk *socfpga_clk_init(struct device_node *node,
>         return clk;
>  }
>  
> +static u8 socfpga_clk_get_parent(struct clk_hw *hwclk)
> +{
> +       u32 l4_src;
> +       u32 perpll_src;
> +
> +       if (streq(hwclk->init->name, SOCFPGA_L4_MP_CLK)) {
> +               l4_src = readl(clk_mgr_base_addr + CLKMGR_L4SRC);
> +               return l4_src &= 0x1;
> +       }
> +       if (streq(hwclk->init->name, SOCFPGA_L4_SP_CLK)) {
> +               l4_src = readl(clk_mgr_base_addr + CLKMGR_L4SRC);
> +               return !!(l4_src & 2);
> +       }
> +
> +       perpll_src = readl(clk_mgr_base_addr + CLKMGR_PERPLL_SRC);
> +       if (streq(hwclk->init->name, SOCFPGA_MMC_CLK))
> +               return perpll_src &= 0x3;
> +       if (streq(hwclk->init->name, SOCFPGA_NAND_CLK) ||
> +                       streq(hwclk->init->name, SOCFPGA_NAND_X_CLK))
> +                       return (perpll_src >> 2) & 3;
> +
> +       /* QSPI clock */
> +       return (perpll_src >> 4) & 3;
> +
> +}
> +
> +static int socfpga_clk_set_parent(struct clk_hw *hwclk, u8 parent)
> +{
> +       u32 src_reg;
> +
> +       if (streq(hwclk->init->name, SOCFPGA_L4_MP_CLK)) {
> +               src_reg = readl(clk_mgr_base_addr + CLKMGR_L4SRC);
> +               src_reg &= ~0x1;
> +               src_reg |= parent;
> +               writel(src_reg, clk_mgr_base_addr + CLKMGR_L4SRC);
> +       } else if (streq(hwclk->init->name, SOCFPGA_L4_SP_CLK)) {
> +               src_reg = readl(clk_mgr_base_addr + CLKMGR_L4SRC);
> +               src_reg &= ~0x2;
> +               src_reg |= (parent << 1);
> +               writel(src_reg, clk_mgr_base_addr + CLKMGR_L4SRC);
> +       } else {
> +               src_reg = readl(clk_mgr_base_addr + CLKMGR_PERPLL_SRC);
> +               if (streq(hwclk->init->name, SOCFPGA_MMC_CLK)) {
> +                       src_reg &= ~0x3;
> +                       src_reg |= parent;
> +               } else if (streq(hwclk->init->name, SOCFPGA_NAND_CLK) ||
> +                       streq(hwclk->init->name, SOCFPGA_NAND_X_CLK)) {
> +                       src_reg &= ~0xC;
> +                       src_reg |= (parent << 2);
> +               } else {/* QSPI clock */
> +                       src_reg &= ~0x30;
> +                       src_reg |= (parent << 4);
> +               }
> +               writel(src_reg, clk_mgr_base_addr + CLKMGR_PERPLL_SRC);
> +       }
> +
> +       return 0;
> +}
> +
> +static unsigned long socfpga_clk_recalc_rate(struct clk_hw *hwclk,
> +       unsigned long parent_rate)
> +{
> +       struct socfpga_clk *socfpgaclk = to_socfpga_clk(hwclk);
> +       u32 div = 1, val;
> +
> +       if (socfpgaclk->fixed_div)
> +               div = socfpgaclk->fixed_div;
> +       else if (socfpgaclk->div_reg) {
> +               val = readl(socfpgaclk->div_reg) >> socfpgaclk->shift;
> +               val &= div_mask(socfpgaclk->width);
> +               if (streq(hwclk->init->name, SOCFPGA_DB_CLK))
> +                       div = val + 1;
> +               else
> +                       div = (1 << val);
> +       }
> +
> +       return parent_rate / div;
> +}
> +
> +static struct clk_ops gateclk_ops = {
> +       .recalc_rate = socfpga_clk_recalc_rate,
> +       .get_parent = socfpga_clk_get_parent,
> +       .set_parent = socfpga_clk_set_parent,
> +};
> +
> +static void __init socfpga_gate_clk_init(struct device_node *node,
> +       const struct clk_ops *ops)
> +{
> +       u32 clk_gate[2];
> +       u32 div_reg[3];
> +       u32 fixed_div;
> +       struct clk *clk;
> +       struct socfpga_clk *socfpga_clk;
> +       const char *clk_name = node->name;
> +       const char *parent_name[SOCFGPA_MAX_PARENTS];
> +       struct clk_init_data init;
> +       int rc;
> +       int i = 0;
> +
> +       socfpga_clk = kzalloc(sizeof(*socfpga_clk), GFP_KERNEL);
> +       if (WARN_ON(!socfpga_clk))
> +               return;
> +
> +       rc = of_property_read_u32_array(node, "clk-gate", clk_gate, 2);
> +       if (rc)
> +               clk_gate[0] = 0;
> +
> +       if (clk_gate[0]) {
> +               socfpga_clk->hw.reg = clk_mgr_base_addr + clk_gate[0];
> +               socfpga_clk->hw.bit_idx = clk_gate[1];
> +
> +               gateclk_ops.enable = clk_gate_ops.enable;
> +               gateclk_ops.disable = clk_gate_ops.disable;
> +       }
> +
> +       rc = of_property_read_u32(node, "fixed-divider", &fixed_div);
> +       if (rc)
> +               socfpga_clk->fixed_div = 0;
> +       else
> +               socfpga_clk->fixed_div = fixed_div;
> +
> +       rc = of_property_read_u32_array(node, "div-reg", div_reg, 3);
> +       if (!rc) {
> +               socfpga_clk->div_reg = clk_mgr_base_addr + div_reg[0];
> +               socfpga_clk->shift = div_reg[1];
> +               socfpga_clk->width = div_reg[2];
> +       } else {
> +               socfpga_clk->div_reg = 0;
> +       }
> +
> +       of_property_read_string(node, "clock-output-names", &clk_name);
> +
> +       init.name = clk_name;
> +       init.ops = ops;
> +       init.flags = 0;
> +       while (i < SOCFGPA_MAX_PARENTS && (parent_name[i] =
> +                       of_clk_get_parent_name(node, i)) != NULL)
> +               i++;
> +
> +       init.parent_names = parent_name;
> +       init.num_parents = i;
> +       socfpga_clk->hw.hw.init = &init;
> +
> +       clk = clk_register(NULL, &socfpga_clk->hw.hw);
> +       if (WARN_ON(IS_ERR(clk))) {
> +               kfree(socfpga_clk);
> +               return;
> +       }
> +       rc = of_clk_add_provider(node, of_clk_src_simple_get, clk);
> +       if (WARN_ON(rc))
> +               return;
> +}
> +
>  static void __init socfpga_pll_init(struct device_node *node)
>  {
>         socfpga_clk_init(node, &clk_pll_ops);
> @@ -160,6 +330,12 @@ static void __init socfpga_periph_init(struct device_node *node)
>  }
>  CLK_OF_DECLARE(socfpga_periph, "altr,socfpga-perip-clk", socfpga_periph_init);
>  
> +static void __init socfpga_gate_init(struct device_node *node)
> +{
> +       socfpga_gate_clk_init(node, &gateclk_ops);
> +}
> +CLK_OF_DECLARE(socfpga_gate, "altr,socfpga-gate-clk", socfpga_gate_init);
> +
>  void __init socfpga_init_clocks(void)
>  {
>         struct clk *clk;
> -- 
> 1.7.9.5
