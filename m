From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Fri, 29 May 2015 17:58:12 +0200
Subject: [PATCH 1/3] clk: mux: Add regmap support for simple mux
In-Reply-To: <CAGhQ9VysJ4O2uOc4LxdN_bFY42fP=ugLp=Sh2rtFEaaavf3yOQ@mail.gmail.com>
References: <1432838508-5184-1-git-send-email-matthias.bgg@gmail.com>
 <1432838508-5184-2-git-send-email-matthias.bgg@gmail.com>
 <CAGhQ9VysJ4O2uOc4LxdN_bFY42fP=ugLp=Sh2rtFEaaavf3yOQ@mail.gmail.com>
Message-ID: <CABuKBe+2xU=wTezgi6c=A1=2phbq+Xtu2ST=ThETt21OVf-P3A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-05-29 8:57 GMT+02:00 Joachim  Eastwood <manabian@gmail.com>:
> Hi Matthias,
>
> On 28 May 2015 at 20:41, Matthias Brugger <matthias.bgg@gmail.com> wrote:
>> Some devices like SoCs from Mediatek need to use the clock muxes
>> through a regmap interface.
>> This patch adds regmap support for simple the simple multiplexer
>> clock code.
>
> Nice to see regmap support. This something I would also like to see
> added to the clk framework.
> And if the approach is agreed upon I would like to see support on
> gates and dividers also.

I totally agree.

>
>> +static void clk_mux_writel(struct clk_mux *mux, u32 val)
>> +{
>> +       if (mux->flags && CLK_MUX_USE_REGMAP)
>
> Assume you mean &.

Sure, it's just luck that the patch didn't end up with a hanging
system when I tested it yesterday.
Fixed in next version.

>
>> +               regmap_write(mux->regmap, mux->offset, val);
>> +       else
>> +               clk_writel(val, mux->reg);
>> +}
>> +
>> +static u32 clk_mux_readl(struct clk_mux *mux)
>> +{
>> +       u32 val;
>> +
>> +       if (mux->flags && CLK_MUX_USE_REGMAP)
>
> And here.

Ditto.

>
>> +               regmap_read(mux->regmap, mux->offset, &val);
>> +       else
>> +               val = clk_readl(mux->reg);
>> +
>> +       return val;
>> +}
>> +
> [...]
>> @@ -409,7 +410,9 @@ void clk_unregister_divider(struct clk *clk);
>>  struct clk_mux {
>>         struct clk_hw   hw;
>
>>         void __iomem    *reg;
>> +       struct regmap   *regmap;
>
> Since it not possible to have both iomem and regmap at the same time.
> Could this be put in a union or does that make registration more
> difficult?

It just adds a flag check to the registration.
I will add it in the next version.

Thanks for reviewing.
Matthias


-- 
motzblog.wordpress.com
