From: myungjoo.ham@samsung.com (MyungJoo Ham)
Date: Mon, 2 Aug 2010 21:51:11 +0900
Subject: [PATCH v3] ARM: Samsung SoC: clksrc-clk: wait for the stable
	SRC/DIV status.
In-Reply-To: <003001cb3203$ce869bd0$6b93d370$%kim@samsung.com>
References: <1280717476-32327-1-git-send-email-myungjoo.ham@samsung.com>
	<003001cb3203$ce869bd0$6b93d370$%kim@samsung.com>
Message-ID: <AANLkTikCRMaRVj4tvBSS0RTTwYF_GKuGSqZBG3+_j-kd@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 2, 2010 at 2:30 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> MyungJoo Ham wrote:
>>
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
>> --
>> v2:
>> ? ? ? - Wait-for-stable loop is described at an inline function.
>> v3:
>> ? ? ? - Stop using clksrc_reg for stable bits. Use "clkstat_reg" for
>> ? ? ? ? them.
>>
>> ---
>> ?arch/arm/plat-samsung/clock-clksrc.c ? ? ? ? ? ? ?| ? 14 +++++++++++++
>> ?arch/arm/plat-samsung/include/plat/clock-clksrc.h | ? 22
>> +++++++++++++++++++++
>> ?2 files changed, 36 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/plat-samsung/clock-clksrc.c
> b/arch/arm/plat-samsung/clock-
>> clksrc.c
>> index 46d204a..79ae92e 100644
>> --- a/arch/arm/plat-samsung/clock-clksrc.c
>> +++ b/arch/arm/plat-samsung/clock-clksrc.c
>> @@ -50,6 +50,15 @@ static unsigned long s3c_getrate_clksrc(struct clk
> *clk)
>> ? ? ? return rate;
>> ?}
>>
>> +static inline void s3c_wait_for_stable(struct clkstat_reg *stat)
>> +{
>> + ? ? WARN_ON(stat == NULL);
>
> if (stat == NULL)
> ? ? ? ?return;

Because .reg_*_stable is included in struct clksrc_clk and
s3c_wait_for_stable is called by clk_set_parent and clk_set_rate,
which have struct clksrc_clk, stat is unlikely to be NULL and if it's
NULL, s3c_wait_for_stable is called from a wrong function and wrong
context; thus, I'd use WARN for it rather than silently doing return.

>
> If don't need to check status, have not become define relevant status
> register.
>
>> + ? ? if (stat->reg) {
>
> No need?...or need to check stat->reg and stat->shift?

If stat->reg is NULL (it can be intentionally NULL), it means that the
corresponding struct clksrc_clk does not have stable-stat bit; thus,
pass this checking routine. And, stat->shift may be both 0 and
positive effectively.

stat->reg = 0 : NO STAT REGISTER
stat->reg != 0 : STAT Register Exists. Use stat->shift to specify the
bit (stat->shift can be 0 or larger)

>
>> + ? ? ? ? ? ? do { } while (((__raw_readl(stat->reg) >> stat->shift) & 1)
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? != stat->stable);
>
> I'm still wondering we _really_ need 'stable'...just comments is enough,
> right now.

S5PV210 is fine without stable because stat->stable is always 0 for S5PV210.

However, this is for "Samsung-SoC" not for "S5PV210" although only
S5PV210 uses this feature for now.

I've added stat->stable for the generality. Would it be better discard
such generality and assume that other Samsung-SoC systems will also
use the same stat bit scheme for every register (0 for stable, 1 for
changing for every STAT register) with S5PV210? If we can guarantee
such homogeneousity, getting rid of stable property would be perfectly
fine. It is added just because I couldn't sure about Samsung-SoC chips
other than S5PV210. (and I thought some chips may use different scheme
for each register; e.g., some registers use 0 for stable, some others
use 1 for stable)

>
>> + ? ? ? ? ? ? do { } while (((__raw_readl(stat->reg) >> stat->shift) & 1)
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? != stat->stable);
>
>> + ? ? }
>> +}
>> +
>> ?static int s3c_setrate_clksrc(struct clk *clk, unsigned long rate)
>> ?{
>> ? ? ? struct clksrc_clk *sclk = to_clksrc(clk);
>> @@ -68,6 +77,8 @@ static int s3c_setrate_clksrc(struct clk *clk, unsigned
> long rate)
>> ? ? ? val |= (div - 1) << sclk->reg_div.shift;
>> ? ? ? __raw_writel(val, reg);
>>
>> + ? ? s3c_wait_for_stable(&sclk->reg_div_stable);
>> +
>> ? ? ? return 0;
>> ?}
>>
>> @@ -93,6 +104,9 @@ static int s3c_setparent_clksrc(struct clk *clk, struct
> clk
>> *parent)
>> ? ? ? ? ? ? ? clksrc |= src_nr << sclk->reg_src.shift;
>>
>> ? ? ? ? ? ? ? __raw_writel(clksrc, sclk->reg_src.reg);
>> +
>> + ? ? ? ? ? ? s3c_wait_for_stable(&sclk->reg_src_stable);
>> +
>> ? ? ? ? ? ? ? return 0;
>> ? ? ? }
>>
>> diff --git a/arch/arm/plat-samsung/include/plat/clock-clksrc.h
> b/arch/arm/plat-
>> samsung/include/plat/clock-clksrc.h
>> index 50a8ca7..f1d54da 100644
>> --- a/arch/arm/plat-samsung/include/plat/clock-clksrc.h
>> +++ b/arch/arm/plat-samsung/include/plat/clock-clksrc.h
>> @@ -40,11 +40,30 @@ struct clksrc_reg {
>> ?};
>>
>> ?/**
>> + * struct clkstat_reg - register definition for clock stat bits
>> + * @reg: pointer to the register in virtual memory.
>> + * @shift: the shift in bits to where the bitfield is.
>> + * @stable: the bit value of stable status.
>> + */
>> +struct clkstat_reg {
>> + ? ? void __iomem ? ? ? ? ? ?*reg;
>> + ? ? unsigned short ? ? ? ? ?shift;
>> + ? ? unsigned short ? ? ? ? ?stable;
>
> If you want to use this, just 'value' is better.
> But...I think...we don't need this field now.
>
>> +};
>> +
>> +/**
>> ? * struct clksrc_clk - class of clock for newer style samsung devices.
>> ? * @clk: the standard clock representation
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
>> @@ -61,6 +80,9 @@ struct clksrc_clk {
>>
>> ? ? ? struct clksrc_reg ? ? ? reg_src;
>> ? ? ? struct clksrc_reg ? ? ? reg_div;
>> +
>> + ? ? struct clkstat_reg ? ? ?reg_src_stable;
>> + ? ? struct clkstat_reg ? ? ?reg_div_stable;
>> ?};
>>
>> ?/**
>> --
>
>
> Thanks.
>
> Best regards,
> Kgene.
> --
> Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
> SW Solution Development Team, Samsung Electronics Co., Ltd.
>
>



-- 
MyungJoo Ham (???), Ph.D.
Mobile Software Platform Lab,
Digital Media and Communications (DMC) Business
Samsung Electronics
cell: 82-10-6714-2858
