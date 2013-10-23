From: tushar.behera@linaro.org (Tushar Behera)
Date: Wed, 23 Oct 2013 15:24:33 +0530
Subject: [PATCH] ARM: bL_switcher: Remove cpu_hotplug_driver_{lock,unlock}()
Message-ID: <1382522073-14995-1-git-send-email-tushar.behera@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 6dedcca610c6 ("hotplug, powerpc, x86: Remove
cpu_hotplug_driver_lock())" removes the the definition of
cpu_hotplug_driver_{lock,unlock} APIs, thereby causing a build error.

Replace these calls with {lock,unlock}_device_hotplug().

Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
---
 arch/arm/common/bL_switcher.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/common/bL_switcher.c b/arch/arm/common/bL_switcher.c
index 63bbc4f..5774b6e 100644
--- a/arch/arm/common/bL_switcher.c
+++ b/arch/arm/common/bL_switcher.c
@@ -577,9 +577,9 @@ static int bL_switcher_enable(void)
 	int cpu, ret;
 
 	mutex_lock(&bL_switcher_activation_lock);
-	cpu_hotplug_driver_lock();
+	lock_device_hotplug();
 	if (bL_switcher_active) {
-		cpu_hotplug_driver_unlock();
+		unlock_device_hotplug();
 		mutex_unlock(&bL_switcher_activation_lock);
 		return 0;
 	}
@@ -615,7 +615,7 @@ error:
 	bL_activation_notify(BL_NOTIFY_POST_DISABLE);
 
 out:
-	cpu_hotplug_driver_unlock();
+	unlock_device_hotplug();
 	mutex_unlock(&bL_switcher_activation_lock);
 	return ret;
 }
@@ -629,7 +629,7 @@ static void bL_switcher_disable(void)
 	struct task_struct *task;
 
 	mutex_lock(&bL_switcher_activation_lock);
-	cpu_hotplug_driver_lock();
+	lock_device_hotplug();
 
 	if (!bL_switcher_active)
 		goto out;
@@ -685,7 +685,7 @@ static void bL_switcher_disable(void)
 	bL_activation_notify(BL_NOTIFY_POST_DISABLE);
 
 out:
-	cpu_hotplug_driver_unlock();
+	unlock_device_hotplug();
 	mutex_unlock(&bL_switcher_activation_lock);
 }
 
-- 
1.7.9.5
