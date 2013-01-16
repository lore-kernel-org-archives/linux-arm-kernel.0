From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Wed, 16 Jan 2013 13:31:51 +0100
Subject: [PATCH v4 2/9] clk: tegra: Add tegra specific clocks
In-Reply-To: <1357890387-23245-3-git-send-email-pgaikwad@nvidia.com>
References: <1357890387-23245-1-git-send-email-pgaikwad@nvidia.com><1357890387-23245-3-git-send-email-pgaikwad@nvidia.com>
Message-ID: <20130116.143151.1531468192773974887.hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Prashant Gaikwad <pgaikwad@nvidia.com> wrote @ Fri, 11 Jan 2013 08:46:20 +0100:
...
> +const struct clk_ops tegra_clk_periph_ops = {
> +       .get_parent = clk_periph_get_parent,
> +       .set_parent = clk_periph_set_parent,
> +       .recalc_rate = clk_periph_recalc_rate,
> +       .round_rate = clk_periph_round_rate,
> +       .set_rate = clk_periph_set_rate,
> +       .is_enabled = clk_periph_is_enabled,
> +       .enable = clk_periph_enable,
> +       .disable = clk_periph_disable,
> +};
> +
> +const struct clk_ops tegra_clk_periph_nodiv_ops = {
> +       .get_parent = clk_periph_get_parent,
> +       .set_parent = clk_periph_set_parent,
> +       .is_enabled = clk_periph_is_enabled,
> +       .enable = clk_periph_enable,
> +       .disable = clk_periph_disable,
> +};
> +
> +struct clk *tegra_clk_periph(const char *name, const char **parent_names,
> +                            int num_parents, struct tegra_clk_periph *periph,
> +                            void __iomem *clk_base, u32 offset)
> +{
> +       struct clk *clk;
> +       struct clk_init_data init;
> +
> +       init.name = name;
> +       init.ops = &tegra_clk_periph_ops;
> +       init.flags = 0;
> +       init.parent_names = parent_names;
> +       init.num_parents = num_parents;
> +
> +       periph->hw.init = &init;
> +       periph->magic = TEGRA_CLK_PERIPH_MAGIC;
> +       periph->mux.reg = clk_base + offset;
> +       periph->divider.reg = clk_base + offset;
> +       periph->gate.clk_base = clk_base;
> +
> +       clk = clk_register(NULL, &periph->hw);
> +       if (IS_ERR(clk))
> +               return clk;
> +
> +       periph->mux.hw.clk = clk;
> +       periph->divider.hw.clk = clk;
> +       periph->gate.hw.clk = clk;
> +
> +       return clk;
> +}
> +
> +struct clk *tegra_clk_periph_nodiv(const char *name, const char **parent_names,
> +                             int num_parents, struct tegra_clk_periph *periph,
> +                             void __iomem *clk_base, u32 offset)
> +{
> +       struct clk *clk;
> +       struct clk_init_data init;
> +
> +       init.name = name;
> +       init.ops = &tegra_clk_periph_nodiv_ops;
> +       init.flags = CLK_SET_RATE_PARENT;
> +       init.parent_names = parent_names;
> +       init.num_parents = num_parents;
> +
> +       periph->hw.init = &init;
> +       periph->magic = TEGRA_CLK_PERIPH_MAGIC;
> +       periph->mux.reg = clk_base + offset;
> +       periph->gate.clk_base = clk_base;
> +
> +       clk = clk_register(NULL, &periph->hw);
> +       if (IS_ERR(clk))
> +               return clk;
> +
> +       periph->mux.hw.clk = clk;
> +       periph->gate.hw.clk = clk;
> +
> +       return clk;
> +}

The above two functions are almost duplicate, can we take the common part from them?

const struct clk_ops tegra_clk_periph_nodiv_ops = {
       .get_parent = clk_periph_get_parent,
       .set_parent = clk_periph_set_parent,
       .is_enabled = clk_periph_is_enabled,
       .enable = clk_periph_enable,
       .disable = clk_periph_disable,
};

struct clk *__tegra_clk_periph(const char *name, const char **parent_names,
			    int num_parents, struct tegra_clk_periph *periph,
			    void __iomem *clk_base, u32 offset, int div)
{
       struct clk *clk;
       struct clk_init_data init;

       init.name = name;
       init.parent_names = parent_names;
       init.num_parents = num_parents;
       init.ops = div ? &tegra_clk_periph_ops : &tegra_clk_periph_nodiv_ops
       init.flags = div ? 0 :?CLK_SET_RATE_PARENT;

       periph->hw.init = &init;
       periph->magic = TEGRA_CLK_PERIPH_MAGIC;
       periph->mux.reg = clk_base + offset;
       periph->divider.reg = clk_base + offset;
       periph->gate.clk_base = clk_base;

       clk = clk_register(NULL, &periph->hw);
       if (IS_ERR(clk))
	       return clk;

       periph->mux.hw.clk = clk;
       periph->divider.hw.clk = div ? NULL : clk;
       periph->gate.hw.clk = clk;

       return clk;
}

static inline struct clk *tegra_clk_periph(const char *name, const char **parent_names,
			    int num_parents, struct tegra_clk_periph *periph,
			    void __iomem *clk_base, u32 offset)
{
	return __tegra_clk_periph(name, parent_names, num_parents, periph, clk_base, offset, 1);
}

static inline struct clk *tegra_clk_periph_nodiv(const char *name, const char **parent_names,
			     int num_parents, struct tegra_clk_periph *periph,
			     void __iomem *clk_base, u32 offset, )
{
	return __tegra_clk_periph(name, parent_names, num_parents, periph, clk_base, offset, 0);
}
