From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 16 Jan 2013 11:44:35 -0700
Subject: [PATCH v4 2/9] clk: tegra: Add tegra specific clocks
In-Reply-To: <20130116.143151.1531468192773974887.hdoyu@nvidia.com>
References: <1357890387-23245-1-git-send-email-pgaikwad@nvidia.com><1357890387-23245-3-git-send-email-pgaikwad@nvidia.com>
 <20130116.143151.1531468192773974887.hdoyu@nvidia.com>
Message-ID: <50F6F513.1030806@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/16/2013 05:31 AM, Hiroshi Doyu wrote:
> Prashant Gaikwad <pgaikwad@nvidia.com> wrote @ Fri, 11 Jan 2013 08:46:20 +0100:
> ...
>> +struct clk *tegra_clk_periph(const char *name, const char **parent_names,
>> +                            int num_parents, struct tegra_clk_periph *periph,
>> +                            void __iomem *clk_base, u32 offset)
...
>> +struct clk *tegra_clk_periph_nodiv(const char *name, const char **parent_names,
>> +                             int num_parents, struct tegra_clk_periph *periph,
>> +                             void __iomem *clk_base, u32 offset)
...
>
> The above two functions are almost duplicate, can we take the common part from them?

Sure, that looks reasonable.

> struct clk *__tegra_clk_periph(const char *name, const char **parent_names,
> 			    int num_parents, struct tegra_clk_periph *periph,
> 			    void __iomem *clk_base, u32 offset, int div)

>        periph->divider.reg = clk_base + offset;

That will also need to be conditional.

>        periph->divider.hw.clk = div ? NULL : clk;

And that test is inverted.

> static inline struct clk *tegra_clk_periph(const char *name, const char **parent_names,
> 			    int num_parents, struct tegra_clk_periph *periph,
> 			    void __iomem *clk_base, u32 offset)

I'd rather just make these regular functions in the .c file; otherwise
they have to go into the header file, which means prototyping
__tegra_clk_periph() there and it just gets messy.
