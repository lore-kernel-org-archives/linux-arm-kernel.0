From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 9 Dec 2014 09:46:53 +0100
Subject: [PATCH] arm: imx: correct the hardware clock gate setting for
 shared nodes
In-Reply-To: <1418111885-3623-1-git-send-email-b20788@freescale.com>
References: <1418111885-3623-1-git-send-email-b20788@freescale.com>
Message-ID: <20141209084653.GR14482@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Dec 09, 2014 at 03:58:05PM +0800, Anson Huang wrote:
> For those clk gates which hold share count, since its is_enabled
> callback is only checking the share count rather than reading
> the hardware register setting, in the late phase of kernel bootup,
> the clk_disable_unused action will NOT handle the scenario of
> share_count is 0 but the hardware setting is enabled, actually,
> uboot normally enables all clk gates, then those shared clk gates
> will be always enabled until they are used by some modules.
> 
> So the problem would be: when kernel boot up, the usecount cat
> from clk tree is 0, but the clk gates actually is enabled in
> hardware register, it will confuse user and bring unnecessary power
> consumption, take i.MX6SX for example, the ESAI clk info
> is as below, the use count is 0, but the hardware register read
> from CCM_CCGR1_CG8 is ungated.

I believe the problem is that the shared count is not increased
correctly during registration. When it would be increased during
registration for each clock that is enabled in hardware clock_disable_unused
could do its job like intended.

Could you test the attached patch?

-------------------------------8<--------------------------

>From 8095ee6e407f33887b2afa504767d00fcca4f10c Mon Sep 17 00:00:00 2001
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Tue, 9 Dec 2014 09:39:06 +0100
Subject: [PATCH] ARM: i.MX: clk-gate2: Fix shared clock enable counting

When during registration of a shared clock the clock is enabled
in hardware the shared_count must be increased. This makes sure
that during clk_disable the shared_count is decreased first before
actually diabling the clock. When done like this the is_enabled
callback can return the hardware state of the clock, like it is
intended.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-imx/clk-gate2.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-imx/clk-gate2.c b/arch/arm/mach-imx/clk-gate2.c
index 5a75cdc..a673364 100644
--- a/arch/arm/mach-imx/clk-gate2.c
+++ b/arch/arm/mach-imx/clk-gate2.c
@@ -96,10 +96,7 @@ static int clk_gate2_is_enabled(struct clk_hw *hw)
 {
 	struct clk_gate2 *gate = to_clk_gate2(hw);
 
-	if (gate->share_count)
-		return !!__clk_get_enable_count(hw->clk);
-	else
-		return clk_gate2_reg_is_enabled(gate->reg, gate->bit_idx);
+	return clk_gate2_reg_is_enabled(gate->reg, gate->bit_idx);
 }
 
 static struct clk_ops clk_gate2_ops = {
@@ -129,6 +126,9 @@ struct clk *clk_register_gate2(struct device *dev, const char *name,
 	gate->lock = lock;
 	gate->share_count = share_count;
 
+	if (share_count && clk_gate2_reg_is_enabled(reg, bit_idx))
+		(*share_count)++;
+
 	init.name = name;
 	init.ops = &clk_gate2_ops;
 	init.flags = flags;
-- 
2.1.3


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
