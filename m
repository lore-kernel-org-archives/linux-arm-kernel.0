From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Wed, 27 Apr 2016 15:24:24 +0000
Subject: [PATCH V3] clk: bcm2835: mark enabled clocks with CLK_ENABLE_HAND_OFF
Message-ID: <1461770664-29384-1-git-send-email-kernel@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Sperl <kernel@martin.sperl.org>

The bcm2835 firmware enables several clocks and plls before
booting the linux kernel.

These plls should never get disabled as it may result in a
stopped system clock and more.

So during probing we check if the clock is enabled
and if it is then mark that clock with CLK_ENABLE_HAND_OFF.
As a consequence this will also enable the corresponding
parent plls and pll-divs.

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>

--
Note that this requires the following patches applied:
* clk: introduce CLK_ENABLE_HAND_OFF flag
* clk: per-user clk prepare & enable ref counts

Here some detailed info:

Registered clocks with hand-off:
bcm2835-clk 20101000.cprman: found enabled clock timer - enabling hand off
bcm2835-clk 20101000.cprman: found enabled clock otp - enabling hand off
bcm2835-clk 20101000.cprman: found enabled clock uart - enabling hand off
bcm2835-clk 20101000.cprman: found enabled clock v3d - enabling hand off
bcm2835-clk 20101000.cprman: found enabled clock isp - enabling hand off
bcm2835-clk 20101000.cprman: found enabled clock h264 - enabling hand off
bcm2835-clk 20101000.cprman: found enabled clock vec - enabling hand off
bcm2835-clk 20101000.cprman: found enabled clock tsens - enabling hand off
bcm2835-clk 20101000.cprman: found enabled clock emmc - enabling hand off

Enabled clock count:
root at raspcm:~# grep -vE ^0 /sys/kernel/debug/clk/*/clk_enable_count
/sys/kernel/debug/clk/apb_pclk/clk_enable_count:1
/sys/kernel/debug/clk/clock/clk_enable_count:1
/sys/kernel/debug/clk/core/clk_enable_count:3
/sys/kernel/debug/clk/emmc/clk_enable_count:1
/sys/kernel/debug/clk/h264/clk_enable_count:1
/sys/kernel/debug/clk/isp/clk_enable_count:1
/sys/kernel/debug/clk/osc/clk_enable_count:7
/sys/kernel/debug/clk/otp/clk_enable_count:1
/sys/kernel/debug/clk/plla/clk_enable_count:1
/sys/kernel/debug/clk/plla_core/clk_enable_count:3
/sys/kernel/debug/clk/pllc/clk_enable_count:1
/sys/kernel/debug/clk/pllc_per/clk_enable_count:1
/sys/kernel/debug/clk/plld/clk_enable_count:1
/sys/kernel/debug/clk/plld_per/clk_enable_count:1
/sys/kernel/debug/clk/pllh_aux/clk_enable_count:1
/sys/kernel/debug/clk/pllh_aux_prediv/clk_enable_count:1
/sys/kernel/debug/clk/pllh/clk_enable_count:1
/sys/kernel/debug/clk/timer/clk_enable_count:1
/sys/kernel/debug/clk/tsens/clk_enable_count:1
/sys/kernel/debug/clk/uart0_pclk/clk_enable_count:1
/sys/kernel/debug/clk/uart/clk_enable_count:1
/sys/kernel/debug/clk/v3d/clk_enable_count:1
/sys/kernel/debug/clk/vec/clk_enable_count:1

That is a setup where the clock bcm2835 is only referenced
in the device tree for pcm (which was not loaded or running
at the time I took the above).

Using pcm-audio would trigger a machine halt before this patch.
Now this does not happen.

Changelog:
 V1 -> V2: swith to use CLK_IS_CRITICAL for enabled pll_div
 V2 -> V3: swith to use CLK_ENABLE_HAND_OFF for enabled clocks

---
 drivers/clk/bcm/clk-bcm2835.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
index 35f8de7..65d62c2 100644
--- a/drivers/clk/bcm/clk-bcm2835.c
+++ b/drivers/clk/bcm/clk-bcm2835.c
@@ -1251,7 +1251,14 @@ static struct clk *bcm2835_register_clock(struct bcm2835_cprman *cprman,
 		init.flags |= CLK_SET_RATE_GATE | CLK_SET_PARENT_GATE;
 	}

+	/* if the clock is running then enable HAND_OFF */
+	if (cprman_read(cprman, data->ctl_reg) & CM_ENABLE) {
+		dev_info(cprman->dev,
+			 "found enabled clock %s - enabling hand off\n",
+			 data->name);
+		init.flags |= CLK_ENABLE_HAND_OFF;
+	}
+
 	clock = devm_kzalloc(cprman->dev, sizeof(*clock), GFP_KERNEL);
 	if (!clock)
 		return NULL;
--
2.1.4
