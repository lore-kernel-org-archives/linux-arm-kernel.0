From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 18 Oct 2016 13:49:18 +0800
Subject: [PATCH] Revert "clocksource/drivers/timer_sun5i: Replace code by
 clocksource_mmio_init"
Message-ID: <20161018054918.26855-1-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This reverts commit 157dfadef832 ("clocksource/drivers/timer_sun5i:
Replace code by clocksource_mmio_init").

struct clocksource is also used by the clk notifier callback, to
unregister and re-register the clocksource with a different clock rate.
clocksource_mmio_init does not pass back a pointer to the struct used,
and the clk notifier callback fixed assumed the struct clocksource in
struct sun5i_timer_clksrc was valid. This results in a kernel NULL
pointer dereference when the hstimer clock is changed:

	Unable to handle kernel NULL pointer dereference at virtual address 00000004
	pgd = c0204000
	[00000004] *pgd=00000000
	Internal error: Oops: 805 [#1] SMP ARM
	Modules linked in:
	CPU: 0 PID: 44 Comm: kworker/0:1 Not tainted 4.8.0-14234-g346c22e #1
	Hardware name: Allwinner sun6i (A31) Family
	Workqueue: events dbs_work_handler
	task: ee1e0a80 task.stack: ee282000
	PC is at clocksource_unbind+0x2c/0x5c
	LR is at clocksource_unregister+0x2c/0x44
	pc : [<c03a4678>]    lr : [<c03a46d4>]    psr: 20000013
	sp : ee283d38  ip : ee019288  fp : 00124f80
	r10: 00000000  r9 : ffffffff  r8 : ee007808
	r7 : 00000000  r6 : 00000001  r5 : c1442b50  r4 : ee019298
	r3 : ee0192cc  r2 : 00000000  r1 : 00000000  r0 : 00000000
	Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
	Control: 10c5387d  Table: 4020406a  DAC: 00000051
	Process kworker/0:1 (pid: 44, stack limit = 0xee282220)
	Stack: (0xee283d38 to 0xee284000)
	3d20:                                                       ee019298 ee283dac
	3d40: 00000001 c03a46d4 ffffffff c0a6f350 ffffffff c035ea50 ee01a0dc ee01a0c4
	3d60: 00000000 00000001 ee283dac c035edc0 00000000 c066fb7c ee01a0c0 c1388890
	3d80: ee00f480 00000001 fffffffa 00124f80 00124f80 c035edf4 00000000 c13ab624
	3da0: 00000001 c0670174 ffffffff ee0188c0 0501bd00 044aa200 ee01a01c ee00f480
	3dc0: ee00f480 00000000 00000001 c06702c0 ee00f480 ee00cd00 00000000 00000001
	3de0: fffffffa c0670288 ee00cd00 ee00cc80 00000000 00000001 fffffffa c0670288
	3e00: ee00cc80 ee00cc00 00000000 00000001 fffffffa c0670288 ee00cc00 ee00c300
	3e20: 00000000 00000001 fffffffa c0670288 ee00cc00 337f9800 eefa8050 ee00c300
	3e40: fffffffa c0672020 ee686940 337f9800 eefa8050 ee6868c0 fffffffa c0672098
	3e60: ee686940 ee663400 eefa8050 c07eea64 000d2f00 c0a216fc 337f9800 3c14dc00
	3e80: c1302514 ee57ac00 00000000 00000002 c1462434 00000000 00000000 000d2f00
	3ea0: ee22d680 c0a21cb8 00000010 000f6180 000d2f00 00000021 ee68cc00 ee57ac00
	3ec0: 0092a180 00a79400 ee68cc80 ee686c40 eefad900 c0a25344 ee68cc40 00000000
	3ee0: ee68cc04 ee57ac00 c1408bac 00000000 eefad900 c0a2588c ee68cc40 ee22d680
	3f00: eefad900 00000000 eefb0e00 c0357d84 c1302100 eefad918 eefad900 ee22d698
	3f20: 00000008 c1302100 eefad918 ee282000 eefad900 c0358a00 ee22bc00 ee22d680
	3f40: c03589c8 00000000 ee22bc00 ee22d680 c03589c8 00000000 00000000 00000000
	3f60: 00000000 c035d66c 00000000 00000000 ffffffff ee22d680 00000000 00000000
	3f80: ee283f80 ee283f80 00000000 00000000 ee283f90 ee283f90 ee22bc00 ee22bc00
	3fa0: c035d590 00000000 00000000 c0307d38 00000000 00000000 00000000 00000000
	3fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
	3fe0: 00000000 00000000 00000000 00000000 00000013 00000000 ffffffff ffffffff
	[<c03a4678>] (clocksource_unbind) from [<c03a46d4>] (clocksource_unregister+0x2c/0x44)
	[<c03a46d4>] (clocksource_unregister) from [<c0a6f350>] (sun5i_rate_cb_clksrc+0x34/0x3c)
	[<c0a6f350>] (sun5i_rate_cb_clksrc) from [<c035ea50>] (notifier_call_chain+0x44/0x84)
	[<c035ea50>] (notifier_call_chain) from [<c035edc0>] (__srcu_notifier_call_chain+0x44/0x60)
	[<c035edc0>] (__srcu_notifier_call_chain) from [<c035edf4>] (srcu_notifier_call_chain+0x18/0x20)
	[<c035edf4>] (srcu_notifier_call_chain) from [<c0670174>] (__clk_notify+0x70/0x7c)
	[<c0670174>] (__clk_notify) from [<c06702c0>] (clk_propagate_rate_change+0xa4/0xc4)
	[<c06702c0>] (clk_propagate_rate_change) from [<c0670288>] (clk_propagate_rate_change+0x6c/0xc4)
	Code: e5942038 e2843034 e5941034 e3a00000 (e5812004)
	---[ end trace c5149f92effb19a4 ]---

Revert the commit for now. clocksource_mmio_init can be made to pass back
a pointer, but the code churn and usage of an inner struct might not be
worth it.

Reported-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Fixes: 157dfadef832 ("clocksource/drivers/timer_sun5i: Replace code by
		      clocksource_mmio_init")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/clocksource/timer-sun5i.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/timer-sun5i.c b/drivers/clocksource/timer-sun5i.c
index c184eb84101e..4f87f3e76d83 100644
--- a/drivers/clocksource/timer-sun5i.c
+++ b/drivers/clocksource/timer-sun5i.c
@@ -152,6 +152,13 @@ static irqreturn_t sun5i_timer_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static cycle_t sun5i_clksrc_read(struct clocksource *clksrc)
+{
+	struct sun5i_timer_clksrc *cs = to_sun5i_timer_clksrc(clksrc);
+
+	return ~readl(cs->timer.base + TIMER_CNTVAL_LO_REG(1));
+}
+
 static int sun5i_rate_cb_clksrc(struct notifier_block *nb,
 				unsigned long event, void *data)
 {
@@ -210,8 +217,13 @@ static int __init sun5i_setup_clocksource(struct device_node *node,
 	writel(TIMER_CTL_ENABLE | TIMER_CTL_RELOAD,
 	       base + TIMER_CTL_REG(1));
 
-	ret = clocksource_mmio_init(base + TIMER_CNTVAL_LO_REG(1), node->name,
-				    rate, 340, 32, clocksource_mmio_readl_down);
+	cs->clksrc.name = node->name;
+	cs->clksrc.rating = 340;
+	cs->clksrc.read = sun5i_clksrc_read;
+	cs->clksrc.mask = CLOCKSOURCE_MASK(32);
+	cs->clksrc.flags = CLOCK_SOURCE_IS_CONTINUOUS;
+
+	ret = clocksource_register_hz(&cs->clksrc, rate);
 	if (ret) {
 		pr_err("Couldn't register clock source.\n");
 		goto err_remove_notifier;
-- 
2.9.3
