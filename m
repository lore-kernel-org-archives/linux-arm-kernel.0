From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 30 Aug 2016 15:10:10 +0200
Subject: [PATCH 1/2] clk: mvebu: set flags in CP110 gate clock
In-Reply-To: <1471933609-8456-2-git-send-email-mw@semihalf.com>
References: <1471933609-8456-1-git-send-email-mw@semihalf.com>
 <1471933609-8456-2-git-send-email-mw@semihalf.com>
Message-ID: <20160830151010.0f85dfd7@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, 23 Aug 2016 08:26:48 +0200, Marcin Wojtas wrote:

> diff --git a/drivers/clk/mvebu/cp110-system-controller.c b/drivers/clk/mvebu/cp110-system-controller.c
> index 7fa42d6..0835e1d 100644
> --- a/drivers/clk/mvebu/cp110-system-controller.c
> +++ b/drivers/clk/mvebu/cp110-system-controller.c
> @@ -144,6 +144,7 @@ static struct clk *cp110_register_gate(const char *name,
>  
>  	init.name = name;
>  	init.ops = &cp110_gate_ops;
> +	init.flags = CLK_IS_BASIC;

Is this really correct?

The documentation for CLK_IS_BASIC is pretty slim, but it says:

   #define CLK_IS_BASIC            BIT(5) /* Basic clk, can't do a to_clk_foo() */

However, we *do* have a to_clk_*() macro in this driver:

struct cp110_gate_clk {
        struct clk_hw hw;
        struct regmap *regmap;
        u8 bit_idx;
};

#define to_cp110_gate_clk(clk) container_of(clk, struct cp110_gate_clk, hw)

If you read the commit log of commit
f7d8caadfd2813cbada82ce9041b13c38e8e5282, which introduced the flag, it
says:

    clk: Add CLK_IS_BASIC flag to identify basic clocks
    
    Most platforms end up using a mix of basic clock types and
    some which use clk_hw_foo struct for filling in custom platform
    information when the clocks don't fit into basic types supported.
    
    In platform code, its useful to know if a clock is using a basic
    type or clk_hw_foo, which helps platforms know if they can
    safely use to_clk_hw_foo to derive the clk_hw_foo pointer from
    clk_hw.
    
    Mark all basic clocks with a CLK_IS_BASIC flag.
    
    Signed-off-by: Rajendra Nayak <rnayak@ti.com>
    Signed-off-by: Mike Turquette <mturquette@linaro.org>

We are in the case where we have our own clk_hw_foo structure, and a
to_clk_hw_foo macro to derive the clk_hw_foo from clk_hw.

According to this, the CP110 clocks are *not* basic clocks, and
therefore we shouldn't have this flag. Perhaps just the memset() is
missing.

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
