From: djkurtz@chromium.org (Daniel Kurtz)
Date: Fri, 3 Jul 2015 14:08:13 +0800
Subject: [PATCH v2 3/4] clk: mediatek: Add subsystem clocks of MT8173
In-Reply-To: <1435900531.3526.41.camel@mtksdaap41>
References: <1435633127-31952-1-git-send-email-jamesjj.liao@mediatek.com>
 <1435633127-31952-4-git-send-email-jamesjj.liao@mediatek.com>
 <CAGS+omDJtTcVvcL925LFxUSeunWONp188OOP-H42uQ=6BaY9FQ@mail.gmail.com>
 <1435900531.3526.41.camel@mtksdaap41>
Message-ID: <CAGS+omCVmdaW6ksn7aY5jOrZtYDu0kvSnxX2mnUJQCToaM8LZg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 3, 2015 at 1:15 PM, James Liao <jamesjj.liao@mediatek.com> wrote:
> On Wed, 2015-07-01 at 22:54 +0800, Daniel Kurtz wrote:
>> On Tue, Jun 30, 2015 at 10:58 AM, James Liao <jamesjj.liao@mediatek.com> wrote:
>> >
>> > +static struct mtk_gate_regs cg_regs_4_8_0 = {
>>
>> These should all be:
>>
>> static const struct mtk_gate_regs ...
>
> OK, I'll fix it.
>
>> > +       .set_ofs = 0x0004,
>> > +       .clr_ofs = 0x0008,
>> > +       .sta_ofs = 0x0000,
>> > +};
>> > +
>> > +#define GATE_IMG(_id, _name, _parent, _shift) {                        \
>> > +               .id = _id,                                      \
>> > +               .name = _name,                                  \
>> > +               .parent_name = _parent,                         \
>> > +               .regs = &cg_regs_4_8_0,                         \
>> > +               .shift = _shift,                                \
>> > +               .ops = &mtk_clk_gate_ops_setclr,                \
>> > +       }
>> > +
>> > +static struct mtk_gate img_clks[] __initdata = {
>>
>> These should all be:
>>
>> static const ... __initconst = {
>
> OK, I'll fix it.
>
>> > +
>> > +static void __init mtk_imgsys_init(struct device_node *node)
>> > +{
>> > +       struct clk_onecell_data *clk_data;
>> > +       void __iomem *base;
>>
>> I don't think you need base for any of these.
>> mtk_clk_register_gates() will use syscon_node_to_regmap() to lookup
>> the regmap by itself.
>
> OK, I'll remove it.
>
>> > +       int r;
>> > +
>> > +       base = of_iomap(node, 0);
>> > +       if (!base) {
>> > +               pr_err("%s(): ioremap failed\n", __func__);
>> > +               return;
>> > +       }
>> > +
>> > +       clk_data = mtk_alloc_clk_data(CLK_IMG_NR_CLK);
>>
>> Unrelated to this patch, but:
>> I think each clock node should statically declare its
>> clk_onecell_data, and pass it to mtk_alloc_clk_data().
>> mtk_alloc_clk_data() should then just allocate and initialize the clks array.
>
> Is there any different from allocating clk_onecell_data and clks arary
> dynamically?

I generally believe it is always a bit better to statically allocate
memory where possible.  There would then be slightly less to do at
runtime (in this case on the critical boot path), and less churn on
the heap.  Each individual allocation probably doesn't matter very
much, but it adds up.

>> >  /* APMIXED_SYS */
>> >
>> > -#define CLK_APMIXED_ARMCA15PLL 1
>> > -#define CLK_APMIXED_ARMCA7PLL  2
>> > +#define CLK_APMIXED_ARMCA15PLL         1
>> > +#define CLK_APMIXED_ARMCA7PLL          2
>> >  #define CLK_APMIXED_MAINPLL            3
>> >  #define CLK_APMIXED_UNIVPLL            4
>> >  #define CLK_APMIXED_MMPLL              5
>> > @@ -232,4 +232,91 @@
>> >  #define CLK_PERI_UART3_SEL             39
>> >  #define CLK_PERI_NR_CLK                        40
>>
>> Why do we count up from 1 instead of 0?
>> This means that for each clock-controller:
>>   clk_onecell_data->clk[0] == ERR_PTR(-ENOENT)
>
> It's a legacy implementation. I think it doesn't matter for function or
> size in this implementation. We may change clock index to start from 0
> in next SoC clock implementation.

Ok.  I don't think it matters a lot.  Just curious.

Thanks!
-Dan
