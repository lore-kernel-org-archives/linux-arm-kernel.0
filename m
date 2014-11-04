From: hukeping@huawei.com (HuKeping)
Date: Tue, 4 Nov 2014 17:40:25 +0800
Subject: [RESEND PATCH] ARM: kexec: Fix validating CPU hotplug support
Message-ID: <1415094025-66180-1-git-send-email-hukeping@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 2103f6cba61a8b8bea3fc1b63661d830a2125e76 added a hotplug checking in
machine_kexec_prepare(), but it will lead a failure when loading the
crash-kernel in some cases.

Kexec utility can load the crash kernel by two ways:
1. kexec -l kernel-image
2. kexec -p kernel-image

In case #1, for rapid reboot, it's correct to do the hotplug checking things,
for it will shut down cpus in _cpu_down() later when command "kexec -e" be
sent, this routine needs the support of cpu hotplug.

In case #2, for use on panic, it's unnecessary to do the same thing, the whole
routing has no business with cpu shutting down. Check for cpu hot plug will
lead a failure to load the kernel.

Prior to this patch, if the first kernel is not support the CPU hotplug, when
a crash come, the kexec utility will not work.

Signed-off-by: Hu Keping <hukeping@huawei.com>
---
 arch/arm/kernel/machine_kexec.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kernel/machine_kexec.c b/arch/arm/kernel/machine_kexec.c
index 8cf0996..7706c67 100644
--- a/arch/arm/kernel/machine_kexec.c
+++ b/arch/arm/kernel/machine_kexec.c
@@ -41,11 +41,16 @@ int machine_kexec_prepare(struct kimage *image)
 	int i, err;
 
 	/*
+	 * For rapid reboot:
 	 * Validate that if the current HW supports SMP, then the SW supports
 	 * and implements CPU hotplug for the current HW. If not, we won't be
 	 * able to kexec reliably, so fail the prepare operation.
+	 *
+	 * For use on panic:
+	 * It is unnecessary to check the cpu hot plug. 
 	 */
-	if (num_possible_cpus() > 1 && !platform_can_cpu_hotplug())
+	if (image->type != KEXEC_TYPE_CRASH &&
+		(num_possible_cpus() > 1 && !platform_can_cpu_hotplug()))
 		return -EINVAL;
 
 	/*
-- 
1.8.5.5
