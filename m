From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 12 Jun 2013 14:01:20 -0600
Subject: [PATCH V2 1/2] kexec: return error of machine_kexec() fails
Message-ID: <1371067281-655-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Prior to commit 3ab8352 "kexec jump", if machine_kexec() returned,
sys_reboot() would return -EINVAL. This patch restores this behaviour
for the non-KEXEC_JUMP case, where machine_kexec() is not expected to
return.

This situation can occur on ARM, where kexec requires disabling all but
one CPU using CPU hotplug. However, if hotplug isn't supported by the
particular HW the kernel is running on, then kexec cannot succeed.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
v2: New patch.

Eric, Patch 2/2 doesn't really depend on this in particular, except to
avoid returning 0 back to user-space on failure, and thus generating:

kexec failed: Success

Hence, I think you can just apply this to your tree, and Russell will
apply 2/2 to his. If not, perhaps you can ack it so Russell can take
both?
---
 kernel/kexec.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/kexec.c b/kernel/kexec.c
index 59f7b55..bde1190 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -1702,6 +1702,8 @@ int kernel_kexec(void)
 		pm_restore_console();
 		unlock_system_sleep();
 	}
+#else
+	error = -EINVAL;
 #endif
 
  Unlock:
-- 
1.8.1.5
