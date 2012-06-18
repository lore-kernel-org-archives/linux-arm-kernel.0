From: b-cousson@ti.com (Cousson, Benoit)
Date: Mon, 18 Jun 2012 11:35:36 +0200
Subject: [PATCHv3 5/7] ARM: OMAP4: clock data: add clockdomains for clocks
 used as main clocks
In-Reply-To: <20120618061608.30632.62660.stgit@dusk>
References: <20120618061037.30632.28539.stgit@dusk>
 <20120618061608.30632.62660.stgit@dusk>
Message-ID: <4FDEF668.6050108@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

On 6/18/2012 8:16 AM, Paul Walmsley wrote:
> Until the OMAP4 code is converted to disable the use of the clock
> framework-based clockdomain enable/disable sequence, any clock used as
> a hwmod main_clk must have a clockdomain associated with it.  This
> patch populates some clock structure clockdomain names to resolve the
> following warnings during kernel init:
> 
> omap_hwmod: dpll_mpu_m2_ck: missing clockdomain for dpll_mpu_m2_ck.
> omap_hwmod: trace_clk_div_ck: missing clockdomain for trace_clk_div_ck.
> omap_hwmod: l3_div_ck: missing clockdomain for l3_div_ck.
> omap_hwmod: ddrphy_ck: missing clockdomain for ddrphy_ck.
> 
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Rajendra Nayak <rnayak@ti.com>
> Cc: Beno?t Cousson <b-cousson@ti.com>
> ---
>   arch/arm/mach-omap2/clock44xx_data.c |    5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
> index 2172f66..e2b701e 100644
> --- a/arch/arm/mach-omap2/clock44xx_data.c
> +++ b/arch/arm/mach-omap2/clock44xx_data.c
> @@ -84,6 +84,7 @@ static struct clk slimbus_clk = {
>   
>   static struct clk sys_32k_ck = {
>   	.name		= "sys_32k_ck",
> +	.clkdm_name	= "prm_clkdm",

I guess that patch need to be revisited based on discussion we had and the patch you proposed in [1].
Assuming Tony is OK, it should be probably part of the -rc, because this domain should not have been introduced in 3.5-rc1 at all for OMAP4.
So it will be better to revert the patch that introduced that first before adding any new fix that will rely on a code that will disappear.


In fact, I think the proper way to fix that while maintaining the OMAP2&3 way of dealing with clkdm is to ensure that at least one clkdm is there in either hwmod or the main_clk.
That will fix these issues and the one that will append when the fake main_clk will be removed.

Here is a patch that is doing that.


Thanks,
Benoit

[1] http://www.mail-archive.com/linux-omap at vger.kernel.org/msg70177.html


--- 
>From e5ffe6533236125c3c0b5eff883bfc1cf3cbe9f4 Mon Sep 17 00:00:00 2001
From: Benoit Cousson <b-cousson@ti.com>
Date: Fri, 15 Jun 2012 11:26:49 +0200
Subject: [PATCH] ARM: OMAP2+: hwmod: Do not check clkdm for main_clk if oh does have one

When a clkdm is handled directly at the hwmod level, there is no need to handle
it with the main_clk as well. It is thus useless to complain about the missing clkdm for the main_clk in that case.

Warn only if the clkdm is missing in both main_clk and hwmod.

Init hwmod clkdm first to ensure it will be there when the main_clk
will be initialized.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 162f9c7..f33f4e2 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -609,7 +609,7 @@ static int _init_main_clk(struct omap_hwmod *oh)
 		return -EINVAL;
 	}
 
-	if (!oh->_clk->clkdm)
+	if (!oh->_clk->clkdm && !oh->clkdm)
 		pr_warning("omap_hwmod: %s: missing clockdomain for %s.\n",
 			   oh->main_clk, oh->_clk->name);
 
@@ -1339,10 +1339,10 @@ static int _init_clocks(struct omap_hwmod *oh, void *data)
 
 	pr_debug("omap_hwmod: %s: looking up clocks\n", oh->name);
 
+	ret |= _init_clkdm(oh);
 	ret |= _init_main_clk(oh);
 	ret |= _init_interface_clks(oh);
 	ret |= _init_opt_clks(oh);
-	ret |= _init_clkdm(oh);
 
 	if (!ret)
 		oh->_state = _HWMOD_STATE_CLKS_INITED;
-- 
1.7.0.4
