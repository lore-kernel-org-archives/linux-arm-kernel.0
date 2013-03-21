From: robherring2@gmail.com (Rob Herring)
Date: Thu, 21 Mar 2013 09:06:26 -0500
Subject: [PATCH 00/11] sp804 and integrator timer CLKSRC_OF support
In-Reply-To: <201303211324.37654.arnd@arndb.de>
References: <1363820051-24428-1-git-send-email-robherring2@gmail.com>
 <201303211324.37654.arnd@arndb.de>
Message-ID: <514B13E2.2050201@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/21/2013 08:24 AM, Arnd Bergmann wrote:
> On Wednesday 20 March 2013, Rob Herring wrote:
>> This series is dependent on my CLKSRC_OF clean-up in arm-soc, my
>> sched_clock selection series[1], and Arnd's default machine descriptor
>> patch (for default clocksource_of_init call). The full series is
>> available here:
> 
> All your patches look good to me, but I'd suggest you don't depend on
> my default machine descriptor patch yet, that just makes the dependencies
> harder to track, and we can easily remove all the calls once they
> are obsoletely.
> 

I really only need the hunk that calls clocksource_of_init which is
really somewhat unrelated to a default machine desc. So what if I just
pull out this hunk to a separate patch:

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
@@ -115,6 +116,10 @@ int __init
register_persistent_clock(clock_access_fn read_boot,

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
