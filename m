From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Wed, 18 May 2011 17:02:45 +0530
Subject: [PATCH] ARM: smp_twd: Reconfigure clockevents after cpufreq change
In-Reply-To: <BANLkTinUxn_szHVHSKOZ1WJAckmo9mSudA@mail.gmail.com>
References: <1305588114-23728-1-git-send-email-ccross@android.com>	<4DD27F7D.2070305@ti.com>
	<BANLkTinUxn_szHVHSKOZ1WJAckmo9mSudA@mail.gmail.com>
Message-ID: <4DD3AE5D.8040501@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5/17/2011 10:36 PM, Colin Cross wrote:
> On Tue, May 17, 2011 at 7:00 AM, Santosh Shilimkar
> <santosh.shilimkar@ti.com>  wrote:
>> Colin,
>>
>> On 5/17/2011 4:51 AM, Colin Cross wrote:
>>>
>>> The localtimer's clock changes with the cpu clock.  After a
>>> cpufreq transition, update the clockevent's frequency and
>>> reprogram the next clock event.
>>>
>>> Adds a clock called "smp_twd" that is used to determine the
>>> twd frequency, which can also be used at init time to
>>> avoid calibrating the twd frequency.
>>>
>>> Signed-off-by: Colin Cross<ccross@android.com>
>>> Cc: Thomas Gleixner<tglx@linutronix.de>
>>> Cc: Russell King<linux@arm.linux.org.uk>
>>> Cc: Santosh Shilimkar<santosh.shilimkar@ti.com>
>>> Cc: Rob Herring<robherring2@gmail.com>
>>> ---
>>>   arch/arm/kernel/smp_twd.c |   69
>>> +++++++++++++++++++++++++++++++++++++++++++--
>>>   1 files changed, 66 insertions(+), 3 deletions(-)
>>>
>>> This patch depends on Thomas Gleixner's patch to add
>>> clockevents_reconfigure
>>> See: https://lkml.org/lkml/2011/5/13/122
>>>
>>> This patch adds a clock that can be used to skip calibration as well
>>> as update the frequency.  A later patch (or a later version of this patch)
>>> will drop twd_calibrate_rate once all platforms provide the necessary
>>> smp_twd clock.
>>>
>>
>> Since the "smp_twd" clock node will not have a clk_set_rate()
>> associated with it, will the clk_get_rate() gives you real
>> rate. May be we can associate this node as a child of
>> CPU clock node and use the fixed divider based on peripheral
>> ratio. Is that the idea here to realize it ?
>
> Yes, the idea is that it will be a fixed divider off the cpu clock,
> which will have been updated by cpufreq.
Ok.
Below patch for OMAP twd clock node. Also
attached in case mailer eats tabs.

Regards
Santosh

 From 8a3e307c1a610a24f78d575c0ac04a7bbe1d39b8 Mon Sep 17 00:00:00 2001
From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Date: Wed, 18 May 2011 16:27:41 +0530
Subject: [PATCH] OMAP4: clock: Add CPU local timer clock node.

Local timer clock is sourced from the CPU clock and hence changes
along with CPU clock. These per CPU local timers are used as
clock-events, so they need to be reconfigured on CPU frequency
as part of CPUfreq governor.

Newly introduced clockevents_reconfigure() needs to know the
TWD clock-rate. Provide a clock-node to make clk_get_rate() work
for TWD.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
  arch/arm/mach-omap2/clock44xx_data.c |    9 +++++++++
  1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clock44xx_data.c 
b/arch/arm/mach-omap2/clock44xx_data.c
index 8c96567..5477f4b 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -3010,6 +3010,14 @@ static struct clk auxclkreq5_ck = {
  	.recalc		= &omap2_clksel_recalc,
  };

+static struct clk smp_twd = {
+	.name		= "smp_twd",
+	.parent		= &dpll_mpu_ck,
+	.ops		= &clkops_null,
+	.fixed_div	= 2,
+	.recalc		= &omap_fixed_divisor_recalc,
+};
+
  /*
   * clkdev
   */
@@ -3283,6 +3291,7 @@ static struct omap_clk omap44xx_clks[] = {
  	CLK(NULL,	"auxclkreq3_ck",		&auxclkreq3_ck,	CK_443X),
  	CLK(NULL,	"auxclkreq4_ck",		&auxclkreq4_ck,	CK_443X),
  	CLK(NULL,	"auxclkreq5_ck",		&auxclkreq5_ck,	CK_443X),
+	CLK(NULL,	"smp_twd",		&smp_twd,	CK_443X),
  };

  int __init omap4xxx_clk_init(void)
-- 
1.6.0.4




-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: 0001-OMAP4-clock-Add-CPU-local-timer-clock-node.patch
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110518/d66dfefa/attachment-0001.ksh>
