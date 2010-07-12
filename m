From: myungjoo.ham@samsung.com (MyungJoo Ham)
Date: Mon, 12 Jul 2010 16:06:58 +0900
Subject: [PATCH] ARM: S5PV210: allow clk to use clksrc as parents
In-Reply-To: <039a01cb2180$d36679b0$7a336d10$%kim@samsung.com>
References: <1278395553-9228-1-git-send-email-myungjoo.ham@samsung.com>
	<027d01cb1f51$99a74780$ccf5d680$%kim@samsung.com>
	<AANLkTimvA_gSxZsrkEWZMLRFl82MsW5tV9g4trFmaMIr@mail.gmail.com>
	<038201cb2169$c92ccbf0$5b8663d0$%kim@samsung.com>
	<AANLkTilbDABhIIIWCtiHLsvQtss8A99XYWyCy0MkihD3@mail.gmail.com>
	<039a01cb2180$d36679b0$7a336d10$%kim@samsung.com>
Message-ID: <AANLkTikf5-KdGju_IcYg8t5ZV3iIzOhr4VdSa104ZZHH@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 12, 2010 at 2:12 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> MyungJoo Ham wrote:
>>
>> Hello,
>>
>> On Mon, Jul 12, 2010 at 11:27 AM, Kukjin Kim <kgene.kim@samsung.com> wrote:
>> > MyungJoo Ham wrote:
>> >>
>> >> Hello,
>> >>
>> >> On Fri, Jul 9, 2010 at 7:29 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
>> >> > MyungJoo Ham wrote:
>> >> >>
>> >> > Hi,
>> >> >
>> >> > Cc'ed Ben Dooks.
>> >> >
>> >> >> This patch allows clk in init_clocks[] and init_clocks_disable[] to use
>> >> >> clksrc_clk.clk in clksrcs[].
>> >> >>
>> >> >> For example, clk "lcd" may need to set "sclk-fimd" as a parent if
>> >> >> the div and src settting of sclk-fimd changes and a user of "lcd" wants
>> >> >> to get the exact information about the rate. If "sclk-fimd" is set as a
>> >> >> parent of "lcd", then the clk framework can provide the wanted
>> >> >> information; otherwise, the change in "sclk-fimd" does not update "lcd"
>> >> >> properly.
>> >> >>
>> >> > I don't think so.
>> >> >
>> >> > This can be problem because the parent clock of LCD(FIMD) is not always
>> >> > SCLK_FIMD. And LCD block is on DSYS clock domain, so the parent clock
>> of
>> >> > 'lcd' should be dsys clock, not sclk_fimd.
>> >> > Basically used dsys bus clock as LCD IP clock and can be used sclk_fimd or
>> >> > not. So should separate them and need to separate control.
>> >>
>> >> Well, yes SCLK_FIMD is not ALWAYS the parent of LCD(FIMD), but it is one of
>> the
>> >> possible parents of LCD(FIMD); thus, SCLK_FIMD should be able to become
>> the
>> >> parent. I'm not saying that SCLK_FIMD should be the parent, but SCLK_FIMD
>> >> should
>> >> be ABLE to be the parent. That's why I made it just "possible', not making it an
>> >> actual parent.
>> >>
>> > More correctly, the clk 'lcd' means clock that should be used basically at FIMD
>> block.
>> > So it means used clock on system bus, should be SCLK_ACLK.
>> >
>> > Actually, if disabled clk 'lcd', we can't access FIMD block such as its register.
>> >
>> > As I say again, clk 'lcd' is on dsys clock domain, because of these meaning, so
>> the parent clock of 'lcd' should be dsys clock.
>>
>> Ok, then, clk_get_rate(lcd) returns 166MHz, always, which in turn,
>> makes it more difficult
>> for lcd clock users to get the correct current rate when sclk_fimd's
>> DIV changes. When we need to show that lcd is in dsys domain, isn't it
>> enough to set dsys is an ancestor (grandparent) of lcd?
>>
>> I thought it'd contain more semantics if lcd's parent is fimd and
>> fimd's parent is dsys; i.e., dsys is still an ancestor of lcd and
>> clk_get_rate(lcd) may return the clock value of lcd while DIV/SRC
>> changes. When lcd does not use sclk_fimd anymore, we can
>> set_parent(lcd, something) anytime (to do this more easily, we may
>> need to define lcd within clksrc_clk).
>>
>>
> Please refer to below diagram.
>
> ------------------------------------
> ? ? ? ? ? dsys bus
> ----------------+-------------------
> ? ? ? ? ? ? ? ?|
> ? ? ? ? ? ? ? ?|1.clk 'lcd'
> ? ? ? ? ? ? ? ?|
> ? ? ? ? ? ?+---+-----------+
> ? ? ? ? ? ?| ? | FIMD block|
> ? ? ? ? ? ?| +-+ ? ? ? ? ? |
> ? ? ? ? ? ?| | ? ? ? ? ? ? |
> ? ? ? ? ? ?| | |\ ? ? ? ? ?|
> ? ? ? ? ? ?| +-|m| ? ? ? ? |
> 2.SCLK_FIMD | ? |u|----+ ? ?|
> ------------+---|x| ? ?| ? ?|
> ? ? ? ? ? ?| ? |/ ? ? | ? ?|
> ? ? ? ? ? ?| ? ? ? ? ?| ? ?|
> ? ? ? ? ? ?+----------+----+
> ? ? ? ? ? ? ? ? ? ? ? |
> inside of SoC ? ? ? ? ?|
> -----------------------+--------------------------
> outside of SoC ? ? ? ? |
> ? ? ? ? ? ? ? ? ? ? ? | 3.clk?
> ? ? ? ? ? ? ? ? ? ? ? |
> ? ? ? ? ? ? ? +--------------+
> ? ? ? ? ? ? ? | LCD module ? |
> ? ? ? ? ? ? ? +--------------+
>
> In clock.c the clk 'lcd' means #1 in above diagram.
> So you mean clk 'lcd' is #3', maybe confused :-(
>

