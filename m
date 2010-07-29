From: myungjoo.ham@samsung.com (MyungJoo Ham)
Date: Thu, 29 Jul 2010 14:07:07 +0900
Subject: [PATCH] ARM: Samsung SoC: clksrc-clk: wait for the stable SRC/DIV
	status.
In-Reply-To: <4C50681B.8040306@simtec.co.uk>
References: <1280287044-6645-1-git-send-email-myungjoo.ham@samsung.com>
	<4C50681B.8040306@simtec.co.uk>
Message-ID: <AANLkTikgOABkS0_Q48rmd37LZVe8kf_dHLP1CNF9xBBe@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 29, 2010 at 2:25 AM, Ben Dooks <ben@simtec.co.uk> wrote:
> On 28/07/10 04:17, MyungJoo Ham wrote:
>> Many MUX and clock dividers have a status bit so that users can wait
>> until the status is stable. When corresponding registers are accessed
>> while a clock is not stable, we may suffer from unexpected errors.
>>
>> Therefore, we introduce a mechanism to let the operations related with
>> updating SRC/DIV registers of clksrc-clk wait for the stabilization:
>> clk_set_parent, clk_set_rate.
>>
>> In order to use this feature, the definition of clksrc_clk should
>> include reg_src_stable or reg_div_stable. With effective rec_src_stable
>> values, clk_set_parent returns with a stabilized SRC register and
>> with effective rec_div_stable values, clk_set_rate returns with a
>> stabilized DIV register. If .reg field is null, its (either SRC or DIV)
>> register's status is not checked and returned without waiting; i.e.,
>> some MUX/DIV may not need this feature.
>>
>> When setting reg_*_stable, .size is used to tell the value of "stable".
>> If .size = 0, the stable status is 0 and if .size = 1, the stable status
>> is 1.
>>
>> Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>> ---
>> ?arch/arm/plat-samsung/clock-clksrc.c ? ? ? ? ? ? ?| ? 13 +++++++++++++
>> ?arch/arm/plat-samsung/include/plat/clock-clksrc.h | ? 10 ++++++++++
>> ?2 files changed, 23 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/plat-samsung/clock-clksrc.c b/arch/arm/plat-samsung/clock-clksrc.c
>> index 46d204a..5ff17ad 100644
>> --- a/arch/arm/plat-samsung/clock-clksrc.c
>> +++ b/arch/arm/plat-samsung/clock-clksrc.c
>> @@ -68,6 +68,12 @@ static int s3c_setrate_clksrc(struct clk *clk, unsigned long rate)
>> ? ? ? val |= (div - 1) << sclk->reg_div.shift;
>> ? ? ? __raw_writel(val, reg);
>>
>> + ? ? if (sclk->reg_div_stable.reg) {
>> + ? ? ? ? ? ? do { } while (((__raw_readl(sclk->reg_div_stable.reg) >>
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? sclk->reg_div_stable.shift) & 1)
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? != sclk->reg_div_stable.size);
>> + ? ? }
>> +
>> ? ? ? return 0;
>> ?}
>
> you could move the code for this out to a separate inlined function to
> avoid it being here twice, and possibly make it flow better.
>

Ok. Inlining those is done with the v2 patch. Thanks.

>> @@ -93,6 +99,13 @@ static int s3c_setparent_clksrc(struct clk *clk, struct clk *parent)
>> ? ? ? ? ? ? ? clksrc |= src_nr << sclk->reg_src.shift;
>>
>> ? ? ? ? ? ? ? __raw_writel(clksrc, sclk->reg_src.reg);
>> +
>> + ? ? ? ? ? ? if (sclk->reg_src_stable.reg) {
>> + ? ? ? ? ? ? ? ? ? ? do { } while (((__raw_readl(sclk->reg_src_stable.reg) >>
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? sclk->reg_src_stable.shift) & 1)
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? != sclk->reg_src_stable.size);
>> + ? ? ? ? ? ? }
>> +
>> ? ? ? ? ? ? ? return 0;
>> ? ? ? }
>>
>> diff --git a/arch/arm/plat-samsung/include/plat/clock-clksrc.h b/arch/arm/plat-samsung/include/plat/clock-clksrc.h
>> index 50a8ca7..282821d 100644
>> --- a/arch/arm/plat-samsung/include/plat/clock-clksrc.h
>> +++ b/arch/arm/plat-samsung/include/plat/clock-clksrc.h
>> @@ -45,6 +45,13 @@ struct clksrc_reg {
>> ? * @sources: the sources for this clock
>> ? * @reg_src: the register definition for selecting the clock's source
>> ? * @reg_div: the register definition for the clock's output divisor
>> + * @reg_src_stable: the register definition to probe if reg_src is
>> + * ? ?stabilized after the update of reg_src. It is "stabilized" if
>> + * ? ?reg[shift] == size. If reg == NULL, this stable reg is not looked
>> + * ? ?up. Thus, in S5PV210, size is usually 0.
>> + * @reg_div_stable: the register definition to probe if reg_div is
>> + * ? ?stabilized after the update of reg_div. Same mechanism with
>> + * ? ?reg_src_stable.
>> ? *
>> ? * This clock implements the features required by the newer SoCs where
>> ? * the standard clock block provides an input mux and a post-mux divisor
>> @@ -61,6 +68,9 @@ struct clksrc_clk {
>>
>> ? ? ? struct clksrc_reg ? ? ? reg_src;
>> ? ? ? struct clksrc_reg ? ? ? reg_div;
>> +
>> + ? ? struct clksrc_reg ? ? ? reg_src_stable;
>> + ? ? struct clksrc_reg ? ? ? reg_div_stable;
>> ?};
>>
>> ?/**
>
>



-- 
MyungJoo Ham (???), Ph.D.
Mobile Software Platform Lab,
Digital Media and Communications (DMC) Business
Samsung Electronics
cell: 82-10-6714-2858
