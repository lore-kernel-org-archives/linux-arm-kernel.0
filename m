From: djkurtz@chromium.org (Daniel Kurtz)
Date: Wed, 1 Jul 2015 23:22:35 +0800
Subject: [PATCH v2 4/4] clk: mediatek: Add USB clock support in MT8173
 APMIXEDSYS
In-Reply-To: <CAGS+omBRAJVN3uPYn9YdKZ3VBj61c-rpY_cNgnK6x9U0uJBPYw@mail.gmail.com>
References: <1435633127-31952-1-git-send-email-jamesjj.liao@mediatek.com>
 <1435633127-31952-5-git-send-email-jamesjj.liao@mediatek.com>
 <CAGS+omBRAJVN3uPYn9YdKZ3VBj61c-rpY_cNgnK6x9U0uJBPYw@mail.gmail.com>
Message-ID: <CAGS+omBsu3zkBf0C_QECBP7NShFhkMih36z1vynvVQ5wCLfZ8w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi James,

This looks like 3 separate gate clocks in a chain, with a timing
constraint: USB_LPF must be enabled 100 us after USB_TX.

  26MHz--> [GATE] --USB_TX--> [LPF] --USB_LPF--> [GATE] --USB_OUT-->
            ^                  ^                  ^
            +--------------+   |                  |
AP_PLL_CON2.REF2USB_TX_EN -+   |                  |
AP_PLL_CON2.REF2USB_TX_LPF_EN -+                  |
AP_PLL_CON2.REF2USB_TX_OUT_EN --------------------+


I think we can model the gate parts using a proper clock tree model
and the existing clock gate semantics.
I'm not sure the best way to model the delay; but in theory that could
be handled by the clock user (USB driver).

-Dan

