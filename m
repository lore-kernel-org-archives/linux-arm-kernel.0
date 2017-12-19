From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 19 Dec 2017 19:17:13 +0530
Subject: [PATCH v3 4/5] ARM: davinci: convert to common clock framework
In-Reply-To: <1512785711-15064-5-git-send-email-david@lechnology.com>
References: <1512785711-15064-1-git-send-email-david@lechnology.com>
 <1512785711-15064-5-git-send-email-david@lechnology.com>
Message-ID: <b8025b62-c7c0-29f8-388d-d84816adf688@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi David,

On Saturday 09 December 2017 07:45 AM, David Lechner wrote:
> This converts the clocks in mach-davinci to the common clock framework.
> 
> Most of the patch just involves renaming struct clk to struct davinci_clk.
> There is also a struct clk_hw added to provide the bridge between the
> existing clock implementation and the common clock framework.
> 
> The clk_get_parent and clk_set_parent callbacks are dropped because all
> clocks currently (effectivly) have a single parent, in which case the
> common clock framework does not want you to implement these functions
> yourself.
> 
> clk_unregister() is dropped because it is not used anywhere in
> mach-davinci.
> 
> EXPORT_SYMBOL() is removed from functions not used outside of mach-davinci.
> 
> Fixed checkpatch.pl warning about bare use of unsigned in dump_clock().
> 
> Signed-off-by: David Lechner <david@lechnology.com>

The cleanups leading upto this patch look fine, but I am not sure about
this patch itself. Ideally, we should have moved to drivers/clk also.
And shared code with keystone too since the PSC and PLL implementations
of the two architectures are quite similar.

I could think of this as an intermediate step while we get there, but I
am afraid of the churn that would cause. For example, if we reuse
keystone driver, we will be using clk_psc and we can get rid of the
davinci_clk that this patch introduces.

So unless there is big roadblock to moving to drivers/clk, we should
probably do that in one shot.

Thanks,
Sekhar
