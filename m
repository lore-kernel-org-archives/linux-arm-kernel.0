From: mturquette@ti.com (Mike Turquette)
Date: Thu, 23 Aug 2012 19:31:35 -0700
Subject: [PATCH 1/1] clk: add DT support for clock gating control
In-Reply-To: <1341767726-25630-1-git-send-email-sebastian.hesselbarth@googlemail.com>
References: <1341767726-25630-1-git-send-email-sebastian.hesselbarth@googlemail.com>
Message-ID: <20120824023135.4547.2534@nucleus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Sebastian Hesselbarth (2012-07-08 10:15:26)
> This patch adds support for using clock gates (clk-gate) from DT based
> on Rob Herrings DT clk binding support for 3.6.
> 
> It adds a helper function to clk-gate to allocate all resources required by
> a set of individual clock gates, i.e. register base address and lock. Each
> clock gate is described as a child of the clock-gating-control in DT and
> also created by the helper function.
> 

Hi Sebastian,

Thanks for submitting this.  I'd prefer for Rob or someone with a more vested
interest in DT to review your binding.  I have some comments on the code below.

<snip>
> diff --git a/drivers/clk/clk-gate.c b/drivers/clk/clk-gate.c
> index 578465e..1e88907 100644
> --- a/drivers/clk/clk-gate.c
> +++ b/drivers/clk/clk-gate.c
> @@ -15,6 +15,9 @@
>  #include <linux/io.h>
>  #include <linux/err.h>
>  #include <linux/string.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_platform.h>
>  
>  /**
>   * DOC: basic gatable clock which can gate and ungate it's ouput
> @@ -148,3 +151,84 @@ struct clk *clk_register_gate(struct device *dev, const char *name,
>  
>         return clk;
>  }
> +
> +#ifdef CONFIG_OF
> +/**
> + * of_clock_gating_control_setup() - Setup function for clock gate control
> + *   This is a helper for using clk-gate from OF device tree. It allocates
> + *   a common lock for a base register and creates the individual clk-gates.
> + */
> +void __init of_clock_gating_control_setup(struct device_node *np)
> +{
> +       struct device_node *child;
> +       const char *pclk_name;
> +       void __iomem *base;
> +       spinlock_t *lockp;
> +       unsigned int rnum;
> +       u64 addr;
> +
> +       pclk_name = of_clk_get_parent_name(np, 0);
> +       if (!pclk_name) {
> +               pr_debug("%s: unable to get parent clock for %s\n",
> +                       __func__, np->full_name);
> +               return;
> +       }
> +
> +       lockp = kzalloc(sizeof(spinlock_t), GFP_KERNEL);
> +       if (!lockp) {
> +               pr_debug("%s: unable to allocate spinlock for %s\n",
> +                        __func__, np->full_name);
> +               return;
> +       }
> +
> +       spin_lock_init(lockp);

The spinlocks for the basic clock types have always been optional.  This
code should reflect that and not assume the spinlock.

Also I wonder if the assumption is true that a single spinlock
corresponding to a device_node is always the right thing for every
platform.  What about a 32-bit register that contains some gating bits
and a 3-bit wide field for a mux which we perform read-modify-write
operations on?

You'll have to pardon my DT ignorance.  My concerns above may be totally
crazy with respect to DT.

> +       base = of_iomap(np, 0);
> +       rnum = sizeof(resource_size_t) * 8;
> +       addr = of_translate_address(np, of_get_property(np, "reg", NULL));
> +
> +       pr_debug("create clock gate control %s\n", np->full_name);

There are some inconsistent prints here.  How about leading this trace
with a __func__ like you do below for the error messages?

> +
> +       for_each_child_of_node(np, child) {
> +               struct clk *cg;
> +               const char *cg_name;
> +               const char *cg_pclk_name;
> +               u32 propval[2];
> +               unsigned int rbit;
> +
> +               if (of_property_read_u32_array(child, "reg", propval, 2)) {
> +                       pr_debug("%s: wrong #reg on %s\n",
> +                                __func__, child->full_name);
> +                       continue;
> +               }
> +
> +               rbit = propval[0];
> +               if (rbit >= rnum) {
> +                       pr_debug("%s: bit position of %s exceeds resources\n",
> +                                __func__, child->full_name);
> +                       continue;
> +               }
> +
> +               cg_pclk_name = of_clk_get_parent_name(child, 0);
> +               if (!pclk_name)
> +                       cg_pclk_name = pclk_name;

!pclk_name would have caused an early return above, so this conditional
will never evaluate as true.  Even if it did, I'm not sure I follow the
logic.  Why set cg_pclk_name to NULL if pclk_name is NULL?

> +
> +               if (of_property_read_string(child, "clock-output-names",
> +                                           &cg_name)) {
> +                       unsigned int nlen = 4 + 16 + strlen(child->name);
> +                       char *name = kzalloc(nlen+1, GFP_KERNEL);
> +                       if (!name)
> +                               continue;
> +                       snprintf(name, nlen, "%u@%llx.%s", rbit,
> +                                (unsigned long long)addr, child->name);
> +                       cg_name = name;
> +               }
> +
> +               pr_debug("  create clock gate: %s\n", cg_name);

Extra whitespace typo?  Again, would be nice to lead this trace with a
__func__ string.

> +
> +               cg = clk_register_gate(NULL, cg_name, cg_pclk_name, 0,
> +                                      base, rbit, propval[1], lockp);
> +               if (cg)
> +                       of_clk_add_provider(child, of_clk_src_simple_get, cg);

Need to check if clk_register_gate fails and do memory leak cleanup of
name and maybe lockp for the corner case where none of the clock
registration operations succeed.

Regards,
Mike