Uh.. yes, I meant #3 by the clk LCD.

This CLK_GATE_IP - FIMD gates both ACLK_FIMD and SCLK_FIMD at the same
time; thus, this should be over the MUX of SCLK_FIMD, I thought. (User
Manual: Clock Controler - Clock Gating Control Register
(CLK_GATE_IP1)) If we should have a struct clk that represents
ACLK_FIMD, the clock representing ACLK_FIMD should not directly
control CLK_GATE_IP1 as CLK_GATE_IP1 gates SCLK_FIMD as well if the
User Manual is correct.

If we really need to represent ACLK_FIMD separately, why don't we
create "aclk_fimd" and let "fimd" or "lcd" become a struct clksrc_clk
that chooses between aclk_fimd and sclk_fimd? How about this? (and
other similar clocks)

Anyway, with this feature, we may now think about calling
"clk_disable(parent)" when a clk is doing
"clk_set_parent(another_parent)" if the clk is "clk_enable"d. I'd be
happy to hear any suggestions and comments on this.

E.g.,

struct clk *a = clk_get("A");
clk_set_parent(a, clk_A);
clk_enable(a);
some ops with a;
/* we need another clock speed with different source */
clk_set_parent(a, clk_B);
some ops with b;

In this example, we, at least, need to enable clk_B when
clk_set_parent is called and we'd better clk_disable(clk_A) if
clk_enable(clk_A) is called at clk_enable(a);


