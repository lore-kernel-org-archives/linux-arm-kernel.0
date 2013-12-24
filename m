From: gsi@denx.de (Gerhard Sittig)
Date: Tue, 24 Dec 2013 16:07:41 +0100
Subject: [PATCH v4 03/15] clk: Add regmap core helpers for
 enable/disable/is_enabled
In-Reply-To: <1387847559-18330-4-git-send-email-sboyd@codeaurora.org>
References: <1387847559-18330-1-git-send-email-sboyd@codeaurora.org>
 <1387847559-18330-4-git-send-email-sboyd@codeaurora.org>
Message-ID: <20131224150741.GG8064@book.gsilab.sittig.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 23, 2013 at 17:12 -0800, Stephen Boyd wrote:
> 
> The clock framework already has support for simple gate clocks
> but if drivers want to use the gate clock functionality they need
> to wrap the gate clock in another struct and chain the ops by
> calling the gate ops from their own custom ops. Plus the gate
> clock implementation only supports MMIO accessors so other bus
> type clocks don't benefit from the potential code reuse. Add some
> simple regmap helpers for enable/disable/is_enabled that drivers
> can use as drop in replacements for their clock ops or as simple
> functions they call from their own custom ops. This is based on 
> similar helps in the regulator framework.

The same comment applies as to the previous version.  Is it
useful to introduce copies of the gate handling while the
difference in only in how the hardware registers get accessed?

> --- a/include/linux/clk-provider.h
> +++ b/include/linux/clk-provider.h
> @@ -177,11 +177,21 @@ struct clk_init_data {
> [ ... ]
> @@ -447,6 +457,9 @@ struct clk *__clk_lookup(const char *name);
>  long __clk_mux_determine_rate(struct clk_hw *hw, unsigned long rate,
>  			      unsigned long *best_parent_rate,
>  			      struct clk **best_parent_p);
> +int clk_is_enabled_regmap(struct clk_hw *hw);
> +int clk_enable_regmap(struct clk_hw *hw);
> +void clk_disable_regmap(struct clk_hw *hw);

Looking at the patch:  Do you expect callers to remember whether
a clock gate is backed by mmio or by regmap access, to call a
different set of routines?  Should this not be hidden behind the
API and be transparent after clock registration?

I'd suggest to fold regmap support into Tero Kristo's ll_ops
approach, and to discuss this in his v12 thread.


virtually yours
Gerhard Sittig
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr. 5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office at denx.de
