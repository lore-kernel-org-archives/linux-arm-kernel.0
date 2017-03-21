From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 21 Mar 2017 17:36:15 +0100
Subject: [PATCH v3 7/8] clk: qcom: Add MSM8960/APQ8064 LPASS clock
 controller (LCC) driver
In-Reply-To: <1421719535-28398-8-git-send-email-sboyd@codeaurora.org>
References: <1421719535-28398-1-git-send-email-sboyd@codeaurora.org>
 <1421719535-28398-8-git-send-email-sboyd@codeaurora.org>
Message-ID: <CACRpkdaJpJm7z3JbX3a=hg2UhZLVe55HjjC+JcP+iZFBwu1CFQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When looking at this and trying to adapt it to MSM8660/APQ8060
like Neil did with MDM9615 I get pretty confused.

On Tue, Jan 20, 2015 at 3:05 AM, Stephen Boyd <sboyd@codeaurora.org> wrote:

> Add an LCC driver for MSM8960/APQ8064 that supports the i2s,
> slimbus, and pcm clocks.
>
> Change-Id: I2549b821f7bf467c1bd80d4827a1a7621e725659
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
(...)

So this:

> +static const u8 lcc_pxo_pll4_map[] = {
> +       [P_PXO]         = 0,
> +       [P_PLL4]        = 2,
> +};
> +
> +static const char *lcc_pxo_pll4[] = {
> +       "pxo",
> +       "pll4_vote",
> +};

