From: tdas@codeaurora.org (Taniya Das)
Date: Fri, 02 Nov 2012 23:42:38 +0530
Subject: idle_sleeptime calculation for hotplugged cpu
Message-ID: <50940D16.2020304@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I was looking at the arch/arm/process.c:cpu_die, I was wondering why we 
do not exit from NOHZ for a hotplugged/offline cpu?
If I understand correctly an offlined cpu too will enter 
NOHz(tick_nohz_idle_enter) and update the idle_entrytime. The cpu will die
and it will reenter the idle thread and update idle_entrytime onces it 
comes back online and only then it will exit NOHz, but time spent in sleep
idle_sleeptime will be wrongly calculated.


void cpu_idle(void)

{


.....

/* endless idle loop with no priority at all */

while (1) {

idle_notifier_call_chain(IDLE_START);

tick_nohz_idle_enter();-->  Offline CPU entering NOHZ

rcu_idle_enter();

while (!need_resched()) {

#ifdef CONFIG_HOTPLUG_CPU

if (cpu_is_offline(smp_processor_id()))
cpu_die(); ---> CPU becomes offline and re-enter the idle thread without 
exiting from NOHZ,

#endif

...
}


Is it a good idea to exit from NOHZ before cpu_die() or it could be 
achieved in some other way? Please provide your
comments.

-- 
Thanks & Regards,
Taniya Das.

QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation.

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121102/f2197fc1/attachment-0001.html>
