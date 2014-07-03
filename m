From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 3 Jul 2014 11:26:17 +0800
Subject: [PATCH 4/5] ARM: imx: clk-gate2: Use post decrement for
 share_count
In-Reply-To: <CAOMZO5AYA-i8Rp2Oo+unwUXmH0uQ8D3rnXxBQUgqKrfXw-vN-A@mail.gmail.com>
References: <1404194129-25543-1-git-send-email-festevam@gmail.com>
 <1404194129-25543-4-git-send-email-festevam@gmail.com>
 <20140701115252.GM14471@dragon>
 <CAOMZO5BmJFmjYP9=rfR5eRKWPioPoW=UjE_h=Q3kbEAJGRixAQ@mail.gmail.com>
 <20140702043508.GA16176@dragon>
 <CAOMZO5AYA-i8Rp2Oo+unwUXmH0uQ8D3rnXxBQUgqKrfXw-vN-A@mail.gmail.com>
Message-ID: <20140703032615.GE16176@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 02, 2014 at 11:27:21AM -0300, Fabio Estevam wrote:
> > From 0ed4b3edc661c63f86c914ea3c6deb3af3438151 Mon Sep 17 00:00:00 2001
> > From: Shawn Guo <shawn.guo@freescale.com>
> > Date: Wed, 2 Jul 2014 11:32:06 +0800
> > Subject: [PATCH] ARM: imx: fix shared gate clock to have its own enable count
> >
> > Let's say clock A and B are two gate clocks that share the same register
> > bit in hardware.  Therefore they should be registered as shared gate
> > clocks with imx_clk_gate2_shared().
> >
> > In the current implementation, clk_enable(A) call will have share_count
> > become 1.  If clk_disable(B) is called right after that, the register
> > bit will be cleared to gate off the clocks.  This is unexpected.  The
> > cause for that is there is no enable count tracking for clock A and B
> > respectively.
> >
> > The patch fixes the issue by adding enable_count into clk_gate2, and
> > tracks it prior to share_count in .enable and .disable.  Also,
> > .is_enabled is fixed to report enable state instead of hardware state
> > in case of shared gate clock.
> >
> > Reported-by: Fabio Estevam <fabio.estevam@freescale.com>
> > Cc: <stable@vger.kernel.org>
> > Fixes: f9f28cdf2167 ("ARM: imx: add shared gate clock support")
> 
> No need to Cc stable on this one as the this commit did not reach stable.

Yes, you're right.

...

> > @@ -67,6 +71,9 @@ static void clk_gate2_disable(struct clk_hw *hw)
> >
> >         spin_lock_irqsave(gate->lock, flags);
> >
> > +       if (--gate->enable_count > 0)
> > +               goto out;
> 
> All these pre-decrement look buggy because enable_count and
> share_count are 'unsigned int'.
> 
> If share_count is 0 and then you decrement it, it will still be
> greater than zero.
> --(*gate->share_count) > 0 and --gate->enable_count > 0 are always true.

Hmm, clk_gate2_disable() should never be called with a zero share_count.
I will add a check for that.

> I have tried to make share_count and enable_count as 'int'. Then it
> resulted CGR5 as
> 0FFFCFFF, which still leaves ssi1 and ssi3 enabled (I have locally
> made ssi a shared clock now)

Right.  The patch did not fix the problem correctly.  I just started it
over again with the one below.  Can you please test it?  Thanks.

Shawn

---8<-------------------

>From e057f4c129e77639372f2b4a3b9eb8a9de2095f8 Mon Sep 17 00:00:00 2001
From: Shawn Guo <shawn.guo@freescale.com>
Date: Wed, 2 Jul 2014 11:32:06 +0800
Subject: [PATCH] ARM: imx: fix shared gate clock

to be added ...

Reported-by: Fabio Estevam <fabio.estevam@freescale.com>
Fixes: f9f28cdf2167 ("ARM: imx: add shared gate clock support")
Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
---
 arch/arm/mach-imx/clk-gate2.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-imx/clk-gate2.c b/arch/arm/mach-imx/clk-gate2.c
index 4ba587da89d2..3aa9c74d13be 100644
--- a/arch/arm/mach-imx/clk-gate2.c
+++ b/arch/arm/mach-imx/clk-gate2.c
@@ -67,8 +67,12 @@ static void clk_gate2_disable(struct clk_hw *hw)
 
 	spin_lock_irqsave(gate->lock, flags);
 
-	if (gate->share_count && --(*gate->share_count) > 0)
-		goto out;
+	if (gate->share_count) {
+		if (WARN_ON(*gate->share_count == 0))
+			goto out;
+		else if (--(*gate->share_count) > 0)
+			goto out;
+	}
 
 	reg = readl(gate->reg);
 	reg &= ~(3 << gate->bit_idx);
@@ -78,19 +82,26 @@ out:
 	spin_unlock_irqrestore(gate->lock, flags);
 }
 
-static int clk_gate2_is_enabled(struct clk_hw *hw)
+static int clk_gate2_reg_is_enabled(void __iomem *reg, u8 bit_idx)
 {
-	u32 reg;
-	struct clk_gate2 *gate = to_clk_gate2(hw);
+	u32 val = readl(reg);
 
-	reg = readl(gate->reg);
-
-	if (((reg >> gate->bit_idx) & 1) == 1)
+	if (((val >> bit_idx) & 1) == 1)
 		return 1;
 
 	return 0;
 }
 
+static int clk_gate2_is_enabled(struct clk_hw *hw)
+{
+	struct clk_gate2 *gate = to_clk_gate2(hw);
+
+	if (gate->share_count)
+		return !!(*gate->share_count);
+	else
+		return clk_gate2_reg_is_enabled(gate->reg, gate->bit_idx);
+}
+
 static struct clk_ops clk_gate2_ops = {
 	.enable = clk_gate2_enable,
 	.disable = clk_gate2_disable,
@@ -116,6 +127,9 @@ struct clk *clk_register_gate2(struct device *dev, const char *name,
 	gate->bit_idx = bit_idx;
 	gate->flags = clk_gate2_flags;
 	gate->lock = lock;
+
+	if (share_count)
+		*share_count = clk_gate2_reg_is_enabled(reg, bit_idx) ? 1 : 0;
 	gate->share_count = share_count;
 
 	init.name = name;
-- 
1.8.3.2