> +static struct clk_rcg mi2s_osr_src = {
> +               .parent_map = lcc_pxo_pll4_map,
> +                       .parent_names = lcc_pxo_pll4,

> +static const char *lcc_mi2s_parents[] = {
> +       "mi2s_osr_src",

> +static struct clk_branch mi2s_osr_clk = {
> +                       .parent_names = lcc_mi2s_parents,
> +                       .num_parents = 1,

> +static struct clk_regmap_div mi2s_div_clk = {
> +                       .parent_names = lcc_mi2s_parents,
> +                       .num_parents = 1,

> +static struct clk_branch mi2s_bit_div_clk = {
> +                       .parent_names = (const char *[]){ "mi2s_div_clk" },
> +                       .num_parents = 1,

> +static struct clk_regmap_mux mi2s_bit_clk = {
> +                       .parent_names = (const char *[]){
> +                               "mi2s_bit_div_clk",
> +                               "mi2s_codec_clk",
> +                       },
> +                       .num_parents = 2,

So:

PXO | PLL4
  -> mi2s_osr_src
     -> mi2s_osr_clk
  -> mi2s_div_clk
     -> mi2s_bit_div_clk
        -> mi2s_bit_clk

If I select the only existing parent.

This funky mi2s_codec_clk parent does not seem to exist in this
or any of the drivers copying this. What is that? Do we have a
orphan clock parent?

Anyway: when I look in the vendor tree, this parent selection etc
does not seem to exist. Am I looking at the wrong code? I'm
on android-msm-3.4 arch/arm/mach-msm/clock-8960.c
It more seems like the reparenting is a later invention, and I
can't figure out where to learn about this.

Does MSM8660 even have the same structure? I would guess so
but it looks simpler somewhat when I inspect the vendor tree.

The MSM8960 does this:

static CLK_AIF_OSR(mi2s_osr, LCC_MI2S_NS_REG, LCC_MI2S_MD_REG,
                LCC_MI2S_STATUS_REG);
static CLK_AIF_BIT(mi2s_bit, LCC_MI2S_NS_REG, LCC_MI2S_STATUS_REG);

static CLK_AIF_OSR_DIV(codec_i2s_mic_osr, LCC_CODEC_I2S_MIC_NS_REG,
                LCC_CODEC_I2S_MIC_MD_REG, LCC_CODEC_I2S_MIC_STATUS_REG);
static CLK_AIF_BIT_DIV(codec_i2s_mic_bit, LCC_CODEC_I2S_MIC_NS_REG,
                LCC_CODEC_I2S_MIC_STATUS_REG);

static CLK_AIF_OSR_DIV(spare_i2s_mic_osr, LCC_SPARE_I2S_MIC_NS_REG,
                LCC_SPARE_I2S_MIC_MD_REG, LCC_SPARE_I2S_MIC_STATUS_REG);
static CLK_AIF_BIT_DIV(spare_i2s_mic_bit, LCC_SPARE_I2S_MIC_NS_REG,
                LCC_SPARE_I2S_MIC_STATUS_REG);

static CLK_AIF_OSR_DIV(codec_i2s_spkr_osr, LCC_CODEC_I2S_SPKR_NS_REG,
                LCC_CODEC_I2S_SPKR_MD_REG, LCC_CODEC_I2S_SPKR_STATUS_REG);
static CLK_AIF_BIT_DIV(codec_i2s_spkr_bit, LCC_CODEC_I2S_SPKR_NS_REG,
                LCC_CODEC_I2S_SPKR_STATUS_REG);

static CLK_AIF_OSR_DIV(spare_i2s_spkr_osr, LCC_SPARE_I2S_SPKR_NS_REG,
                LCC_SPARE_I2S_SPKR_MD_REG, LCC_SPARE_I2S_SPKR_STATUS_REG);
static CLK_AIF_BIT_DIV(spare_i2s_spkr_bit, LCC_SPARE_I2S_SPKR_NS_REG,
                LCC_SPARE_I2S_SPKR_STATUS_REG);

While the MSM8x60 does this:

static CLK_AIF_OSR(mi2s_osr, LCC_MI2S_NS_REG, LCC_MI2S_MD_REG,
                LCC_MI2S_STATUS_REG);
static CLK_AIF_BIT(mi2s_bit, LCC_MI2S_NS_REG, LCC_MI2S_STATUS_REG);

static CLK_AIF_OSR(codec_i2s_mic_osr, LCC_CODEC_I2S_MIC_NS_REG,
                LCC_CODEC_I2S_MIC_MD_REG, LCC_CODEC_I2S_MIC_STATUS_REG);
static CLK_AIF_BIT(codec_i2s_mic_bit, LCC_CODEC_I2S_MIC_NS_REG,
                LCC_CODEC_I2S_MIC_STATUS_REG);

static CLK_AIF_OSR(spare_i2s_mic_osr, LCC_SPARE_I2S_MIC_NS_REG,
                LCC_SPARE_I2S_MIC_MD_REG, LCC_SPARE_I2S_MIC_STATUS_REG);
static CLK_AIF_BIT(spare_i2s_mic_bit, LCC_SPARE_I2S_MIC_NS_REG,
                LCC_SPARE_I2S_MIC_STATUS_REG);

static CLK_AIF_OSR(codec_i2s_spkr_osr, LCC_CODEC_I2S_SPKR_NS_REG,
                LCC_CODEC_I2S_SPKR_MD_REG, LCC_CODEC_I2S_SPKR_STATUS_REG);
static CLK_AIF_BIT(codec_i2s_spkr_bit, LCC_CODEC_I2S_SPKR_NS_REG,
                LCC_CODEC_I2S_SPKR_STATUS_REG);

static CLK_AIF_OSR(spare_i2s_spkr_osr, LCC_SPARE_I2S_SPKR_NS_REG,
                LCC_SPARE_I2S_SPKR_MD_REG, LCC_SPARE_I2S_SPKR_STATUS_REG);
static CLK_AIF_BIT(spare_i2s_spkr_bit, LCC_SPARE_I2S_SPKR_NS_REG,
                LCC_SPARE_I2S_SPKR_STATUS_REG);

So seemingly this "BIT_DIV" whatever that is, does not exist on the
MSM8660, yet the first two clocks look like that for MSM8960 yet translates
into that complex reparenting mechanism with 5 clocks instead of just 2
like in the vendor tree.

It's a bit hard to follow this...

Yours,
Linus Walleij