>> Besides, we may need to allow clock-clksrc.c's s3c_register_clksrc
>> function to use the default .parent value to set the SRC register
>> accordingly. For example (a patch under construction, not uploaded yet
>> and requires patches submitted before):
>>
>>
>> Author: MyungJoo Ham <myungjoo.ham@samsung.com>
>> Date: ? Thu Jul 8 18:34:01 2010 +0900
>>
>> ? ? ARM: SAMSUNG SoC: clksrc register uses parent value to set default src.
>>
>> ? ? If .parent field is filled when a struct clksrc_clk is registered,
>> ? ? s3c_register_clksrc sets the source clock register accordingly to the
>> ? ? parent clock.
>>
>> ? ? In the previous versions, the parent value was "ignored" because the
>> ? ? value of default register value overwrites the parent field.
>>
>> diff --git a/arch/arm/plat-samsung/clock-clksrc.c
>> b/arch/arm/plat-samsung/clock-clksrc.c
>> index ae8b850..236fb59 100644
>> --- a/arch/arm/plat-samsung/clock-clksrc.c
>> +++ b/arch/arm/plat-samsung/clock-clksrc.c
>> @@ -177,7 +177,7 @@ static struct clk_ops clksrc_ops_nosrc = {
>>
>> ?void __init s3c_register_clksrc(struct clksrc_clk *clksrc, int size)
>> ?{
>> - ? ? ? int ret;
>> + ? ? ? int ret, err = 0;
>>
>> ? ? ? ? for (; size > 0; size--, clksrc++) {
>> ? ? ? ? ? ? ? ? if (!clksrc->reg_div.reg && !clksrc->reg_src.reg)
>> @@ -195,12 +195,25 @@ void __init s3c_register_clksrc(struct
>> clksrc_clk *clksrc, int size)
>> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? clksrc->clk.ops = &clksrc_ops;
>> ? ? ? ? ? ? ? ? }
>>
>> + ? ? ? ? ? ? ? if (clksrc->clk.parent && clksrc->sources &&
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? clksrc->reg_src.reg) {
>> + ? ? ? ? ? ? ? ? ? ? ? err = s3c_setparent_clksrc(&clksrc->clk,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? clksrc->clk.parent);
>> + ? ? ? ? ? ? ? ? ? ? ? if (err < 0)
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? printk(KERN_ERR "[%s:%d] setparent error
>> at reg"
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? "ister_clksrc %s p
>> = %s...\n",
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? __FILE__, __LINE__,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? clksrc->clk.name,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? clksrc->clk.parent->name);
>> + ? ? ? ? ? ? ? }
>> +
>> ? ? ? ? ? ? ? ? /* setup the clocksource, but do not announce it
>> ? ? ? ? ? ? ? ? ?* as it may be re-set by the setup routines
>> ? ? ? ? ? ? ? ? ?* called after the rest of the clocks have been
>> ? ? ? ? ? ? ? ? ?* registered
>> ? ? ? ? ? ? ? ? ?*/
>> - ? ? ? ? ? ? ? s3c_set_clksrc(clksrc, false);
>> + ? ? ? ? ? ? ? if (err < 0)
>> + ? ? ? ? ? ? ? ? ? ? ? s3c_set_clksrc(clksrc, false);
>>
>> ? ? ? ? ? ? ? ? ret = s3c24xx_register_clock(&clksrc->clk);
>>
>>
>>
>>
>> >
>> >> However, in order to make it look better, we may need to make LCD(FIMD)
>> easier
>> >> to switch between SCLK_ACLK and SCLK_FIMD; e.g., by making it another
>> >> clksrc_clk
>> >> with source clocks of SCLK_ACLK and SCLK_FIMD controlling with
>> CLK_GATE_IP.
>> >>
>> >> >
>> >> > As I still saying, the CLK_GATE_IP1[0] for LCD block can gate clock of
>> >> > SCLK_ACLK and SCLK_FIMD which can be source of LCD block, and
>> >> > CLK_SRC_MASK0[5] can gate only SCLK_FIMD, output clock of MUX FIMD.
>> >> >
>> >> >> To do so, we have relocated clksrcs[] and put enum indexes to clksrcs in
>> >> >> order to allow clk in init_clocks[] and init_clocks_disable[] may refer
>> >> >> one of clksrcs[] as its parent. (enum clksrc_refer)
>> >> >>
>> >> >> For example, "lcd" may set "sclk-fimd" as a parent if the following line
>> >> >> replaces the line 878:
>> >> >>
>> >> >> ? ? ? ? ? ? ? .parent ? ? ? ? = &clk_hclk_dsys.clk,
>> >> >>
>> >> >> to
>> >> >>
>> >> >> ? ? ? ? ? ? ? .parent ? ? ? ? = &clksrcs[_clksrc_sclk_fimd],
>> >> >>
>> >> >
>> >> >
>> >> >> Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
>> >> >> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>> >> >> ---
>> >> >> ?arch/arm/mach-s5pv210/clock.c | ?986
>> >> > ++++++++++++++++++++++-------------------
>> >> >> ?1 files changed, 520 insertions(+), 466 deletions(-)
>> >> >>
>> >> >> diff --git a/arch/arm/mach-s5pv210/clock.c b/arch/arm/mach-s5pv210/clock.c
>> >> >> index aa2b1c5..e33c6ed 100644
>> >> >> --- a/arch/arm/mach-s5pv210/clock.c
>> >> >> +++ b/arch/arm/mach-s5pv210/clock.c
>> >> >> @@ -264,6 +264,526 @@ static struct clksrc_clk clk_sclk_vpll = {
>> >> >> ? ? ? .reg_src ? ? ? ?= { .reg = S5P_CLK_SRC0, .shift = 12, .size = 1 },
>> >> >> ?};
>> >> >>
>> >> >
>> >> > And...hmm...maybe made this patch with wrong way...
>> >> >
>> >> >> +static struct clk *clkset_uart_list[] = {
>> >> >> + ? ? [6] = &clk_mout_mpll.clk,
>> >> >> + ? ? [7] = &clk_mout_epll.clk,
>> >> >> +};
>> >> >> +
>> >> >
>> >> > Following is from this patch...
>> >> >
>> >> > -static struct clk *clkset_uart_list[] = {
>> >> > - ? ? ? [6] = &clk_mout_mpll.clk,
>> >> > - ? ? ? [7] = &clk_mout_epll.clk,
>> >> > -};
>> >> > -
>> >> >
>> >> > Same? :-(
>> >> > Why did you remove and add same code?
>> >>
>> >> It is done so in order to make clksrc_clk to be able to be parents of
>> >> clk. (same with the
>> >> later parts)
>> >>
>> >> To do so, I moved clksrc_clk to the front of clk definitions, which in
>> >> turn moved
>> >> clock source list to the front of clksrc_clk.
>> >>
>> >> Or, in order to reduce the changed lines number, would it be better to declare
>> >> the list of struct clksrc_clk before and keep the locations of the lists?
>> >>
>> >>
>> >> >
>> >> > (snip)
>> >> >
>> >> > And...see the below.
>> >> >
>> >> > Added like below...
>> >> >
>> >> >> +static struct clksrc_clk clksrcs[] = {
>> >> >> + ? ? [_clksrc_sclk_dmc] = {
>> >> >> + ? ? ? ? ? ? .clk ? ?= {
>> >> >> + ? ? ? ? ? ? ? ? ? ? .name ? ? ? ? ? = "sclk_dmc",
>> >> >> + ? ? ? ? ? ? ? ? ? ? .id ? ? ? ? ? ? = -1,
>> >> >> + ? ? ? ? ? ? },
>> >> >> + ? ? ? ? ? ? .sources = &clkset_group1,
>> >> >> + ? ? ? ? ? ? .reg_src = { .reg = S5P_CLK_SRC6, .shift = 24, .size = 2 },
>> >> >> + ? ? ? ? ? ? .reg_div = { .reg = S5P_CLK_DIV6, .shift = 28, .size = 4 },
>> >> >> + ? ? },
>> >> >> + ? ? [_clksrc_sclk_onenand] = {
>> >> >> + ? ? ? ? ? ? .clk ? ?= {
>> >> >> + ? ? ? ? ? ? ? ? ? ? .name ? ? ? ? ? = "sclk_onenand",
>> >> >> + ? ? ? ? ? ? ? ? ? ? .id ? ? ? ? ? ? = -1,
>> >> >> + ? ? ? ? ? ? },
>> >> >> + ? ? ? ? ? ? .sources = &clkset_sclk_onenand,
>> >> >> + ? ? ? ? ? ? .reg_src = { .reg = S5P_CLK_SRC0, .shift = 28, .size = 1 },
>> >> >> + ? ? ? ? ? ? .reg_div = { .reg = S5P_CLK_DIV6, .shift = 12, .size = 3 },
>> >> >> + ? ? },
>> >> >
>> >> > (snip)
>> >> >
>> >> > And removed like below...
>> >> >
>> >> >> -static struct clksrc_clk clksrcs[] = {
>> >> >> - ? ? {
>> >> >> - ? ? ? ? ? ? .clk ? ?= {
>> >> >> - ? ? ? ? ? ? ? ? ? ? .name ? ? ? ? ? = "sclk_dmc",
>> >> >> - ? ? ? ? ? ? ? ? ? ? .id ? ? ? ? ? ? = -1,
>> >> >> - ? ? ? ? ? ? },
>> >> >> - ? ? ? ? ? ? .sources = &clkset_group1,
>> >> >> - ? ? ? ? ? ? .reg_src = { .reg = S5P_CLK_SRC6, .shift = 24, .size = 2 },
>> >> >> - ? ? ? ? ? ? .reg_div = { .reg = S5P_CLK_DIV6, .shift = 28, .size = 4 },
>> >> >> - ? ? }, {
>> >> >> - ? ? ? ? ? ? .clk ? ?= {
>> >> >> - ? ? ? ? ? ? ? ? ? ? .name ? ? ? ? ? = "sclk_onenand",
>> >> >> - ? ? ? ? ? ? ? ? ? ? .id ? ? ? ? ? ? = -1,
>> >> >> - ? ? ? ? ? ? },
>> >> >> - ? ? ? ? ? ? .sources = &clkset_sclk_onenand,
>> >> >> - ? ? ? ? ? ? .reg_src = { .reg = S5P_CLK_SRC0, .shift = 28, .size = 1 },
>> >> >> - ? ? ? ? ? ? .reg_div = { .reg = S5P_CLK_DIV6, .shift = 12, .size = 3 },
>> >> >> - ? ? }, {
>> >> >
>> >> > But only changed small lines not every.
>> >> > Following is from my local machine.
>> >> >
>> >> > @@ -665,7 +665,7 @@ static struct clksrc_sources clkset_group2 = {
>> >> > ?};
>> >> >
>> >> > ?static struct clksrc_clk clksrcs[] = {
>> >> > - ? ? ? {
>> >> > + ? ? ? [_clksrc_sclk_dmc] = {
>> >> > ? ? ? ? ? ? ? ?.clk ? ?= {
>> >> > ? ? ? ? ? ? ? ? ? ? ? ?.name ? ? ? ? ? = "sclk_dmc",
>> >> > ? ? ? ? ? ? ? ? ? ? ? ?.id ? ? ? ? ? ? = -1,
>> >> > @@ -673,7 +673,8 @@ static struct clksrc_clk clksrcs[] = {
>> >> > ? ? ? ? ? ? ? ?.sources = &clkset_group1,
>> >> > ? ? ? ? ? ? ? ?.reg_src = { .reg = S5P_CLK_SRC6, .shift = 24, .size = 2 },
>> >> > ? ? ? ? ? ? ? ?.reg_div = { .reg = S5P_CLK_DIV6, .shift = 28, .size = 4 },
>> >> > - ? ? ? }, {
>> >> > + ? ? ? },
>> >> > + ? ? ? [_clksrc_sclk_onenand] = {
>> >> > ? ? ? ? ? ? ? ?.clk ? ?= {
>> >> > ? ? ? ? ? ? ? ? ? ? ? ?.name ? ? ? ? ? = "sclk_onenand",
>> >> > ? ? ? ? ? ? ? ? ? ? ? ?.id ? ? ? ? ? ? = -1,
>> >> > ?(snip)
>> >> >
>> >> > Please make sure your patch has no problem before submitting.
>> >> >
>> >> > Thanks.
>> >> >
>> >> > Best regards,
>> >> > Kgene.
>> >> > --
>> >> > Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
>> >> > SW Solution Development Team, Samsung Electronics Co., Ltd.
>> >> >
>> >> >
>> >
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
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>



-- 
MyungJoo Ham (???), Ph.D.
Mobile Software Platform Lab,
Digital Media and Communications (DMC) Business
Samsung Electronics
cell: 82-10-6714-2858
