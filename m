From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 16 Jun 2016 23:27:10 +0200
Subject: [PATCH V2 51/63] clocksource/drivers/versatile: Convert init function
 to return error
In-Reply-To: <1466112442-31105-1-git-send-email-daniel.lezcano@linaro.org>
References: <1466112442-31105-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1466112442-31105-52-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The init functions do not return any error. They behave as the following:

  - panic, thus leading to a kernel crash while another timer may work and
       make the system boot up correctly

  or

  - print an error and let the caller unaware if the state of the system

Change that by converting the init functions to return an error conforming
to the CLOCKSOURCE_OF_RET prototype.

Proper error handling (rollback, errno value) will be changed later case
by case, thus this change just return back an error or success in the init
function.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/versatile.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/clocksource/versatile.c b/drivers/clocksource/versatile.c
index 0a26d3d..8daeffa 100644
--- a/drivers/clocksource/versatile.c
+++ b/drivers/clocksource/versatile.c
@@ -25,18 +25,20 @@ static u64 notrace versatile_sys_24mhz_read(void)
 	return readl(versatile_sys_24mhz);
 }
 
-static void __init versatile_sched_clock_init(struct device_node *node)
+static int __init versatile_sched_clock_init(struct device_node *node)
 {
 	void __iomem *base = of_iomap(node, 0);
 
 	if (!base)
-		return;
+		return -ENXIO;
 
 	versatile_sys_24mhz = base + SYS_24MHZ;
 
 	sched_clock_register(versatile_sys_24mhz_read, 32, 24000000);
+
+	return 0;
 }
-CLOCKSOURCE_OF_DECLARE(vexpress, "arm,vexpress-sysreg",
+CLOCKSOURCE_OF_DECLARE_RET(vexpress, "arm,vexpress-sysreg",
 		       versatile_sched_clock_init);
-CLOCKSOURCE_OF_DECLARE(versatile, "arm,versatile-sysreg",
+CLOCKSOURCE_OF_DECLARE_RET(versatile, "arm,versatile-sysreg",
 		       versatile_sched_clock_init);
-- 
1.9.1
