From: mturquette@linaro.org (Mike Turquette)
Date: Mon, 24 Feb 2014 16:22:14 -0800
Subject: ccf: where to put constraints?
In-Reply-To: <32a83aee-624b-47ef-a13e-1a9d993005c0@CH1EHSMHS039.ehs.local>
References: <20140224201046.GA13155@katana>
 <8e8ce023-b9a4-41a5-b06c-0f6d934f22e6@VA3EHSMHS020.ehs.local>
 <20140224230532.22529.7958@quantum>
 <32a83aee-624b-47ef-a13e-1a9d993005c0@CH1EHSMHS039.ehs.local>
Message-ID: <20140225002214.22529.23643@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting S?ren Brinkmann (2014-02-24 15:11:55)
> On Mon, 2014-02-24 at 03:05PM -0800, Mike Turquette wrote:
> > Quoting S?ren Brinkmann (2014-02-24 13:21:58)
> > > Hi Wolfram,
> > > 
> > > On Mon, 2014-02-24 at 09:10PM +0100, Wolfram Sang wrote:
> > > > Hi,
> > > > 
> > > > Where do I put constraints when using the CCF? I have a CPU and GPU
> > > > clock derived from the same PLL. Both clocks have their own divider.
> > > > Now, there is the additional constraint that the CPU clock must not be
> > > > lower than the GPU clock. Do I add checks in the set_rate functions?
> > > > Feels like the wrong layer, but not checking it and blindly relying on
> > > > somebody else does not feel correct, too. How to do it best?
> > > 
> > > I don't know if it's the best or only way, but so far, I did things like
> > > that with clock notifiers.
> > > 
> > > I.e. when a clock consumer needs to be notified about its input clock
> > > being changed it registers a clock notifier. In that notifier callback
> > > it then can react to the rate change. E.g. adjust dividers to stay
> > > within legal limits or reject the change completely.
> > 
> > Yes, this is why the notifiers were created. A nice side effect of this
> > is that the code can live outside your clock driver. Often times the
> > clocks are quite capable of running at these speeds, but the problem is
> > the IP blocks (CPU & GPU in Wolfram's case) would be out of spec. It is
> > arguable that this logic does not belong in the clock driver but instead
> > in some cpufreq driver or something like it.
> > 
> > The clock notifiers make it easy to put this logic wherever you like and
> > you can even veto clock rate changes.
> 
> Right, that's how I have it. If a device driver needs to enforce some
> policy on its clock, it implements a clock notifier callback.
> 
> The drawback though, as I see it, it makes interactions hard to
> understand. With such a scheme, rate changes may fail and the cause is
> not always obvious - often hidden really well. Usually all you get is a
> message from the CCF that the rate change for clock <name> failed, but
> if your notifier callback isn't verbose, you can search forever for the
> cause of that failure.
> 
> On our internal repo I had it a few times that "bugs" get assigned to the
> wrong piece. E.g. cpufreq, even though that works perfectly well and
> correct on its own, but some other device enforced some policy through a
> notifier.

Yes, debugging across notifiers is notoriously annoying. How about
something like the following patch?

Regards,
Mike



>From f5b30cad56b3439ac127b43148827a95f6391a92 Mon Sep 17 00:00:00 2001
From: Mike Turquette <mturquette@linaro.org>
Date: Mon, 24 Feb 2014 16:08:41 -0800
Subject: [PATCH] clk: add pr_err and kerneldoc around clk notifiers
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Both the pr_err and the additional kerneldoc aim to help when debugging
errors thrown from within a clock rate-change notifier callback.

Reported-by: S?ren Brinkmann <soren.brinkmann@xilinx.com>
Signed-off-by: Mike Turquette <mturquette@linaro.org>
---
 drivers/clk/clk.c   |  5 ++++-
 include/linux/clk.h | 14 ++++++++++++++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index a6f079d..1a95b92 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -1339,8 +1339,11 @@ static int __clk_speculate_rates(struct clk *clk, unsigned long parent_rate)
 	if (clk->notifier_count)
 		ret = __clk_notify(clk, PRE_RATE_CHANGE, clk->rate, new_rate);
 
-	if (ret & NOTIFY_STOP_MASK)
+	if (ret & NOTIFY_STOP_MASK) {
+		pr_err("%s: clk notifier callback for clock %s aborted with error %d\n",
+				__func__, clk->name, ret);
 		goto out;
+	}
 
 	hlist_for_each_entry(child, &clk->children, child_node) {
 		ret = __clk_speculate_rates(child, new_rate);
diff --git a/include/linux/clk.h b/include/linux/clk.h
index 0dd9114..35a7e00 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -78,8 +78,22 @@ struct clk_notifier_data {
 	unsigned long		new_rate;
 };
 
+/**
+ * clk_notifier_register: register a clock rate-change notifier callback
+ * @clk: clock whose rate we are interested in
+ * @nb: notifier block with callback function pointer
+ *
+ * ProTip: debugging across notifier chains can be frustrating. Make sure that
+ * your notifier callback function prints a nice big warning in case of
+ * failure.
+ */
 int clk_notifier_register(struct clk *clk, struct notifier_block *nb);
 
+/**
+ * clk_notifier_unregister: unregister a clock rate-change notifier callback
+ * @clk: clock whose rate we are no longer interested in
+ * @nb: notifier block which will be unregistered
+ */
 int clk_notifier_unregister(struct clk *clk, struct notifier_block *nb);
 
 /**
-- 
1.8.3.2
