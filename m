From: mturquette@linaro.org (Mike Turquette)
Date: Thu, 21 Mar 2013 11:50:51 -0700
Subject: [RFC 1/8] RFC: CLK: OMAP: Add basic infrastructure for OMAP clocks
In-Reply-To: <1363887347-4686-2-git-send-email-t-kristo@ti.com>
References: <1363887347-4686-1-git-send-email-t-kristo@ti.com>
 <1363887347-4686-2-git-send-email-t-kristo@ti.com>
Message-ID: <20130321185051.834.97551@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Tero Kristo (2013-03-21 10:35:40)
> This patch adds basic infrastructure support for registering clocks
> under common clock framework. This patch is done in preparation for
> moving clock data from arch/arm/mach-omap2/ folder under /drivers/clk/omap.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> Cc: Mike Turquette <mturquette@linaro.org>

Thanks for taking a crack at this Tero!  This is a great step towards
getting rid of clk-private.h.

Regarding the long-term roadmap of the omap clock code:

In general all of the changes to the omap clock code for using the
common struct clk have been very incremental.  We still have the old
legacy struct clk definition, the name of that struct was changed to
clk_hw_omap, but it is still a fairly large, monolithic structure.  Are
there plans to break the clock types up into smaller, more focused clock
types?  E.g. get rid of struct dpll_data and have a dedicated dpll clock
type.

The question above is not reason to block this patch since it is a
fairly large refactoring effort, but it is something to consider.

Some comments below.

<snip>

> +struct omap_clk {
> +       u16                             cpu;
> +       const char                      *dev_id;
> +       const char                      *con_id;
> +       struct omap_init_clk            *clk;
> +};
> +
> +#define CLK(dev, con, ck, cp)          \
> +       {                               \
> +               .cpu = cp,              \
> +               .dev_id = dev,          \
> +               .con_id = con,          \
> +               .clk = ck,              \
> +       }       
> +

IS omap_clk and CLK really necessary today?  I thought that the move to
separate clocks out by tables got rid of this macro/structure?

> +#define OMAP_CLK_FIXED_RATE(_name, _flags, _rate, _ignore)     \
> +       static struct omap_init_clk _name __initdata = {        \
> +               .name = #_name,                                 \
> +               .clk_flags = _flags,                            \
> +               .rate = _rate,                                  \
> +               .clk_register = omap_clk_register_fixed_rate,   \
> +       };
> +

These macros are unreadable.  They were originally born out of the nasty
clk-private.h stuff which included forward declarations of struct clk
and all sorts of ugliness.  I know it saves you LoC to use them now but
I really prefer to use designated initializers for the sake of
readability.  Do you plan to convert the OMAP clock code back to how it
was, pre-macros?

Regards,
Mike
