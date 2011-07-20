From: naveenkrishna.ch@gmail.com (Naveen Krishna Ch)
Date: Wed, 20 Jul 2011 15:22:05 +0530
Subject: [PATCH v2 2/3] ARM: EXYNOS4: Add sclk_spdif clocks.
In-Reply-To: <CAHfPSqAAmu+DMTuiT89TpQ7He-HVqBcA+HHpziG0CyviGrtd_g@mail.gmail.com>
References: <1308655463-8787-1-git-send-email-ch.naveen@samsung.com>
	<1308655463-8787-3-git-send-email-ch.naveen@samsung.com>
	<048301cc450c$37dc4b90$a794e2b0$%kim@samsung.com>
	<CAHfPSqAAmu+DMTuiT89TpQ7He-HVqBcA+HHpziG0CyviGrtd_g@mail.gmail.com>
Message-ID: <CAHfPSqAWxasV--nXtC7JBsV3yKQLY1MVGp=HMAdy-gnB8c-urA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Everyone,

Any suggestions regarding this below problem.

On 18 July 2011 16:55, Naveen Krishna Ch <naveenkrishna.ch@gmail.com> wrote:
> Hi Every one,
>
> On 18 July 2011 11:03, Kukjin Kim <kgene.kim@samsung.com> wrote:
>> Naveen Krishna Chatradhi wrote:
>>>
>>> Add the sclk_spdif clock is of type 'struct clksrc_clk' clock.
>>> Also, add clk_spdifextclk clocks of type 'struct clk' clock.
>>>
>>> Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
>>> ---
>>> ?arch/arm/mach-exynos4/clock.c | ? 35
>>> +++++++++++++++++++++++++++++++++++
>>> ?1 files changed, 35 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-exynos4/clock.c b/arch/arm/mach-exynos4/clock.c
>>> index 937335a..feeb27e 100644
>>> --- a/arch/arm/mach-exynos4/clock.c
>>> +++ b/arch/arm/mach-exynos4/clock.c
>>> @@ -64,6 +64,11 @@ static struct clk clk_audiocdclk2 = {
>>> ? ? ? .name ? ? ? ? ? = "audiocdclk",
>>> ?};
>>>
>>> +static struct clk clk_spdifextclk = {
>>> + ? ? .name ? ? ? ? ? = "spdif_extclk",
>>> + ? ? .id ? ? ? ? ? ? = -1,
>>> +};
>>> +
>>> ?static int exynos4_clksrc_mask_top_ctrl(struct clk *clk, int enable)
>>> ?{
>>> ? ? ? return s5p_gatectrl(S5P_CLKSRC_MASK_TOP, clk, enable);
>>> @@ -550,6 +555,11 @@ static struct clk init_clocks_off[] = {
>>> ? ? ? ? ? ? ? .enable ? ? ? ? = exynos4_clk_ip_peril_ctrl,
>>> ? ? ? ? ? ? ? .ctrlbit ? ? ? ?= (1 << 21),
>>> ? ? ? }, {
>>> + ? ? ? ? ? ? .name ? ? ? ? ? = "spdif",
>>> + ? ? ? ? ? ? .id ? ? ? ? ? ? = -1,
>>> + ? ? ? ? ? ? .enable ? ? ? ? = exynos4_clk_ip_peril_ctrl,
>>> + ? ? ? ? ? ? .ctrlbit ? ? ? ?= (1 << 26),
>>> + ? ? }, {
>>
>> Need to re-work based on clkdev :)
> Sure, will rebase on updated for-next branch.
>>
>>> ? ? ? ? ? ? ? .name ? ? ? ? ? = "ac97",
>>> ? ? ? ? ? ? ? .id ? ? ? ? ? ? = -1,
>>> ? ? ? ? ? ? ? .enable ? ? ? ? = exynos4_clk_ip_peril_ctrl,
>>> @@ -801,6 +811,30 @@ static struct clk init_clocks[] = {
>>> ? ? ? }
>>> ?};
>>>
>>> +static struct clk *clkset_sclk_spdif_list[] = {
>>> + ? ? [0] = &clk_sclk_audio0.clk,
>>> + ? ? [1] = &clk_sclk_audio1.clk,
>>> + ? ? [2] = &clk_sclk_audio2.clk,
>>> + ? ? [3] = &clk_spdifextclk,
>>> +};
>>> +
>>> +static struct clksrc_sources clkset_sclk_spdif = {
>>> + ? ? .sources ? ? ? ?= clkset_sclk_spdif_list,
>>> + ? ? .nr_sources ? ? = ARRAY_SIZE(clkset_sclk_spdif_list),
>>> +};
>>> +
>>> +static struct clksrc_clk clk_sclk_spdif = {
>>> + ? ? .clk ? ?= {
>>> + ? ? ? ? ? ? .name ? ? ? ? ? = "sclk_spdif",
>>> + ? ? ? ? ? ? .id ? ? ? ? ? ? = -1,
>>> + ? ? ? ? ? ? .enable ? ? ? ? = exynos4_clksrc_mask_peril1_ctrl,
>>> + ? ? ? ? ? ? .ctrlbit ? ? ? ?= (1 << 8),
>>> + ? ? ? ? ? ? .ops ? ? ? ? ? ?= &s5p_sclk_spdif_ops,
>>> + ? ? },
>>> + ? ? ? ? ? ? .sources = &clkset_sclk_spdif,
>>> + ? ? ? ? ? ? .reg_src = { .reg = S5P_CLKSRC_PERIL1, .shift = 8, .size = 2
>> },
>>> +};
>>
>> Hmm...is it possible to move this into struct clksrc_clk clksrcs[] ?
> When i try to move it under struct clksrc_clk clksrcs[], I encountered
> a problem with .ops field
> The sample code as follows (I'm not sure if i can copy paste the code for RFC)
>
> +static struct clk *clkset_sclk_spdif_list[] = {
> + ? ? ? [0] = &clk_sclk_audio0.clk,
> + ? ? ? [1] = &clk_sclk_audio1.clk,
> + ? ? ? [2] = &clk_sclk_audio2.clk,
> + ? ? ? [3] = &clk_spdifextclk,
> +};
> +
> +static struct clksrc_sources clkset_sclk_spdif = {
> + ? ? ? .sources ? ? ? ?= clkset_sclk_spdif_list,
> + ? ? ? .nr_sources ? ? = ARRAY_SIZE(clkset_sclk_spdif_list),
> +};
> +
> ?static struct clk *clkset_group_list[] = {
> ? ? ? ?[0] = &clk_ext_xtal_mux,
> ? ? ? ?[1] = &clk_xusbxti,
> @@ -1175,6 +1197,17 @@ static struct clksrc_clk clksrcs[] = {
> ? ? ? ? ? ? ? ? ? ? ? ?.parent ? ? ? ? = &clk_sclk_audio2.clk,
> ? ? ? ? ? ? ? ?},
> ? ? ? ? ? ? ? ?.reg_div = { .reg = S5P_CLKDIV_PERIL4, .shift = 20, .size = 8 },
> + ? ? ? }, {
> + ? ? ? ? ? ? ? .clk ? ?= {
> + ? ? ? ? ? ? ? ? ? ? ? .name ? ? ? ? ? = "sclk_spdif",
> + ? ? ? ? ? ? ? ? ? ? ? .id ? ? ? ? ? ? = 0,
> + ? ? ? ? ? ? ? ? ? ? ? .parent ? ? ? ? = &clk_sclk_audio0.clk,
> + ? ? ? // ? ? ? ? ? ? ?.ops ? ? ? ? ? ?= &s5p_sclk_spdif_ops,
> "When i keep this .ops, The system hangs during boot up.
> If i don't define the .ops, The WARN_ON would print a stack of call
> trace for undefined set_rate function"
> I did not find any set_ops kind off utility functions.
>
> Kindly, point me towards any better way of doing the same.
>
> + ? ? ? ? ? ? ? ? ? ? ? .enable ? ? ? ? = exynos4_clksrc_mask_peril1_ctrl,
> + ? ? ? ? ? ? ? ? ? ? ? .ctrlbit ? ? ? ?= (1 << 8),
> + ? ? ? ? ? ? ? },
> + ? ? ? ? ? ? ? .sources = &clkset_sclk_spdif,
> + ? ? ? ? ? ? ? .reg_src = { .reg = S5P_CLKSRC_PERIL1, .shift = 8, .size = 2 },
> ? ? ? ?},
> ?};
>
>>
>>> +
>>> ?static struct clk *clkset_group_list[] = {
>>> ? ? ? [0] = &clk_ext_xtal_mux,
>>> ? ? ? [1] = &clk_xusbxti,
>>> @@ -1206,6 +1240,7 @@ static struct clksrc_clk *sysclks[] = {
>>> ? ? ? &clk_sclk_audio0,
>>> ? ? ? &clk_sclk_audio1,
>>> ? ? ? &clk_sclk_audio2,
>>> + ? ? &clk_sclk_spdif,
>>> ?};
>>>
>>> ?static int xtal_rate;
>>> --
>>> 1.7.2.3
>>
>>
>> Thanks.
>>
>> Best regards,
>> Kgene.
>> --
>> Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
>> SW Solution Development Team, Samsung Electronics Co., Ltd.
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
>> the body of a message to majordomo at vger.kernel.org
>> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
>>
>
>
>
> --
> Shine bright,
> (: Nav :)
>



-- 
Shine bright,
(: Nav :)
