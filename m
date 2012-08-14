From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Tue, 14 Aug 2012 12:52:31 +0100
Subject: [PATCH] cpuidle: Prevent null pointer dereference in
 cpuidle_coupled_cpu_notify
Message-ID: <1344945151.2674.56.camel@linaro1.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When a kernel is built to support multiple hardware types it's possible
that CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED is set but the hardware the
kernel is run on doesn't support cpuidle and therefore doesn't load a
driver for it. In this case, when the system is shut down,
cpuidle_coupled_cpu_notify() gets called with cpuidle_devices set to
NULL. There are quite possibly other circumstances where this
situation can also occur and we should check for it.

Signed-off-by: Jon Medhurst <tixy@linaro.org>
---

Would a better fix be to delay registering the notifier until
cpuidle_coupled_register_device() is called? Though following through
with that logic would require unregistering the notifier when cpuidle
driver is unregistered and it still seems possible that there would
still be a window of opportunity for things to go wrong.


 drivers/cpuidle/coupled.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpuidle/coupled.c b/drivers/cpuidle/coupled.c
index 2c9bf26..c78a5ff 100644
--- a/drivers/cpuidle/coupled.c
+++ b/drivers/cpuidle/coupled.c
@@ -681,7 +681,7 @@ static int cpuidle_coupled_cpu_notify(struct notifier_block *nb,
 	mutex_lock(&cpuidle_lock);
 
 	dev = per_cpu(cpuidle_devices, cpu);
-	if (!dev->coupled)
+	if (!dev || !dev->coupled)
 		goto out;
 
 	switch (action & ~CPU_TASKS_FROZEN) {
-- 
1.7.10.4
