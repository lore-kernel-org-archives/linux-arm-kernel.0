From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 04 Dec 2014 10:46:36 +0100
Subject: [PATCH v2 2/5] clk: samsung: Fix clock disable failure because
 domain being gated
In-Reply-To: <547F1A5F.8000502@samsung.com>
References: <1417011857-10419-1-git-send-email-k.kozlowski@samsung.com>
 <1417011857-10419-3-git-send-email-k.kozlowski@samsung.com>
 <547F1A5F.8000502@samsung.com>
Message-ID: <1417686396.3314.4.camel@AMDC1943>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On ?ro, 2014-12-03 at 15:12 +0100, Sylwester Nawrocki wrote:
> On 26/11/14 15:24, Krzysztof Kozlowski wrote:
> > Audio subsystem clocks are located in separate block. If clock for this
> > block (from main clock domain) 'mau_epll' is gated then any read or
> > write to audss registers will block.
> > 
> > This was observed on Exynos 5420 platforms (Arndale Octa and Peach
> > Pi/Pit) after introducing runtime PM to pl330 DMA driver. After that
> > commit the 'mau_epll' was gated, because the "amba" clock was disabled
> > and there were no more users of mau_epll. The system hang on disabling
> > unused clocks from audss block.
> > 
> > Unfortunately the 'mau_epll' clock is not parent of some of audss clocks.
> > 
> > Whenever system wants to operate on audss clocks it has to enable epll
> > clock. The solution reuses common clk-gate/divider/mux code and duplicates
> > clk_register_*() functions. In the same time the patch tries to limit
> > functional changes of the driver so it does not fix minor issues with existing
> > code (like leaking memory allocated for clk-gate/clk-mux/clk-divider code).
> > This is addressed later.
> 
> It seems we need separate functions for unregistering the standard
> mux/gate/div clocks.

Yep, I put it on our TODO list...

> > Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> > Reported-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> > Reported-by: Kevin Hilman <khilman@kernel.org>
> > ---
> >  drivers/clk/samsung/clk-exynos-audss.c | 346 +++++++++++++++++++++++++++++----
> >  1 file changed, 311 insertions(+), 35 deletions(-)
> > 
> > diff --git a/drivers/clk/samsung/clk-exynos-audss.c b/drivers/clk/samsung/clk-exynos-audss.c
> > index 7c4368e75ede..9ec7de866ab4 100644
> > --- a/drivers/clk/samsung/clk-exynos-audss.c
> > +++ b/drivers/clk/samsung/clk-exynos-audss.c
> > @@ -29,6 +29,7 @@ static DEFINE_SPINLOCK(lock);
> >  static struct clk **clk_table;
> >  static void __iomem *reg_base;
> >  static struct clk_onecell_data clk_data;
> > +static struct clk *pll_in;
> >  
> >  #define ASS_CLK_SRC 0x0
> >  #define ASS_CLK_DIV 0x4
> > @@ -75,6 +76,276 @@ static const struct of_device_id exynos_audss_clk_of_match[] = {
> >  	{},
> >  };
> >  
> > +static int pll_clk_enable(void)
> > +{
> > +	if (!IS_ERR(pll_in))
> > +		return clk_enable(pll_in);
> > +
> > +	return 0;
> > +}
> > +
> > +static void pll_clk_disable(void)
> > +{
> > +	if (!IS_ERR(pll_in))
> > +		clk_disable(pll_in);
> > +}
> > +
> > +static int audss_clk_gate_enable(struct clk_hw *hw)
> > +{
> > +	int ret;
> > +
> > +	ret = pll_clk_enable();
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = clk_gate_ops.enable(hw);
> > +
> > +	pll_clk_disable();
> > +
> > +	return ret;
> > +}
> > +
> > +static void audss_clk_gate_disable(struct clk_hw *hw)
> > +{
> > +	int ret;
> > +
> > +	ret = pll_clk_enable();
> > +	if (ret)
> > +		return;
> > +
> > +	clk_gate_ops.disable(hw);
> > +
> > +	pll_clk_disable();
> > +}
> > +
> > +static int audss_clk_gate_is_enabled(struct clk_hw *hw)
> > +{
> > +	int ret;
> > +
> > +	ret = pll_clk_enable();
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = clk_gate_ops.is_enabled(hw);
> > +
> > +	pll_clk_disable();
> > +
> > +	return ret;
> > +}
> > +
> > +static const struct clk_ops audss_clk_gate_ops = {
> > +	.enable = audss_clk_gate_enable,
> > +	.disable = audss_clk_gate_disable,
> > +	.is_enabled = audss_clk_gate_is_enabled,
> > +};
> 
> As Tomasz suggested a better approach could be to use regmap
> and let it handle the PLL clock. Unfortunately there the regmap
> is not supported for the base clock types in the clock core and
> that would require even more work and more added code.
> 
> > +/*
> > + * A simplified copy of clk-gate.c:clk_register_gate() to mimic
> > + * clk-gate behavior while using customized ops.
> > + *
> > + * TODO: just like clk-gate it leaks memory for struct clk_gate.
> 
> Please squash patch 5/5 into this one for the next iteration.

Sure.

> 
> > + */
> > +static struct clk *audss_clk_register_gate(struct device *dev, const char *name,
> > +		const char *parent_name, unsigned long flags, u8 bit_idx)
> > +{
> > +	struct clk_gate *gate;
> > +	struct clk *clk;
> > +	struct clk_init_data init;
> > +
> > +	/* allocate the gate */
> > +	gate = kzalloc(sizeof(struct clk_gate), GFP_KERNEL);
> > +	if (!gate)
> > +		return ERR_PTR(-ENOMEM);
> > +
> > +	init.name = name;
> > +	init.ops = &audss_clk_gate_ops;
> > +	init.flags = flags | CLK_IS_BASIC;
> > +	init.parent_names = (parent_name ? &parent_name : NULL);
> > +	init.num_parents = (parent_name ? 1 : 0);
> > +
> > +	/* struct clk_gate assignments */
> > +	gate->reg = reg_base + ASS_CLK_GATE;
> > +	gate->bit_idx = bit_idx;
> > +	gate->flags = 0;
> > +	gate->lock = &lock;
> > +	gate->hw.init = &init;
> > +
> > +	clk = clk_register(dev, &gate->hw);
> > +
> > +	if (IS_ERR(clk))
> > +		kfree(gate);
> > +
> > +	return clk;
> > +}
> > +
> 
> >  /* register exynos_audss clocks */
> >  static int exynos_audss_clk_probe(struct platform_device *pdev)
> >  {
> > @@ -83,7 +354,7 @@ static int exynos_audss_clk_probe(struct platform_device *pdev)
> >  	const char *mout_audss_p[] = {"fin_pll", "fout_epll"};
> >  	const char *mout_i2s_p[] = {"mout_audss", "cdclk0", "sclk_audio0"};
> >  	const char *sclk_pcm_p = "sclk_pcm0";
> > -	struct clk *pll_ref, *pll_in, *cdclk, *sclk_audio, *sclk_pcm_in;
> 
> How about pll_in locally, using a different name for the global pointer
> and ensuring the global pointer is properly initialized to ERR_PTR value
> for cases where we don't need to touch the APLL clock ?

OK.

> 
> > +	struct clk *pll_ref, *cdclk, *sclk_audio, *sclk_pcm_in;
> >  	const struct of_device_id *match;
> >  	enum exynos_audss_clk_type variant;
> >  
> > @@ -115,12 +386,21 @@ static int exynos_audss_clk_probe(struct platform_device *pdev)
> >  	pll_in = devm_clk_get(&pdev->dev, "pll_in");
> >  	if (!IS_ERR(pll_ref))
> >  		mout_audss_p[0] = __clk_get_name(pll_ref);
> > -	if (!IS_ERR(pll_in))
> > +	if (!IS_ERR(pll_in)) {
> >  		mout_audss_p[1] = __clk_get_name(pll_in);
> > -	clk_table[EXYNOS_MOUT_AUDSS] = clk_register_mux(NULL, "mout_audss",
> > +
> > +		ret = clk_prepare(pll_in);
> > +		if (ret) {
> > +			dev_err(&pdev->dev,
> > +				"failed to prepare the pll_in clock\n");
> > +			return ret;
> > +		}
> 
> Let's introduce such chnages only for SoC's where that's really necessary,
> AFAICS it seems to be needed only for "samsung,exynos5420-audss-clock"
> compatible.

Yes, it turned out that only Exynos 5420 has mau_epll clock. On
Exynos4412 for example such problem does not exist.

> > +	}
> > +
> > +	clk_table[EXYNOS_MOUT_AUDSS] = audss_clk_register_mux(NULL, "mout_audss",
> >  				mout_audss_p, ARRAY_SIZE(mout_audss_p),
> > -				CLK_SET_RATE_NO_REPARENT,
> > -				reg_base + ASS_CLK_SRC, 0, 1, 0, &lock);
> > +				CLK_SET_RATE_NO_REPARENT, 0, 1);
> 
> I would prefer leaving the register's address in the arguments list.
> Now you're passing the bit index but not the actual register.

Hmm... that would extend the arguments list without any information (the
register is the same)... but sure, I'll add it.

> 
> >  	cdclk = devm_clk_get(&pdev->dev, "cdclk");
> >  	sclk_audio = devm_clk_get(&pdev->dev, "sclk_audio");
> 

Thanks for reviewing!
Krzysztof
