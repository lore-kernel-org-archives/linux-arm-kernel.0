From: mturquette@ti.com (Turquette, Mike)
Date: Mon, 12 Dec 2011 13:06:35 -0800
Subject: [PATCH v3 4/5] clk: basic gateable and fixed-rate clks
In-Reply-To: <20111212194757.GB12131@lunn.ch>
References: <20111212194757.GB12131@lunn.ch>
Message-ID: <CAJOA=zP1CAsCqJERvXC6tTh_gs_boGYnO3MUC5=Vgiiw=0Vs_w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 12, 2011 at 11:47 AM, Andrew Lunn <andrew@lunn.ch> wrote:
> Hi Mike
>
> +int clk_register_gate(struct device *dev, const char *name, unsigned long flags,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? struct clk *fixed_parent, void __iomem *reg, u8 bit_idx,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?int set_to_enable)
> +
>
> How do you suggest handling gated clocks which are already running
> when calling the register function?
>
> On my kirkwood bases system, the bootloader has already turned on a
> number of clocks. It does not seem right to start messing with
> clk->enable_count and clk->prepare_count. Could clk_register_gate()
> have one more parameter, a bool indicating running?

I don't like this approach.  If the bool for a particular clk is
statically defined then it could be wrong (bootloader/kernel
mismatch).

I've been thinking of adding a clk->ops->init callback in clk_init,
which is defined for a platform to use however the author sees fit.
There have been a few cases where it would be nice to "init" a clk
only once, when it is registered.  That code could also handle
detecting if a clk is enabled or not.

On the other hand we already have a .get_parent callback which is only
good for figuring out which parent a mux clk is using... maybe a
.is_enabled or .get_enabled would be a good idea which also served the
purpose of dynamically determining whether a clk is disabled or
running.

In general though I think we should try to keep the solution in the
core code, not by having platform code pass in a bool.

> The kirkwood mach code keeps a bitmap of which platform_data init
> functions are called from the board file. In a late_initcall function
> it then enables and disables clocks as needed. What i was thinking is
> i can ask the hardware what clocks are already running before i
> register them and register them as running/not running. Then let the
> driver probe functions use the API to enable clocks which are really
> needed. In a late_initcall function, i would then call clk_disable(),
> clk_unprepare() on clocks which the boot loader started, thus turning
> them off if no driver has claimed them.

The problem here is that you're solving the "disabled unused clks"
issue in platform code.  I've started to lay out a little groundwork
for that with a flag in struct clk:
http://git.linaro.org/gitweb?p=people/mturquette/linux.git;a=blob;f=include/linux/clk.h;h=3b0eb3f1caf1d6346b62c785b74a648587bfcc7f;hb=586c6e8922a889a2893ba4467bb3d13b471656a9#l35

The idea behind CLK_IGNORE_UNUSED flag on line 35 is that the common
clk framework can walk the tree (probably as part of a late_initcall,
as you suggested) and disable any clks that aren't already enabled and
don't have this flag set.  This involves zero platform-specific code,
but I haven't gotten around to introducing the feature yet as I'm
really trying to minimize footprint for the core code (and I'm not
doing a good job of that since it keeps growing).

Regards,
Mike

> Is this how you envisage it working?
>
> Thanks
> ? ? ? ?Andrew
