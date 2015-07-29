From: jonas.rabenstein@studium.uni-erlangen.de (Jonas Rabenstein)
Date: Wed, 29 Jul 2015 13:07:57 +0200
Subject: [PATCH] arm64: remove dead-code depending on CONFIG_UP_LATE_INIT
Message-ID: <1438168077-19243-1-git-send-email-jonas.rabenstein@studium.uni-erlangen.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 4b3dc9679cf7 ("arm64: force CONFIG_SMP=y and remove redundant
#ifdefs") removed UP_LATE_INIT from Kconfig, as it had !SMP as dependency
and therfore can not be selected anymore.

Remove dead #ifdef-block depending on UP_LATE_INIT in
arch/arm64/kernel/setup.c

Signed-off-by: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
---
I found this inconsistency using the undertaker and
undertaker-checkpatch tools (https://undertaker.cs.fau.de/).

 arch/arm64/kernel/setup.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 0533f0b..d512ac8 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -213,13 +213,6 @@ void __init do_post_cpus_up_work(void)
 	apply_alternatives_all();
 }
 
-#ifdef CONFIG_UP_LATE_INIT
-void __init up_late_init(void)
-{
-	do_post_cpus_up_work();
-}
-#endif /* CONFIG_UP_LATE_INIT */
-
 static void __init setup_processor(void)
 {
 	u64 features;
-- 
2.1.4