On Wed, Jul 1, 2015 at 11:22 PM, Daniel Kurtz <djkurtz@chromium.org> wrote:
> Hi James,
>
> This looks like 3 separate gate clocks in a chain, with a timing constraint:
> USB_LPF must be enabled 100 us after USB_TX.
>
>   26MHz--> [GATE] --USB_TX--> [LPF] --USB_LPF--> [GATE] --USB_OUT-->
>             ^                  ^                  ^
>             +--------------+   |                  |
> AP_PLL_CON2.REF2USB_TX_EN -+   |                  |
> AP_PLL_CON2.REF2USB_TX_LPF_EN -+                  |
> AP_PLL_CON2.REF2USB_TX_OUT_EN --------------------+
>
>
> I think we can model the gate parts using a proper clock tree model and the
> existing clock gate semantics.
> I'm not sure the best way to model the delay; but in theory that could be
> handled by the clock user (USB driver).
>
> -Dan
>
> On Tue, Jun 30, 2015 at 10:58 AM, James Liao <jamesjj.liao@mediatek.com>
> wrote:
>> Add REF2USB_TX clock support into MT8173 APMIXEDSYS. This clock
>> is needed by USB 3.0.
>>
>> Signed-off-by: James Liao <jamesjj.liao@mediatek.com>
>> ---
>>  drivers/clk/mediatek/clk-mt8173.c      | 143
>> +++++++++++++++++++++++++++++++++
>>  drivers/clk/mediatek/clk-pll.c         |   7 +-
>>  include/dt-bindings/clock/mt8173-clk.h |   3 +-
>>  3 files changed, 146 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/clk/mediatek/clk-mt8173.c
>> b/drivers/clk/mediatek/clk-mt8173.c
>> index 75be757..333b6af 100644
>> --- a/drivers/clk/mediatek/clk-mt8173.c
>> +++ b/drivers/clk/mediatek/clk-mt8173.c
>> @@ -12,6 +12,7 @@
>>   * GNU General Public License for more details.
>>   */
>>
>> +#include <linux/delay.h>
>>  #include <linux/of.h>
>>  #include <linux/of_address.h>
>>  #include <linux/slab.h>
>> @@ -968,6 +969,141 @@ static void __init mtk_pericfg_init(struct
>> device_node *node)
>>  }
>>  CLK_OF_DECLARE(mtk_pericfg, "mediatek,mt8173-pericfg", mtk_pericfg_init);
>>
>> +#define REF2USB_TX_EN          BIT(0)
>> +#define REF2USB_TX_LPF_EN      BIT(1)
>> +#define REF2USB_TX_OUT_EN      BIT(2)
>> +#define REF2USB_EN_MASK                (REF2USB_TX_EN | REF2USB_TX_LPF_EN
>> | \
>> +                                REF2USB_TX_OUT_EN)
>> +
>> +struct mtk_ref2usb_tx {
>> +       struct clk_hw   hw;
>> +       void __iomem    *base_addr;
>> +};
>> +
>> +static inline struct mtk_ref2usb_tx *to_mtk_ref2usb_tx(struct clk_hw *hw)
>> +{
>> +       return container_of(hw, struct mtk_ref2usb_tx, hw);
>> +}
>> +
>> +static int mtk_ref2usb_tx_is_prepared(struct clk_hw *hw)
>> +{
>> +       struct mtk_ref2usb_tx *tx = to_mtk_ref2usb_tx(hw);
>> +
>> +       return (readl(tx->base_addr) & REF2USB_EN_MASK) ==
>> REF2USB_EN_MASK;
>> +}
>> +
>> +static int mtk_ref2usb_tx_prepare(struct clk_hw *hw)
>> +{
>> +       struct mtk_ref2usb_tx *tx = to_mtk_ref2usb_tx(hw);
>> +       u32 val;
>> +
>> +       val = readl(tx->base_addr);
>> +
>> +       val |= REF2USB_TX_EN;
>> +       writel(val, tx->base_addr);
>> +       udelay(100);
>> +
>> +       val |= REF2USB_TX_LPF_EN;
>> +       writel(val, tx->base_addr);
>> +
>> +       val |= REF2USB_TX_OUT_EN;
>> +       writel(val, tx->base_addr);
>> +
>> +       return 0;
>> +}
>> +
>> +static void mtk_ref2usb_tx_unprepare(struct clk_hw *hw)
>> +{
>> +       struct mtk_ref2usb_tx *tx = to_mtk_ref2usb_tx(hw);
>> +       u32 val;
>> +
>> +       val = readl(tx->base_addr);
>> +       val &= ~REF2USB_EN_MASK;
>> +       writel(val, tx->base_addr);
>> +}
>> +
>> +static const struct clk_ops mtk_ref2usb_tx_ops = {
>> +       .is_prepared    = mtk_ref2usb_tx_is_prepared,
>> +       .prepare        = mtk_ref2usb_tx_prepare,
>> +       .unprepare      = mtk_ref2usb_tx_unprepare,
>> +};
>> +
>> +static struct clk *mtk_clk_register_ref2usb_tx(const char *name,
>> +                       const char *parent_name, void __iomem *reg)
>> +{
>> +       struct mtk_ref2usb_tx *tx;
>> +       struct clk_init_data init = {};
>> +       struct clk *clk;
>> +
>> +       tx = kzalloc(sizeof(*tx), GFP_KERNEL);
>> +       if (!tx)
>> +               return ERR_PTR(-ENOMEM);
>> +
>> +       tx->base_addr = reg;
>> +       tx->hw.init = &init;
>> +
>> +       init.name = name;
>> +       init.ops = &mtk_ref2usb_tx_ops;
>> +       init.parent_names = &parent_name;
>> +       init.num_parents = 1;
>> +
>> +       clk = clk_register(NULL, &tx->hw);
>> +
>> +       if (IS_ERR(clk)) {
>> +               pr_err("Failed to register clk %s: %ld\n", name,
>> PTR_ERR(clk));
>> +               kfree(tx);
>> +       }
>> +
>> +       return clk;
>> +}
>> +
>> +struct mtk_apmixed_ex {
>> +       int id;
>> +       const char *name;
>> +       const char *parent;
>> +       u32 reg_ofs;
>> +};
>> +
>> +#define APMIXED_EX(_id, _name, _parent, _reg_ofs) {                    \
>> +               .id = _id,                                              \
>> +               .name = _name,                                          \
>> +               .parent = _parent,                                      \
>> +               .reg_ofs = _reg_ofs,                                    \
>> +       }
>> +
>> +static const struct mtk_apmixed_ex apmixed_ex[] = {
>> +       APMIXED_EX(CLK_APMIXED_REF2USB_TX, "ref2usb_tx", "clk26m", 0x8),
>> +};
>> +
>> +static void __init mtk_clk_register_apmixedsys_special(struct device_node
>> *node,
>> +                       struct clk_onecell_data *clk_data)
>> +{
>> +       void __iomem *base;
>> +       struct clk *clk;
>> +       int i;
>> +
>> +       base = of_iomap(node, 0);
>> +       if (!base) {
>> +               pr_err("%s(): ioremap failed\n", __func__);
>> +               return;
>> +       }
>> +
>> +       for (i = 0; i < ARRAY_SIZE(apmixed_ex); i++) {
>> +               const struct mtk_apmixed_ex *ape = &apmixed_ex[i];
>> +
>> +               clk = mtk_clk_register_ref2usb_tx(ape->name, ape->parent,
>> +                                                       base +
>> ape->reg_ofs);
>> +
>> +               if (IS_ERR(clk)) {
>> +                       pr_err("Failed to register clk %s: %ld\n",
>> ape->name,
>> +                                       PTR_ERR(clk));
>> +                       continue;
>> +               }
>> +
>> +               clk_data->clks[CLK_APMIXED_REF2USB_TX] = clk;
>> +       }
>> +}
>> +
>>  #define MT8173_PLL_FMAX                (3000UL * MHZ)
>>
>>  #define CON0_MT8173_RST_BAR    BIT(24)
>> @@ -1010,12 +1146,19 @@ static const struct mtk_pll_data plls[] = {
>>  static void __init mtk_apmixedsys_init(struct device_node *node)
>>  {
>>         struct clk_onecell_data *clk_data;
>> +       int r;
>>
>>         mt8173_pll_clk_data = clk_data =
>> mtk_alloc_clk_data(CLK_APMIXED_NR_CLK);
>>         if (!clk_data)
>>                 return;
>>
>>         mtk_clk_register_plls(node, plls, ARRAY_SIZE(plls), clk_data);
>> +       mtk_clk_register_apmixedsys_special(node, clk_data);
>> +
>> +       r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
>> +       if (r)
>> +               pr_err("%s(): could not register clock provider: %d\n",
>> +                       __func__, r);
>>
>>         mtk_clk_enable_critical();
>>  }
>> diff --git a/drivers/clk/mediatek/clk-pll.c
>> b/drivers/clk/mediatek/clk-pll.c
>> index 44409e9..813f0c7 100644
>> --- a/drivers/clk/mediatek/clk-pll.c
>> +++ b/drivers/clk/mediatek/clk-pll.c
>> @@ -302,7 +302,7 @@ void __init mtk_clk_register_plls(struct device_node
>> *node,
>>                 const struct mtk_pll_data *plls, int num_plls, struct
>> clk_onecell_data *clk_data)
>>  {
>>         void __iomem *base;
>> -       int r, i;
>> +       int i;
>>         struct clk *clk;
>>
>>         base = of_iomap(node, 0);
>> @@ -324,9 +324,4 @@ void __init mtk_clk_register_plls(struct device_node
>> *node,
>>
>>                 clk_data->clks[pll->id] = clk;
>>         }
>> -
>> -       r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
>> -       if (r)
>> -               pr_err("%s(): could not register clock provider: %d\n",
>> -                       __func__, r);
>>  }
>> diff --git a/include/dt-bindings/clock/mt8173-clk.h
>> b/include/dt-bindings/clock/mt8173-clk.h
>> index 6ce88bf..7b7c555 100644
>> --- a/include/dt-bindings/clock/mt8173-clk.h
>> +++ b/include/dt-bindings/clock/mt8173-clk.h
>> @@ -172,7 +172,8 @@
>>  #define CLK_APMIXED_APLL2              12
>>  #define CLK_APMIXED_LVDSPLL            13
>>  #define CLK_APMIXED_MSDCPLL2           14
>> -#define CLK_APMIXED_NR_CLK             15
>> +#define CLK_APMIXED_REF2USB_TX         15
>> +#define CLK_APMIXED_NR_CLK             16
>>
>>  /* INFRA_SYS */
>>
>> --
>> 1.8.1.1.dirty
>>
>
