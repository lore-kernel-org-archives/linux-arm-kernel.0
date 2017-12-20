From: dongas86@gmail.com (Dong Aisheng)
Date: Wed, 20 Dec 2017 22:33:22 +0800
Subject: [PATCH V2 02/10] clk: reparent orphans after critical clocks
 enabled
In-Reply-To: <20171102073609.GT30645@codeaurora.org>
References: <1499946435-7177-1-git-send-email-aisheng.dong@nxp.com>
 <1499946435-7177-3-git-send-email-aisheng.dong@nxp.com>
 <20171102073609.GT30645@codeaurora.org>
Message-ID: <20171220143322.GC30461@b29396-OptiPlex-7040>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 02, 2017 at 12:36:09AM -0700, Stephen Boyd wrote:
> On 07/13, Dong Aisheng wrote:
> > The orphan clocks reparent operation should be moved after the critical
> > clocks enabled, otherwise it may get a chance to disable a newly
> > registered critical clock which triggers the following warning.
> > 
> > Assuming we have two clocks: A and B, B is the parent of A.
> > Clock A has flag: CLK_OPS_PARENT_ENABLE
> > Clock B has flag: CLK_IS_CRITICAL
> > 
> > Step 1:
> > Clock A is registered, then it becomes orphan.
> > 
> > Step 2:
> > Clock B is registered. Before clock B reach the critical clock enable
> > operation, orphan A will find the newly registered parent B and do
> > reparent operation, then parent B will be finally disabled in
> > __clk_set_parent_after() due to CLK_OPS_PARENT_ENABLE flag as there's
> > still no users of B which will then trigger the following warning.
> > 
> > [    0.000000] WARNING: CPU: 0 PID: 0 at drivers/clk/clk.c:597 clk_core_disable+0xb4/0xe0
> > [    0.000000] Modules linked in:
> > [    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.11.0-rc1-00056-gdff1f66-dirty #1373
> > [    0.000000] Hardware name: Generic DT based system
> > [    0.000000] Backtrace:
> > [    0.000000] [<c010c4bc>] (dump_backtrace) from [<c010c764>] (show_stack+0x18/0x1c)
> > [    0.000000]  r6:600000d3 r5:00000000 r4:c0e26358 r3:00000000
> > [    0.000000] [<c010c74c>] (show_stack) from [<c040599c>] (dump_stack+0xb4/0xe8)
> > [    0.000000] [<c04058e8>] (dump_stack) from [<c0125c94>] (__warn+0xd8/0x104)
> > [    0.000000]  r10:c0c21cd0 r9:c048aa78 r8:00000255 r7:00000009 r6:c0c1cd90 r5:00000000
> > [    0.000000]  r4:00000000 r3:c0e01d34
> > [    0.000000] [<c0125bbc>] (__warn) from [<c0125d74>] (warn_slowpath_null+0x28/0x30)
> > [    0.000000]  r9:00000000 r8:ef00bf80 r7:c165ac4c r6:ef00bf80 r5:ef00bf80 r4:ef00bf80
> > [    0.000000] [<c0125d4c>] (warn_slowpath_null) from [<c048aa78>] (clk_core_disable+0xb4/0xe0)
> > [    0.000000] [<c048a9c4>] (clk_core_disable) from [<c048be88>] (clk_core_disable_lock+0x20/0x2c)
> > [    0.000000]  r4:000000d3 r3:c0e0af00
> > [    0.000000] [<c048be68>] (clk_core_disable_lock) from [<c048c224>] (clk_core_disable_unprepare+0x14/0x28)
> > [    0.000000]  r5:00000000 r4:ef00bf80
> > [    0.000000] [<c048c210>] (clk_core_disable_unprepare) from [<c048c270>] (__clk_set_parent_after+0x38/0x54)
> > [    0.000000]  r4:ef00bd80 r3:000010a0
> > [    0.000000] [<c048c238>] (__clk_set_parent_after) from [<c048daa8>] (clk_register+0x4d0/0x648)
> > [    0.000000]  r6:ef00d500 r5:ef00bf80 r4:ef00bd80 r3:ef00bfd4
> > [    0.000000] [<c048d5d8>] (clk_register) from [<c048dc30>] (clk_hw_register+0x10/0x1c)
> > [    0.000000]  r9:00000000 r8:00000003 r7:00000000 r6:00000824 r5:00000001 r4:ef00d500
> > [    0.000000] [<c048dc20>] (clk_hw_register) from [<c048e698>] (_register_divider+0xcc/0x120)
> > [    0.000000] [<c048e5cc>] (_register_divider) from [<c048e730>] (clk_register_divider+0x44/0x54)
> > [    0.000000]  r10:00000004 r9:00000003 r8:00000001 r7:00000000 r6:00000003 r5:00000001
> > [    0.000000]  r4:f0810030
> > [    0.000000] [<c048e6ec>] (clk_register_divider) from [<c0d3ff58>] (imx7ulp_clocks_init+0x558/0xe98)
> > [    0.000000]  r7:c0e296f8 r6:c165c808 r5:00000000 r4:c165c808
> > [    0.000000] [<c0d3fa00>] (imx7ulp_clocks_init) from [<c0d24db0>] (of_clk_init+0x118/0x1e0)
> > [    0.000000]  r10:00000001 r9:c0e01f68 r8:00000000 r7:c0e01f60 r6:ef7f8974 r5:ef0035c0
> > [    0.000000]  r4:00000006
> > [    0.000000] [<c0d24c98>] (of_clk_init) from [<c0d04a50>] (time_init+0x2c/0x38)
> > [    0.000000]  r10:efffed40 r9:c0d61a48 r8:c0e78000 r7:c0e07900 r6:ffffffff r5:c0e78000
> > [    0.000000]  r4:00000000
> > [    0.000000] [<c0d04a24>] (time_init) from [<c0d00b8c>] (start_kernel+0x218/0x394)
> > [    0.000000] [<c0d00974>] (start_kernel) from [<6000807c>] (0x6000807c)
> > [    0.000000]  r10:00000000 r9:410fc075 r8:6000406a r7:c0e0c930 r6:c0d61a44 r5:c0e07918
> > [    0.000000]  r4:c0e78294
> > [    0.000000] ---[ end trace 0000000000000000 ]---
> 
> Please remove timestamps from logs unless they're important.
> 

Got it.

> > 
> > Fixes: fc8726a2c021 ("clk: core: support clocks which requires parents enable (part 2)")
> > Cc: Stephen Boyd <sboyd@codeaurora.org>
> > Cc: Michael Turquette <mturquette@baylibre.com>
> > Cc: Shawn Guo <shawnguo@kernel.org>
> > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> > 
> > ---
> > ChangeLog:
> > v1->v2:
> >  * add more detailed commit messages
> 
> Thanks for that. We shouldn't be touching the hardware during clk
> registration though, so something is wrong there. It seems that
> adding the flag to enable clks when touching their registers has
> exposed that we should just be doing the toggle of the bookeeping
> stuff underneath the enable lock here.
> 
> We know that the clk isn't enabled with any sort of prepare_count
> here so we don't need to enable anything to prevent a race. And
> we're holding the prepare mutex so set_rate/set_parent can't race
> here either.
> 

Well, it looks like a good suggestion and it does make sense.

> Can you try this patch instead?
> 
> ---8<----
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index c8d83acda006..416d44cc772c 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -2476,14 +2476,17 @@ static int __clk_core_init(struct clk_core *core)
>  	 */
>  	hlist_for_each_entry_safe(orphan, tmp2, &clk_orphan_list, child_node) {
>  		struct clk_core *parent = __clk_init_parent(orphan);
> +		unsigned long flags;
>  
>  		/*
>  		 * we could call __clk_set_parent, but that would result in a
>  		 * redundant call to the .set_rate op, if it exists
>  		 */
>  		if (parent) {
> -			__clk_set_parent_before(orphan, parent);
> -			__clk_set_parent_after(orphan, parent, NULL);
> +			/* update the clk tree topology */
> +			flags = clk_enable_lock();
> +			clk_reparent(orphan, parent);
> +			clk_enable_unlock(flags);
>  			__clk_recalc_accuracies(orphan);
>  			__clk_recalc_rates(orphan, 0);
>  		}


I tested this change worked well.
I could resent the patch with this new method later.

Regards
Dong Aisheng
