From: robherring2@gmail.com (Rob Herring)
Date: Mon,  1 Apr 2013 17:21:11 -0500
Subject: [PATCH v2 01/13] ARM: make machine_desc->init_time default to
 clocksource_of_init
In-Reply-To: <1364854883-5961-1-git-send-email-robherring2@gmail.com>
References: <1364854883-5961-1-git-send-email-robherring2@gmail.com>
Message-ID: <1364854883-5961-2-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>

Originally from a default machine descriptor patch from Arnd, pull out
just the default call to clocksource_of_init part. This is needed so that
platforms can simply remove .init_time calls as they are converted to use
clocksource_of_init.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Nicolas Pitre <nico@linaro.org>
Acked-by: Olof Johansson <olof@lixom.net>
Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/kernel/time.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kernel/time.c b/arch/arm/kernel/time.c
index 955d92d..abff4e9 100644
--- a/arch/arm/kernel/time.c
+++ b/arch/arm/kernel/time.c
@@ -22,6 +22,7 @@
 #include <linux/errno.h>
 #include <linux/profile.h>
 #include <linux/timer.h>
+#include <linux/clocksource.h>
 #include <linux/irq.h>
 
 #include <asm/thread_info.h>
@@ -115,6 +116,10 @@ int __init register_persistent_clock(clock_access_fn read_boot,
 
 void __init time_init(void)
 {
-	machine_desc->init_time();
+	if (machine_desc->init_time)
+		machine_desc->init_time();
+	else
+		clocksource_of_init();
+
 	sched_clock_postinit();
 }
-- 
1.7.10.4
