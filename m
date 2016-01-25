From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 25 Jan 2016 17:00:10 +0100
Subject: [PATCH] kprobes: make wait_for_kprobe_optimizer as __maybe_unused
Message-ID: <1453737722-1960270-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

wait_for_kprobe_optimizer is only used when CONFIG_SYSCTL or CONFIG_DEBUG_FS
is enabled, otherwise we get a build warning

kernel/kprobes.c:566:13: error: 'wait_for_kprobe_optimizer' defined but not used [-Werror=unused-function]

This marks the function as __maybe_unused to shut up that warning.
We could do also add more #ifdef, but that would be a little more
ugly in this case.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 kernel/kprobes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index d10ab6b9b5e0..12c0e0a02a6e 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -563,7 +563,7 @@ static void kprobe_optimizer(struct work_struct *work)
 }
 
 /* Wait for completing optimization and unoptimization */
-static void wait_for_kprobe_optimizer(void)
+static void __maybe_unused wait_for_kprobe_optimizer(void)
 {
 	mutex_lock(&kprobe_mutex);
 
-- 
2.7.0
