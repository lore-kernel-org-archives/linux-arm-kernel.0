From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 14 Feb 2012 14:17:48 +0530
Subject: [PATCH] ARM: OMAP4: cpuidle: Fix the C-state reporting to cpuidle
 governor.
In-Reply-To: <87haz2gtfw.fsf@ti.com>
References: <1328521095-24025-1-git-send-email-santosh.shilimkar@ti.com>
 <87haz2gtfw.fsf@ti.com>
Message-ID: <4F3A1FB4.5010304@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 08 February 2012 04:08 AM, Kevin Hilman wrote:
> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
> 
>> OMAP4 cpuidle driver is reporting the state requested by governor rather than
>> the actually attempted one.
>>
>> This is obviously misleading sysfs and powertop cpuidle statistics.
>> Fix it so that stats are reported correctly.
>>
>> Reported-by: Kevin Hilman <khilman@ti.com>
>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> ---
>>  arch/arm/mach-omap2/cpuidle44xx.c |    1 +
>>  1 files changed, 1 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/cpuidle44xx.c b/arch/arm/mach-omap2/cpuidle44xx.c
>> index cfdbb86..f128489 100644
>> --- a/arch/arm/mach-omap2/cpuidle44xx.c
>> +++ b/arch/arm/mach-omap2/cpuidle44xx.c
>> @@ -85,6 +85,7 @@ static int omap4_enter_idle(struct cpuidle_device *dev,
>>  	cpu1_state = pwrdm_read_pwrst(cpu1_pd);
>>  	if (cpu1_state != PWRDM_POWER_OFF) {
>>  		new_state_idx = drv->safe_state_index;
>> +		index = drv->safe_state_index;
> 
> How about just get rid of new_state_idx all together and just update
> index and use it to index in to the states.
> 
Make sense. Updated patch below.

Regards,
Santosh

>From 939dc3eda7895043c03526110e2a6b41e9861146 Mon Sep 17 00:00:00 2001
From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Date: Sun, 5 Feb 2012 13:18:44 +0530
Subject: [PATCH 2/2] ARM: OMAP4: cpuidle: Fix the C-state reporting to
cpuidle governor.

OMAP4 cpuidle driver is reporting the state requested by governor rather
than
the actually attempted one.

This is obviously misleading sysfs and powertop cpuidle statistics.
Fix it so that stats are reported correctly.

While at this, get rid of new_state_idx, update and use
index in to the states.

Reported-by: Kevin Hilman <khilman@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/cpuidle44xx.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle44xx.c
b/arch/arm/mach-omap2/cpuidle44xx.c
index cfdbb86..72e018b 100644
--- a/arch/arm/mach-omap2/cpuidle44xx.c
+++ b/arch/arm/mach-omap2/cpuidle44xx.c
@@ -65,7 +65,6 @@ static int omap4_enter_idle(struct cpuidle_device *dev,
 	struct timespec ts_preidle, ts_postidle, ts_idle;
 	u32 cpu1_state;
 	int idle_time;
-	int new_state_idx;
 	int cpu_id = smp_processor_id();

 	/* Used to keep track of the total time in idle */
@@ -84,8 +83,8 @@ static int omap4_enter_idle(struct cpuidle_device *dev,
 	 */
 	cpu1_state = pwrdm_read_pwrst(cpu1_pd);
 	if (cpu1_state != PWRDM_POWER_OFF) {
-		new_state_idx = drv->safe_state_index;
-		cx = cpuidle_get_statedata(&dev->states_usage[new_state_idx]);
+		index = drv->safe_state_index;
+		cx = cpuidle_get_statedata(&dev->states_usage[index]);
 	}

 	if (index > 0)
-- 
1.7.4.1




-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0002-ARM-OMAP4-cpuidle-Fix-the-C-state-reporting-to-cpuid.patch
Type: text/x-patch
Size: 1620 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120214/ba57035c/attachment.bin>
