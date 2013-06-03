From: dianders@chromium.org (Doug Anderson)
Date: Mon, 3 Jun 2013 13:10:56 -0700
Subject: [PATCH V4 2/4] clk: samsung: register audio subsystem clocks
 using common clock framework
In-Reply-To: <1370236744-16802-3-git-send-email-padma.v@samsung.com>
References: <1370236744-16802-1-git-send-email-padma.v@samsung.com>
 <1370236744-16802-3-git-send-email-padma.v@samsung.com>
Message-ID: <CAD=FV=XOfi=BsaF+-96SqKwyiwP9h0h3MCJxJ+qWNKaGoP=CcA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Padmavathi,

On Sun, Jun 2, 2013 at 10:19 PM, Padmavathi Venna <padma.v@samsung.com> wrote:

> +static unsigned long reg_save[][2] = {
> +       {ASS_CLK_SRC,  0},
> +       {ASS_CLK_DIV,  0},
> +       {ASS_CLK_GATE, 0},
> +};
> +
> +/* list of all parent clock list */
> +static const char *mout_audss_p[] = { "fin_pll", "fout_epll" };

I think this is supposed to be "xxti" which might or might not be
"fin_pll".  In the exynos4 code these are two different clocks that
are chosen by OM[0].  I'd bet that 99% of the time they are the same,
but it seems better to use "xxti".

At the moment the 5250 code doesn't expose "xxti".  It probably
should.  Andrew (CCed) is looking at this.


> +static const char *mout_i2s_p[] = { "mout_audss", "cdclk0", "sclk_audio0" };
> +
> +#ifdef CONFIG_PM_SLEEP
> +static int exynos_audss_clk_suspend(void)
> +{
> +       int i;
> +
> +       for (i = 0; i < 3; i++)

Can't you use ARRAY_SIZE?


> +void __init exynos_audss_clk_init(struct device_node *np)
> +{
> +       reg_base = of_iomap(np, 0);
> +       if (!reg_base) {
> +               pr_err("%s: failed to map audss registers\n", __func__);
> +               return;
> +       }
> +
> +       clk_table = kzalloc(sizeof(struct clk *) * EXYNOS_AUDSS_MAX_CLKS,
> +                               GFP_KERNEL);
> +       if (!clk_table) {
> +               pr_err("%s: could not allocate clk lookup table\n", __func__);
> +               return;
> +       }
> +
> +       clk_data.clks = clk_table;
> +       clk_data.clk_num = EXYNOS_AUDSS_MAX_CLKS;
> +       of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
> +
> +       clk_table[EXYNOS_MOUT_AUDSS] = clk_register_mux(NULL, "mout_audss",
> +                               mout_audss_p, ARRAY_SIZE(mout_audss_p), 0,
> +                               reg_base + ASS_CLK_SRC, 0, 1, 0, &lock);
> +
> +       clk_table[EXYNOS_MOUT_I2S] = clk_register_mux(NULL, "mout_i2s",
> +                               mout_i2s_p, ARRAY_SIZE(mout_i2s_p), 0,
> +                               reg_base + ASS_CLK_SRC, 2, 2, 0, &lock);
> +
> +       clk_table[EXYNOS_DOUT_SRP] = clk_register_divider(NULL, "dout_srp",
> +                               "mout_audss", 0, reg_base + ASS_CLK_DIV, 0, 4,
> +                               0, &lock);
> +
> +       clk_table[EXYNOS_DOUT_BUS] = clk_register_divider(NULL, "dout_bus",

I'm learning that clock names need to be globally unique in a given
system.  Perhaps "dout_aud_bus" might be more descriptive and less
likely to cause conflicts?
