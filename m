From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 10 Feb 2016 16:14:21 +0100
Subject: [PATCH] cpufreq: select IRQ_WORK in Kconfig
Message-ID: <1455117265-3007562-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The cpufreq core code has started using the irq_work infrastructure, but that
can be disabled in Kconfig, causing a link failure:

drivers/cpufreq/cpufreq_governor.c: In function 'gov_queue_irq_work':
drivers/cpufreq/cpufreq_governor.c:251:3: error: implicit declaration of function 'irq_work_queue_on' [-Werror=implicit-function-declaration]

This adds an explicit 'select' to ensure it's always enabled.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 0144fa03ef46 ("cpufreq: governor: Replace timers with utilization update callbacks")
---
 drivers/cpufreq/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
index 3050e8d48887..ca05037dd565 100644
--- a/drivers/cpufreq/Kconfig
+++ b/drivers/cpufreq/Kconfig
@@ -3,6 +3,7 @@ menu "CPU Frequency scaling"
 config CPU_FREQ
 	bool "CPU Frequency scaling"
 	select SRCU
+	select IRQ_WORK
 	help
 	  CPU Frequency scaling allows you to change the clock speed of 
 	  CPUs on the fly. This is a nice method to save power, because 
-- 
2.7.0
