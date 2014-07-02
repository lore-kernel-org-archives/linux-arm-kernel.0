From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 2 Jul 2014 12:35:09 +0800
Subject: [PATCH 4/5] ARM: imx: clk-gate2: Use post decrement for
 share_count
In-Reply-To: <CAOMZO5BmJFmjYP9=rfR5eRKWPioPoW=UjE_h=Q3kbEAJGRixAQ@mail.gmail.com>
References: <1404194129-25543-1-git-send-email-festevam@gmail.com>
 <1404194129-25543-4-git-send-email-festevam@gmail.com>
 <20140701115252.GM14471@dragon>
 <CAOMZO5BmJFmjYP9=rfR5eRKWPioPoW=UjE_h=Q3kbEAJGRixAQ@mail.gmail.com>
Message-ID: <20140702043508.GA16176@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 01, 2014 at 02:44:40PM -0300, Fabio Estevam wrote:
> On Tue, Jul 1, 2014 at 8:52 AM, Shawn Guo <shawn.guo@freescale.com> wrote:
> 
> >> --- a/arch/arm/mach-imx/clk-gate2.c
> >> +++ b/arch/arm/mach-imx/clk-gate2.c
> >> @@ -67,7 +67,7 @@ static void clk_gate2_disable(struct clk_hw *hw)
> >>
> >>       spin_lock_irqsave(gate->lock, flags);
> >>
> >> -     if (gate->share_count && --(*gate->share_count) > 0)
> >> +     if (gate->share_count && (*gate->share_count)-- > 0)
> >
> > The change makes no sense.  Let's say that clk_gate2_disable() gets
> > called with share_count being 1.  In this case, we should access
> > register to gate the clock, right?
> 
> If share_count is 1 it means that someone else is using the clock and
> we can't disable it.

You do not really know it's someone else or itself.

> 
> Please try running the series without this patch. When the extern
> audio clock is enabled, share_count is 1. Later the the spdif clock
> (the one that is shared with extern audio clock) is disabled by the
> CCF as it is not used, which makes the extern audio clock to be also
> disabled, which is not what we want.
> 
> What would you suggest?

What about the patch below?

Shawn

----8<-------------

>From 0ed4b3edc661c63f86c914ea3c6deb3af3438151 Mon Sep 17 00:00:00 2001
From: Shawn Guo <shawn.guo@freescale.com>
Date: Wed, 2 Jul 2014 11:32:06 +0800
Subject: [PATCH] ARM: imx: fix shared gate clock to have its own enable count

Let's say clock A and B are two gate clocks that share the same register
bit in hardware.  Therefore they should be registered as shared gate
clocks with imx_clk_gate2_shared().

In the current implementation, clk_enable(A) call will have share_count
become 1.  If clk_disable(B) is called right after that, the register
bit will be cleared to gate off the clocks.  This is unexpected.  The
cause for that is there is no enable count tracking for clock A and B
respectively.

The patch fixes the issue by adding enable_count into clk_gate2, and
tracks it prior to share_count in .enable and .disable.  Also,
.is_enabled is fixed to report enable state instead of hardware state
in case of shared gate clock.

Reported-by: Fabio Estevam <fabio.estevam@freescale.com>
Cc: <stable@vger.kernel.org>
Fixes: f9f28cdf2167 ("ARM: imx: add shared gate clock support")
Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
---
 arch/arm/mach-imx/clk-gate2.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/mach-imx/clk-gate2.c b/arch/arm/mach-imx/clk-gate2.c
index 4ba587da89d2..c5dca7cdbbb1 100644
--- a/arch/arm/mach-imx/clk-gate2.c
+++ b/arch/arm/mach-imx/clk-gate2.c
@@ -33,6 +33,7 @@ struct clk_gate2 {
 	u8		bit_idx;
 	u8		flags;
 	spinlock_t	*lock;
+	unsigned int	enable_count;
 	unsigned int	*share_count;
 };
 
@@ -46,6 +47,9 @@ static int clk_gate2_enable(struct clk_hw *hw)
 
 	spin_lock_irqsave(gate->lock, flags);
 
+	if (gate->enable_count++ > 0)
+		goto out;
+
 	if (gate->share_count && (*gate->share_count)++ > 0)
 		goto out;
 
@@ -67,6 +71,9 @@ static void clk_gate2_disable(struct clk_hw *hw)
 
 	spin_lock_irqsave(gate->lock, flags);
 
+	if (--gate->enable_count > 0)
+		goto out;
+
 	if (gate->share_count && --(*gate->share_count) > 0)
 		goto out;
 
@@ -83,6 +90,13 @@ static int clk_gate2_is_enabled(struct clk_hw *hw)
 	u32 reg;
 	struct clk_gate2 *gate = to_clk_gate2(hw);
 
+	/*
+	 * In case this is a shared gate, we cannot just report the hardware
+	 * state but its own enable state.
+	 */
+	if (gate->share_count)
+		return !!gate->enable_count;
+
 	reg = readl(gate->reg);
 
 	if (((reg >> gate->bit_idx) & 1) == 1)
-- 
1.8.3.2
