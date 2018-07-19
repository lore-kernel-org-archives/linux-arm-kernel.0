From: vnkgutta@codeaurora.org (Venkata Narendra Kumar Gutta)
Date: Thu, 19 Jul 2018 15:12:49 -0700
Subject: [PATCH] ARM64: smp: BUG() if smp_send_reschedule() is called for an
 offline cpu
Message-ID: <1532038369-5159-1-git-send-email-vnkgutta@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Based on the 'commit <8b775be35e41b9f> ("ARM: smp:
BUG() if smp_send_reschedule() is called for an offline cpu")'

Sending an IPI_RESCHEDULE to an offline CPU is incorrect and potentially
bad for both power and stability. On some sub-architectures such as MSM,
if a power-collapsed CPU is unexpectedly woken up by an IPI, it will be
begin executing without the preparations that would normally happen as
part of CPU_UP_PREPARE. If clocks, voltage regulators, or other hardware
configuration are not performed, the booting CPU may cause general
instability or (at best) poor power performance since the CPU would be
powered up but not utilized.

One common cause for such issues is misuse of add_timer_on() or APIs
such as queue_work_on() which call it. If proper precautions are not
taken to block hotplug while these APIs are called then a race may
result in IPIs being sent to CPUs that are already offline.

This same argument could be applied to other IPIs (with the exception
of IPI_WAKEUP), but the others are already restricted to only online
CPUs by existing mechanisms, so an explicit assertion is not useful.

Signed-off-by: Matt Wagantall <mattw@codeaurora.org>
Signed-off-by: Trilok Soni <tsoni@codeaurora.org>
Signed-off-by: Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>
---
 arch/arm64/kernel/smp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 2faa986..5e39030 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -898,6 +898,7 @@ void handle_IPI(int ipinr, struct pt_regs *regs)
 
 void smp_send_reschedule(int cpu)
 {
+	BUG_ON(cpu_is_offline(cpu));
 	smp_cross_call(cpumask_of(cpu), IPI_RESCHEDULE);
 }
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
