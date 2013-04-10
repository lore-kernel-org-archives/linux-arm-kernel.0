From: hechtb@gmail.com (Bastian Hecht)
Date: Wed, 10 Apr 2013 12:04:38 +0200
Subject: [PATCH] ARM: hw_breakpoint: Do not use __cpuinitdata for dbg_cpu_pm_nb
Message-ID: <1365588278-5185-1-git-send-email-hechtb+renesas@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We must not declare dbg_cpu_pm_nb as __cpuinitdata as we need it after
system initialization for Suspend and CPUIdle.

This was done in commit 9a6eb310eaa5336b89a27a0bbb78da4bba35f6f1
ARM: hw_breakpoint: Debug powerdown support for self-hosted debug

Signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>
---
Hi,

I've experienced a kernel oops while working on Suspend-To-Ram and CPUIdle
on the Armadillo800EVA from Renesas. After echo mem >/sys/power/state I get:

Unable to handle kernel paging request at virtual address e7fddef0
PC is at 0xe7fddef0
LR is at notifier_call_chain+0x40/0x70

I've bisected the kernel to the commit 9a6eb310eaa5336b89a27a0bbb78da4bba35f6f1

    ARM: hw_breakpoint: Debug powerdown support for self-hosted debug

and succeeded to fix it by removing the __cpuinitdata tag.

Cheers,

 Bastian

 arch/arm/kernel/hw_breakpoint.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/kernel/hw_breakpoint.c b/arch/arm/kernel/hw_breakpoint.c
index 96093b7..8eb67bc 100644
--- a/arch/arm/kernel/hw_breakpoint.c
+++ b/arch/arm/kernel/hw_breakpoint.c
@@ -1043,7 +1043,7 @@ static int dbg_cpu_pm_notify(struct notifier_block *self, unsigned long action,
 	return NOTIFY_OK;
 }
 
-static struct notifier_block __cpuinitdata dbg_cpu_pm_nb = {
+static struct notifier_block dbg_cpu_pm_nb = {
 	.notifier_call = dbg_cpu_pm_notify,
 };
 
-- 
1.7.9.5
